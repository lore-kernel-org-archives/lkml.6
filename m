Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeCJVcv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 16:32:51 -0500
Received: from mout.web.de ([212.227.15.14]:43801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeCJVct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 16:32:49 -0500
Subject: [PATCH 2/3] wlcore: Return directly after a failed kzalloc() in
 wl1271_acx_sta_rate_policies()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Message-ID: <8ef461f4-5103-9181-b68d-e31720206ee3@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:32:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zoadzWvpykN4eCs0r7C+kA+K7rw4bhElcaU4tdKarkbDhSk6V3o
 t3U/Rof8jzeTPX+YmH2lnX/a+Ko/XXhN2t/inKIsh93S0vptWAyVhdiKSaqUWTwJNJp/BZG
 2cbTZUSHqRBVckTQgxsN6kiju7rrnd/K14aSTFAdTJTTikva0qtvoRv9kkPZHQHM+Dpmqhw
 NariMnWaGdJTI7dB4HXtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4T86/VfMj08=:GwFeejgDwRfoZbiIk+d5CF
 sOQP8y9Pj0xQmDBj7n0pYbmBsCF0RZCwFPPGhil6IENTOLOns2fXoj/PmcJIVCtDPzsMtULrX
 orkKYcDCzPJzVfKKCHEf7m4fNlYVENhr79T6FA3JkQtMvgXpoU9sBWN/6Upz7WefDb5PI2JlV
 BPddSGPNhuCtaZ/8EAFFf/q9GAESGFMSussJc/WFTEQ7+MskkxZVhF4GsGK0iZyHed7es54cH
 ND/HdLnVXer9SScDWKCU/jjlTsG8EjqvS1L455aRauX/mdjf+iC4ow5Ly+U1L8n6fvh9XSyVE
 xIPuwtFBDC9bXz+ZQguiLPHCyjrEPlw2OS1mxzSX7IQT0NYvo5e/CXGm931Wq/3GhB9UVIwEI
 e0d2xUDstoRSm9Tiy3EcXPpoMXBucPG122wd639l0c5KP5GSY+xoK0V1CL5unO1Augookj/Ld
 lKQ+s0MIKobFRtlC+/nzNBeQz9g+6hFB/VxUAx5NUBB0K4LHfu3bheBRIHkn9DXszT9EHtkXA
 UdVY7hTJTNlBiR2pjNhNtlREn+sJPbRGX8Frymf39V9jHNCDh+sz3n+dCbCYQ3aGblo0YZlBK
 xEP9Kqa8Yb9LusyiagC5yTFvRZXk/a2Ux9yrLmYY6lhhqmSRP9P/JmfYmDp2d1TPe+k0pbOIY
 LmFly13QsgFIgCd8UBb+7VsHCWJ/mfrrSTx54w7BX7ZegFQRLHAhIfqaLMI7bj6/DsU9xJP1f
 Qx4n4B+ArhYImo6CiIiWh12djp9mJg6E8N8D8q3Ut/WuoeBQWyo3Dqza/SD06ok5BktxvOJu7
 bsVPqMJNl/bNugbxGVuP7/PaQ5L2ol5LR5oMqN1C/h1z2tU6JY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:00:31 +0100

Return directly after a call of the function "kzalloc" failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/wireless/ti/wlcore/acx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/acx.c b/drivers/net/wireless/ti/wlcore/acx.c
index 6991fee8fe61..1cc5bba670e1 100644
--- a/drivers/net/wireless/ti/wlcore/acx.c
+++ b/drivers/net/wireless/ti/wlcore/acx.c
@@ -743,11 +743,8 @@ int wl1271_acx_sta_rate_policies(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	wl1271_debug(DEBUG_ACX, "acx rate policies");
 
 	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
-
-	if (!acx) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!acx)
+		return -ENOMEM;
 
 	wl1271_debug(DEBUG_ACX, "basic_rate: 0x%x, full_rate: 0x%x",
 		wlvif->basic_rate, wlvif->rate_set);
-- 
2.16.2
