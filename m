Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9EFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620A25A57
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFuoHuSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620A25A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933865AbeFYNYu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:24:50 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43379 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933583AbeFYNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:24:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so6788724plj.10;
        Mon, 25 Jun 2018 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Aq2GPCzpJORAj4T7Ju043CZ/rs9iEztNIVE/qiy2V6I=;
        b=YFuoHuSma60BHldv+dAKvqYgfCZvFe5YBnu3MaW680Co4rF+lzObTIve2Cb7U7M4jn
         vSp8tXMWffIHpA2yLsb4QtYeZNEy1V9HTxMnHIAOrNrjYJAazUdT6ApVFfUgIhEOB2S/
         R1KWp0eJ/D5DahAgXUDzB8B4oBsKbb/f4ITmR71S+4teaEHsiwYfFPyD/but7nhoVBQL
         jG+dV5F+iOs//Tv3OXoVL2AL+nY6x0AjHSc38jN+gfZGQDnC3HwfiQQznuGUwd+YgsQJ
         H63IyvzbCi6D7XsIT45i8kLnkQGfFvD2j+mjUKUy/GMaB5YOl4XWKWH5QLux/U24SfKs
         Z8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Aq2GPCzpJORAj4T7Ju043CZ/rs9iEztNIVE/qiy2V6I=;
        b=ulwVVPA29KfgWVGgH5ImzkFv/07mZ4MjBGf8wS3lWcNhbvcJ5SQt1i1sIWw18P+5D/
         FuTHxEnsy16dey6BId5EpkoYelk1MFYqxmAFVRYjYnMDVg79KFkqyQdEQqkysJKkoxYk
         wUIaf1iGuopi62GFHT9GXcnBBIqgHYzCuamgdnJFMr/SobdxWFir6SKE4KsdUZPKqqSw
         dmEtmgLxb0IpwqPKx349/rMzEOdZWGJfTkHe14QQ/P5LJ4aH6o2EItaVGTBXKhH2N6fE
         Ix8zhvEDgFGMzxzLpxcSJVZC/7lj4UFiL6VqCMQrG3iz3K0FI55TiTgmqKvpqUDCugPu
         fHow==
X-Gm-Message-State: APt69E1k0VzNCAl3q2pL4eONN8EYvhgih9cvD6melgWdnRBZ2L7J96Bu
        iDHyK1ojaHPuoUolhufevDg=
X-Google-Smtp-Source: ADUXVKL8Od7h+T3W2vADj5JIYwtqHwXbPhekKN7KYODz9wtXJrrOBVPeBLDBMocSmAaNUXOLo6JIqA==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr12384540pll.54.1529933088044;
        Mon, 25 Jun 2018 06:24:48 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id 90-v6sm2919411pfr.75.2018.06.25.06.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 06:24:47 -0700 (PDT)
Date:   Mon, 25 Jun 2018 22:24:45 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kobject: Fix -Wstringop-truncation warning
Message-ID: <20180625132445.GI24595@lianli.shorne-pla.net>
References: <20180625124538.21051-1-shorne@gmail.com>
 <20180625124538.21051-3-shorne@gmail.com>
 <c89dd856-3637-b235-f134-e15621eab2c6@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c89dd856-3637-b235-f134-e15621eab2c6@c-s.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:57:13PM +0200, Christophe LEROY wrote:
> 
> 
> Le 25/06/2018 à 14:45, Stafford Horne a écrit :
> > When compiling with GCC 9.0.0 I am seeing the following warning:
> > 
> >      In function ‘fill_kobj_path’,
> > 	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
> >      lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
> >         strncpy(path + length, kobject_name(parent), cur);
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      lib/kobject.c: In function ‘kobject_get_path’:
> >      lib/kobject.c:125:13: note: length computed here
> >         int cur = strlen(kobject_name(parent));
> > 		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This is not really an issue since the buffer we are writing to is
> > pre-zero'd and we have already allocated the buffer based on the
> > calculated strlen size and accounted for the terminating '\0'.
> > Just use memcpy() instead.
> 
> If we are already sure the destination is big enough, why not just do a
> strcpy() and drop the 'cur = strlen()' ?

Hi Christophe,

Here were are writing multiple strings into a buffer from back to front.  We are
copying exactly strlen() bytes at a time to avoid the nul terminator being
copied into the buffer.

I don't doubt we could use strcpy() but I was trying to keep the change small.

-Stafford

> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Eric Biggers <ebiggers3@gmail.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   lib/kobject.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 18989b5b3b56..e876957743c8 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
> >   		int cur = strlen(kobject_name(parent));
> >   		/* back up enough to print this name with '/' */
> >   		length -= cur;
> > -		strncpy(path + length, kobject_name(parent), cur);
> > +		memcpy(path + length, kobject_name(parent), cur);
> >   		*(path + --length) = '/';
> >   	}
> > 
