Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715406-1521493213-2-17291952342897211423
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493212; b=vEnjexiO+CPvaHPOIURMoEtQILKd9Xo5xn/DI7WHSwTVMwC
    oS//hla5mslHXphZxwHGlGITZR9NBi/1R4e3ogL8dlYXSmbXTkWImNHtckjyPCou
    PCrg1+7pofmxUDCDcQmy6BB+o2L0QsGVJ8geo13U8Hklrhtgzjljzx/M27bzHDO/
    h76TE5fw2AbU3vH4x1qDvlqaUxEtt79sbnGNSO6oiU7CPgCeoR1efFORWUpDBxr1
    tkeJOC4c/DgcggCU7UPHrjOKRWS6HV9u3jK5ICF/2e3aJ0aq0Jjfisv2cTcMienk
    ds7nuAUuH9AmQq2o9zA3aVrXkTQT5K7DU+auDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493212; bh=5DURBX
    EvFPwdDnr6leF3QUeJHiiLtdYFXgLUneDNTGk=; b=JFhDukBHjSgoyqi8r1EsGg
    U4ouun+mhfz9LU5NM7MXja4gBVNzr87TKl2HSCptAOujeBi8sQ3NBtmx009z/93J
    0WOEjYnW7q88Y54u7yTqiYZKxhQvmKXXMslK0X209DGuiD/F+O+jtXTZaihm0tVP
    dVo6UC4EqKOB9ktRluwmdW/qlI3xZLnRl46cXd3Kl/Rxdp3sU5b0I0/OtvUWV2Un
    XisbVgePP8tpkOICKfggZwvufTp3eWcYo/jxfJcvmUZzEBEc2FD6bvhJO76K5+JE
    a5M1NnrQgx4WV6/roNq7/Sw2OMfeqs9HG2YOMY1RRpcO0uawYl5rnHkVbPKOojgQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lUa/RVEu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheektdenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lUa/RVEu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejheektdenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030489AbeCSU7j (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:59:39 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965473AbeCSQDC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 169/281] net: freescale: fix potential null
 pointer dereference
Thread-Topic: [PATCH AUTOSEL for 4.9 169/281] net: freescale: fix potential
 null pointer dereference
Thread-Index: AQHTv5uB4dQYNlZ09US8lvQuIGAy8A==
Date: Mon, 19 Mar 2018 16:01:13 +0000
Message-ID: <20180319155742.13731-169-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:XSB3xQRu24A7s5kfG2YZK0R86ESlXepAq+EEYxUpWx38xhjpDNloh9S/qY7kNLaJAWwOwfDMMubv2g2K6pOVUNKCjVo1L5mru7tZJu35LHrRkfWCw2IvvgSbBNuqrA1Vgq+PqqG8m/wOiFTVkTy2bCCMsuRygTqlBFSP7DtgP/W/4lfYRnMjn+z5Aja+jorBPcjf/zIgyLKusn8Ea/iKyMC3CQ0g2N9AVGk6knNWNgXunNRS5GvPBLyzuvv9ZnOH;20:694EyjfCzU+DffrxuS+J2Wm6vz0eUhWiXzwPseeD+9w3MgiRYBqsdI7KRfe3ZQ7iLctP9ZZgixoH3MVtiLSmPD2YBg4uufnzrPG5ARdkiPX6tlWllgFCGhdZHHtDjqcSHVdyBRBt1nwptkKWFl5/6J68zkuQGEgmHSbx2aZE5wE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 214fc46d-c02d-4a31-22b0-08d58db2e053
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07257519DF3859617938FA26FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EP9Hw8QEtUj5MNNQ0xoCAi1e+cuMH6GpjH8O7oY6FCs6j0gvSVoVv2AvifCkcJob+p4phPhAc5wCQV4mbJ1oms4DATKmez2cewBZ4SkrAlV7wwwILhDZKwAaeWFqC5aHEgMMOmNGqY6ccSHYplbPerWkZDCc+SD+8PvNLWiB85lF+NvUzOwOdPy7uVZPwzsZh4uAhsvetl7wLbZ22WIg15s4HCQXYj7lGduiFUddS/qZq+DcnABSX3gfjOsfX7zCXsPZmbtWa+XQsozYWKEl5RiJnZjzzQGCGo64+90AL1dwQyS+jsC0MgGMFzjSqHltUounc1CoMjYLZP5e2NX12w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214fc46d-c02d-4a31-22b0-08d58db2e053
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:13.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

[ Upstream commit 06d2d6431bc8d41ef5ffd8bd4b52cea9f72aed22 ]

Add NULL check before dereferencing pointer _id_ in order to avoid
a potential NULL pointer dereference.

Addresses-Coverity-ID: 1397995
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/eth=
ernet/freescale/fsl_pq_mdio.c
index 446c7b374ff5..a10de1e9c157 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -381,7 +381,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pd=
ev)
 {
 	const struct of_device_id *id =3D
 		of_match_device(fsl_pq_mdio_match, &pdev->dev);
-	const struct fsl_pq_mdio_data *data =3D id->data;
+	const struct fsl_pq_mdio_data *data;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct resource res;
 	struct device_node *tbi;
@@ -389,6 +389,13 @@ static int fsl_pq_mdio_probe(struct platform_device *p=
dev)
 	struct mii_bus *new_bus;
 	int err;
=20
+	if (!id) {
+		dev_err(&pdev->dev, "Failed to match device\n");
+		return -ENODEV;
+	}
+
+	data =3D id->data;
+
 	dev_dbg(&pdev->dev, "found %s compatible node\n", id->compatible);
=20
 	new_bus =3D mdiobus_alloc_size(sizeof(*priv));
--=20
2.14.1
