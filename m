Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8609C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41713208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/bofx7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41713208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeHWTZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:25:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38389 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeHWTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:25:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id i7-v6so4452604lfh.5;
        Thu, 23 Aug 2018 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GvuQEJ17N55Qpb9Ta9R0WLcasNi/qqQ96HuwpPOOGXg=;
        b=b/bofx7TwrPfoBI2CkQp1h9CQB0nG1TvIjjYTsE1x7Sg+n3iXkUS5xlj8zPDkGbAuG
         e4dEUjIGxpKir6FXr5bKD+ExBYGdKRdjj9uun2m2m/D0AafN9UKGG+RXIZy+ib4snqrB
         wKMXf560nQqwWXMZlk5ItMTYlrMZExBVPI9/FRlSUmSzGbzuPoQUyn7b4murwtTfLMzh
         iQkUeE0e9Xh5HPf8DTddXDOX/lpBtBqEmJ1NxrtGcnkSydwhpmO/onOAhGiADlvu4HB7
         oEwQoM9I8cMD3lyRGgZZlpGQ+Jxbh+DYa9N4FzPp3mpqYk4zZ30/crCJnUFc8aSWGGX1
         PSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GvuQEJ17N55Qpb9Ta9R0WLcasNi/qqQ96HuwpPOOGXg=;
        b=maEvKf0M6HosJUfD35jnnt4CCtdxq+5GQP4Lg9t2BLqA2/Md19weRp7yJK0E3ToDRp
         ZES1rPS+fg5imgWqcsEhbXoSyKwgm0VASsdf4jPWv+FZOgLWzk7QTlu7+jwhfA1IZ4GQ
         8BvaqN9y5poUnajMPygUq8OBVtTNZa/rjg5sVURaWIrHzZU9dJcTvwq8nbRmgpOAfBSD
         wixIQmHYZ0H4c8OehqeVSszV3pbaNWadP7pUa95WQ/al8P/j5Vy/yhYGZ6KcWx/ijyTI
         vZC30NPCgVaQ2xF9iBYDJYQbibzKibanQ7j343Zl9BmlU5hs1+xBCKWYEjf8zcuNZaUk
         /SxQ==
X-Gm-Message-State: AOUpUlEg+iHSQ2XkRXAtq9XozDcSJjm1YPO7yMPZMw7gIUaYMScwlLc3
        6MnQykxT+crKQ/dfgatgz/nTZXZi530=
X-Google-Smtp-Source: AA+uWPyEs+hrP+zzPy8gU6kgxberYxW2JD1VrWCsKJhVNIj1O2SEGAadXNXZC1b82fVV8A/hkRmKHA==
X-Received: by 2002:a19:9f92:: with SMTP id i140-v6mr14202213lfe.72.1535039740964;
        Thu, 23 Aug 2018 08:55:40 -0700 (PDT)
Received: from pc-sasha.localdomain (93-127-25-142.static.vega-ua.net. [93.127.25.142])
        by smtp.gmail.com with ESMTPSA id v62-v6sm859612lfa.51.2018.08.23.08.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:55:40 -0700 (PDT)
Date:   Thu, 23 Aug 2018 18:55:37 +0300
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     hns@goldelico.com, lucas.demarchi@profusion.mobi, jeyu@kernel.org,
        cwhuang@linux.org.tw, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
Message-ID: <20180823155537.GB4654@pc-sasha.localdomain>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
 <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
 <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 05:38:27PM +0900, Masahiro Yamada wrote:
> Hi Randy,
> 
> 
> 2018-08-23 8:33 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> > On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
> >> This patch requires that /sbin/depmod is installed and installable on
> >> the build host.
> >>
> >> But not all build hosts for cross compiling Linux are Linux systems
> >> and are able to provide a working port of depmod, especially at the
> >> file patch /sbin/depmod.
> >>
> >> I use, for example, a Darwin system to cross compile Linux and I run
> >> depmod -a on the embedded system once, after installing a new Linux
> >> kernel there.
> >>
> >> I have no problem with seeing a warning, but aborting the build process
> >> is IMHO a bad idea since the previous behaviour didn't harm many people
> >> as far as I see. Probably 99% of people compiling Linux kernels do that
> >> on Linux and 99% of those have depmod installed for optimal operation of
> >> their build host. So IMHO printing the warning is good enough.
> >
> > Thanks for the report and sorry about the problem.
> >
> > I'm OK with changing the error to a warning.
> > Does the patch below work for you?
> >
> > thanks.
> > ---
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > When $DEPMOD is not found, only print a warning instead of exiting
> > with an error message and error status.
> >
> > E.g.:
> > Warning: 'make modules_install' requires /sbin/depmod. Please install it.
> > This is probably in the kmod package.
> > ../scripts/depmod.sh: line 44: /sbin/depmod: No such file or directory
> > make[1]: *** [/home/rdunlap/lnx/lnx-418/Makefile:1244: _modinst_post] Error 127
> > make: *** [Makefile:146: sub-make] Error 2
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> >  scripts/depmod.sh |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > --- lnx-418.orig/scripts/depmod.sh
> > +++ lnx-418/scripts/depmod.sh
> > @@ -15,9 +15,8 @@ if ! test -r System.map ; then
> >  fi
> >
> >  if [ -z $(command -v $DEPMOD) ]; then
> > -       echo "'make modules_install' requires $DEPMOD. Please install it." >&2
> > +       echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
> >         echo "This is probably in the kmod package." >&2
> > -       exit 1
> 
> 
> 'exit 0' is missing here.
> 
> This shell script would fail, then abort the build process.
> 
> 
> > ../scripts/depmod.sh: line 44: /sbin/depmod: No such file or directory
> > make[1]: *** [/home/rdunlap/lnx/lnx-418/Makefile:1244: _modinst_post] Error 127
> > make: *** [Makefile:146: sub-make] Error 2
> 
> 
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

May I suggest the following implementation:

diff -U0 scripts/depmod.sh ~/tmp/depmod.sh 
--- scripts/depmod.sh   2018-08-10 17:14:19.036349222 +0300
+++ /home/sasha/tmp/depmod.sh   2018-08-23 18:07:23.486048827 +0300

# 'if' block may be omitted here. If System.map isn't there and isn't
readable, 'exit 0'.
@@ -13,3 +13 @@
-if ! test -r System.map ; then
-       exit 0
-fi
+test -r System.map || exit 0

# Have the 'if' test statement syntax conform with the remainder of the
script, which uses 'if test' rather then the 2nd form of the test utility,
i.e. '[ expr ]'.
# In my view, the use of the negation operator, '!', makes the intent
clearer, and reads, 'if $DEPMOD not found', rather then 'if the length
of $DEPMOD is zero'.
@@ -17 +15 @@
-if [ -z $(command -v $DEPMOD) ]; then
+if test ! $(command -v $DEPMOD); then
@@ -20 +18 @@
-       exit 1
+       exit 0

[Sample run]
# Testing for a non-existant utility:
% if test ! $(command -v cmd); then echo cmd not found; fi
% cmd not found

# Testing for a existing utility:
% if test ! $(command -v ed); then echo ed not found; fi

% if test $(command -v ed); then echo ed found; fi
% ed found
