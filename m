Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FCC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4124AE3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbHxbHGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB4124AE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964780AbeFWCby (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:31:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41063 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934590AbeFWCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:31:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so4281654ply.8;
        Fri, 22 Jun 2018 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A8qh48rlzzXackprY+OeOCMFWuvV+fDMOFQ9qifcOK4=;
        b=UbHxbHGtljLs2ANisIhAS3/BZ36iIJBffZncq9uT901kuA4hKTBUWk4i0mbb9aSRql
         S8XG2mIRMN64ptQiwrStNBiwNEMamaRIkjibsPv9zvK1c4Deu7YwVaXTgSrdM5hwoDDZ
         wBNY+q5pfh9kh/EMSz6aR6azFq9X55VGMMhOZk2ehyzyITg7XqHrpc44bdXityxCcJif
         l+nkOsYjV8Y+ii8LhOg8eImq8JkBH6m6IZEdkShgyNDDRuuWMwFLdICcfmzRTjECCuWB
         YEo3Dj/H6m5v1ny1hRv2A7EvU5o+NjjVDbwBJnlGjXPW0O4Z3HGIVbtE4OTaTx0vMXNt
         Y+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A8qh48rlzzXackprY+OeOCMFWuvV+fDMOFQ9qifcOK4=;
        b=HEu+MORDeeRwhFpEVMmOoJBPPJ3oQY6RfXsCvowMif9sA7ltZut3OSfI3A58jvwQSv
         GRphQ2s93TL/bvUggR8qVNQ7W2TvaSpjqjmwWrvqD1rXB0BYJTv68NJEhg/Qqzh1mB4p
         JOoR36xEbuh9Ayt+G5qH6sVpxswpMF45r8izStdK+PaO2Yaj5Q+yLnkUJ2m7hUZkIVwI
         k89UbEufRVVuOD4naOSK9yihOsAf4LGKAm0j9cxny9mTXc/e0ffVP9Ag9nfT1GigOX96
         TcQg+8Knpn2CMVSQW/3/z9ESQZII+GeyIm4uzB41KaGBPLA+RS8J4FZ3SZYglf4PxeoY
         dinA==
X-Gm-Message-State: APt69E2U4GQzdlV8njtrqh8vwjNRUtOWeVh6zwLmttukGpmQokLefrJf
        hJAYAom7uGKZXrVMWbEDOKI=
X-Google-Smtp-Source: ADUXVKLrx2WIVKd+gN/3LSZ2tXLTnxpTvxWn9z2XZjVXf7AzHhgpR1f+BHY8lYkwTOVfkhnHWvvltw==
X-Received: by 2002:a17:902:b60c:: with SMTP id b12-v6mr3943350pls.44.1529721111970;
        Fri, 22 Jun 2018 19:31:51 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id q9-v6sm10851389pgv.84.2018.06.22.19.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:31:51 -0700 (PDT)
Date:   Fri, 22 Jun 2018 19:31:49 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kobject: Fix -Wstringop-truncation warning
Message-ID: <20180623023149.GA880@sol.localdomain>
References: <20180623020753.27266-1-shorne@gmail.com>
 <20180623020753.27266-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180623020753.27266-3-shorne@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 11:07:53AM +0900, Stafford Horne wrote:
> When compiling with GCC 9.0.0 I am seeing the following warning:
> 
>     In function ‘fill_kobj_path’,
> 	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
>     lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
>        strncpy(path + length, kobject_name(parent), cur);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     lib/kobject.c: In function ‘kobject_get_path’:
>     lib/kobject.c:125:13: note: length computed here
>        int cur = strlen(kobject_name(parent));
> 		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is pointing out a bug that the strncpy limit is the source string not the
> destination buffer remaining length.  Fix it.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  lib/kobject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 18989b5b3b56..15338e5a96f2 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
>  		int cur = strlen(kobject_name(parent));
>  		/* back up enough to print this name with '/' */
>  		length -= cur;
> -		strncpy(path + length, kobject_name(parent), cur);
> +		strncpy(path + length, kobject_name(parent), length);
>  		*(path + --length) = '/';
>  	}

It should be replaced with memcpy(), AFAICS; it wouldn't change the behavior but
it would quiet the gcc warning.  Your proposed "fix" is heavily broken: notice
that the code is building a string backwards (end to beginning).

- Eric
