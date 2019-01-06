Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D4C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1366820868
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcdnRzXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfAFRQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:16:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33674 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAFRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:16:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so28581956lfc.0;
        Sun, 06 Jan 2019 09:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECo3UMwhJhcU25xjwIsa4xBOPP2q83et6OCuOIefeik=;
        b=IcdnRzXZN68+hwCb5BXME04XPXSkGkoxtlqMd71XaaG/ScTdbkTvNiikecb56mj3cm
         S2A/H5HRJgX3gzkgLO1XZqLq5luT+05BMqmrCEc2mOXAUsMnUZZ8efzhzm2mrBDTrKDe
         ZXKNdgkPcRfIDu4zK1Xi/88GR5f2r/BXVAtmq3qc1Qo5lfrip5bvLo/p+ICn2FhFMm2t
         25d2soJyHH9aShG/P/ioK+i0xYScGgT4rgdFKkYWFoDFk7xfB0/mtZA1Ipyg08vTlEnl
         eMHr3k59iaojc8ANHItGhyyC1cZldUIbePJvTuq8TbLWzvVQgYh6S/+t6lU6TyBSxsyg
         6DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECo3UMwhJhcU25xjwIsa4xBOPP2q83et6OCuOIefeik=;
        b=SEJ810GReIVbO3DVTJjsikka0ea1yKEnLln+Da3ZIGG6eyQ8O9rQcsymmeElxVQ07d
         Gwr3/xOvvkQ3QyFMzFDoUEM7HhDwyfkPXV8RfHMJyjQ/Urw6iMZuSTnj5x6H2sbu7fMJ
         f1s64o5OIxUwUfg6K0Bu85/WwDxBg1wkDvxTVP+aq0z5fgiX79GEiLeZzBUhRNZPPNn1
         IUcczlTkMWJAzHEWEbWAHeFJTJJBSi5bmNBfcUb3T7RqAZWfX/OflrnVppQDseWkIX4y
         lK39OaDZ/kfBEvwVL2DQNXsGNPJc/pw4JercgGIEKDD4b3P5U1T3QTqR7/Vv93tzwwbR
         CFQQ==
X-Gm-Message-State: AA+aEWb8KRTP0CW+nfBIEkRfAYpSNVL2VDi+Sx3JMxK+SrvJJgUs1HlT
        GyKoC8xYjtfAADfs/Q7m49x2xI5k
X-Google-Smtp-Source: AFSGD/XX+9WOJM3LXGFdfsa0QPPdUhhvqJYpk3HlYExSeeyO1Njrz3oNrN+EUKine9IFe3742/4X1A==
X-Received: by 2002:a19:5154:: with SMTP id f81mr30649640lfb.96.1546795003116;
        Sun, 06 Jan 2019 09:16:43 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id b17sm12339409lfc.21.2019.01.06.09.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:16:42 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 0/3] add support for PMS7003 PM sensor
Date:   Sun,  6 Jan 2019 18:16:11 +0100
Message-Id: <20190106171614.12615-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Plantower PMS7003 PM matter sensor.

Unfortunately datasheet is not available for download from the Plantower
website so one needs to find it elsewhere, for instance here:

https://download.kamami.com/p564008-p564008-PMS7003%20series%20data%20manua_English_V2.5.pdf

Tomasz Duszynski (3):
  iio: chemical: add support for Plantower PMS7003 sensor
  dt-bindings: add Plantower to the vendor prefixes
  dt-bindings: iio: chemical: pms7003: add device tree support

 .../iio/chemical/plantower,pms7003.txt        |  14 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/pms7003.c                | 411 ++++++++++++++++++
 5 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 drivers/iio/chemical/pms7003.c

--
2.20.1

