Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67457C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D7A2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 02:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D7A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725748AbeLBNZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:25:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:45117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725727AbeLBNZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:25:43 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MFPyK-1ghWJa3Kzs-00EOvs; Sun, 02 Dec 2018 03:11:31 +0100
From:   Qian Cai <cai@gmx.us>
To:     davem@davemloft.net
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com, joe@perches.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH v2] net/core: tidy up an error message
Date:   Sat,  1 Dec 2018 21:11:19 -0500
Message-Id: <20181202021119.7737-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:iDx2G0xsSKwpkiPl7r+C81ag5RaddUSy9sxdYFGeAAq3x27XXn7
 wV8yYtTgCA+W2LDwERJdkVOoGLMTfnd1c47mg84p/krxaojTqnFOBtfpeR3A8drXKDDmira
 kKsq09NhO1AIwd45SHI+mQ81NtwdWYioFBctLQSryiHs/du1UK8KmeUguHeOgu+IXvSzB67
 XRTHrv6LCP0gSZYv2OZag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6yi6eGltyiA=:eTuBMK7w9p+W+z9N7qQy7h
 KoIMZF55kmTtDmxen5Ot7rjoJZrkzfMJ36QasGLXfZ4ZfO6ct99CMv0ZWsSRgSLA0Q2vdzPDO
 mMH4doro4Hqs68tuQ2k265nv3R5aXaYgQ+RY9kTW7NTNCQvyCq4lp6ZwHsxldQHT0V/yb8Bre
 gcKz2WEyS0yfdWx570QRRgoIDIqeurtp3YXaprYbQr/lmc5i8pDBdRlR4rtRGgIP/V6WoV8DI
 ioeCFYbcgRK/kpJYk26z+S+xBwdU+y3DcbP2CQQBFTzSzkC4RIcpZE7IAGHmvYcxf1Sv0HLSV
 dXL2RxyuKUj4Gn/00e0j88VvYF3bGm0+NPdjkQVldTJfH4L2vTAW8RJdnAMFz5ujMqaWXFYEo
 OWmq/mJft/8RiqOLfrz81linPfKE2zo2tzb42pVui5/VzLiotcjiaW64FjBzDj0Sr/F5OLAF/
 caNo0EnVXBc2Cbe64JhvBfKX8E6mztSQRp+r4nG4VFljLQp/gPuux0HIDoneDbD74JcQDO8D/
 aA4NpMjBnong0wRWXzYY+w9SIWQVgtVVh4aDFH8dEMpXGjW6w1O3HN2CZudSyxO01qi9aLKQy
 5DFDeUXxb9EloOW3Mxe9v+GJrxurQpXQUp4lRn0lxdDRMsbaogIIz5sUt6XVPu+2/Dosh1NQ5
 K9h/ipPCSEvWGy4tD5VZNMLtkvF09yMfrI8S/i3Ew6oBRE6OZ3aYfxX/M9LudR1ThuNs1LS0A
 MD0dYjiboJPIv+YZ8H8aoIrP6+Jz82DNtC95YQYnSClVColpSJAePgVLHzPxui+vFeilZvPIn
 4bFpvC28D50nU4kRZrKxFYG+g1nm3T29Hw+Kv1NMEOnVrWgYxlLvCg+Nz52vHTIKcNNIc4Ax7
 Waw+SI5fo4Ic8yqdgRIoXBgOlY8wB73S2QPQ8tcYw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netif_napi_add() could report an error like this below due to it allows
to pass a format string for wildcarding before calling
dev_get_valid_name(),

"netif_napi_add() called with weight 256 on device eth%d"

For example, hns_enet_drv module does this.

hns_nic_try_get_ae
  hns_nic_init_ring_data
    netif_napi_add
  register_netdev
    dev_get_valid_name

Hence, make it a bit more human-readable by using netdev_err_once()
instead.

Signed-off-by: Qian Cai <cai@gmx.us>
---

v2:
* Used netdev_err_once() suggested by Joe.
* Replaced the hard-coded function name with __func__.

 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddc551f24ba2..65ac80970d1f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6204,8 +6204,8 @@ void netif_napi_add(struct net_device *dev, struct napi_struct *napi,
 	napi->skb = NULL;
 	napi->poll = poll;
 	if (weight > NAPI_POLL_WEIGHT)
-		pr_err_once("netif_napi_add() called with weight %d on device %s\n",
-			    weight, dev->name);
+		netdev_err_once(dev, "%s() called with weight %d\n", __func__,
+				weight);
 	napi->weight = weight;
 	list_add(&napi->dev_list, &dev->napi_list);
 	napi->dev = dev;
-- 
2.17.2 (Apple Git-113)

