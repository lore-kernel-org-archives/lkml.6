Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE2CECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6F2088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DHyL/RiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E6F2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeILMzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34964 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbeILMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so1255200wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OFySLdUXLR62cbw4pNAPVJeRRRSSn5qAUSTbLxQWiuk=;
        b=DHyL/RiF5XgjsiKnEBzBYmh2kn/efYixJ5aUB8NNVONZRhbwU/th1otz6h4cEMpmmw
         NRLLPbqVe4ZzVTQcH+MdXt8yqUjErDQDxCuINucnYGZOb3+h8776OcezvuJtqWlzp7Fq
         Xse/g5vHWi8CcRK6V9p/VszR2ZK5TA9+mGsV5MiQRG2UugKLjGTD8sZjPqpODeOe3437
         5oCoyyfNEEDqUE0jjGc7YxkMnQCPDrXcXO0Fn0/cr8zu1zDSWm1QyaLiV20mB4tzYUnV
         dgwz3EFwdE3Qpgp4icQprp3DtFr2SYpoK9EDrpDkEKgzbgJd+SOQpQG+tXantDd9ukul
         /wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OFySLdUXLR62cbw4pNAPVJeRRRSSn5qAUSTbLxQWiuk=;
        b=MLCN8BbjDfpbGmdRyhB8mY0f+xiQ4xeGr/SIk1OC5J2qs5xumTGNKmjgPzTqy+nG0x
         3cr6Pt2YudLSDayEqUVP7E5ImAll2PXWigm5lqJtpBr+qLyk3b0CnDB3PtrqIjPx2IAM
         A0Beoeafpkz+tsm/qNcFtP4ggpA2DVKuuDzqwcjOUckhTPa9toto3J1Bob7CSgj/fMxv
         BFsY5G3uJQnTPEIGSbBZACPSAFdgpYhAnRIbD5+DqaFpnAnen1aPyUN1teEQiZ1PwYt8
         +e+KQo2vwg4nSQusHlirviVgft1SLHAWwnYV7LZ1R9dNJ41QoR8vxbczekRTC4N1psBs
         eRhQ==
X-Gm-Message-State: APzg51CHqp0F2cvjPdU6wKW+JwAWcGGCkQvBcevO7avduGsd9ZlybxLS
        lPQIfVk9GkNhvGvklDLB5xmGTQ==
X-Google-Smtp-Source: ANB0VdZMuP8hdw6W5jip+1KH/V4Aqq14DjXxtevrsObaZHBLqEVYB8iFK3vpO5IsY9t3EQCDpsURMg==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr753953wma.126.1536738739034;
        Wed, 12 Sep 2018 00:52:19 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 21/21] nvmem: use octal permissions instead of constants
Date:   Wed, 12 Sep 2018 09:51:29 +0200
Message-Id: <20180912075129.25185-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits a warning when using symbolic permissions. Use octal
permissions instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bc14ffd87ca3..e174b282cc1f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -154,7 +154,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= 0644,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -178,7 +178,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUGO,
+		.mode	= 0444,
 	},
 	.read	= bin_attr_nvmem_read,
 };
@@ -201,7 +201,7 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUSR,
+		.mode	= 0600,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -225,7 +225,7 @@ static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUSR,
+		.mode	= 0400,
 	},
 	.read	= bin_attr_nvmem_read,
 };
-- 
2.18.0

