Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967226AbeBPMjr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:39:47 -0500
Received: from mout.web.de ([212.227.17.11]:35589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967151AbeBPMjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:39:45 -0500
Subject: [PATCH 2/3] pata_macio: Improve a size determination in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Message-ID: <44765718-d832-c58b-6055-91c7c9b11b73@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1e87cf7d-eda2-12d9-af01-17f6619cda72@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SCvE2UaWrJniAtcJEurDR4YblgI0CBHZBJb1UZomcIf4ST2HQIk
 4GmyUseJgkQ2r5bGfDF3IlI0gP+5KmsCnaQpeKaX6gSRg6DSqQnxBMPsRzKL1M4QDBV/Nlb
 T9Q9/7rX3elXexHk7BINqrtAB+XaQJ0oZA77qBaUIViAyB7OMZlnIu3+FAV44l+6OhBts4b
 wEhSD1qDAidTzpGkXNJTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G+Y49GT9jyk=:9LlPEvB/XeJC0eKe2nPGM1
 PLtHvPAoSNsxVfE83DpyOMeNnmrUoBejmaTeF/4eFV07Qe6oTx5cz1/4lOOppFY1VKCpn/EcP
 PFSFYGY0tYiW9QufXAg03kO8VhcyOzmLita1f6ldQYbXV3nIVD9REncvowOdb3x+PDKpKGVWi
 WcBy89iSi4mX9Uu1+1QwYiaaHpNFUjhm7GV/TAHmnHJzBU4iV4x6Kf0xjSXOCWoAGzUaFR1L9
 2nAaVO3L1iFQO++cc8p6V9lYDsTJFeTOTnqDjjOpX+8kLk896oIXayJFaWWoNXwcKyNZ1uvE6
 H7M4UMjcHIvN8urdWDjJzBXHWUU5M7v9fUTme1yVLzDb/hzvgFtQqWfHhfv5rMKs1EbrA4MlH
 lSwjNtRx1rALQU45rY4m3YNo+Ma6czmQvm8Es/+Cz333/hP3oQjGNv7wAuh9+JyJHirpIFpDt
 3vnStFJEG7lvLowfrd0cfKelidBjOPXfvJ/9ZhW1PJU8qWAB6zpYsxCUc4q482IFZey+4u8su
 v2qQAPIVvtYykZKFxGvhOTWFJqLJeTpr7aAhrSmxaJ7bqBmwU0dhKd5+iJZxjthW3i3bmqo4Z
 wNLtOSl3CAzdAok4SGtVpG8/pqcxOeHTs7tPtm63EfRH99naHRmdCnvLFKcIFCVvoHwWaxjfp
 yjE3pdRPsqNtAEkORzJWKf8k+G1zY1eRvbdAgjtQ2CVSRbbkEK+p+KUpOvuHFH8FtOAgnMKUA
 OvT3/q585JbrP/7uSRomaam+U1gki68TmqCvyz00lsG4pKilExWlTk6UYdAG2p3vo0WBVvWER
 ogbEXsP3vjQbXtDuuThxEkCq9Id4syXcGozOWrgqyx0Q/cINzs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 13:08:14 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_macio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..dc40af4c615c 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1129,8 +1129,7 @@ static int pata_macio_attach(struct macio_dev *mdev,
 	macio_enable_devres(mdev);
 
 	/* Allocate and init private data structure */
-	priv = devm_kzalloc(&mdev->ofdev.dev,
-			    sizeof(struct pata_macio_priv), GFP_KERNEL);
+	priv = devm_kzalloc(&mdev->ofdev.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -1273,8 +1272,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 	}
 
 	/* Allocate and init private data structure */
-	priv = devm_kzalloc(&pdev->dev,
-			    sizeof(struct pata_macio_priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.16.1
