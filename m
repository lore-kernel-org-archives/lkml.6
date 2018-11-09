Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9055EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8B2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YTXngxX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeKJEQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:16:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37238 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJEQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:16:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so1315012pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EvtYIyNdyk3BF1xWrCBtg1DWX6jsEZA3oOygIX97AiE=;
        b=YTXngxX5f8cNwBa/ZLQAAkiWayjyncVAkH0XpNW/Np2WbRC6uX6bchHZNT8MHxy5C4
         trIYBZHxHAx/1ai3wjNmvs8UiLdrLAB5ZssXd396ESZwXaLke36/Bj3G2JMSxZnVVBXd
         G0MtFiX7lwEk/Bp0akgZf3mFkKgENThXuSTGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvtYIyNdyk3BF1xWrCBtg1DWX6jsEZA3oOygIX97AiE=;
        b=O+qcp9mlFAm82pKVwHs+3/j7ppY34Gwn+N4pZ/RZhec4uQ+gTnOYKt9Ou8OdX18ZuJ
         6THACmidL1ZTQP4sBBMgdH7LFT/zPhFKfqvf90csgf356lBQ7Lp6OM2l8vLGUU1wKN4k
         V6Dq+iseVP3sGrAQ6qaT/GiScQCqIM8G/MgWp+U1zild0DpwCfm0BMfgqM+msCWodG+1
         FUVgdRDPy0M/7etIQ9YJl+wKvTwFpBPDyo6XxkLh7Z8xD3I8dXTZiRGonx5fQWitt4/Q
         mBQYyujQq5X/oNPA5YsG6M3D8a+4G5O2XFTc+X0BM9Q0UKI7usmhQkhdpFEILLx68O3D
         a0Kw==
X-Gm-Message-State: AGRZ1gK0PrsvbWIXg9xKHDrltolk16kPMGsWqKK0Fw9ilgXAyXhXLjry
        9+F0ZWnlznauKwoEsIoZK2GBoHKfwY8=
X-Google-Smtp-Source: AJdET5dXo5Wbk+H61QlD1kVCLkSBDHBAU+VFuo/kyq2Q1mdrzfu9TuLNxyfnXXv0brdMUoyUuJLPSQ==
X-Received: by 2002:a17:902:f208:: with SMTP id gn8mr5746671plb.6.1541788480573;
        Fri, 09 Nov 2018 10:34:40 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id 62sm7129021pgc.61.2018.11.09.10.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 10:34:39 -0800 (PST)
Date:   Fri, 9 Nov 2018 10:34:37 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Douglas Anderson <dianders@chromium.org>, Genki Sky <sky@genki.is>,
        Guenter Roeck <linux@roeck-us.net>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
Message-ID: <20181109183436.GA45531@google.com>
References: <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com>
 <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net>
 <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
 <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

git-diff-index does not refresh the index for you, so using it for a
"-dirty" check can give misleading results. Commit 6147b1cf19651
("scripts/setlocalversion: git: Make -dirty check more robust") tried to
fix this by switching to git-status, but it overlooked the fact that
git-status also writes to the .git directory of the source tree, which
is definitely not kosher for an out-of-tree (O=) build. That is getting
reverted.

Fortunately, git-status now supports avoiding writing to the index via
the --no-optional-locks flag, as of git 2.14. It still calculates an
up-to-date index, but it avoids writing it out to the .git directory.

So, let's retry the solution from commit 6147b1cf19651 using this new
flag first, and if it fails, we assume this is an older version of git
and just use the old git-diff-index method.

Cc: Genki Sky <sky@genki.is>
Cc: Christian Kujau <lists@nerdbynature.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
On Fri, Nov 09, 2018 at 11:55:26AM +0900, Masahiro Yamada wrote:
> > On Wed, Nov 7, 2018 at 1:18 PM Doug Anderson <dianders@chromium.org> wrote:
> > > On Wed, Nov 7, 2018 at 1:07 PM Genki Sky <sky@genki.is> wrote:
> > > > On Wed, 7 Nov 2018 12:55:14 -0800, Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > Ubuntu 16.04 ships with git version 2.7.4.
> > > >
> > > > Okay. I guess --no-optional-locks is a no-go then.
> > >
> > > In theory you could wrap it.  If passing git with
> > > "--no-optional-locks" doesn't work you could fall back to the old
> > > code?  That would mean only people with newer git would get your new
> > > feature and everyone else would stick with the pre-existing behavior.
> >
> > +1, that's what I was going to suggest. Presumably older git would
> > give non-zero exit status for unknown flags, and we take that as
> > signal to try to the old way?
> 
> I also like this idea!
> 
> I will pick-up this revert patch soon.
> 
> 
> Brian,
> Could you please send a patch on top of that?

Done.

It's not supremely beautiful, but I believe it works. I tested with new
git, and with a faked git wrapper that rejects --no-optional-locks,
dumps an error to stderr, and returns a non-zero exit code. I don't
happen to have an older copy of git lying around at the moment...

 scripts/setlocalversion | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..eab1f90de50d 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -73,8 +73,19 @@ scm_version()
 			printf -- '-svn%s' "`git svn find-rev $head`"
 		fi
 
-		# Check for uncommitted changes
-		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+		# Check for uncommitted changes.
+		# First, with git-status, but --no-optional-locks is only
+		# supported in git >= 2.14, so fall back to git-diff-index if
+		# it fails. Note that git-diff-index does not refresh the
+		# index, so it may give misleading results. See
+		# git-update-index(1), git-diff-index(1), and git-status(1).
+		local git_status
+		git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
+		if [ $? -eq 0 ]; then
+			if echo "$git_status" | grep -qv '^.. scripts/package'; then
+				printf '%s' -dirty
+			fi
+		elif git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
 			printf '%s' -dirty
 		fi
 
-- 
2.19.1.930.g4563a0d9d0-goog
