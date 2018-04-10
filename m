Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeDJMoC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:44:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23133 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbeDJMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180410124356epoutp02fdf5561a44781019fa33442268bc1291~kE7OzXpYp0274802748epoutp02Z
X-AuditID: b6c32a48-8c1ff70000000ff2-87-5accb18b4469
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 09/17] thermal: qoriq: enable/check sensor after its setup
 is finished
Date: Tue, 10 Apr 2018 14:42:03 +0200
Message-id: <1523364131-31059-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHfXbv7q7S6jZNH18wGCllaC8YPWmIkuAVi4owY0U29KLS5svu
        NO2TaZhaM8VAk6WZJjZcwzXdspm65Uu+gRm+pFYLE03ScKBlSrlNv/3P+f/+55wPh8QED7he
        ZEqqnJGliiVCwgVvNR86GXi/eVB0dGj8FGqu1HDRnLUXILWiG0c1H8e4qPPOKED/vi1yUb8+
        j4PuVj3DUf2shYdG25QEsireAaRcmuKhWUsJgeZ1HkjbOEGgP23VOGr/bAXhe+m85R6Crvoy
        RNCvq2Z4dMunE3SdcYFDa1VFBD09ZiRoRf4SQZfoVIDWj1VjdF/FGk73Tug5tFXre4Evcjmd
        yEhSshjZkbAbLsmdlYu89AUi27A5guUCC7cYOJOQCoaVhfWgGLiQAsoAYIO6huMo1gDsmDVw
        dqimaTXhMN4AWN6n3o6sA1jRoOfZKIIKgWX3VFsGSbpRMVDXRNoYjHqMw1/T3ZiNcaWuwIZG
        hV3jlB/8vVJtz/KpaNjaU7d9ky9831Nu185b/b/ty1zbIEg95MHxkQncAUXCltoCwqFd4Y9e
        Hc+hveGcqhk4AvkArhqMmMMoBdCoETh0KDT3jtg3YNRuWGje5NmuhhQfFhZsIzRUqE3bMyPg
        fMGwfa+AUgL4ZDWqFHg9BU4q4M6ks9Ikhj2eHhzEiqVsZmpSUEKaVAvsPxJAG0Dn8FkToEgg
        3MVHHQMiAVecxeZITQCSmNCNL1EPigT8RHHObUaWFi/LlDCsCXiTuNCDn3tuy6KSxHLmJsOk
        M7Idl0M6e+UCJXnen+32HMgQTL4IrxW0K3wPGwI/HAwJ88TqO0N9z+g5lZfkG8FzrFvW15j1
        YKf8i/6t+1IyRveois4pF+IifMbn35quRhV4Wy5Hx15/OfP8Wv8rvw7NfrPmgBx0JW6K3L9T
        eT+Xi40JPpGirljJ1GT8xopHXFnjrbxHUia7X4izyeJjAZiMFf8H/gEwUx8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd3ujWeiDNZ+VbfYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MAzNesxe8ZKvY8fcicwPjQ9YuRk4OCQETiTV31rJ1MXJxCAnsZJT4MfMWC4Tzi1FiQ/cs
        dpAqNgEriYntqxi7GDk4RAS8Jbas4QCpYRaYySLRNvUpI0iNsECExMP5B8CmsgioSvz4NA+s
        l1fAU2LbscVQ2+QkTh6bDGZzAsV/733PCjJTSMBD4tsU6wmMPAsYGVYxSqYWFOem5xYbFRjl
        pZbrFSfmFpfmpesl5+duYgQG/bbDWv07GB8viT/EKMDBqMTDO+Hg6Sgh1sSy4srcQ4wSHMxK
        Irw5a89ECfGmJFZWpRblxxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamDs
        C6xe7DZJVl/kVAhLqM3asPmd1x/o3Ky57ytrW3r/bPXilYbpDU+fn/keuvC2XljQgo8Rcxgn
        rTnonHvbPp9/k47xxMNftu2eobt0053vz+wbXTdqzr82PffJD+HmxrcGT+P9BYvnRNzosik5
        EuV9zzAh66HlKdbVd79tmqD0xi1fiH+CwZxoJZbijERDLeai4kQAyP6+bHYCAAA=
X-CMS-MailID: 20180410124355epcas2p272d4a06619ad3a3e58c792186069f0bc
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124355epcas2p272d4a06619ad3a3e58c792186069f0bc
X-RootMTR: 20180410124355epcas2p272d4a06619ad3a3e58c792186069f0bc
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124355epcas2p272d4a06619ad3a3e58c792186069f0bc@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after enabling monitoring.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index cdd6f59..2695021 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -242,13 +242,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
-	thermal_zone_device_toggle(data->tz, true);
-	thermal_zone_device_check(data->tz);
-
 	/* Enable monitoring */
 	site |= 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
+	thermal_zone_device_toggle(data->tz, true);
+	thermal_zone_device_check(data->tz);
+
 	return 0;
 
 err_tmu:
-- 
1.9.1
