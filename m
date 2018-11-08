Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019DBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B6320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn1dMsPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B6320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKICio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:38:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33013 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:38:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so27759054qko.0;
        Thu, 08 Nov 2018 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=Qn1dMsPBpCE1TLjEARhiU+vzHZsEDzwZ2ILiAMpRemoJiQcv3S4hwIDJZyi8kEDxuK
         AVLcPw8Qi6sH+OOFzqZOY+x3qdWZ4nF+EajLK90rBYnoCEGxbKzG96sN2QM68X7tZbkK
         xDD0LhJtpuJwxrPltK2ZBu3LAQPiSzolcoJl/+vDsj37L2o179N2S7fYMYuG6DffLzXd
         Y1qkXts9biYCAjfXJRhfSjJaKhrKIG71IwFzVBc0rjlaOtN28c5cYhWhIAIS96uns/2w
         rjNCUkDXRLNqeNOD151KIh4o65OLyNJNn+tz3WP0kcKPfl5ld+G0q39yonuoAt3TmGih
         2lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y8GXMyTR7MZVo9+2nDy/iUhDA4xLhvp/vOq8kA8CSKM=;
        b=gTfbZPb6kcJAVk7RCZDqFmidGGKTfRutD2USAYsKbZ9H+auIjbWd3O3Z483PnTTBnl
         J56nOve1y0UT4h0xiHrwdMck74GqF1DwIDNv4NElfpwZ/VBv8tJlU9dA+sxOQrBHRTVc
         RN2fc9xf6hExXCpw0jzCnJrsk6zNQ6UFCokXVFsm0BObQ7A7+k7/TDmQSZN2pnLyYgb9
         dVTfH/PD0v1c0F8f9xpRRKhdF9GdblOG9Hu2H+jKLnoCHWPqDmGy/nRsBddBnoPopklB
         Fku3/OubxtOhmauwDVMzxFcPEiJIliWkVws7SaJgyrNXHMFOY17h1UtGrGW6BfMkZE7h
         0TVg==
X-Gm-Message-State: AGRZ1gJlFhvlFKduDsrbvmJVVjEWeRpUzfxNlh2KpbOZ7Uo69C4fSXjV
        39puc8fEWFbYdeqn/MkgxFU=
X-Google-Smtp-Source: AJdET5dG71KjjBF/cB67Al7YOT8iac8oDb+5DySk7zFafn8ClCssJ8zU7MFkTcYbQAOSCT4F7a9Tow==
X-Received: by 2002:aed:34a3:: with SMTP id x32mr5060430qtd.316.1541696539044;
        Thu, 08 Nov 2018 09:02:19 -0800 (PST)
Received: from localhost.localdomain ([50.224.228.202])
        by smtp.gmail.com with ESMTPSA id 53-v6sm3172243qtw.52.2018.11.08.09.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 09:02:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: Add support for the Smartlabs SML-5442TW
Date:   Thu,  8 Nov 2018 21:01:08 +0400
Message-Id: <1541696475-27454-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
References: <1541691207-24768-1-git-send-email-christianshewitt@gmail.com>
 <1541696475-27454-1-git-send-email-christianshewitt@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-S based on the
Amlogic P231 reference design using the S905D chipset. Specs:

2GB DDR3 RAM
8GB eMMC storage
10/100 Base-T Ethernet
802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
2x single colour and 1x dual colour LEDs on the front panel
1x reset button on the front panel
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
Single DVB-S tuner (AVL6762/MxL608)
2x USB 2.0 ports
1x micro SD card slot
UART pins (internal)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292..ad79f2d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -91,6 +91,7 @@ Board compatible values (alphabetically, grouped by SoC):
 
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
+  - "smartlabs,sml5442tw" (Meson gxl s905d)
 
   - "amlogic,p241" (Meson gxl s805x)
 
-- 
2.7.4

