Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241646-2-9983010822776393784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241646; b=dA0a7McycIywgWlqSTxPHUFkyDRxvwOBop1/GFNNLgi+2NMN2i
    WVgdbfZ3/Spa35OrhR8gxpbPwM57qSDy3lcwZwwSfGlOidPJ38dpqYeUV4A/16GC
    oogCOW3vsNJNzwxmyLwXEEk7kNvnoFZxqIYx1VaS71s22KDC9l2kvldt7XEwWPxh
    a9STq3re+titcQqnD6hWNa9+8ECvdLZ13hYMPODGhJOT+3UsBdf8QytlQc6znOKm
    9H9slsqHJ4UBkP3s7vUereaiYstGVVTVnJ2ywMXCppCr198sZm9K4EnVxEeZIv5S
    sA0U+b79MI7NigAxStkTtmFwlRxMx0KyPOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241646; bh=SjU0ayZ9q8
    x3frxV9w7H/1/Qhg1eusCAHKjrJcYLx+o=; b=auqSHUn9x4bAlgT5cH2PB/CcpS
    rc4d2zDkszAWvcpdnhYJUmYxsY51AKte+CXz2p4nMNPw4Z8VGDM00c8y2rDCLd8T
    fsrKyaOc2xQ7TenuNQQz/VKfaxJMI3F5yee/R19fSxvx75HoMnMH3d0ZXssNwQfz
    asSkKj5NyDu/JQVQkwsppy+Fpa2eT+DeflsPxIeXzrEUHs7NFIR2A9HuWhb4sgpZ
    DABF4JkFFQMgQHdkYqFJ6I0DnELudSaloiuWzTaLGakqCxEQmDBJ6LAzm2Ueyo0D
    tJUkGCfmjCXd/8wEgvmg5o4Nsvr31JX3q4WoGu797oHVIg4iIqZ8Hq4/IsFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=niSeZHCl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=niSeZHCl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPhsYib/Nb8vozj1fWFCXRwjMa+iCpQLmoQOCXF8dlvVD7Ft+Uq+suk96uRfcEcjfX0Nw3RpqE0HaJXEy+tkk2lm4MGoCg/O223nDwSDGGI0x+BoqueV
    6ChYho9MZY9ucJQrFlFwxAY2WUzEcMp+MOkeKMreDzu3/1E7Ywu6baEbordji3xsUBW5q9aJcvhFeSykmLWNcmvnSGefSiLEtGARUJuMpoayZ3AQO93+vVTm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vggBfdFIAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=lnWoYhIlFxxW0EnSGZsA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755914AbeDICkb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:40:31 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755533AbeDIA1X (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 035/293] net: ena: add missing unmap bars on
 device removal
Thread-Topic: [PATCH AUTOSEL for 4.9 035/293] net: ena: add missing unmap bars
 on device removal
Thread-Index: AQHTz5j0GBEP8VNMnkS0s5Rn2WkHdQ==
Date: Mon, 9 Apr 2018 00:23:17 +0000
Message-ID: <20180409002239.163177-35-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:hdgnsVmn8WmWl65vmTVUyLFguQa7QOxTQvcXC8wJ8OH6yZHiFNbVwNk9lC1oIyBXQo05t2VcGmQbZ8lpSzJVjN5EYQXcFUNkb22nDhNPvJy60y6Yghz+IPbporGT0xEXNXxb5mHTo5lEm/RZOPjXLLGgtqHWZOaWkK6dWyRBDHfpcp3ZPe/6xIuhw3k0/ou9GGJqPHUIN0R5IIuS4ENtGHR5cI5hlWPbsMoaPNcPhnN+qmmMkNA992q/1UVMTEwC;20:7yHQqz4duiXFpbbUAqMumV4bFl7c/fB5emjZ6hKpVgnnnko5cGS/Ztxu66e9K4gQFpbifqHdj/t3opj8zE/eyhFbZScsEAcATI7G83KTlLb55KFNFGNU6Xa14I7fHqyazY3UpdCgxnvpBmt3JTnZoLNNyB0YTCXpJbWvApgxMWM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e014ef49-ef2b-42b6-46f0-08d59db0a804
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031ED4E89A4582A6DD4DBDAFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: CA3ADfCkFmmqvcnm4pM0dk09qAtT+jfbSXzo7omO4i6DGxhRA5q+3RPtD8MYJAYaxA4iMZkX4FKzoE7VXdeZ6UU8KNlUR7GNTiJv5SI+FJwLoGQBHkTIYPOqzjSHmw4rYGrArmbC/bGKFJzma1ZG/5wqwDNTOl/ad3V/wX4MWNgt1aIBZjJx0hiFeL8/ESPTz3f3a3aINE7pKH46LjkiwkCcEa+ioKsF/e5YpT4oqf2jJPAqgQ7bFj3TsowYPtFJZeJOVBxT+/CEw3b3ExAgH60TyKUq9y71Nejz2LETIUc4HFV/otBfId0EKYppl/JWsJ3iZlfOgddiMFxFBKOdamQBEOVGCu1+HWNFV6wLIziregXbkR0i+RP4PJxTa/QB2ZiSjqk60PTPQrOvtn+tYM9TjBHWKWeiSWdXXagaZIA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e014ef49-ef2b-42b6-46f0-08d59db0a804
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:17.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 0857d92f71b6cb75281fde913554b2d5436c394b ]

This patch also change the mapping functions to devm_ functions

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/eth=
ernet/amazon/ena/ena_netdev.c
index fe691017d5aa..0d9ce08ee3a9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2808,6 +2808,11 @@ static void ena_release_bars(struct ena_com_dev *ena=
_dev, struct pci_dev *pdev)
 {
 	int release_bars;
=20
+	if (ena_dev->mem_bar)
+		devm_iounmap(&pdev->dev, ena_dev->mem_bar);
+
+	devm_iounmap(&pdev->dev, ena_dev->reg_bar);
+
 	release_bars =3D pci_select_bars(pdev, IORESOURCE_MEM) & ENA_BAR_MASK;
 	pci_release_selected_regions(pdev, release_bars);
 }
@@ -2895,8 +2900,9 @@ static int ena_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 		goto err_free_ena_dev;
 	}
=20
-	ena_dev->reg_bar =3D ioremap(pci_resource_start(pdev, ENA_REG_BAR),
-				   pci_resource_len(pdev, ENA_REG_BAR));
+	ena_dev->reg_bar =3D devm_ioremap(&pdev->dev,
+					pci_resource_start(pdev, ENA_REG_BAR),
+					pci_resource_len(pdev, ENA_REG_BAR));
 	if (!ena_dev->reg_bar) {
 		dev_err(&pdev->dev, "failed to remap regs bar\n");
 		rc =3D -EFAULT;
@@ -2916,8 +2922,9 @@ static int ena_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 	ena_set_push_mode(pdev, ena_dev, &get_feat_ctx);
=20
 	if (ena_dev->tx_mem_queue_type =3D=3D ENA_ADMIN_PLACEMENT_POLICY_DEV) {
-		ena_dev->mem_bar =3D ioremap_wc(pci_resource_start(pdev, ENA_MEM_BAR),
-					      pci_resource_len(pdev, ENA_MEM_BAR));
+		ena_dev->mem_bar =3D devm_ioremap_wc(&pdev->dev,
+						   pci_resource_start(pdev, ENA_MEM_BAR),
+						   pci_resource_len(pdev, ENA_MEM_BAR));
 		if (!ena_dev->mem_bar) {
 			rc =3D -EFAULT;
 			goto err_device_destroy;
--=20
2.15.1
