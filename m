Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0421924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjvaOMau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfBOQT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:19:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43834 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfBOQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:19:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so5039332pfh.10;
        Fri, 15 Feb 2019 08:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0WQIojlwUfV7KIdk2zetym0falQgqTF4Y8ctpcOVLTg=;
        b=PjvaOMauTC58ec8vP7N2obpbjUpc+Kba9l5dhGBTCVyEu9NBKYXYKQF/SmwhP2W2Uj
         iLHk/bJ8IseNs7xKOU2aboeyz42FDtNAsxRp5mOZLisV2tC14tNzDqDKYQj8J1ix+PUM
         CXe1GgV/lLebjPDmHpGyJQ4cXV0fQGM2FyDC3U3YB+HgAROg+Rhq9WGq902aVOXN//CF
         X9UGInkOZ5VQdQureOg9kmLqQOoX52cMqQXCv4s0+fdBsrbumqBba0ndJ5nwvUB+m+v8
         41YERBXug8putaTpLKvhzbrMnimXGN8KPuvLKqaM5ldZjMNEP1shk2F6FYWgUnvybFNA
         Cnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=0WQIojlwUfV7KIdk2zetym0falQgqTF4Y8ctpcOVLTg=;
        b=XMtVEre7Kt0/w08fo91/CEiVrTY1fOeG40rcSdhaaAVNj4/pTtHB1tZK3glM8IWuk+
         tLyCmR1qGh9UUzOkWPn0v+Z7qNQ6iEfl0z8BvXHzbFLMgIhrWOC5Ovw/WOK1DWmihYHs
         Hdw8IBist8UW2y4Ak1ei9NLLaXtMGfVowmzjLzvx4xtMHvVppS3xrSsVs4bPlsamB3s7
         AKuE9jG4U3xtoo0HflrpO8kM7IWRpG5ouTZLbReMbGjC/wATSRU1InGzdP0G0PKbgZjx
         kS1pUBLmqDsReAaGdmIZhSwmv3Ry+OvO/3XISv3+R40xdxu7l4i9vbylGkwEHGP21ITm
         uf9g==
X-Gm-Message-State: AHQUAubUJO9D26fa8kd3bFJfbE+H47/sO1usz7wvxM06MBTat2xg3X+1
        6EuXzMsSBHb8OngS9rGq229I3n+K308=
X-Google-Smtp-Source: AHgI3Ib48wd9wpkp8G0EguebYNNwVmOfOejTR3P3kf4DkVuj0bumbAZXFiCVUYJswPtxvBBPbZblEw==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr6170742pgk.147.1550247597675;
        Fri, 15 Feb 2019 08:19:57 -0800 (PST)
Received: from mdr-mbp.hsd1.ca.comcast.net (c-73-189-12-233.hsd1.ca.comcast.net. [73.189.12.233])
        by smtp.gmail.com with ESMTPSA id k64sm14428052pfj.69.2019.02.15.08.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:19:57 -0800 (PST)
Subject: [RFC PATCH 4.4] Documentation/network: reword kernel version
 reference
From:   Mark Rustad <mrustad@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 15 Feb 2019 08:19:55 -0800
Message-ID: <20190215161955.12119.77812.stgit@mdr-mbp.hsd1.ca.comcast.net>
User-Agent: StGit/0.19-57-g180c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seemed odd to say "since 4.17" in a 4.4 kernel. Consider
rewording the reference to indicate where in the stable series
it was introduced as well as where it originated.

Signed-off-by: Mark Rustad <mrustad@gmail.com>

---

Does this brief elaboration add useful information? It seems to
me that someone using a particular series of stable kernels would
find this information to be helpful or at least potentially less
confusing to a non-developer.
---
 Documentation/networking/ip-sysctl.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
index 7c229f59016f..2fb35658d151 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -116,7 +116,7 @@ ipfrag_high_thresh - LONG INTEGER
 	Maximum memory used to reassemble IP fragments.
 
 ipfrag_low_thresh - LONG INTEGER
-	(Obsolete since linux-4.17)
+	(Obsolete since linux-4.4.174, backported from linux-4.17)
 	Maximum memory used to reassemble IP fragments before the kernel
 	begins to remove incomplete fragment queues to free up resources.
 	The kernel still accepts new fragments for defragmentation.

