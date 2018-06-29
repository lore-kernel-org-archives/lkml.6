Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F8C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A658727C72
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0kpUEV03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A658727C72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbeF2Jkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:40:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45982 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933615AbeF2Jkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:40:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so8202095wrn.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7UpIifBzzlHofhCVWyJaw6cfbiRR9ZhvkhoeVpGg5M=;
        b=0kpUEV03j1mvInFsLtalEfZMaWcGsUNYAnFPBd2wl1QyRfU1T7V0Mla0oSSs5bT9zL
         j25nhqT7ZLBhx3US3Q5RhpqbWxvVthWyc/zwhrvlMSzAZVaI5VRESDNml0VXUII/lrQm
         f4nVXFJcuVzbDtx6GbcGdzbzYr7szzd4/wFszze1ibYOnrIYM1beFAXfGc43c/rr4Atn
         4B1R16gtjVjNiYr3oEnj73dr7amaEosgnlAtSqxq5U1lJvMO8JIaywZ7c4biMlZdqxsx
         eBcQI6WLv4nepN51hhIIonGxFJtGNbT0L83ivbYqKkjAAKiJCl+RdXDWGxjFWRp+lkV7
         caLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7UpIifBzzlHofhCVWyJaw6cfbiRR9ZhvkhoeVpGg5M=;
        b=B2wnyQHX6jKKQTDZ2xDyh4E6Cmltwvgnq+yc9rhZjqZAUlMZ1a0chEZx8vP41Qw4Ra
         PrtLJwbA0zpm4zPzpxr+XruP/W5fj1+KWCugKjmNNcoo9ZdLwr7FEBbbINKWNUiYHBJN
         9NSKTJsx3uR2B+pRj9npaxNGHLExK6deaZSiG1YB99vnwqDIvpv2Mrdp5s1PDH/ngkJn
         YQPgJWBO71wztfLszNAv6RuyeDLeALB5hVlyB/QmX86EGpf2dqXTzSCglsqYfQZWS6xQ
         ezghZxVD6lti4pyCtCkd89tZ3LwactA5BOl4//9fu0bxVRQnndoygw8B5Ppi5Jv59f71
         rdZQ==
X-Gm-Message-State: APt69E2NLQkstSJmQtlAs9ZgC9ASR8m/ayil9SEiMDqUF7cKvDBjceZD
        zrCW0orr1X0kHRAntaZB+WCxtw==
X-Google-Smtp-Source: AAOMgpcZKV8OR13dLTBEB8kRKij9oPYm6SUlDyIfl7hmR2Nomfp94V2fOrnn9K55Klm10Y77Oyy92g==
X-Received: by 2002:adf:f482:: with SMTP id l2-v6mr8685670wro.259.1530265246041;
        Fri, 29 Jun 2018 02:40:46 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:40:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 02/18] Documentation: nvmem: document lookup entries
Date:   Fri, 29 Jun 2018 11:40:23 +0200
Message-Id: <20180629094039.7543-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Describe the usage of nvmem cell lookup tables.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..9d5e3ca2b4f3 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Additionally it is possible to create nvmem cell lookup entries and register
+them with the nvmem framework from machine code as shown in the example below:
+
+static struct nvmem_cell_lookup foobar_lookup = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0xd000,
+		.bytes = ERH_ALEN,
+	},
+	.nvmem_name = "foobar",
+};
+
+static void foobar_register(void)
+{
+	...
+	nvmem_add_lookup_table(&foobar_lookup, 1);
+	...
+}
+
+A lookup entry table can be later removed if needed:
+
+static void foobar_fini(void)
+{
+	...
+	nvmem_del_lookup_table(&foobar_lookup, 1);
+	...
+}
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.17.1

