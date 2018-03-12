Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbeCLLcs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:32:48 -0400
Received: from mout.web.de ([212.227.15.4]:53597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbeCLLcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:32:35 -0400
Subject: [PATCH 2/5] Bluetooth: btmrvl: Delete an unnecessary variable
 initialisation in btmrvl_sdio_register_dev()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Message-ID: <86aa2939-9823-f3ed-0cd7-0ca04131cdd4@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Xfq4Pr1mnP2N7GYy5+1MaCmsoc/Bs6dzWruJ8bMxV1kRnfjNjiN
 rS96xUxvjJmpikGO83K5Ig6mZfU6MRxJSrjNzvsT3GFMMJfpIO8dZ5fHhcGndOdC/9UobAZ
 WgihZR/dQq/E9Il+sHDaGTrxl2EnLBuY+cGXVVAxNtaZKfAFR008rdmJ4PlLXtZjFfrjOaW
 Kv6yUIwpa4NtCNfSuHfmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:abPFh4TcAOo=:GIfH1EipI0qdJY6URvqzOW
 ayNV8LsrGdszBkzXXvt92X6ZrtbpStaRkWSCvlXuUSYt5zJkkK32N3vLAhOIGcfyG8LswctFB
 NkxaQt2E+6znwglmq6/cixZnMj4yh9pcbCjtojS8LOZLKqNCSLLPnLJPtt1xzkz3QJVqrq00d
 kxJyQmn8S4ZfID4UB7mTW5Zgb/FczBFqj3fMD2mDKWIr7APGVhFDazjAtE40peNqp7Z9YZ2wj
 hh9VgEE4Q0ZOYrexy0vi1iVQjl4ROarEDYvLvc8DKPSIImPcA5M+MUBVf7kep61Ps0quF9Xgh
 sWfloPyO6ZAbGcN5beTjOrEd2A2g1IU1rTdbiaFDzbi8Uenp+o9V9o6ZY6XJT1bRyoEo+aU7G
 fvd+ns53YuSvqb2ZrC1IHqN3XBRdt55gSi0fadKUcawaCSANqauts0HzYzwqTSevnXF/6MTNR
 0bgUo+rTafHk4tCsznFKy16fBr2XRfJh2nxPjHu4WZfTC6rCrRerzj/ZXIeM7ZEGnxiyUiKMt
 ks/aMm1XvJAVdEIzOE49L3r+19tFH4DRebww7ya9GzdpmvDoSyGouo0nSDYJayE6jse7yt+m5
 UbFZi0mhpqD7EnsL/1W3Kk5i7h6PcIxxbhwCmX2qHozcWdx3+Nq2lbPJI3dmWyP1kfWFY2erY
 pGd5zTfXb2lG0h4l8zQQnulQsOmYiWazQKxHSwvjmQDncWVPiKwsT6xVaF3jI0929CQY017AP
 wv/sqA7DRFHeglcOx/zL+yTT/dLW5EzpL3JP/B41GdnATO8tU/bMfVVDeQA/AskPnn8mckO9G
 iR9mvRSWLdi0AdSEWRKzoeAxkYu+HKUDzNuu2JVuf5znVkNFWY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 10:20:04 +0100

The local variable "ret" will be set to an appropriate value a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index df2a04bd8428..84c222abf0f7 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -920,7 +920,7 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 {
 	struct sdio_func *func;
 	u8 reg;
-	int ret = 0;
+	int ret;
 
 	if (!card || !card->func) {
 		BT_ERR("Error: card or function is NULL!");
-- 
2.16.2
