Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeDJMn4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:43:56 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57510 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeDJMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:43:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180410124348epoutp0309a8d209531412d9b2004bc8abb979a3~kE7HgKHL80547905479epoutp03w
X-AuditID: b6c32a48-8c1ff70000000ff2-7b-5accb18420bd
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
Subject: [PATCH 08/17] thermal: qcom: tsens: enable/check sensor after its
 setup is finished
Date: Tue, 10 Apr 2018 14:42:02 +0200
Message-id: <1523364131-31059-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG/XbOzo7DxXFafmj4xyoiS2th8WURJiInKpIIognaIU8q21Q2
        NTWIecnWUrOim4pputDhJcfUZbNkXqZmiS2WqF0sMbW8ISkadtmO/vd7v+d5v/d54SUxcT7f
        l0xITGFViYxCQgjx5o5dBwNzG/tl+77NbEaNDxv4aGLRBlBdQReOHr938FF7lh2gv19/8FFf
        SzYP5RY/wVHV+JgA2VtLCbRY0AlQ6eyIAI2PFRJo0uSDjNVDBFppLcNR26dFEOpJZ891E3Tx
        5zcE/bz4o4BuGj5AV1qmeLTRcIOgRx0Wgi7ImSXoQpMB0C2OMozuebCM07ahFh69aPSPFMmE
        R2JZRUIaq9p79IIwXlu/AJLHiPTWknqBBrzj64A7Calg2GtaFeiAkBRTZgCb9S0EVywDeK/g
        Jb7hKrxWjnHCCwCze5v5XLEKoKbE7nIRVAi8fd0AdIAkvakT0FRLOj0Y9QiH86NdmPPdi4qG
        jpEYpx2ndsAe/QrhZBFFw6aV+vVh/rC3+64rnjt1HP5um3PNgtQtAXT8vLOeOxz+yR8AHHvB
        aZtJwLEfnDA0Aq4hB8AlswXjhCIALQ1ijg/DDtug6yOM2gS1HWsCZzhIiaA2b91Cw8m8fh7H
        x2DtM/P6wqUAzuSN84qAbzlwM4AtbLJaGceq9ycHB6kZpTo1MS7oYpLSCFw3EkCbQfvbk1ZA
        kUDiIUKvXsvEfCZNnaG0AkhiEm+Roq5fJhbFMhmZrCopRpWqYNVW4EfiEh+R5tR/iYpjUlg5
        yyazqg2VR7r7akDEQJRcXHF2MMx42aJvk/RJuwaGdfE770uryLWrl/Te4qjAdMWkJ1ON6+14
        l/y0JsdRHmuLDHH7YPrFbD0nnSI0Vdqn4dboom2d2y2dueV7ZFk18vOBmUszEaShIvRQwoJx
        oH1eLtltvjJ9s++L9vsZR0WlVFfj52G0LzvCJLg6npEGYCo18w+tZQvmHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd2WjWeiDPbcYrXYOGM9q8Wzz8cZ
        Ldb2HmWxmH/lGqvFgcbLjBb/H71mtTi1vYnJomXWIhaLJU8esltc3jWHzeJz7xFGiznvbrNb
        PHnYx2bxYou4xaYVN9gsfu6ax2Kx995nRgdBj6b3x9g8Zt0/y+axc9Zddo+tt0w9Fu95yeSx
        aVUnm8eda3vYPHqb37F59G1Zxeix/do8Zo8T07+zeBy/sZ3J4/MmuQDeKC6blNSczLLUIn27
        BK6MjnUfGQseslXsmr2OvYHxEmsXIyeHhICJRF/rAuYuRi4OIYGdjBLv3s5hg3B+MUpsPPeX
        BaSKTcBKYmL7KsYuRg4OEQFviS1rOEBqmAVmski0TX0KFhcWiJO4djsepJxFQFXixNKfbCA2
        r4CHxNaf61gglslJnDw2GWwxp4CnxO+971lBWoWAar5NsZ7AyLOAkWEVo2RqQXFuem6xUYFR
        Xmq5XnFibnFpXrpecn7uJkZgyG87rNW/g/HxkvhDjAIcjEo8vBMOno4SYk0sK67MPcQowcGs
        JMKbs/ZMlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbG
        0gPfWDt0pvtX7NmhHxsjt03BLbp/qt3UWQff5vHX7ryYd4/jSZblipn603sCu9WkbrBvq2Kc
        eml7xrZS6SBhaQvrLE1rqYx7yXN+XZa333mMg+P1le+8OjbLH+166Hm8deezG+/MH2gmzHJQ
        WLYlxY7r5lWzNNt+1/9BbTbe0koBO870GeopsRRnJBpqMRcVJwIAFPf+X3UCAAA=
X-CMS-MailID: 20180410124348epcas2p3ca37509a4054ba323bc40080b86b842c
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124348epcas2p3ca37509a4054ba323bc40080b86b842c
X-RootMTR: 20180410124348epcas2p3ca37509a4054ba323bc40080b86b842c
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180410124348epcas2p3ca37509a4054ba323bc40080b86b842c@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable/check sensor after setting tmdev->sensor[i].tzd and calling
chipset specific enable operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0d119c1..da44494 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -102,13 +102,13 @@ static int tsens_register(struct tsens_device *tmdev)
 		if (IS_ERR(tzd))
 			continue;
 
-		thermal_zone_device_toggle(tzd, true);
-		thermal_zone_device_check(tzd);
-
 		tmdev->sensor[i].tzd = tzd;
 
 		if (tmdev->ops->enable)
 			tmdev->ops->enable(tmdev, i);
+
+		thermal_zone_device_toggle(tzd, true);
+		thermal_zone_device_check(tzd);
 	}
 	return 0;
 }
-- 
1.9.1
