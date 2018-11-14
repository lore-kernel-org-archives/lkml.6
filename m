Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEEBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEEB22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEEB22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeKNTzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:55:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:48309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:55:05 -0500
Received: from localhost.localdomain ([217.86.137.241]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEKZg-1gGE0h38Xo-00FTCb; Wed, 14 Nov 2018 10:52:27 +0100
From:   Tim Schumacher <timschumi@gmx.de>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vojtech@suse.cz,
        dmitry.torokhov@gmail.com, timschumi@gmx.de
Subject: [PATCH] Input: iforce - Add the Saitek R440 Force Wheel
Date:   Wed, 14 Nov 2018 10:52:40 +0100
Message-Id: <20181114095240.25967-1-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.1.450.ga4b8ab536
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FvUnBeT2Zed4KGwqy3PMf9bvUwXX1Gr8LsTMLk8ALZjPzZyqkrj
 VdiADVLZpVcTfp/CzF6RA26TwtKr5Sy77RInTkDwBrznpORmahYDv4LVHQTSIF/u/wQB+D1
 JfUJxblHG/QCXh/T+eaRZmRpDX1+Ovoj1Fg4IEBxGEHGYeZuPF1i7spucmwQVgVq/7n/Mn9
 NFCcOxDkyNfNBGlsEPA1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q2jwp9KyV2w=:JZLVOPM8RomgpButgWoR2I
 JFUed1afuhHyZiSeH/uXQjthfj2H3EsvTjz30nm2RZlAEDocsXQPsbTyqldcQo/UO5kYKcx25
 WFPlMzVzQ95pXTpQ0Qtk2MetaeKQ2MQO+cl1zJ4ySw61MNF0ekrHR6M670H70PSpeSZatxhol
 ZYM11YLqY8dJhtq8bPHhYn/AGl5iz/BB7a9qYTqQ37UCyeClbDitLAIWn5flPkG2HnHoEScY7
 8gQxBLIKdjfkwyT3MlQx4l3gWyMO7CQnLKPXBmcxwXF8hvwk/uM5ArH+3Dbxt5io1JyE2U621
 Y1HwO2jpRHE9/p2rn51848oA7Qd8zYwNVb7bmsXlELpoIxUEg/xwIRhjm8pZ3AlhhgNLBnIly
 HaLdZ/uqpgDqjlyBg9pvTT4BXxK2Zl+QMeWg4BFpuR0VD4LNIefD32F+sjUNFBcr+iO2MSMGP
 C6uxtQtb3h8XA3u+SmlDO0IYYHoUD74FnNZSrvO9dju0whnC+bXnpHsAIztVPbpPITxHxH2/q
 vw5NZluy4EC6EgT5tzRMIa/yEooSAVp12Jozj5+PnqM4UGRNyo5uSq3Of4o3TqbA3mLu57Squ
 eLUK0WkTMbCLE0vCj2xZ5FH6657Y4+Z6ClIZzJ7MAN6CVfMIQh4LBbLdIImgOQSakj42w4zFo
 KcF/fjco3lApEH0e/WQa3FSmHmaZcpbiprLLjS7KbUiAUKHh9VuXzBiKYdvRznmY0q9fGovpf
 SGmixzq/28Mp3YE73R2rBuE3+wp/xJB/MP6fMpcQYkyce+zKt2H8xi/nN3xmTrwXE/kRzvS5e
 bqhpupx/UlqmyjeVThbMYPWl1JoloJAXqFg+VIDNx4oI4u3c2ghHOHj4k+ZPcBA6yE00H0bWd
 YorVc17PJPZfFfu42/q0+aFi/Jpc2+PPDWlCQ/3i4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
---
Please note that I do NOT own this device.

I'm adding this based on the fact that this is an iforce-based
device and that the Windows driver for the R440 works for the
Logitech WingMan Formula Force after replacing the device/vendor
IDs (I got the vendor/device IDs from there as well).

Please don't add this patch if adding devices based on that is
not ok.

Also (not related to this patch specifically), does anyone know
what the question marks at the end of some device definitions
are supposed to mean?
---
 drivers/input/joystick/iforce/iforce-main.c | 1 +
 drivers/input/joystick/iforce/iforce-usb.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 58d5cfe46526..432deecaeff9 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -67,6 +67,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x05ef, 0x8888, "AVB Top Shot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
+	{ 0x06a3, 0xff04, "Saitek R440 Force Wheel",			btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0001, "Guillemot Jet Leader Force Feedback",	btn_joystick, abs_joystick_rudder, ff_iforce },
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 78073259c9a1..cdea61ae838d 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -214,6 +214,7 @@ static const struct usb_device_id iforce_usb_ids[] = {
 	{ USB_DEVICE(0x05ef, 0x8888) },		/* AVB Top Shot FFB Racing Wheel */
 	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
+	{ USB_DEVICE(0x06a3, 0xff04) },		/* Saitek R440 Force Wheel */
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0003) },		/* Guillemot Jet Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
-- 
2.19.1.450.ga4b8ab536

