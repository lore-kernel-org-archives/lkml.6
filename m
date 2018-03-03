Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120582-2-8640966827827933993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120581; b=iz8d2p/OcvjomkiWsyz/9vfLL5V6VDvrIajdKhhYvpMaU9q
    rpLUn58/1Zj80kIideesKmlexFqvJU8fvv+/5QlUMbg804xTZosJJGcn+DGAl6Di
    5aNxFHj2eyR2ceX9B/xZ4eSUU762m7jXSjeZ2V3sO/mPLY5eTgaTeKjTxyFgEx+E
    t+CYmlMbHsG4GDrNNFR49ezHuImwuIRfMe3nO+iArqW8FVePdU/t1hUoVOBKdflK
    E1T/TmWrNDwBhfrgr5JjjvkNnFOUzgvAHVXmi/R9RG20IQzuhqNu+NVjjQFaR4wu
    mdnILvvvgGCeyxyQG3M6Ltx3Ey0gNELWkURAhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120581; bh=0V+alk
    W8TaWwSD+frSpPxxeRaiYWdxEGWdRicrQaVNY=; b=fP8Q2UBwXxLECDMBmwBHQ4
    a8cpHXC8CVgf7PYEeusNVUAET8SYNCi7iewmkm1tkLkH0ZMhCQ44Y+tEitV30QHQ
    I2t3w63n1lXv+K/VVo1EmEvzHQ4Q5tfusMLWNR1yhQF0BuvngnbnM0uHNxVaDYxj
    Wqlwx6UlkxNX37ChXNkCResNcXL3Aw9nr7OlnciZKWJM9LC3XHOk+j7mgxGuK31z
    9+Vk+1rYWGj8++8/ghzFtZhFkO8p7X2xX5aDSRXwqiZyrRt19jMO97qDwuTo+Xdj
    B6LpxR8gfIgJhw7yt6W8149jbLmcr+ynssGiUsJnQK7p5lqXEmjiLw6OPJzdwhQw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QPqCVGGj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QPqCVGGj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeCCWer (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:34:47 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933677AbeCCWen (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 121/219] qed: Correct MSI-x for storage
Thread-Topic: [PATCH AUTOSEL for 4.9 121/219] qed: Correct MSI-x for storage
Thread-Index: AQHTsz8KyaiNmv5rZEyt/BfwBampVQ==
Date: Sat, 3 Mar 2018 22:29:06 +0000
Message-ID: <20180303222716.26640-121-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:9SSI/sC04efX8JySsC/hMuRPQba2THRAV6R7ws/OycMZpafrUv9gD13eUiiEDpmzq3TagSwhMXGUlhDL2D2Q/7WXoYhss4u8qkxSDcxuzDiJnrNLb6V+GmjitOH8gMYwZuDxOZpV0qH6865CbmfVctAtyDS5t8M1n7NzEj4dbOciBHz8j9I2WDU17WChh4XzeP/9miPVJUlEiA0KJX8+1su6I2WJVKJzquPZugAKUNicgvX7Ai4A3dTZxwv/JPEi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b4ad672-2fdd-4f1d-62a9-08d58156f4d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1068870753333F4E26DB1E2EFBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(59450400001)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(575784001)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: kckXM6Xqd3fKNCODulNLS+SGPUpTyTfJla46WVadC30eXbYCnTVsgmWZUSp9HsxEGU7QcvWZ3HmIUXQ+9IIRdW8q/OBS0obcWCThXA2MK+jxjwbVRKksfruAA65hpaGakFt5N3ABlqjZCy0eQqMzw8OnBgu20n0iczs/IqzzNV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4ad672-2fdd-4f1d-62a9-08d58156f4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:06.4476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit 2f78227874754b1e10cd348fd6e7693b0dabb3f6 ]

When qedr is enabled, qed would try dividing the msi-x vectors between
L2 and RoCE, starting with L2 and providing it with sufficient vectors
for its queues.

Problem is qed would also do that for storage partitions, and as those
don't need queues it would lead qed to award those partitions with 0
msi-x vectors, causing them to believe theye're using INTa and
preventing them from operating.

Fixes: 51ff17251c9c ("qed: Add support for RoCE hw init")
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ether=
net/qlogic/qed/qed_main.c
index 333c7442e48a..dba3fbe4800e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -711,7 +711,8 @@ static int qed_slowpath_setup_int(struct qed_dev *cdev,
 	cdev->int_params.fp_msix_cnt =3D cdev->int_params.out.num_vectors -
 				       cdev->num_hwfns;
=20
-	if (!IS_ENABLED(CONFIG_QED_RDMA))
+	if (!IS_ENABLED(CONFIG_QED_RDMA) ||
+	    QED_LEADING_HWFN(cdev)->hw_info.personality !=3D QED_PCI_ETH_ROCE)
 		return 0;
=20
 	for_each_hwfn(cdev, i)
--=20
2.14.1
