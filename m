Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A29C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF2A21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:05:36 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGRFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:05:36 -0500
Received: from orion.localdomain ([77.2.6.87]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdv2u-1hQZhb406o-00b6Dt; Thu, 07 Feb 2019 18:05:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Thu,  7 Feb 2019 18:05:31 +0100
Message-Id: <1549559131-7423-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:o/bJtBDVg/nz+HvTddHfXCLT6w0T/Ro5emGw+ibhZpKu1WvN3nr
 +gix8ATNP09B1I0McgkmxVm1iiTQlPz137e+ucw0/3bued7oYkjerfTzDMfcg9pt6Fjph72
 TV5bli4erTuQu/+Jc9fYgnemloBCtRgfv6hEtAjzw+lWgd2UPHLn8oZ9jM3cmIZKFhykyIE
 GciqOuWd8k3lvfzcQpZ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:04JJmCySCww=:24R3lQIKbIHmjPglMEyLJO
 UXQiw/mZf5ezSRYZa4G65xn5efu9jLbJ3qwjjym149jbcHuFr1xXMq8aoJLT6MNYmwdY+ShA5
 fZtVggciihOnc0Oo4pEgfKrakhkcOEwJWHS1JRxUz3pG64kI32IMi1y3UNSzKBjUKIsM/iq+2
 wj//I4ba0Cc8DO6IanBRVC8cQoZq3CuI6r97zslG9/LB6MNmPi+sCBgagXvhbNx3tYC2rfVeD
 7+EaEfKad+FMWhxq466U4/4cMtVfyT2Bqh00LIjtEt90ZReD1JrYCde36DqrsMuAW5bBzM9Yx
 tu1OginIkTmfAaoUDuA5mLRU7XdWMjgrF8XC+iYXO75cVwM0YJVC0lFeXv/jitlzD4GPARXkD
 ZvgAoZcArZnFe4/U0XaLuSo5Fcnvs2P/xKH11udlLVfX+SVOLGht034CccUkwU2xtNsgOe4K3
 szlC8/Hi7WLdCiRe2ClkG2mnmZK6DThwbkpv/PVALglGhp24dLZp5bRhmfbWOjZUe2EJOR66y
 4UkZHUw3fs6Heeyc6oRbcXuZat8pW1ZrY1STyD63OtuIe+qHtJbm7mxQ96dDavSBD7Bjmdi+d
 vIkzyRWHBBozMeLYRMbBAQx0vLVTKBM4VDEYdv9vtjueoCeFaJFZpR7hLRnPcTOV7mb5AErCJ
 NLnVCZ6A0GjeAVpC6On9FqyNkCLw7hxBD33wz7QYKfdAAMl2Syyo4ZbnRtBb0ESMpX959pI/n
 lU84WYJ86K5klXfV2p/NLxKESTUcMzyhP0dRwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name ('gpio-keys-polled'),
allow the passing a name via platform data ('name' field was already present),
but default to old behaviour in case of NULL.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1

