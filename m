Return-Path: <sean.wang@mediatek.com>
X-Google-Smtp-Source: AIpwx48JewXsRH8+LSSo3zuzvGYupbTm4BHTDQib66lksHL1lXwOHmvYNUybwmo3XTCco4/lXkpp
ARC-Seal: i=1; a=rsa-sha256; t=1522058626; cv=none;
        d=google.com; s=arc-20160816;
        b=bCPcgj+IN6j/P8KWB+yJOIgnyo32Ask/vSnIxSwDDn5RCYw9N0BeWxlq8YSDUVajc7
         ehB7dg5xcEjYW2TnApOkjowLaKQd1L2HmERVIpZc2rp+NnJZ7Zwy3rdbND+E/sVldHSY
         I6yQTK22gOeFz00idcaCGmJ/J0dKm6c3wFQ2AGLFlfTep7RhyFZQ9tLNcm+IK7mPk1ve
         h9e6ZcV9dcHxpeEjTWaHnZg51dNsoMqyDhA6lqiHazZYFuXHjjEHDR+0B7UAZ1teD+gQ
         n5faw+GVdj2yA2NJW3CV/YNyAhQs7FJgmeZwKgsI7h3pg1FgmJR9/i6KUn3OsAZycUbh
         NkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=diyv45ilkGWMrW3oocyzaQ/oTkD+vr+5JodxFCbnzb8=;
        b=aFoLyzgB2En+k7LkVlA5QRGPVjgJjuizETNd3nzulAgv6L2Cshaa5vxfQCBg8zn7N3
         73EmqBQtTlM3S6mFrLBQQxpBFgczY/IJG7T4zIbXQ6NSxjAa8EEbFYaIyqEruOrCtvyB
         0X0+tXVrNtTrqTTxneTR9+o7bS0r2iXVD1ol2TdDjbC8ztR20uVNhH84+CNZ6AWLG9hN
         z/mFEK3JFG+W+hUZm9IMRuSPTtqYv2nk2hk3mjauxBU1XRqf0o02BArWJNaOY2Q62194
         w4Rjb7oV11AwiCT/MQNKQ1Yw5YLKODPKjQLcC+p3/YUWxJPQ73ggdgR9hszBTVerxZVr
         aEKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
X-UUID: 48fed0e4be944e0f9c04a06602e56a5d-20180326
From: <sean.wang@mediatek.com>
To: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<matthias.bgg@gmail.com>, <chunfeng.yun@mediatek.com>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Sean
 Wang" <sean.wang@mediatek.com>
Subject: [PATCH] usb: xhci-mtk: remove redundant MODULE_ALIAS entries
Date: Mon, 26 Mar 2018 18:03:36 +0800
Message-ID: <9b7cc59683fc4d1d2b03419cec4b440d5d949114.1522055042.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TM-AS-Result: No-4.477500-8.000000-10
X-TMASE-MatchedRID: JLDJ3zY9u2nLqx3pQDUvTo0JVVcEm48nXs5nqGvDCfOl4EP+dy+wBGEj
	04n4UkciNMW1025grLlEOP/MktCQ9nEjLiYgp5vhA9lly13c/gHrMzI9rN7ar3epM/I+teqco8W
	MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbvqwGfCk7KUs1IWi1zbDSk0FuA6kvnxMSkzI5
	7RvsdMxSgazhgYRH0R6kfHXMypf7VCNPVgwfT02mQ9nh/r5//bi9il21BxQFoq4lEzoceWuQ9cv
	Ed/Et5dVEc5IqztENReYfSkFq6uAb7jE6+wkCSeftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.477500-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595994146227274778?=
X-GMAIL-MSGID: =?utf-8?q?1595994146227274778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

MODULE_ALIAS exports information to allow the module to be auto-loaded at
boot for the drivers registered using legacy platform registration.

However, currently the driver is always used by DT-only platform,
MODULE_ALIAS is redundant and should be removed properly.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b0ab4d5..2807c769 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -766,7 +766,6 @@ static struct platform_driver mtk_xhci_driver = {
 		.of_match_table = of_match_ptr(mtk_xhci_of_match),
 	},
 };
-MODULE_ALIAS("platform:xhci-mtk");
 
 static int __init xhci_mtk_init(void)
 {
-- 
2.7.4
