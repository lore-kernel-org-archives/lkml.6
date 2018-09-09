Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B97C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F013204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 21:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F013204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeIJChf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 22:37:35 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44087 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeIJChe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 22:37:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A4A3030000945;
        Sun,  9 Sep 2018 23:46:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 855C110751; Sun,  9 Sep 2018 23:46:28 +0200 (CEST)
Message-Id: <76fccab34a66023c08b71a864a9fea77daac9742.1536517047.git.lukas@wunner.de>
In-Reply-To: <cover.1536517047.git.lukas@wunner.de>
References: <cover.1536517047.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 9 Sep 2018 23:42:01 +0200
Subject: [PATCH 5/5] MAINTAINERS: Add Lukas Wunner as co-maintainer of
 thunderbolt
To:     Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Noever has let it be known off-list already a while ago that he
currently cannot spare as much time for Thunderbolt development as he'd
like.  As a result the driver's development has become dominated by
Intel.

I would like to step up as co-maintainer to provide additional checks
and balances and prevent the driver from degenerating into an Intel-only
show.  A number of things really irk me:

* I've been contributing to this driver as well as Thunderbolt-related
  bits to the EFI, GPU and PCI subsystems for close to three years and
  was explicitly asked by Intel to cc them on every Thunderbolt-related
  patch.  Yet Intel did not see fit to cc me on their changes that went
  into 4.17.  I literally only learned about their existence from
  reading the news.  In the 4.19 cycle I was only cc'ed on a subset of
  their patches.

* Intel's efforts have been focussed exclusively on firmware-controlled
  tunnel management (ICM).  They made no contributions to OS-controlled
  tunnel management.  ICM cannot be used on Macs with Thunderbolt 1 + 2.
  ICM requires trusting a firmware blob.  ICM does not offer the same
  versatility as OS-controlled tunnel management, e.g. using separate
  tunnels to afford different QoS levels or correlation of Thunderbolt
  ports with PCI devices.  Apple chose OS-controlled tunnel management
  for very valid technical reasons.

* Our OS-controlled tunnel management still lacks important features
  such as daisy-chaining and DP tunnels.  Each feature needs to be
  reverse-engineered because there is no public spec.  Intel issued a
  press statement in May 2017 promising to make the specification public
  "next year".  More than a year has passed -- no spec.  The company has
  since changed leadership, who knows if they haven't silently canned
  the plans for a public spec?  I offered to sign an NDA and go through
  a disclosure process for every patch -- no reaction.

* Reverse-engineering requires verbose logging so that we're able to
  collect data on various systems and endpoint devices to deduce the
  meaning of registers.  Yet Intel now seeks to mute log output, thereby
  curbing our reverse-engineering efforts.  This exemplifies a worrying
  tendency to ignore the needs of non-Intel stakeholders in the
  developer community or even undermine them.

* Recent Intel contributions are maintainer self-commits without any
  Reviewed-by tags, which is generally considered a bad practice.
  Review comments offered by Intel-outsiders are not taken seriously.
  For example the driver's initcall level has been fiddled with twice
  now.  A review comment pointing out the fragility of abusing initcall
  levels to implement dependencies and suggesting the use of a notifier
  chain instead was summarily dismissed as unnecessary unless it breaks
  a third time.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..8815f4639e58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14445,6 +14445,7 @@ F:	drivers/platform/x86/thinkpad_acpi.c
 
 THUNDERBOLT DRIVER
 M:	Andreas Noever <andreas.noever@gmail.com>
+M:	Lukas Wunner <lukas@wunner.de>
 M:	Michael Jamet <michael.jamet@intel.com>
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Yehezkel Bernat <YehezkelShB@gmail.com>
-- 
2.18.0

