Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90BFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7053B2750E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gVdyASm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7053B2750E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966639AbeF1OdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:33:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51687 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966610AbeF1OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:33:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so9995951wmw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7UpIifBzzlHofhCVWyJaw6cfbiRR9ZhvkhoeVpGg5M=;
        b=gVdyASm30ArpJozKmUzNuCS5xPa3DEinEI1fRZlWr5AaRZovZ0v31zLxUbDBgm0RRM
         fMXsYziP0C5mH+m7NhoR0wWc7vy2n1MQw33PayAG3rGkVZi3BywV0jX/iof9nSlVYcal
         kRMW0ULXbt08cQyuhFt/NQmAD5T4ThoZ0fN+pvVitC8Jp5VUZcGZ6mlTdodoXULj2zfW
         VBC+BxIB95gQclaFtaWXMfqxkiH6N1p522wY5kQTEAVX82xTu09Xbhsu0rhiljf60cdY
         WHjvwZaAHYpfwbukNSTcez8OMYm+Xk8q6yuDEv0pggj7Af0mNTAG3uegGKbQKQYNB1Gs
         n4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7UpIifBzzlHofhCVWyJaw6cfbiRR9ZhvkhoeVpGg5M=;
        b=XaJLZOmEqGlL82y3AusfjMb7ZNbI/ByKW0nSmkuBmcP5Hwd53someRGQupM4mahpac
         ouVi2gBQ29uTIbt4TYEYnskNBTeAP9ChkWISCL5a0nTJRXskvrW3nhDPF9/+lfqRaMD6
         BAthkwKTOZ6n4OZ8p5qAKz99va9RRlxoLf2w7WZAA+SsmxSEQ9x1odMnwSDkHPVZTAKO
         MQmujXGGpDR6cT9efpn7VqjWOgTXopYEoESPPlox9VSlnyx4moMN7whQonluueujzYkR
         Hp9hmT23orE9mUjK5XFWog0ldZ1u3hFuLOoNeGDSq+uD27/8muwPqjViraBAAjrXOMgL
         lhdQ==
X-Gm-Message-State: APt69E1kEuBSxZJdiTgNUb9lhAx56NpV7hG1k+/bDKuBb8lJNkajvAeI
        hfqmrQxLmh0n4lptAX6I3Fm35A==
X-Google-Smtp-Source: AAOMgpdTEMBWoO1krAiLbVwisFuV3wHT7CWPj3omeQCBOn8xuuK7ky8KMrzXFboLx8ezS4SWgLUrEA==
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr8180543wme.54.1530196391269;
        Thu, 28 Jun 2018 07:33:11 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-87-41.w90-86.abo.wanadoo.fr. [90.86.29.41])
        by smtp.gmail.com with ESMTPSA id 4-v6sm8037499wmh.14.2018.06.28.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:33:10 -0700 (PDT)
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
Subject: [PATCH v3 02/18] Documentation: nvmem: document lookup entries
Date:   Thu, 28 Jun 2018 16:32:28 +0200
Message-Id: <20180628143244.4561-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628143244.4561-1-brgl@bgdev.pl>
References: <20180628143244.4561-1-brgl@bgdev.pl>
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

