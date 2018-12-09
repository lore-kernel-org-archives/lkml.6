Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A603C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACBD2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CHw6CpTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACBD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLITBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:01:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52712 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLITBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:01:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so8791640wmb.2;
        Sun, 09 Dec 2018 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKSka/+/cVpRHh/4vbzTPbz+qQ+/vVf1kkbTmUZ6zvo=;
        b=CHw6CpTPHF19FzbrESn/kQOq6RBZjBX2S9LWGTvd4Jy5/8hOTLvK5HaSUSsTjyX1xs
         LGrSGfuk+YX1siefrZpEO2MfetpTNMBJPehrBu1bYDwZk6z7xwYUAwJpXYhqIFYXycZ2
         mfp5AmwylQj3T79OqV0CnFOGUrte4hj3bZCwmJ4TUren8ZJEeIWaD3JVr0UFENi74RtA
         28bdnI92HVtRQCuAoYYWN2r9D9dbuxJHM5Ca4uwhxwiGRhjT+RsBdIXFBn3GW/fXz8eQ
         Si9R+aUBbSZdgu+jIvtCMfGJ53rIeSF7CzDuNBxg0I5a1IE4pWpHFPSC3MsEi8gfLWHe
         Ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKSka/+/cVpRHh/4vbzTPbz+qQ+/vVf1kkbTmUZ6zvo=;
        b=B0PXIeYjemZwSGl4mMmVZTpC4mcCyEdOFWQM1GiAYB+361xR3WzsP1JoRvQQkL5+Ug
         TcotRwxVItoHcs7yGs2FCc2YGN/yRVM0XUpKx+80/JjBHGVDmDLpc4vF8FWj0U7Wbtr+
         DufCuFqijCSz9BuExHboXahgABQHperMZsXR9oxn6jLL2O9Wp+02r5ji/Z0+ZsJnjwa1
         bjuI+nph6X2nwsSA+uG/K5bZ0kEnGyJJW5mguytucxmq+jJ0TQNkfacdsUEP6X05O6+S
         uouk/6xYnqujnWqeRSW/RQnbLxrWRCc2BQzfzUuJy/26AC2yfupfWXLLtqoCbNTm7g8h
         9Okg==
X-Gm-Message-State: AA+aEWZGOX959fPea8lh7arz6YywgdhrumBVak4MZM8axvEqdOn8bfVs
        wqYo5LRay+BHQ33MXfQUwP1M0fk/
X-Google-Smtp-Source: AFSGD/X8xBh/cgoJxf6cXn7CZH//Zs45FpKW5F/aGAR9KTjB9/fJPP0PAoWaL249Vj1v8NrGS3Z1TQ==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr8724696wmf.46.1544382106224;
        Sun, 09 Dec 2018 11:01:46 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l197sm30560215wma.44.2018.12.09.11.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:01:45 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-usb@vger.kernel.org, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Arthur.Petrosyan@synopsys.com, christianshewitt@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/1] usb: dwc2: disable power_down on Amlogic devices
Date:   Sun,  9 Dec 2018 20:01:29 +0100
Message-Id: <20181209190129.11870-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209190129.11870-1-martin.blumenstingl@googlemail.com>
References: <20181209190129.11870-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable power_down by setting the parameter to
DWC2_POWER_DOWN_PARAM_NONE. This fixes a problem on various Amlogic
Meson SoCs where USB devices are only recognized when plugged in before
booting Linux. A hot-plugged USB device was not detected even though the
device got power (my USB thumb drive for example has an LED which lit
up).

A similar fix was implemented for Rockchip SoCs in commit c216765d3a1def
("usb: dwc2: disable power_down on rockchip devices"). That commit
suggests that a change in the dwc2 driver is the cause because the
default value for the "hibernate" parameter (which then got renamed to
"power_down" to support other modes) was changed in the v4.17 merge
window with:
commit 6d23ee9caa6790 ("Merge tag 'usb-for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing").

Cc: <stable@vger.kernel.org> # 4.19
Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 7c1b6938f212..38c813b1d203 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -111,6 +111,7 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
 		GAHBCFG_HBSTLEN_SHIFT;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
-- 
2.19.2

