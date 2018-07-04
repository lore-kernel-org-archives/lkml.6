Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C39C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5D214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPQWcbDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C5D214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeGDQMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:12:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39748 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbeGDQMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:12:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so6588213wmc.4;
        Wed, 04 Jul 2018 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cBBRGWahCYoNdEnHkfQ8DQQmBfqAqpxIM6hnc0LP21o=;
        b=PPQWcbDyR2h4Dkpthsn8pSizD4DPGAReGZvEM0P1buRg55Hs3GOeQoFQXe7dS5m8LG
         p8XmK+9ZG4O8y2tkNUr2/GYrrSloeFiUnzFRiLym7a5vtaUjtd0U24O4WWPhg0+Witg4
         5i04BwkJ4JZT+Yy3GWaaH2KSCZ3t4l20yz7JRn6tZtQcmh0hhK9xzsofVAUD/I12BmiD
         Y0VRYlSj4AuxmmE3PR6E6mZCzwLDzOkqyxsFffoX/ajttghFG2TQyqgQ3rXH68sjaKZh
         7rHoU4EkVuQmqQRtM1DPHAjySDL93x0QVHxJywRSJ8wTHga3A2bIrIvBgZorhQ6idwhY
         mweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBBRGWahCYoNdEnHkfQ8DQQmBfqAqpxIM6hnc0LP21o=;
        b=DVbT/XEucQORZsh9cWEFh4Wx3lAmKJwFiYnMdtRaQMcSajIq1icq2QjjKVlmKOyixG
         WIqRnbiWawDxuKmaSlIZimurkuNKKfEachD8RFeWbwqoCmm9tczQxDgmnIF4/B3zvnyn
         hx0rGGHgEZOoOrMlykOwitjViyXhHr959wVau9cDnRvqtkY1FgTjjJCOjlTAdhgsS9fm
         CBUwGQqX2EpyLr/EiqT4GWk5avL5+K/bAYrFFS7aGj6KwrO4syvMcUFxLKEdoUzgfoQg
         +HAdudwNRIthy/NI7icbmJQyjZTKQu0b6/9zF6+a6SyNo1J/lLU4c9hwsJNSFLj8clMH
         EnBQ==
X-Gm-Message-State: APt69E0q/ZeBcEONiKbTOP13htL6QQlvQFN1AEJOtocgc+HoW2aHW2UT
        Za0FMrUigx9tfojt/IFnAqU=
X-Google-Smtp-Source: AAOMgpdlKf7Y/10ep148BjfI2ZZ3XqlY2Vi4DXjvH1tSzEN16yJlLIovi1k0MrC5y/I5mWO+kFVG0Q==
X-Received: by 2002:adf:86f6:: with SMTP id 51-v6mr2244751wry.232.1530720771958;
        Wed, 04 Jul 2018 09:12:51 -0700 (PDT)
Received: from e6-mvucnik-xps.ijs.si ([2001:1470:ff80:e6:916c:c370:4e45:3d9])
        by smtp.googlemail.com with ESMTPSA id h2-v6sm4119860wmd.0.2018.07.04.09.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 09:12:51 -0700 (PDT)
From:   Matevz Vucnik <vucnikm@gmail.com>
To:     bjorn@mork.no
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matevz Vucnik <vucnikm@gmail.com>
Subject: [PATCH v2] qmi_wwan: add support for Quectel EG91
Date:   Wed,  4 Jul 2018 18:12:48 +0200
Message-Id: <1530720768-18349-1-git-send-email-vucnikm@gmail.com>
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
index 8fac8e1..3850280 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1253,6 +1253,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
 
-- 
2.7.4

