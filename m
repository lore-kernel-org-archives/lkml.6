Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493358-2-8366175324125317406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493358; b=fpKLvz5QUp15PpT45q9ikbxC2+Y8yH3uFJpGDzcT+S6hQQm
    E7/2c9ADkL91HAFmbFB9nF/nfIt9pWcB7B6jTAUtsvfdyC0mRlAQvOD0xiGBIpMT
    T1DFfipCtxW7/nTHNnSZnk5NeTNJ0Tok+WfMpmkeX3HZfhw/fx69t5LkrEjSBQBe
    g7MoJAnbRK5pCNVBzFuIABZbyssbsqalQtw42SwetWvnRBo9uX2PW8cl0Sb+bpvZ
    9YUEHUdFqjeDJI4PiiM9v8sf30njlJMp4vxl15a+CfQlFOLIgpy83pAnalIA9FP2
    PZ3sXJg57Hvqp3yRQ4BOzibo8GpYjqiacywO4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493358; bh=mKpnJn
    E8gGiqICkyDQf72/kIP6d5gJ0CAb0ZeC+MVBU=; b=asWYHOrXkt6XxzoqnyXQ33
    G//qWbBgJFGPtNViLBeUpD3iYMNsHnv5hlTz8P+TYYom/gDQtPMaocwyV4HzzowC
    Fcuy0/U9K12xl4++IK8+ZPsf37NmYO0A5Hos0wPhTDEDzPZvAHroM2No1CgVPXv7
    4+42ObyHUYJ56GuX/t40lG/wbrm8cpRyzX3hSeUi8KaaaGOApjtnK/3Ev65ghhJu
    jfkhyZLwKeSzUY8x87S+2MwMs9xXT1I/PWGA0T1V0h7ZHRro+wMMkh36XK5g7DFB
    5DxFoqQCL2EwykS8JpwYXwILlZzm8KT82PrsagSEvI1jiFUK+CooX/sF0TK3s6Vw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iGwFcgN0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeefheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iGwFcgN0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeefheenucevlhhushhtvghrufhiiigvpeegfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968571AbeCSVBz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:01:55 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965476AbeCSQCv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arjun Vynipadath <arjun@chelsio.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 163/281] cxgb4: Fix netdev_features flag
Thread-Topic: [PATCH AUTOSEL for 4.9 163/281] cxgb4: Fix netdev_features flag
Thread-Index: AQHTv5t9NXymPH7PfEKgfK2LjHaKBQ==
Date: Mon, 19 Mar 2018 16:01:06 +0000
Message-ID: <20180319155742.13731-163-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:h26pi3n0XfmxyOMoeFLOGK9fjA62foiKFUT2IsXvwQNsVyH/Skg74wQfJRiWXFw/JsxPy00P437ZEaTDmn2d6ZHUSIMQPNUq3N67esfZl5tVCyxhuXuE4sBNqn5wZEWL975fGLHB0bDSp3BSmcdxV+pxoldZUdi/73HQGWezLM6zKPV/wePaqHsmiD+OIide8FHpdhmVO/x7fVri4t12LzzxQoldyE/Bq2qCLH1L9oExus2IDWbX6a6K2yOayDCk;20:8ewRUUgnYVbjilUwvhD49O6OJN81Picagam+7edMcecM1OusYBKtenATQrwQ4EsZkLIe+rmriWwYWfxt57bYUFFVyqdXs0cJonx6OOJMrB9OyRlVuJ0sj2ouujE0uzE0nR/83gYWj1kqgRcXkEAtPBdzBw3cfLbxC9ZfVfkvhQM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68518fbf-e477-4933-7c10-08d58db2dbde
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725B8ADE6CABEA786A6829FFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FsyIs5xfHHh+0qJpGQHsQCSnZXtRpMne09SkI3s8asGHPDyJdYhibDHhuPwwI22hBziQAwWxJSFAUmiSCCm0AgDx7WxbtD/O8MQ0AoAcF1azrFAXX/zoi9qH/n2jhZMP3Kxz6bReuBWSZ24+e1/yFOyInpswVm5JqICTmvXewpz/QBC3AQuEW1Rt3tZhEHFawZeiTGqaToDQaJ0si+J/SK453JBb+x8GSPxNeNMeUkLlI1a58SXKk/Ao4OEvJPTP4XLh54xvRAd1ChmeRKXI/CDCgpWzDUx9SYb/vWXGe9N2XBwoUjg2MvbhromY8+p7D53PflncssmELaPFAfh9yg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68518fbf-e477-4933-7c10-08d58db2dbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:06.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit 90592b9a35836bacd34d92a3aba7958756b6a7c0 ]

GRO is not supported by Chelsio HW when rx_csum is disabled.
Update the netdev features flag when rx_csum is modified.

Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/=
ethernet/chelsio/cxgb4/cxgb4_main.c
index 0c2a32a305bc..3ec32d7c5866 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -2742,6 +2742,16 @@ static int cxgb_setup_tc(struct net_device *dev, u32=
 handle, __be16 proto,
 	return -EOPNOTSUPP;
 }
=20
+static netdev_features_t cxgb_fix_features(struct net_device *dev,
+					   netdev_features_t features)
+{
+	/* Disable GRO, if RX_CSUM is disabled */
+	if (!(features & NETIF_F_RXCSUM))
+		features &=3D ~NETIF_F_GRO;
+
+	return features;
+}
+
 static const struct net_device_ops cxgb4_netdev_ops =3D {
 	.ndo_open             =3D cxgb_open,
 	.ndo_stop             =3D cxgb_close,
@@ -2766,6 +2776,7 @@ static const struct net_device_ops cxgb4_netdev_ops =
=3D {
 #endif
 	.ndo_set_tx_maxrate   =3D cxgb_set_tx_maxrate,
 	.ndo_setup_tc         =3D cxgb_setup_tc,
+	.ndo_fix_features     =3D cxgb_fix_features,
 };
=20
 #ifdef CONFIG_PCI_IOV
--=20
2.14.1
