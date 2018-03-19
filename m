Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479792-2-16319350008443478221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479791; b=qlwZRucll79U8kJrPOI7dkI12S4KVT9qZ1Xgl6Mr/2/Suyn
    lLHo+nUrTj0fdl7ZktPYsSnlEm2bZXzg9Ul2jiIZ23O1PYWOsSWKkDGoVbhZzpgs
    OagPhnCkWjlZ5wAvCcNi0BYPqlDaIFs4zzvnIbTmKPpUVXh41ZvmddmprtSIA8p7
    LOsjzvi1DSWAmX6NHW0tewPQ1HTtcV+aFHYHy4fE0rST5iuIzASuyjPIhnzBCBm6
    8abBe5l+RQO5urMHvOrkV12uQyoD1BT37p7KOjU6GqypNbpZnp7AZwgbNBpEywDQ
    HEUfHnfA6+/T5CUNtV72eTsf96uzcqVmkDDdWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479791; bh=U6nstS
    qkGqYnTnccZPVVj9Ud2O2NnByaKh1KYWUFyhk=; b=oRkKt/CONcK45uZI2caoSn
    GL4vVAf0p8UdrBuZnLRsD+Sb8LBK3PPV1KxsfWXDtsUYr+X5q3la2M/v4T09592Z
    pK5b8cHxK6+lqDKm+peScoRbv8fwqWIDj/3mX0rLk8M5ZF37BAx+eRhhjpI+Vc3f
    P9S8vEn1msv6WMU2lU/PZbx+sBZIkDXR1lHUCJl2LI/ClbesgxkPK1KjPREyh9fS
    BuotHMPa7Tq8SldXiKzSnnCqypDugOL6aqTWheke5o/cBkzqKiRGZgKDANIDGLfF
    4KdEEERZU2s7TCOMW7vnpBDO+yFL7XD8IhIC/tpZCLcDfIzTWkc/E6L8xZ00gwYw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KbLY7R3Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekvdefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KbLY7R3Y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekvdefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967857AbeCSRPK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:15:10 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966562AbeCSQKG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 109/167] mtd: nand: gpmi: Fix gpmi_nand_init()
 error path
Thread-Topic: [PATCH AUTOSEL for 4.4 109/167] mtd: nand: gpmi: Fix
 gpmi_nand_init() error path
Thread-Index: AQHTv5xmBMy24wBuN06VpbXlFfOUSg==
Date: Mon, 19 Mar 2018 16:07:38 +0000
Message-ID: <20180319160513.16384-109-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:6udGgMSw6bXy6kjgU/S9NHh/XXUyWl/YXP1UVMp9MavWtfZLgWCowxkKyFnV90QjBaaAKPXIhwD1OK1u7xx3s/6pt4QHgfBfqQTqf6HNGwyKXiXO89B+et3dTHRrhjegYOWal7GCOU+bgqqMC0LKnj8JT6hy7DCMFMnmKmC0doNgT9uva2w+aD7T7g9pljZs/6Z2cowb0U0Lm6UbjnjXzf5j7d71XYKVInFmGCFalveMXMNUNoLVKXnMI6dfpiPB;20:b/BZCDtzP2PCa/Rs6BPQUS3HDy/O31CE+vtUQd/s2K1cHPMoRt0NmUzy3oCCv+emC3hWZCKVHlmUxG7CfdwnCHhr3KakrQYUludHqXgOM0XxXBLXnPG/uKMY96UyPTScuxVRwRvhiRbCVbSTCmCLbnE98QsbOlM0wLba6bQ1I/w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf97578f-58c9-4f1b-452f-08d58db3dc92
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091942355FE68219A07AE9F9FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /ueNPKpcKC3tJnxMU6hrhZwERZsPOuDdOd+OY0eYVI5/HgcQunHCLPGmWc9cjZsBMm77L+oV9aa2KgyL0RypmQ7gkWC6BRyx7jvYE3/kHIko9qO/luCHD3xE/fS9RG3bdMwgJ89HOE8WLZPURCdkVWfl/TVj+/+ri35Wmr4J1WTxjc///yQF5paNi8wzaUP2MeW7QSi3AxEhkm/QqeNU6LLLsrXdKMnYV0VScUemJuWLFtAJ5G+ATyvWj6TtqRlELuHy7+AdQNn9pRrojMVF1MZIqtuJ1jXtBXtNeKs+uDyFpELaLBssX7GwlSYV1OQK16oU4xLA3DFN5SmLcLf5Sg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf97578f-58c9-4f1b-452f-08d58db3dc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:38.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Boris Brezillon <boris.brezillon@free-electrons.com>

[ Upstream commit 4d02423e9afe6c46142ce98bbcaf5167316dbfbf ]

The GPMI driver is wrongly assuming that nand_release() can safely be
called on an uninitialized/unregistered NAND device.

Add a new err_nand_cleanup label in the error path and only execute if
nand_scan_tail() succeeded.

Note that we now call nand_cleanup() instead of nand_release()
(nand_release() is actually grouping the mtd_device_unregister() and
nand_cleanup() in one call) because there's no point in trying to
unregister a device that has never been registered.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi=
-nand/gpmi-nand.c
index e2a239c1f40b..411888e44969 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1949,19 +1949,21 @@ static int gpmi_nand_init(struct gpmi_nand_data *th=
is)
=20
 	ret =3D nand_boot_init(this);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	ret =3D chip->scan_bbt(mtd);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
=20
 	ppdata.of_node =3D this->pdev->dev.of_node;
 	ret =3D mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
 	if (ret)
-		goto err_out;
+		goto err_nand_cleanup;
 	return 0;
=20
+err_nand_cleanup:
+	nand_cleanup(chip);
 err_out:
-	gpmi_nand_exit(this);
+	gpmi_free_dma_buffer(this);
 	return ret;
 }
=20
--=20
2.14.1
