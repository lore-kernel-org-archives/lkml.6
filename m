Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3240820-1524146721-2-10430152660637946984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524146720; b=NTGwhBRExEYsGu8qMUPOEFLXxqB44l7Sy3czjsJ89327KD4YV2
    uIzoTl8pHpoM3M4wa0Z7Ah1GQxcAh82h81BYBrd6w3Be3gu218p5W7A2+qik1q2G
    C9JMl0+Eny9tRMDf6hiOm0cHTDWso0ROfFkvzNgqaORAaCr7bz0hpDaundg1kejW
    GnSJCFt5x2Kh7gSlBYSktGkjT3hGpCbOZr9YbLOy5YU8DKtMuBgagrsJZLuXu2IB
    VGqxKkA7qxSgQbmvJ83xHOD1xGwGxk0sj9GrohiYKMCcQ0I5oKvY0Sdhsbw/wSqy
    Cb7hrWJ+XcEkSBqdI9eFNVI4WHUxp/B9oHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524146720;
    bh=pQ+isVs8/ZCiw1R7eMFmv1oZvE3xssUSU+237AgdpLE=; b=mOVdfqurTjfJ
    rtZAvCglDm0InXX2U/n6hOM7obFIk8NSMHp8LReZ4tauGV4s599ki0TyRlsNDRrB
    icTvH1j+yJsMpfjihfz/tWhY9y5f/9WOO73b3KHk6EMbhTN4SACLpscag0A7UHRO
    +WBeYDJ/gPC1zlsmGZWS2Wi9q4UJbyoymE5Wv5n/GHR1XtbmMZptGMBno3wgXICf
    MMpqVy+42s2979D8LX8VyMZHZ6lEwKh06wZ8qEb9A++9Zhm0zX++yaTr0DB/2VZk
    zPyUszAUWpv9s3jSrW09UuB6/odORX9wsJkAAJFJtVEq73IH/vi6qHWKDJqn5dui
    XuaSsq/sJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NoNxRsw2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RyHpfGB6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=NoNxRsw2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RyHpfGB6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOvL9QBskh4ER40DltWmgRdUcnVgrR1fzGO4nP/qTxcqBR8osFCq/2Ro1Abqa9THRJDP0ZIEpEDpqLQJXg+V+nJmaNbr2VrYOw5cDemiXOXs0ue2SHbr
    E6Fh4Br6AF2RoZA/OcNGGmA6UiyaNv6P0HmGIbAuSs5FAAB/wKNFFalshZiwg4rSHS5ORQMCuDHpQxrB21BMZTAslSx8DuAZW2P7NE7WgoOb48m99+PzwCpt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=r1yQAAA-wz4A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8
    a=EqdPLkY1AAAA:8 a=a7YQX-FH10p2eUT3kI0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=SLz71HocmBbuEhFRYD3r:22 a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDSOFS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:05:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33311 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDSOFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 10:05:16 -0400
X-Google-Smtp-Source: AIpwx4/cDX2y/h1orLtAphS3hRKIhJjlyHtJLVxJUlNSY8s2D3qPNpUgNzdhzUkmQuE8eIYoqUl6eg==
From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To: Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Dun Hum <bitter.taste@gmx.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: asus-wireless: Fix NULL pointer dereference
Date: Thu, 19 Apr 2018 07:04:34 -0700
Message-Id: <20180419140434.15131-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <CA+A7VXUb-u9=MDRrZxpwGiuFwQAdYCJoxaZHjLPLAcYc6PTEHQ@mail.gmail.com>
References: <CA+A7VXUb-u9=MDRrZxpwGiuFwQAdYCJoxaZHjLPLAcYc6PTEHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the module is removed the led workqueue is destroyed in the remove
callback, before the led device is unregistered from the led subsystem.

This leads to a NULL pointer derefence when the led device is
unregistered automatically later as part of the module removal cleanup.
Bellow is the backtrace showing the problem.

  BUG: unable to handle kernel NULL pointer dereference at           (null)
  IP: __queue_work+0x8c/0x410
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP NOPTI
  Modules linked in: ccm edac_mce_amd kvm_amd kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 joydev crypto_simd asus_nb_wmi glue_helper uvcvideo snd_hda_codec_conexant snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel asus_wmi snd_hda_codec cryptd snd_hda_core sparse_keymap videobuf2_vmalloc arc4 videobuf2_memops snd_hwdep input_leds videobuf2_v4l2 ath9k psmouse videobuf2_core videodev ath9k_common snd_pcm ath9k_hw media fam15h_power ath k10temp snd_timer mac80211 i2c_piix4 r8169 mii mac_hid cfg80211 asus_wireless(-) snd soundcore wmi shpchp 8250_dw ip_tables x_tables amdkfd amd_iommu_v2 amdgpu radeon chash i2c_algo_bit drm_kms_helper syscopyarea serio_raw sysfillrect sysimgblt fb_sys_fops ahci ttm libahci drm video
  CPU: 3 PID: 2177 Comm: rmmod Not tainted 4.15.0-5-generic #6+dev94.b4287e5bem1-Endless
  Hardware name: ASUSTeK COMPUTER INC. X555DG/X555DG, BIOS 5.011 05/05/2015
  RIP: 0010:__queue_work+0x8c/0x410
  RSP: 0018:ffffbe8cc249fcd8 EFLAGS: 00010086
  RAX: ffff992ac6810800 RBX: 0000000000000000 RCX: 0000000000000008
  RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff992ac6400e18
  RBP: ffffbe8cc249fd18 R08: ffff992ac6400db0 R09: 0000000000000000
  R10: 0000000000000040 R11: ffff992ac6400dd8 R12: 0000000000002000
  R13: ffff992abd762e00 R14: ffff992abd763e38 R15: 000000000001ebe0
  FS:  00007f318203e700(0000) GS:ffff992aced80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 00000001c720e000 CR4: 00000000001406e0
  Call Trace:
   queue_work_on+0x38/0x40
   led_state_set+0x2c/0x40 [asus_wireless]
   led_set_brightness_nopm+0x14/0x40
   led_set_brightness+0x37/0x60
   led_trigger_set+0xfc/0x1d0
   led_classdev_unregister+0x32/0xd0
   devm_led_classdev_release+0x11/0x20
   release_nodes+0x109/0x1f0
   devres_release_all+0x3c/0x50
   device_release_driver_internal+0x16d/0x220
   driver_detach+0x3f/0x80
   bus_remove_driver+0x55/0xd0
   driver_unregister+0x2c/0x40
   acpi_bus_unregister_driver+0x15/0x20
   asus_wireless_driver_exit+0x10/0xb7c [asus_wireless]
   SyS_delete_module+0x1da/0x2b0
   entry_SYSCALL_64_fastpath+0x24/0x87
  RIP: 0033:0x7f3181b65fd7
  RSP: 002b:00007ffe74bcbe18 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3181b65fd7
  RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000555ea2559258
  RBP: 0000555ea25591f0 R08: 00007ffe74bcad91 R09: 000000000000000a
  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
  R13: 00007ffe74bcae00 R14: 0000000000000000 R15: 0000555ea25591f0
  Code: 01 00 00 02 0f 85 7d 01 00 00 48 63 45 d4 48 c7 c6 00 f4 fa 87 49 8b 9d 08 01 00 00 48 03 1c c6 4c 89 f7 e8 87 fb ff ff 48 85 c0 <48> 8b 3b 0f 84 c5 01 00 00 48 39 f8 0f 84 bc 01 00 00 48 89 c7
  RIP: __queue_work+0x8c/0x410 RSP: ffffbe8cc249fcd8
  CR2: 0000000000000000
  ---[ end trace 7aa4f4a232e9c39c ]---

Unregistering the led device on the remove callback before destroying the
workqueue avoids this problem.

https://bugzilla.kernel.org/show_bug.cgi?id=196097

Reported-by: Dun Hum <bitter.taste@gmx.com>
Cc: stable@vger.kernel.org
Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/platform/x86/asus-wireless.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index 343e12547660..b8e35a8d65cf 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -181,8 +181,10 @@ static int asus_wireless_remove(struct acpi_device *adev)
 {
 	struct asus_wireless_data *data = acpi_driver_data(adev);
 
-	if (data->wq)
+	if (data->wq) {
+		devm_led_classdev_unregister(&adev->dev, &data->led);
 		destroy_workqueue(data->wq);
+	}
 	return 0;
 }
 
-- 
2.17.0
