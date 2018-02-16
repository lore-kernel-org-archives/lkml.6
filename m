Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031023AbeBPP5q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:57:46 -0500
Received: from mout.web.de ([217.72.192.78]:33185 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030613AbeBPP5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:57:44 -0500
Subject: [PATCH 1/3] pata_arasan_cf: Delete an error message for a failed
 memory allocation in arasan_cf_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Message-ID: <05b48a33-81ae-b1b1-428c-4a9a0c9a4fe8@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d492f9d2-ed64-e858-441a-fa554369032c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:4PRvHQI2yQrzzB6WbojX22Ju+MhJ0Vt5eLtYALPJlIeBUjDiFK0
 598j8fnnUMgiEDKRqcjFtKvK2d/JzdU0YEa18h68NNqOQvfhYxUTX6edoHtwMxhoNkr8a6x
 9qAM5647y6qWNvGqw8MlYoah5ZYDg3G8qKkQGRh9Dsqpcu6irsFfQIKKolGF+6jdp1/AIXQ
 1eKVIz6joDYSfTIzg9SbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:00V2dxCnpZo=:Cn7L5SxC99vopeEDycDVUO
 EVaT281BZNzNbfmjk+zHsgsdt5ixZiDndtKfVSS0d5QqtwqBJE4HG+aBJJa227AYMcMLBCaF6
 ePBwpCTUryrTBI+8gFJs/fSexaPVDBtI71MmKayjDpP0rpoAGQd5OQB20Kbj7l2p7qV+785Xt
 5Jn+Zcl+SnVqiVGCoAzCWwTaX6VDeh6Fca+0pbPGpjHsQSQmWiArWvsd2S38FRbkdoyBdMVAO
 Wnk7EbnvaTlYgTuG5vfbVlfVKAp4Vg1g2o2xlkQB0kaxKeeKLFpgw4wnqLfMnxRGg+FLTSUON
 cgZtxLOyChRgDzmxHRPxVUGBNOZ6eCpthMK7WHsoAI3wGe+ViWqtLNlOSGFFuWrnbdpu9W3eS
 fSvpB8pZ6Vpp1ypFgJtIbdTOjpY/Sly+F6LMo14E6fDCW1Cs+IGumF0f+i29bbZQLbHeNtJSh
 JKbVkjx3XIGs34oZfe6ALyCILUwrkFJs7ksYM5ZBXWyyAUqqyGTn+5YG8y0YfDKy5Q0mfh2Nv
 pfMuDYzys1+vAxjLljMJHUQGbgP78JXOKoksmmsH/8haHrKPO8cDTrvQ2iM3mmlNj8pUe/m16
 Hp2gaiTpzFi1CKTVRDpyctZZ5qv9ASuoRBTAcEvt3AIytN1kjw2U64VgQsVZWIhlNvzweBvB+
 Yn62zd4YqE3i+RpE99DpZtX/s5Np2QcFD2SIV5O37z5vty47yvEEi/wF0KIhajLQkBEIArh+7
 XvdJP/8Jgprhtv9DNme32aY/3bZ9pYtvLrYbLFe1wuneT/vvEdGMCp36F4OcLgBCT007EoaJh
 jlWlVNPgEJy3Ng9P/TcJgkxNTC7mB0hVRQWEo+Y9lQKDbCAZHM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 16:01:12 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_arasan_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b4d54771c9fe..be5fbcedecbf 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -809,10 +809,8 @@ static int arasan_cf_probe(struct platform_device *pdev)
 	}
 
 	acdev = devm_kzalloc(&pdev->dev, sizeof(*acdev), GFP_KERNEL);
-	if (!acdev) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!acdev)
 		return -ENOMEM;
-	}
 
 	if (pdata)
 		quirk = pdata->quirk;
-- 
2.16.1
