Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeBFTxM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:53:12 -0500
Received: from mout.web.de ([212.227.15.14]:51235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeBFTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:53:11 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] hid-a4tech: Delete an error message for a failed memory
 allocation in a4_probe()
Message-ID: <236c998d-02d4-f120-3d03-4619a2bb89d9@users.sourceforge.net>
Date: Tue, 6 Feb 2018 20:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:YHdnb06PTueNkCfRCzbaaacZ5s0XIqzvLBSBRrCaeYJakMbpRAq
 EnH9FKbGt/R6Z2TLMxSvajvD14X7KIZc/WZ/jzpxU9yt5sIKOahb7eogxHL3pQ2KKmHj6SP
 AkybrWSyHtV0fqqM8c00A/s/yQkwAFzo/WGC34+d4+r5z5N55HBLlBes+sOphIsWPJ578nT
 qcCYe1E0RiUTXsjjodM9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nn816PF6jFU=:+ovSlKWET5KrdwOb8U1pDc
 bIzSfvG7B5vNEZkBLxvllmiASrn5e00utKchQvoY7Jtm2bih+vrgNMtlOOaYdLHBNcu/j95KP
 lz3czrNInF10JIBCZySEWnIdviaPVrwWCdI5uW2qwdQunCGXuJ2ue4xz7liDrg8/2ZwpU+yHX
 36ndpptkDsTmTnqePrgtgnm2KartRSBX9+HwpPmUV/egxCgW0w6VGzv7r/FsiXU4WJCvCRJRQ
 DJI6lFGKCNFzBFZD3TC8sKPzSw8q69ZNh5xTxEYKUkdKnoAalQF9/iEU8v1/BDbSfH3g0SzcE
 aE/PLo9Rd5GmHVUEu3VWoBu38BJ/ugvY1u6OZK2WwF1/G7g06LpMNtsGpk1n3rBwyiylfVP1U
 CLmmjdc6eues/Qkdfj5XNi/VJ4KJtQ56dPSl+dt1Utq7ybRn82GSCl5rLxlFhVtsTSA3XBYDX
 Qdyt7rVQjq5UuGNTwRe5rphW91IECM9Dn+oLDD+/0ffDFOeJXu71AEtncyTPo2rnarZ5HPwJz
 XOgcDPY/2qdwU5NfyU13JmIJBrIPHH8g3oT+sbS9F75ZDehgoDRsepTNPkDA+wNu11+JbfM2/
 hcjwImx5c2EUdmtlEY32Pjf1k6ISgiJ2KaY91aEGLULCRQA3B4l3A6N5gUI4QoeTFCDYY0ETo
 Oagf/fPk2/jPd7zl073FoN175lLjciVkOxRGtlKOl6nI1hxPPfORAU1U4efQV1SVKmSQrYyXx
 DmlIPGBRSZRpnjChi8HxTE05h/JuemSce2ZNXangaEUiPD8e3x5sTZDCYFm3JOY91fllxWGSb
 gPR0AUE9nviYK/dVUw5rkxnYluebJVGg2PygJKbf78lf0d9BC4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 20:48:04 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-a4tech.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
index 9428ea7cdf8a..7a364f17f39e 100644
--- a/drivers/hid/hid-a4tech.c
+++ b/drivers/hid/hid-a4tech.c
@@ -91,10 +91,8 @@ static int a4_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 
 	a4 = devm_kzalloc(&hdev->dev, sizeof(*a4), GFP_KERNEL);
-	if (a4 == NULL) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!a4)
 		return -ENOMEM;
-	}
 
 	a4->quirks = id->driver_data;
 
-- 
2.16.1
