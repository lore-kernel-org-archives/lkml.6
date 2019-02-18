Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600A21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391859AbfBRSDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:03:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:55935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389255AbfBRSDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:03:32 -0500
Received: from Juliuss-Air-2.fritz.box ([92.195.200.83]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MRTiG-1gT6I10z1s-00SgPw; Mon, 18 Feb 2019 19:03:17 +0100
From:   Julius Niedworok <julius.n@gmx.net>
To:     netdev@vger.kernel.org
Cc:     julius.n@gmx.net, ga58taw@mytum.de,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Petr Machata <petrm@mellanox.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] net-sysfs: consistent behavior between ioctl and sysfs
Date:   Mon, 18 Feb 2019 19:02:49 +0100
Message-Id: <20190218180255.15822-1-julius.n@gmx.net>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
X-Provags-ID: V03:K1:D8Dc4Zobh6tpUjZ0l8Nm97fm4q7NkeQyFWMKOBRGLT+MqZIhNa+
 uLqSnsIAFEhv4HnCc4P4d0qLqO/JvxJxstjpgeD62di5MJRQNPV5r9eCAGqfLumU+vuDUXE
 EQAxC6SGaKkrkXn9hT9LEugMUaiSxhFvcVEZjhuegBkepi+kPZvY3gj4FG0rqNRHGvV6oiB
 RdMwjUKxajeFPVkYVR5Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKDRUNGYypE=:KCqbxwQojlBszzO9HVurIN
 iX64AIBqTbn/paPUk2YGwTCUYwj8yuiYTz6Bf1hGAqY7vv8KJkSuvPWDczZYiW2BRpVaOLHc5
 0pra3wMnZEc2aJmNlv5kpwyJ0Cq11iZZBmfxJ/bgoT5RDaGbE4xF2Z0+XzO7UtYYHvAvx5/jX
 4OrPJpvIkabAWdZVMqlqvMwnwvAw13xoVskMnIlznOR+mgdO/+e4iteIG5XE3reoy2KHxh8t7
 XHPxWroYyfuKrXFSegR3bcTRH50NMqUlZBVezzE8LhG9ZaeNUch313OzlktAfLXFYOu0B3oyE
 cJ18oXAYspej5948/QBd9gNVeVIqkVqECDxRKXGem0lkECCRZsPIx5rRgHzpUzT/0NGfHDO3+
 y1Kb14FclDaqUmtHPlTtd/61Gn4RLkafSqUE2cqRtpUGb7NCkNPq7KgobnNZIvHaPUHRbsMuM
 8liB0OsiyILj4dpJ6poLGfqHRwa/OT/i+wAFOgviSP5V7frqCwf6SOE+LwAKhDm9iPlSXVaqN
 l9lvtPzhw3jnVramlTBu/m/yi/SlwCmjZbtZkC1BfRdQFbmYaNxT5QIO6zLhiy3gvwjGl0OmZ
 fP8vWjYn+OSppjOZphRR32Xi/QYSCknkIZZ73CZqOi8sNOyx2SC9hc9vSz9IkDziyZN3Fe0Ql
 INRC2qZNfzIE2eHHJhtiyWYHICpRkuZVg0cGWBLR2aOzVqBO85th0gM/ScSFydPi6sA0XV04K
 TcIh5uBfTYY/h92ebxiJlugrKQFQi3eheBBZiBqoanfZTIcK5OT5dhSfJfS23qiKVT/vTf4hW
 hxwNLVdv5bjRTxl+/4Iq/Yn2eK+qAp291xwHdkce2mQy6xYba/XlzS3+/8aW6ImiAShYHG03/
 VT62bq9cT5WznCyCAjkHJvkqWSGHQ6+FI3gjR5E/3d2gyZWKE21FoQTkwjfobG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags of a network interface can be read either from
/sys/class/net/<dev>/flags or from the ioctl SIOCGIFFLAGS. When the ioctl
is used, dev_get_flags is called to extract the flags. However, reads on
the sysfs file return the plain content of the flags integer and do not
call dev_get_flags.

In order to fix this inconsistent behavior, replace the NETDEVICE_SHOW_RW
macro by the functions format_flags and flags_show. These functions extract
the flags by calling dev_get_flags and return them formatted for the user.

This makes the behavior between calling the SIOCGIFFLAGS ioctl and reading
/sys/class/net/<dev>/flags consistent.

Co-developed-by: Charlie Groh <ga58taw@mytum.de>
Signed-off-by: Charlie Groh <ga58taw@mytum.de>
Signed-off-by: Julius Niedworok <julius.n@gmx.net>
---
 net/core/net-sysfs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ff9fd2b..8ae8be5 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -345,7 +345,19 @@ static ssize_t flags_store(struct device *dev, struct device_attribute *attr,
 {
 	return netdev_store(dev, attr, buf, len, change_flags);
 }
-NETDEVICE_SHOW_RW(flags, fmt_hex);
+
+static ssize_t format_flags(const struct net_device *dev, char *buf)
+{
+	return sprintf(buf, fmt_hex, dev_get_flags(dev));
+}
+
+static ssize_t flags_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	return netdev_show(dev, attr, buf, format_flags);
+}
+static DEVICE_ATTR_RW(flags);
 
 static ssize_t tx_queue_len_store(struct device *dev,
 				  struct device_attribute *attr,
-- 
2.10.1 (Apple Git-78)

