Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD41ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B38820664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tf8az2Bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B38820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeKAJWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:22:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46320 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeKAJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:22:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id f8-v6so2832860edt.13;
        Wed, 31 Oct 2018 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46/NOuoiPhhGNrGWXzwwHseMHtA5x0+HvtY23ixXS+s=;
        b=tf8az2Bx2CeDO02zJ1rCCAXLkt9edprsTLl8+mRmCqVZj6cb3JFualyjCzmXiJCr3b
         gr0znxUuMe9ifSfWm1IruZc5iIrns57Y3jbr4KDrBocs2QlvzVCyom7qo7pq+QNtKVtX
         AhwGz7GKSCb06ohW+FYJQM0vJNQwGjS7PjJvrE7+XEuAWzQCeK7ck7eit35hQ+GBAovO
         C7LS9EKFvBFUvrkOqLVb5BCn/WHmuearXlOq+QWuR6Xhas/fTTB5zC/EwubZseC5ylR0
         BMOsuum/VqRvVpEx7KoLiYArT7giNrQB87L73sRM/W6COJyAcTlKjo/CWnGRoJc0g2Nh
         F/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46/NOuoiPhhGNrGWXzwwHseMHtA5x0+HvtY23ixXS+s=;
        b=UgE79G6H507Ryq55RAk5hIRlXkexeXodtCMC2OQeYYDJVaGInsZ/fSsG7Yq3Pr+HCF
         QeAzZ4MVvR+5fDtQsT2sG0xnBsrrDiSpMMwhE3NTYCwFVSeZ4CTP31gL6DPjjMA/hTU3
         /eDe++3z0BSxtPz8ATGD7dmyZrd2NYR8EU0yhUUy5DQWHxXpao1whNm3EZ/q4IyTWubR
         cv1tn0e5YrU1iWUg1D4+7rJuWKsUsTUN8foU5LaVkiy+uLMa+UAbUp3dI/nSM2bgsii3
         i25JjQyvE8ZeNmGYFhX+g/qaLyF3BqDhjnbp02q+rA5IlMFJXxfL23giKPGxFHsGxGMf
         7WkQ==
X-Gm-Message-State: AGRZ1gIVD+reQOR049HDml0D84+5d2MTnUHNk9ucCjkzEVQkco5FHPqE
        Tp4h/6vuBqk8R90H6dbfxBI=
X-Google-Smtp-Source: AJdET5d38Uv0WuXi6Bs2UZLPsgdsTja12I8JiubCuwwh+/A9fTZWhnvPZy4l8Fkj7VCb9E8SBcSJ/w==
X-Received: by 2002:a17:906:2201:: with SMTP id s1-v6mr2812543ejs.31.1541031704495;
        Wed, 31 Oct 2018 17:21:44 -0700 (PDT)
Received: from kiddo.lan ([2601:602:9400:bc9f::a3c])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2981468ejd.3.2018.10.31.17.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:21:43 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     hadess@hadess.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 1/3] asus-wmi: Tell the EC the OS will handle the display off hotkey
Date:   Wed, 31 Oct 2018 17:21:26 -0700
Message-Id: <20181101002128.28884-2-jprvita@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002128.28884-1-jprvita@endlessm.com>
References: <20181101002128.28884-1-jprvita@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past, Asus firmwares would change the panel backlight directly
through the EC when the display off hotkey (Fn+F7) was pressed, and
only notify the OS of such change, with 0x33 when the LCD was ON and
0x34 when the LCD was OFF. These are currently mapped to
KEY_DISPLAYTOGGLE and KEY_DISPLAY_OFF, respectively.

Most recently the EC on Asus most machines lost ability to toggle the
LCD backlight directly, but unless the OS informs the firmware it is
going to handle the display toggle hotkey events, the firmware still
tries change the brightness through the EC, to no effect. The end result
is a long list (at Endless we counted 11) of Asus laptop models where
the display toggle hotkey does not perform any action. Our firmware
engineers contacts at Asus were surprised that there were still machines
out there with the old behavior.

Calling WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2) on the _WDG device
tells the firmware that it should let the OS handle the display toggle
event, in which case it will simply notify the OS of a key press with
0x35, as shown by the DSDT excerpts bellow.

 Scope (_SB)
 {
     (...)

     Device (ATKD)
     {
         (...)

         Name (_WDG, Buffer (0x28)
         {
             /* 0000 */  0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11,
             /* 0008 */  0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66,
             /* 0010 */  0x4E, 0x42, 0x01, 0x02, 0x35, 0xBB, 0x3C, 0x0B,
             /* 0018 */  0xC2, 0xE3, 0xED, 0x45, 0x91, 0xC2, 0x4C, 0x5A,
             /* 0020 */  0x6D, 0x19, 0x5D, 0x1C, 0xFF, 0x00, 0x01, 0x08
         })
         Method (WMNB, 3, Serialized)
         {
             CreateDWordField (Arg2, Zero, IIA0)
             CreateDWordField (Arg2, 0x04, IIA1)
             Local0 = (Arg1 & 0xFFFFFFFF)

             (...)

             If ((Local0 == 0x53564544))
             {
                 (...)

                 If ((IIA0 == 0x00050011))
                 {
                     If ((IIA1 == 0x02))
                     {
                         ^^PCI0.SBRG.EC0.SPIN (0x72, One)
                         ^^PCI0.SBRG.EC0.BLCT = One
                     }

                     Return (One)
                 }
             }
             (...)
         }
         (...)
     }
     (...)
 }
 (...)

 Scope (_SB.PCI0.SBRG.EC0)
 {
     (...)

     Name (BLCT, Zero)

     (...)

     Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
     {
         If ((BLCT == Zero))
         {
             Local0 = One
             Local0 = RPIN (0x72)
             Local0 ^= One
             SPIN (0x72, Local0)
             If (ATKP)
             {
                 Local0 = (0x34 - Local0)
                 ^^^^ATKD.IANE (Local0)
             }
         }
         ElseIf ((BLCT == One))
         {
             If (ATKP)
             {
                 ^^^^ATKD.IANE (0x35)
             }
         }
     }
     (...)
 }

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b52b192a4f16..c25b946bb602 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2150,7 +2150,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	}
+	} else
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
-- 
2.19.1

