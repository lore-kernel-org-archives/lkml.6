Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeCJVbq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 16:31:46 -0500
Received: from mout.web.de ([212.227.15.3]:33629 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeCJVbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 16:31:44 -0500
Subject: [PATCH 1/3] wlcore: Delete an unnecessary variable initialisation in
 wl1271_acx_sta_rate_policies()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Message-ID: <76c402d0-e8eb-9b05-20c1-33db7e5325c2@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:31:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:lY2VtkWBKZfCV0QOgJfa58YV4a7KilA9OZodPFYlHoIwzPbS0+l
 sW1U5GSUEQC259Ze6s12IcM/XhIgggDJ1WOJ5JsgrwztjeIjzLeeUrOeWUdW0GaJITfLJd8
 D/Tm3KTF/FOfEnKGzXVzYl2ac1iDqyglfSV+Q5XRtMUpX9dR4E1WHAhNeR8tquTyyxDC0w7
 /paO1wYRCTxU2L7xRdLCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fZPjhbhN+Eg=:sLryy4fXYF0x2bKd+fDvu7
 /X7MoaAVoDeHWWVjUwIa5K+VHzizBaVjw/M7Pd7jpMvStBVjoEkZrNB6pDusuZ4mDk/XBli5J
 8X2U9McPBFFiUEbSG7mbkjteMeGGoTTzwVkpGZmlrf+Q9HeWkkVZsHd0zb+GxpZ1Av+JPvxzY
 dZG8sIAe+JzM478h2aE2G2G5M+Ttfrv5E7sc4mWp8Y57HAjBT8uIvbmxz9SHUic/ijdmntzR5
 oAGNzPAHyGMmM9nBcb8ghdyUggy8J/5ws36r7zAeDTWIwwllvdhRg4Py/5KRMt92mdvU223RR
 C/Lf30UB48jJhtUQYmiuIngzbivnd9tP8zgb8GczJ9xOseIoY+doxE9mcAwCoOrpnaOHG2EXa
 lVvMwW7eToFioPBANydUiR2hhlLE4kIU6OFzPwfT7t9OFKm2wGTXXLeiZuLulhTEYBkBwHJWK
 p1gVrXBPmVX5f1xpD7mFhOAby+Ij1Rn/WzDVBxYyXGGLMSIrMfHCSgt7xPFFEqeUOJT5FXUuH
 I6kYp0frvFyyGXQOL10v45K88WsAVjB+4nMa5Y0yAoTPEX7pWiHeQyP69FEIcgp0HoBSBtcUp
 f5WhMpcYa6nLt4uR6SpAk1pPQ3Mpv8GFLK2EA80BdNxUo+x9o5UHvIpNEvqnOoNkmYDmtYYPU
 aEADlRH+WU5Rltp31JRmspdhzOgLWZ2hJGoHaIy/KTBUf6psOaO0OiHQKnd5DElorXn3hWC5p
 FG3F55OExSbPWqQ4seR8doarZa5oNhEC7cu/LO1ErArdGMyfr6zNU6J7Jl8ananknCt3Yqchf
 m4GyC5Q4RKKxwci9H4RKfDillq4lNFVQU5/mFcVtLhLEgm2s5M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 21:51:17 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/wireless/ti/wlcore/acx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/acx.c b/drivers/net/wireless/ti/wlcore/acx.c
index 3ca9167d6146..6991fee8fe61 100644
--- a/drivers/net/wireless/ti/wlcore/acx.c
+++ b/drivers/net/wireless/ti/wlcore/acx.c
@@ -738,7 +738,7 @@ int wl1271_acx_sta_rate_policies(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 {
 	struct acx_rate_policy *acx;
 	struct conf_tx_rate_class *c = &wl->conf.tx.sta_rc_conf;
-	int ret = 0;
+	int ret;
 
 	wl1271_debug(DEBUG_ACX, "acx rate policies");
 
-- 
2.16.2
