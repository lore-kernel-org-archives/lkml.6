Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F1920873
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBWAgVvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeLTABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:01:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35604 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeLTABb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:01:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so239512wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNRQwHzHCnSl0m0xOWhcZAQafUuDZb+evzNWgEIpjB0=;
        b=qBWAgVvSycaqzvZF3FqfqLPMYghgrlbbopm55d5QFT9cwbA/+FcsABO4HKCidpXQkn
         F6i50sDJyKtPEpYTsKfrhxsFNXith3W38sOw+LdBqQvsn4J5t1L4u72xWtv4yU0OoQp+
         mPk8qKq/NOaHUyruhpkK26463Q99b9yw6288XK6GTF/T669wqkMeF1YE6ilvuAsn1P1V
         S+lIYjg7hcUqnmSZ1vwhpMfhY8Z+PdShCEwMjPA+5OfC19ALytU9fglgGLwucRcbv5+9
         fnFTaYL1smYDhWVC3eZqE5KCVcMYlKrdTXquwMT9DgaocJo2S+bga67IpLTKZs4+mLpB
         xSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNRQwHzHCnSl0m0xOWhcZAQafUuDZb+evzNWgEIpjB0=;
        b=iXPbEBDjufQ45mL9xf/gIXBCn5DpluUaLKyNHggkZ2XFUWVZCiTYZdga21zyMuINk9
         8FxY2uEpey5DRS2G5HQxTPk9JCyslg3jBWt4TEMp1ZZEDvWsA5pPnUuUJzYzkoQqAxwJ
         KKHPpnROhVdXQEXSrDaEDlriAiuRkP71KEjK8ot8cvRMP4GvJAIIfN2iH3ssZ5dZBTGt
         wXqkbhsScaolWRAQfajaruSenPAKikU2GZfgk9Ix0g6W6hnTSYPUxST1eP0YYUnfXnbh
         q7w2hHE43G4ESu6PlMoAhTMs5m2HNTmCdejyDu33SJPRrc4TdmWwlpl4BL2vaP0PcFrX
         M+8A==
X-Gm-Message-State: AA+aEWaV+tzjRWi8AslH1MW7CVZkzcKBw7x2g7X/RwRN98vPirw77SDs
        hF0H63vWKK3DbzLNuKdcFJk=
X-Google-Smtp-Source: AFSGD/XLnH4ca0wlqKFfmxSED4iHzOEOhPmfEJbSA/hdkX4Z63orMDDb3P/y8ONNFxqug7Jcd+0IqQ==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr3756492wmj.10.1545264089690;
        Wed, 19 Dec 2018 16:01:29 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j202sm17214230wmf.15.2018.12.19.16.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 16:01:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Documentation/process: hardcoded core.abbrev considered harmful!
Date:   Thu, 20 Dec 2018 01:01:12 +0100
Message-Id: <20181220000112.24891-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop recommending that core.abbrev=12 be hardcoded when referring to
kernel commits, and instead rely on the git's default abbreviation.

Hardcoding this at "12" was done in
8401aa1f5997 ("Documentation/SubmittingPatches: describe the Fixes:
tag", 2014-06-06), back then Linus's git/git@e6c587c733 ("abbrev: auto
size the default abbreviation", 2016-09-30) had not yet landed, and
the default abbreviation was "7".

At the time linux.git had around 3.5 million objects, so if the auto
sizing had been in effect "11" would have been picked. Now "12" is
what we pick by default anyway.

More importantly, we'll roll over to "13" at around 16 million
objects, which given the growth rate isn't that far off. At that point
this documentation will be worse than the default.

Let's just stop doing this. Git versions as of 2.11 released over 2
years ago use the auto-sizing, and it seems like a fair assumption
that kernel developers use a fairly recent git version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As an aside I have upcoming git.git patches so you'll be able to set
core.abbbrev to e.g. +1 to get "13" now, "14" when it rolls over at
~16 million etc. Maybe that'll be a good fit for projects like
linux.git that want more future-proof abbreviated SHAs than most.

 Documentation/process/submitting-patches.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index c0917107b90a..faf661f58cb1 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -189,8 +189,6 @@ the SHA-1 ID, and the one line summary.  For example::
 The following ``git config`` settings can be used to add a pretty format for
 outputting the above style in the ``git log`` or ``git show`` commands::
 
-	[core]
-		abbrev = 12
 	[pretty]
 		fixes = Fixes: %h (\"%s\")
 
-- 
2.20.1.415.g653613c723

