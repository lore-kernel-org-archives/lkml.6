Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70381C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DD021721
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/7DruTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DD021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeHMN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:28:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35354 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeHMN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:28:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so7493185pfh.2;
        Mon, 13 Aug 2018 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+cYf1ibBNjgTTmHaFpUj0T02TGwf9GaBeRtX61j8pdU=;
        b=g/7DruTCRsUr2FhzL/mHec7CX94W/DyOzW+wpwIhAbBu//letu7QIpz/i7bBZhjZQ2
         RRnA/5ljSo/L+ZOPR7/Yu67VJKMaDLTRMiGV0aYchOQjBKlKSSjtwha3d+ooIzR+2aYl
         5PfqP3vNh5UnzEiohxAs67mdmDa79ei6NNp4Z9+/4OA/TUIX60dle8iLZrvGVnxfMlbm
         mVVia5sPV107hAKE8565c7DDFOIdHgj9jdC8RriVv+V+30l3e0Pwsascoupm+8UhOAXK
         /2MciNJJvMEOvwyjCMO7MJ2Eg7LXH6h/WwRn/2T8rucRskmJqzZxZy0vONvgMORO5poC
         uSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+cYf1ibBNjgTTmHaFpUj0T02TGwf9GaBeRtX61j8pdU=;
        b=IVK45mnpKtMz5JPxO9hWZR664RTV4B4tt5FZPXnXS+TP8G6vLt7EhDr2VbcwBKDgYo
         VgUtMn3iUOE1uD/OV3T2RsKSzexaF/7XUUtMBVx5JvHQ18fWUmnLvKdqSs/U1rPOEor8
         vLjrgDBF/FNDCNb1PJzZdWx4AUHcfPXfykj9bSPOdofda7asBWccu5uGDzXKPudB1utJ
         KdGCXlLHal5RgzOafs3Hkup8UHwb4a49y3XKQ1V6vWGglbkrd6tBQ7854vjzefAueTnZ
         6pP044ZdZY8t1URYmxHdzttJjBvVkjcsxN6O1mpcNk5iQGuUghcaGbGfbzS/WuoPoUf4
         aQ/g==
X-Gm-Message-State: AOUpUlGQ0xp8i96O+KOKQreCZV9JgXx7eTflELkeUKgSsB1f81pE3rr/
        pDc/gYpd7AJSgEtCsZ6T+TI=
X-Google-Smtp-Source: AA+uWPyfNtz6tZr4ZeqQp0SflKiL3+4FhrRDPe579m7r4ASFnqnIiP/AbcGaoYkxt0N4wOLRRLvhAQ==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr18394288pfi.43.1534157212932;
        Mon, 13 Aug 2018 03:46:52 -0700 (PDT)
Received: from localhost.localdomain ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id p19-v6sm30186335pgk.28.2018.08.13.03.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 03:46:52 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     corbet@lwn.net
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2] docs: dev-tools: coccinelle: Update documentation
Date:   Mon, 13 Aug 2018 16:16:38 +0530
Message-Id: <20180813104638.7935-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fix install instruction by adding `./autogen` command
  before `./configure`.
* Add link to a more detailed installation instruction.
* Add link to SmPL grammar documentation.
* Add single space after ',' to slightly improve readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

v2:
   - instruction -> instructions
   - Or Github at: -> Or from Github at:

 Documentation/dev-tools/coccinelle.rst | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 94f41c290bfc..aa14f05cabb1 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -30,18 +30,29 @@ of many distributions, e.g. :
  - NetBSD
  - FreeBSD
 
-You can get the latest version released from the Coccinelle homepage at
+Some distribution packages are obsolete and it is recommended
+to use the latest version released from the Coccinelle homepage at
 http://coccinelle.lip6.fr/
 
-Once you have it, run the following command::
+Or from Github at:
 
-     	./configure
+https://github.com/coccinelle/coccinelle
+
+Once you have it, run the following commands::
+
+        ./autogen
+        ./configure
         make
 
 as a regular user, and install it with::
 
         sudo make install
 
+More detailed installation instructions to build from source can be
+found at:
+
+https://github.com/coccinelle/coccinelle/blob/master/install.txt
+
 Supplemental documentation
 ---------------------------
 
@@ -51,6 +62,10 @@ https://bottest.wiki.kernel.org/coccicheck
 
 The wiki documentation always refers to the linux-next version of the script.
 
+For Semantic Patch Language(SmPL) grammar documentation refer to:
+
+http://coccinelle.lip6.fr/documentation.php
+
 Using Coccinelle on the Linux kernel
 ------------------------------------
 
@@ -223,7 +238,7 @@ Since coccicheck runs through make, it naturally runs from the kernel
 proper dir, as such the second rule above would be implied for picking up a
 .cocciconfig when using ``make coccicheck``.
 
-``make coccicheck`` also supports using M= targets.If you do not supply
+``make coccicheck`` also supports using M= targets. If you do not supply
 any M= target, it is assumed you want to target the entire kernel.
 The kernel coccicheck script has::
 
-- 
2.17.1

