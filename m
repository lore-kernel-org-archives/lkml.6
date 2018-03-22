Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1361858-1521684252-2-9213417620761943515
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521684251; b=YCbskip3e33DOeYhvhwAktSTiKHOXMyAdIY6LImsvcP51xG
    ajTC67z0LoGHHgKzX524vruUPcO5Io9ndLQkG/tF7uKRuhwWYgjBV86m3FKujWqy
    Lc3qvkQ/lEZNvxJOffHe182oBQiO8MA5srOmPYgcfycE7yKo9V3aSY2YGqxgNSm5
    75kllXFsxyA4zYP9geIr+PfKmkIP+DnId+NsszKOmhgQCWNXQrxaauGieGxa9SQF
    woFH5NxievoGbRHn1kCU6DxuiudS/pMwCfnirUivDQETmXBWErf43mUKc63vf9QZ
    9QhJQ7fxjROsxaeYo+oUOikI13xfDLTYM4TQDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521684251; bh=9
    Xwl7dP/CfLYy4Ow+cs+cg1UdN8MHNt+5KJJBSZvIqQ=; b=TFmJAnoc5pBjz2WgR
    U6SId9KX0W88Q5S6FQN7H/yn7aiiBfLnMduJAERVv5/E1FZckcUykivjOehh48r2
    R+4jBeqsziOnSsPEas+GoDXUWOATjk4kEfc8xC5k0d/RdwzTDtf8eqfjqT/wxQhN
    XL3+QjvPttKtj33tpu4wxR8f4KEc1aohQJ3Qy1FBHRxs7BkaX4lrOfIAdKSQQzQ6
    xvnAexAHfTcvss7J93Tx9yeYAyYxs07YlbFBhO5PwvD2ipQsOvUo44H/eL5cXJEb
    L/uHW3rQQG2FDaDat8K0IGYJiT4nZHq39lzliUbMZjRLC7oStaVJZL9oQonVrxp1
    fZNhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Crispin
 <blogic@openwrt.org>, Michael Lee <igvtee@gmail.com>, NeilBrown
 <neil@brown.name>, Felix Fietkau <nbd@openwrt.org>
Subject: [PATCH -next] staging: mt7621-eth: fix return value check in
 mtk_connect_phy_node()
Date: Thu, 22 Mar 2018 02:09:51 +0000
Message-ID: <1521684591-77182-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In case of error, the function of_phy_connect() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: e3cbf478f846 ("staging: mt7621-eth: add the drivers core files")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/staging/mt7621-eth/mdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
index 96ecda9..9d71307 100644
--- a/drivers/staging/mt7621-eth/mdio.c
+++ b/drivers/staging/mt7621-eth/mdio.c
@@ -82,10 +82,10 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
 
 	phydev = of_phy_connect(eth->netdev[mac->id], phy_node,
 				mtk_phy_link_adjust, 0, phy_mode);
-	if (IS_ERR(phydev)) {
+	if (!phydev) {
 		dev_err(eth->dev, "could not connect to PHY\n");
 		eth->phy->phy_node[port] = NULL;
-		return PTR_ERR(phydev);
+		return -ENODEV;
 	}
 
 	phydev->supported &= PHY_GBIT_FEATURES;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
