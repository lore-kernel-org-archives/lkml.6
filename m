Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEACDC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C0024AED
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJl4+Rte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C0024AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934725AbeFWCuM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:50:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41109 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934663AbeFWCuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:50:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so3723312pgl.8;
        Fri, 22 Jun 2018 19:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ivu9PS4UdgUE05m+Iz9kv7lUvuj7BkhGemCtehaD73Y=;
        b=nJl4+Rtehcwjp+YSrL8N9uyZWAwv0QZnaQv9JsvkHW/1xOZ95fhsSFQhMhsVb7wWZd
         b8EUqrctUrC8GZeQcNHMcosh1vxCglMYASPG5CPDBFehNaGpfTXQipqjpzDwgAj8b9CG
         +YvHE2LOageTN8Yn0dy+brT9yzBFMj+9101Z5GZ353hjjwoamTLSXEVzDfIozwTI9Iu6
         kXzNLkxpKWRbRb4iA1HPdFiVfV51ZfhxRqr0l2E99QnNl7JUmZ0LbfH8nE0xTm6kcml4
         kKLaIkPMLASjuIc1iM5yLNXRn5j+YbMsDjUD6u+EKuA5Y+bew7o3o3YZONCF6Rn+/pT3
         tjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ivu9PS4UdgUE05m+Iz9kv7lUvuj7BkhGemCtehaD73Y=;
        b=cT7Q0klhf2HLop7YDuG8VYnHgB17Dq5z520AccNDgouKbmoeCOb4TQCYf110+a4pVe
         Q/K1ZdFT44dN+6Sky3ppZADzph4kHPZNTHakWCWjBZfz2K7uy5+X4lHCOInpX5YySSZw
         JCjizzrWmBnUDuzfjARFrHMevWgOWFhjr4yj72+IjWKtKwm3AZ72nL7ezMyYKqWZgGwu
         7o4cKC6/FUp5XhB3TDlltRhlqQVJ2uqgL2L72cBmB51TCWkE+aMO6DlXf4NX4ec9v+S1
         F5ssbhClXK4iURUUjP6EbGEVFAIzxU+b9SzIgM/+jcxVKetsmhMEv/ewI85fYYh4BoI/
         Zkyg==
X-Gm-Message-State: APt69E2POZ5ZW3EoF8W2Or+q3B8QJGZ6WM1KE/sl/lvgcDRjDgOZLINg
        CpQtJLNAKejtxcJb3oRkeORiCKj4
X-Google-Smtp-Source: ADUXVKJU/kkzTPhvvbT1VlM1TwnYDxULrlAGVYKrcwjJ5hR03TAeC1nxcVE7FDpQc4vSMWVgTIl+JQ==
X-Received: by 2002:a65:6031:: with SMTP id p17-v6mr2635162pgu.140.1529722210243;
        Fri, 22 Jun 2018 19:50:10 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id y23-v6sm18804681pfa.73.2018.06.22.19.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:50:09 -0700 (PDT)
Date:   Sat, 23 Jun 2018 11:50:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kobject: Fix -Wstringop-truncation warning
Message-ID: <20180623025008.GF24595@lianli.shorne-pla.net>
References: <20180623020753.27266-1-shorne@gmail.com>
 <20180623020753.27266-3-shorne@gmail.com>
 <20180623023149.GA880@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180623023149.GA880@sol.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:31:49PM -0700, Eric Biggers wrote:
> On Sat, Jun 23, 2018 at 11:07:53AM +0900, Stafford Horne wrote:
> > When compiling with GCC 9.0.0 I am seeing the following warning:
> > 
> >     In function ‘fill_kobj_path’,
> > 	inlined from ‘kobject_get_path’ at lib/kobject.c:155:2:
> >     lib/kobject.c:128:3: warning: ‘strncpy’ output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
> >        strncpy(path + length, kobject_name(parent), cur);
> >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     lib/kobject.c: In function ‘kobject_get_path’:
> >     lib/kobject.c:125:13: note: length computed here
> >        int cur = strlen(kobject_name(parent));
> > 		 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This is pointing out a bug that the strncpy limit is the source string not the
> > destination buffer remaining length.  Fix it.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  lib/kobject.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 18989b5b3b56..15338e5a96f2 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -125,7 +125,7 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
> >  		int cur = strlen(kobject_name(parent));
> >  		/* back up enough to print this name with '/' */
> >  		length -= cur;
> > -		strncpy(path + length, kobject_name(parent), cur);
> > +		strncpy(path + length, kobject_name(parent), length);
> >  		*(path + --length) = '/';
> >  	}
> 
> It should be replaced with memcpy(), AFAICS; it wouldn't change the behavior but
> it would quiet the gcc warning.  Your proposed "fix" is heavily broken: notice
> that the code is building a string backwards (end to beginning).

Sorry about that, I didnt notice.  I will fix.

-Stafford
