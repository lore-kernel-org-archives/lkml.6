Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479590-2-2438677966134774467
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
    t=1521479590; b=XEHlRKY9Wg6FeZzZf78y3qQ/JW8LTvUkTZUso4+wC2DkFOW
    poQ/a6H/f1z6nwSIERi3SbazDCmm7iXF/7b1l5Mz+sUbo2MqQj4t3jfXzmPPdYw+
    9XOTzl/O+9326Ai63UDN17LbARjIZmSH/DHhfFdqf0lQBHpjkyZ6vvf13hN8Hfou
    AccuX0/EUFqkT0ZaRwXi+RaXOa5pnRmDM+SPs8BPodnLVNaCEDaFMMCStXPMgBoC
    yiAaXiGrPyuWYGQ7AsE6eUcTY3Wz+hCxsuxajJcX1ev0ut3eVmfWWxrQT1ipKuDS
    NKLow2wFQ8+FsaEFA13iV+B+XZbUgIyx421d5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479590; bh=Q+aAqX
    Xh7MrbltKl0bJiZgpFtbMGFcWY9FUMcZvo0QI=; b=p1Nr0BwyfoVGMQAQzBF5UZ
    cSFBpN6j7ZyTpS3iQseEJn7nGqsQyDfF2xkQdpBg6xr5cL+fVfniwwsLbIrIQgTE
    DE3RCkputZQZuhlSeaFKj42DGIzTkw47ObrP0SmJKprnw8uY8vjIempULVf7STgC
    HSGBcF/veG5VewAthKav+8tLGNpfIMkMLo0YzRV1wj7A8Z2XqJfTNAVkw0/O4X18
    5uwnVyMwGXZZGSTF5xSLPHhVuObEqCjS7zqDAWkFz26bT1/c9O8cQ4uCvM8k6I3m
    T+H94Nrwt8d2OI+w45nbCHYnuEh3cnaISJcbkz2vqhM5Hm0p10eJ5MKcz4RKOG8g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VFU8K6eG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehjeelnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VFU8K6eG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeehjeelnecuvehluhhsthgvrhfuihiivgepfedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966520AbeCSQKV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:21 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966560AbeCSQKF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 108/167] net: freescale: fix potential null
 pointer dereference
Thread-Topic: [PATCH AUTOSEL for 4.4 108/167] net: freescale: fix potential
 null pointer dereference
Thread-Index: AQHTv5xmGSYL+QmSGEyJEe8XdYpxEA==
Date: Mon, 19 Mar 2018 16:07:37 +0000
Message-ID: <20180319160513.16384-108-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:PNkGi0NLJCCgQwZsGVBMCNpvKu6zIHRYnHS1+kNvftGUT38pAWv9sB+fNbltWilu9H5DzbtixgKsgzxt8nnYNyq8pZmhZ3rMXznxyry+vG6kXPDR5LqQq6lcNO8oV65FBdbLSJyuQaYyj/vTiYNaSCqL3KSmzTCdWS4+lU7HLwow0nUHj9vnJDvpU8pAN5m8BN7aHibP5Se0ZPVg9tOT+yg00FDjG3dv+zFsr0sMa98WmGCb5gYRazzKcbtgOBwu;20:9FZ6HpZkOgd5lRiKQaeMQUavGNfs5owzk81lBuJ8QYiU0+4sXZzhR37F34NkntPuHHSXSB3opfArJ7dApZyTi+JoFmT206rZm3R84ZWGoZNooJRJL8qLcfMYLBCtUrWW7253vsWRKGjYTDh8QIpZzrBZJMju/nKYoV4lue83jm4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7695e664-ee8f-4046-b24b-08d58db3dbfd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919DFB920AFD8AC747AC980FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cguDDgKHzGvoOzV9rPjtdI50EsBk8tXC+hBRrx2/vmVowly1IknUcaAclWSLqe4/xxtDrT7jKHI2xn60gqrmpWIyLKLjNGDex1oihXW+cSqfzZt16DUjpVA5a/ad5X2zdyKzGA2E5z8J1Vy1jYxG4jeM7lOg9tsQPz6RhZ0umdo6lPcXw4Q6njnO4khjzc3in250nkoBQmSvZPPMjwZR6uU0IZ9fWf9hLXIW4wRGXiBDq3Wm95N+94+gO1rd9I8CeimDb75awYioBNIW/4pxVCL+GTGnOzn7RkNTIyMhH1XMuk0VHvekp+Smqf1mpZLXJ7j7SQ7P+xmYmEbxBMoTlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695e664-ee8f-4046-b24b-08d58db3dbfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:37.4992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 40071dad1c57..9c76f1a2f57b 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -382,7 +382,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pd=
ev)
 {
 	const struct of_device_id *id =3D
 		of_match_device(fsl_pq_mdio_match, &pdev->dev);
-	const struct fsl_pq_mdio_data *data =3D id->data;
+	const struct fsl_pq_mdio_data *data;
 	struct device_node *np =3D pdev->dev.of_node;
 	struct resource res;
 	struct device_node *tbi;
@@ -390,6 +390,13 @@ static int fsl_pq_mdio_probe(struct platform_device *p=
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
