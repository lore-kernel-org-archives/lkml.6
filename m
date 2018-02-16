Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967090AbeBPMic (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:38:32 -0500
Received: from mout.web.de ([212.227.17.11]:46065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966628AbeBPMia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:38:30 -0500
Subject: [PATCH 1/3] pata_macio: Delete an error message for a failed memory
 allocation in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Message-ID: <0e764e7d-98cf-7f4e-91ff-bf82aa381442@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0skjKZAEiZovk6HaRT456I83tJA8MUM33YG9BD0nLkKzrCmI72M
 Hw1ifQYP+P2bM96vwvfk14BkMBYAAGWnU96ntwkiKz2QS6sFa5J6KNf/kH8N+MPjkf6Jitm
 ZR/EgCFu/wVBsdla4gEs3wB/elCddWFJYMPcoT3Lp7H11AXXMN39R7SxjVIy3TwQrQRU5Y0
 bEE8cOb50/FggsN1POc2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nhHWUdH1bio=:PTEM78wzEY8DlvOFApWStn
 Ux5aqoK/SRi8ExfMKARPo17P85quPtC/ETr5otUR/dYd19UfjusdAO0m5krvCSK4uyONccF9J
 e/ImcuSMZFn7f/++qNzJ5NNj7CRDslc3rJUGb9vgAWCC3by9y/7XAjjRXqMh/qa1M6sxYekC3
 F2D7pfZDvj7rtCyWjFRGh3+UA3RIb36mlBrrdbv7GiCnIY9t2YA1qBZ2hPmMUftUQr8aueYY7
 G/6SskLmuhZ74Q+yEoulcm6E2eLAEgxYtbHEVN7yRPiAhZQgIF2lgfgNZN4ZcOQxgONagrwpx
 QaLuPsdR6wJJ+BrxHRiQGpH+IUq5rtVyQ9MYQn8otmDcmYsCxv75+S7ZSbvhXcscDpopiDWCj
 2QieCeUC/nb0dkdI0TmG9Rx0UOWzoYPwWkcuDZRouE+12EqfvPPBs6zcrX3QXAScp7xC+32WX
 nYXxPfxVHAPj8Rak5AxbnsXv52hc5q/uaOCJalpnwqc2HR1iT36XDiKWUxlBfckawHlo6xkDk
 MLFGnw6TD5LiNOGDWxARomVqWWfrgfaBNUBhLVMS+72WyUrxqhS0yFJzFEmZTVDmHRquqUL8t
 gXSViWZNS3fKVOfKv+CHeucx4uK8ZfOFxKnXmYyS/lbH4/cywPGN7VmbX6Q9hNqy0R8kF/Vtm
 BZNvbKtXHuHuhGhWIn0Vi+VBhXD4tF9YiNBuTqKKcXxCxaz8jzst6UO5377u+PlvwBXuOq51n
 l6zA6rc3PUJaXn6Uy7ZGrkm0x6s5WO+gBjKkjRlAEYoB7973TtIy9MXag7DJV6jKzNHIVzzSs
 HW+QF9ocZN+ACdS/WbC9PyACVjS8hdtD/f2dZpSOCTpv80R32w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:01:45 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_macio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 0adcb40d2794..9588e685d994 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1131,11 +1131,9 @@ static int pata_macio_attach(struct macio_dev *mdev,
 	/* Allocate and init private data structure */
 	priv = devm_kzalloc(&mdev->ofdev.dev,
 			    sizeof(struct pata_macio_priv), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&mdev->ofdev.dev,
-			"Failed to allocate private memory\n");
+	if (!priv)
 		return -ENOMEM;
-	}
+
 	priv->node = of_node_get(mdev->ofdev.dev.of_node);
 	priv->mdev = mdev;
 	priv->dev = &mdev->ofdev.dev;
@@ -1277,11 +1275,9 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 	/* Allocate and init private data structure */
 	priv = devm_kzalloc(&pdev->dev,
 			    sizeof(struct pata_macio_priv), GFP_KERNEL);
-	if (priv == NULL) {
-		dev_err(&pdev->dev,
-			"Failed to allocate private memory\n");
+	if (!priv)
 		return -ENOMEM;
-	}
+
 	priv->node = of_node_get(np);
 	priv->pdev = pdev;
 	priv->dev = &pdev->dev;
-- 
2.16.1
