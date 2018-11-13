Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B24C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B880E2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1vYYzEVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B880E2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbeKNAAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:00:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54658 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeKNAAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so12089949wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wc5Df3TA4f94uLSsVA/a5jHyDSL54/2MBnBTB6cxEnk=;
        b=1vYYzEVMAGadRKLT0RQ86f6NaJeDBQdRo5PcIQW+gjQaEMORE5p4BmSYnozx2+bm01
         Q2CjN2KqClhs3TvHGgbhYqzQXBryzHjpEVYV9sYA6qh5JjGG5V51d7dvn/OwjoJf7W0h
         Oa4OoBuyk4LpExaIlebw8tG81zlEMlBJ+qPS+KDG71vZtZIfZHyMc8wKG4ywI1oI9vSM
         aL3U5atBVGsibUiB+VAQqZZQcSrLbRRfNw1X+If+93zWPfsBjLFSbKNldeD47SVTv3Z7
         6W42HFENmnRdP/h6KFZzTdTQjdgNiBU4isB59h9pougLYIerBRIyB+YEzk4MQIefVS7g
         bnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wc5Df3TA4f94uLSsVA/a5jHyDSL54/2MBnBTB6cxEnk=;
        b=MnbzXVacZyNWR5U6Ok31YoNopGoSWXwjdcUVoXn5nQaBlf0tweaKItmVBJAEfT6/vZ
         GNUCYnMxKOnf+VHCwrKzeG1G+dCVTlWJAgsEESd6scg+R7Uu6A3c3uyl6O+6UrOYk8CE
         TaZCSK5YO0D29hp/7Zdi2cFveaa1D2/EDXqNMbvAjVSqaFWvi8nlrAv8hND7Z+R6L5Eb
         SHn9e38KfXzIjqkhYhAcAGD7Qdl5GKY2UUsmszzGmll/MBmlc3XdGGXthtw4jsR0g5T8
         iE8CuWGWix9uDnxjiZpjTXXGR9WN/YsRUqb276bwaEK8Z14sZ2Ji151DeK/37Ge5B7Rt
         82sw==
X-Gm-Message-State: AGRZ1gJfmvU6+jNDIwtQicGA5+dEP+bOYkHElbBy1BYJM9gjLqzYpvjc
        shvIm+WN4hUm1Q5xuoS2ucURYg==
X-Google-Smtp-Source: AJdET5eCneZzsonjCIJKb/v0cfrebw9r5UEFvH3gsPSan+oKyRzFwJATmLjnp+gyJK9zwU1UItgv/w==
X-Received: by 2002:a1c:f30b:: with SMTP id q11-v6mr3301060wmq.45.1542117733498;
        Tue, 13 Nov 2018 06:02:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/25] net: cadence: switch to using nvmem_get_mac_address()
Date:   Tue, 13 Nov 2018 15:01:19 +0100
Message-Id: <20181113140133.17385-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a generalized helper routine to read the MAC address from
nvmem which takes struct device as argument. The nvmem subsystem will
then try device tree first before all other potential providers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1d86b4d5645a..d9a208f7bb40 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4055,7 +4055,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
 	} else {
-		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
+		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
 		if (err) {
 			if (err == -EPROBE_DEFER)
 				goto err_out_free_netdev;
-- 
2.19.1

