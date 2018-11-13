Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BC9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EC7206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/zCrSvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EC7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeKNFDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:03:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47069 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNFDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:03:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so6109055pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=01PCAwDbzKcdC5J29DOuEyf8Kjg21XeQWU8yKoiwgus=;
        b=c/zCrSvhcUBp21GOMXqM5rEv/YiR243jO9zjg5zz7FZy5cUKsVgQKeKkk2pBvJs+Dt
         ZKOaszBmLKxSmIgRYE/sccb5aI7GULjwyc3w44TbEnVd4N6vw3pk57imGsVjMIjTaLAI
         EMeKHTAxMs4KOU9Ds9ABQPg+GDyJ05S1n/w3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=01PCAwDbzKcdC5J29DOuEyf8Kjg21XeQWU8yKoiwgus=;
        b=jdwk0jSpwNx6qI1eaMkRtyp6/BtHU8cDnhzQ3ZX+6PD4ClTZd31o+loky21DFYb5MR
         E4lxhCnrR3QkO1Mm4ane8mKIU2cTjnZJO0qU+vSJIjikPDmvPKIcx56z4c2XKxgK1eug
         s3O/PRFQ0O85Pw893RoWdGZDWbm4Ju0GYFTVxRiPNNcOg09451/+g6yMgNd1d9OJ59RO
         rvTcCzDNyM5Ot22Av2x63qG3jaBxPbxnkr8oh+2YfEjRclpgT3aFQmhQJ1H1/21if/Zy
         W9BdxXIUpOqqVShSEQGwCxoGcOQiqX4DL3Ig+ifjNRSPvAA10CO7WXVktjF5JeRKs3RJ
         TRqw==
X-Gm-Message-State: AGRZ1gLwfd9JLmT1wt4oLzyh42FQyrs67HkLlAWPUk7CpXEJt+wv5rQ+
        K8pqg6k1Nwm8jUGoSpZ8N8RcyA==
X-Google-Smtp-Source: AJdET5fsYkmwfoQ2vdawUKO28z4DaJSOsgU7KLeTrmwdNICYC86AbPXzmTU4Oux/jfrYiTUfhY+UfQ==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr6460383pfh.8.1542135820093;
        Tue, 13 Nov 2018 11:03:40 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id v191sm26362389pgb.77.2018.11.13.11.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:03:39 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:03:36 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     alexander.kapshuk@gmail.com
Cc:     sky@genki.is, schwab@linux-m68k.org, yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
Message-ID: <20181113190335.GA50985@google.com>
References: <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org>
 <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is>
 <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com>
 <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
 <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
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

It's hairy to get the 'grep -vq' (inverted matching) correct by stashing
the output of git-status (you have to be careful about the difference
betwen "empty stdin" and "blank line on stdin"), so just pipe the output
directly to grep and use a regex that's good enough for both the
git-status and git-diff-index version.

Cc: Genki Sky <sky@genki.is>
Cc: Christian Kujau <lists@nerdbynature.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

On Tue, Nov 13, 2018 at 10:32:16AM -0800, Brian Norris wrote:
> I can submit it. I expect Masahiro-san would prefer a proper v2 patch
> for review, given how much would change from my v1.

Done

v1 -> v2:
 * handle empty (non-dirty) results properly, where
     echo "${empty_variable}" | grep -qv "${something_else}"
   always has a 0 exit status (a blank line is an inverted match for any
   non-blank expression). Just pipe directly to grep instead, with a
   hopefully-not-too-permissive regex to handle both versions.
 * actually tested with dirty and non-dirty trees this time

 scripts/setlocalversion | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..2190de4b57ad 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -73,8 +73,16 @@ scm_version()
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
+		if {
+			git --no-optional-locks status -uno --porcelain 2>/dev/null ||
+			git diff-index --name-only HEAD
+		} | grep -qv '^\(.. \)\?scripts/package'; then
 			printf '%s' -dirty
 		fi
 
-- 
2.19.1.930.g4563a0d9d0-goog
