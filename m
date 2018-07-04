Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE76C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380023E3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+g+FyX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380023E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeGDOkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:40:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50878 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGDOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:40:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so6174208wmc.0;
        Wed, 04 Jul 2018 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cLmR6Nz+14jlpzaY0K6wZ59vUKjmRn8oFCRldxGomtM=;
        b=n+g+FyX4P4LyCJMf0sFHwFZ02QnaZjYR93q2gnYnTz4af0kfKYWSkQa5ZwbyXEcr/q
         qmTgocSF1H6zAvQnDC4XXffsnaBP96Ufm7EFFcp65DO9XBfNjG8ZRfn55MBD4UsHdVPg
         PVIpeC9fU3r9jWHbkdJrnkXN9+Gs/bVU/oGhWGYafbbJsg883xbINEgaYrsnU+OoCHNE
         BUDRBGovNXgZVhNnYpSfaotU8uQJPklbo/ffQKTPnT/6P6mMLsNvZzvJJVbB8boWy5IX
         gTeliZFY3hpRpG4+C1In6yAwfBYPeIy4T3PzTJ0kW7/2V9e40Kuzyv2EHYRQ5kGY5M1W
         gdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cLmR6Nz+14jlpzaY0K6wZ59vUKjmRn8oFCRldxGomtM=;
        b=oPygdcspruVLQ14G4KHIyvKQREB7U8M5ts3lbtuZJstR3r9hEwt5e8SxA/DzY+ji3C
         bKVvswKC+a/xoJ0P9nCjLrN1TyL+/pEIx04RVWfnTd6T3Hp5LLNY33xs1XJJsJYwz9as
         TofaMAQl+vmFLTNUAvk44WHPJFNgntNa4brt88AvAbZmH1te/dVRbL5FedPeKnO6NO/2
         wBDQVlgO+oqdVN2ueC7GFhYWKchTiQkFa2WSmOCP599CI3Mds2G0KZUFmXf8GVs224eh
         vSui7G7P5mcXbkitIem6qoiFfAPrQGGBV69BWypVc4PEFSil3xEuVe51uOuFWLC8gjN1
         pOrw==
X-Gm-Message-State: APt69E0qxLjG2Q9x7DFAcCcM9I0YQTeRjXqd1MhliXiec1KomGbVuBtP
        jrOm4WBOVsya/pFkKlvS82E=
X-Google-Smtp-Source: AAOMgpeU20L9jF/0c/VQh/722aEmKDIJcVjKdfhEEPUxL8VpSufH4dYP2OsTrqQpzdsmlWNOqLT7hA==
X-Received: by 2002:a5d:4b50:: with SMTP id w16-v6mr1842914wrs.87.1530715208621;
        Wed, 04 Jul 2018 07:40:08 -0700 (PDT)
Received: from e6-mvucnik-xps.ijs.si ([2001:1470:ff80:e6:916c:c370:4e45:3d9])
        by smtp.googlemail.com with ESMTPSA id 17-v6sm8812448wmm.21.2018.07.04.07.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 07:40:08 -0700 (PDT)
From:   Matevz Vucnik <vucnikm@gmail.com>
To:     bjorn@mork.no
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matevz Vucnik <vucnikm@gmail.com>
Subject: [PATCH] qmi_wwan: add support for Quectel EG91
Date:   Wed,  4 Jul 2018 16:40:05 +0200
Message-Id: <1530715205-13676-1-git-send-email-vucnikm@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the USB id of LTE modem Quectel EG91. It requires the
same quirk as other Quectel modems to make it work.

Signed-off-by: Matevz Vucnik <vucnikm@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 8fac8e1..829c05b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1255,6 +1255,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
-- 
2.7.4

