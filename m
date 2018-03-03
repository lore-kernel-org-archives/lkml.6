Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120935-2-13220604666042976702
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120934; b=uotNLa7xAL5qTYLsfuoksk2FUkTQijFjoFaHDJ2tUWK7oka
    uWWb9HyDlS3BMUgMkzvi+TqOHTIfKHZ5jf50+XatiF83P+RVQehQ4n+rgglSo9vp
    B5cEKC5jbE6XUPACHiU1Q+0xUpxoGSqRvSGElRCkH9gPJHpV3lsJ2UStr6lSvf5R
    toS2Fy+4NUIQer6NWzouOlRx33L8Hk008femK3WdOLl9KD3oYM/+GVAIwufPVB9v
    Qv/xAb8c/w3XlTwSETwlwmix8nP4mGafujs5Xi9cgO7B9wKQGBz4z1RIa7iUDLHy
    Jhgkj6rg4180kDUft3fWm261K5fx4y0fei89fiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120934; bh=aaUlEq
    eyEsyvzV2ppzVq0DE/HrB5TYmz1tVxBIozQEg=; b=ui7TrMBq7aLUJiTVcIzvaC
    8dRyX1lH7DWpiMGXAKVvNN3fkCLK7rJ6YQa0NWoiYyipL11BFawRcnUvfmg8pNHG
    xPhg1WmUtfd/iBzd2B+pIX4WuLquxvxkYznvZ11gzo1DK/joXFxrH2JzuhGleDzp
    jz086Ke3UnEmrNuSRvisol4HMrbeDBP86iCzjPzTQgMdkdqxovDiuYf6FxajyaTQ
    ogqaLVu822m7NpJDAQm/jUPBv9sjfpb0D0LjAlVWEkfh/Py5dOcGslhiIjDK3WnB
    NiXpSXDbMLDx4N0ZJ49TSgROmt+Ecvh/AEog314Zq7xPYaZZstuAfPjkq8WcWZwA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o8TfSgHc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o8TfSgHc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCCXsl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:48:41 -0500
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:3173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934085AbeCCWeA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: lipeng <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 101/219] net: hns: Correct HNS RSS key set
 function
Thread-Topic: [PATCH AUTOSEL for 4.9 101/219] net: hns: Correct HNS RSS key
 set function
Thread-Index: AQHTsz8DgrKMaYQSW0m5rJ1IjsPkuw==
Date: Sat, 3 Mar 2018 22:28:54 +0000
Message-ID: <20180303222716.26640-101-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:DJACzqrsDwsu9+OJMnYWZKCWecnPm5dy44m5EdTmr4MZ+NWrjFKoJkR0jq3ho40q+e3188aPLiKxP9XNZAJd74ZbawCq2vY0JBZJaLgeqvDMxoXhSpKoA8nl/R9zs0W/wwgn+y5f2r1WEBWpeThNkUrKqrFBgTlbQ0a8zKnwSJorjLaJ31yZo8u6hg9s4UGW1hxJyRqtwnlzTo7nCQbyKhryPOLQqUlqkR2w6+/Ys5jbuZn+xJ9wQ8buHhV/zxvW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb5f0701-5c7d-4a0c-97f6-08d58156d9be
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10657E170212780655ED8E9AFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(265634631926514);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: QIpFCA3012mUrgyO21h9snNb2PzPeMp7dGlDYMsYgXA4ElpviH53ddi0cRPUX6QLHlcB5r5CAdo4VjG3azPpXo8Vl9ceoz5G2pupyHyozJ7YEnHPA58pZ45+Ysih+yv7a6+D7a+yVAaU3vsQ32w2fLhrWIJtPXzpypdRHnT2Dw0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f0701-5c7d-4a0c-97f6-08d58156d9be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:54.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: lipeng <lipeng321@huawei.com>

[ Upstream commit 64ec10dc2ab8ef5bc6e76b1d4bc8203c08a6da1e ]

This patch fixes below ethtool configuration error:

localhost:~ # ethtool -X eth0 hkey XX:XX:XX...
Cannot set Rx flow hash configuration: Operation not supported

Signed-off-by: lipeng <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c | 23 ++++++++++++++-----=
----
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  |  9 ++++-----
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_ae_adapt.c
index 2d0cb609adc3..b7c8433a7a37 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -773,8 +773,9 @@ static int hns_ae_get_rss(struct hnae_handle *handle, u=
32 *indir, u8 *key,
 		memcpy(key, ppe_cb->rss_key, HNS_PPEV2_RSS_KEY_SIZE);
=20
 	/* update the current hash->queue mappings from the shadow RSS table */
-	memcpy(indir, ppe_cb->rss_indir_table,
-	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
+	if (indir)
+		memcpy(indir, ppe_cb->rss_indir_table,
+		       HNS_PPEV2_RSS_IND_TBL_SIZE  * sizeof(*indir));
=20
 	return 0;
 }
@@ -785,15 +786,19 @@ static int hns_ae_set_rss(struct hnae_handle *handle,=
 const u32 *indir,
 	struct hns_ppe_cb *ppe_cb =3D hns_get_ppe_cb(handle);
=20
 	/* set the RSS Hash Key if specififed by the user */
-	if (key)
-		hns_ppe_set_rss_key(ppe_cb, (u32 *)key);
+	if (key) {
+		memcpy(ppe_cb->rss_key, key, HNS_PPEV2_RSS_KEY_SIZE);
+		hns_ppe_set_rss_key(ppe_cb, ppe_cb->rss_key);
+	}
=20
-	/* update the shadow RSS table with user specified qids */
-	memcpy(ppe_cb->rss_indir_table, indir,
-	       HNS_PPEV2_RSS_IND_TBL_SIZE * sizeof(*indir));
+	if (indir) {
+		/* update the shadow RSS table with user specified qids */
+		memcpy(ppe_cb->rss_indir_table, indir,
+		       HNS_PPEV2_RSS_IND_TBL_SIZE  * sizeof(*indir));
=20
-	/* now update the hardware */
-	hns_ppe_set_indir_table(ppe_cb, ppe_cb->rss_indir_table);
+		/* now update the hardware */
+		hns_ppe_set_indir_table(ppe_cb, ppe_cb->rss_indir_table);
+	}
=20
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net=
/ethernet/hisilicon/hns/hns_ethtool.c
index 87d5c94b2810..8490cba230bd 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1243,6 +1243,7 @@ hns_set_rss(struct net_device *netdev, const u32 *ind=
ir, const u8 *key,
 {
 	struct hns_nic_priv *priv =3D netdev_priv(netdev);
 	struct hnae_ae_ops *ops;
+	int ret;
=20
 	if (AE_IS_VER1(priv->enet_ver)) {
 		netdev_err(netdev,
@@ -1252,12 +1253,10 @@ hns_set_rss(struct net_device *netdev, const u32 *i=
ndir, const u8 *key,
=20
 	ops =3D priv->ae_handle->dev->ops;
=20
-	/* currently hfunc can only be Toeplitz hash */
-	if (key ||
-	    (hfunc !=3D ETH_RSS_HASH_NO_CHANGE && hfunc !=3D ETH_RSS_HASH_TOP))
+	if (hfunc !=3D ETH_RSS_HASH_NO_CHANGE && hfunc !=3D ETH_RSS_HASH_TOP) {
+		netdev_err(netdev, "Invalid hfunc!\n");
 		return -EOPNOTSUPP;
-	if (!indir)
-		return 0;
+	}
=20
 	return ops->set_rss(priv->ae_handle, indir, key, hfunc);
 }
--=20
2.14.1
