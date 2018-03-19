Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474655-2-11139011641534590726
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
    t=1521474654; b=hv4coYSgwCO4cc4JY9FpYeKxBNrJxwaEX5RPdUQ73Q4Al6l
    zA3VR13DWLhVBnAyPibjwW9qNDYTD+6n4v4Txn/Sand2Atm8MR5/tA4cYhxTH1iG
    379j9NQioMEAhwLT95/pSPumsaCIAMZawIQZZIyOlcADGTuySBGAGTYidRD/ek99
    VlZCcgtHg/6BV4hdo/1f2F/ZYrq3eK1DG+okhnubkX/gkIQNPnCzrp8fqNqh1YVf
    88j7TanqabiNK+rvEMBzS1U8nfYDwRx4cbS3gaZqYvV/LOXIKY3xIRVrnZi6CtHi
    uMBk6wmf+JWDov8YBMU7LVDL2biD/X0oZzoQ6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474654; bh=aicwdn
    SwCjOUP/UysK+W0AgICeNttFqemYnRaTP/lv4=; b=T9ATqWFCoyxHEV1YxczVgn
    ZJsH6NNiL922u8lZDL/8UkYYNf3JQEcLXYdP2geJ8HrKrQZdjzkVv0k9q7qyxd6T
    fOJz0haX54eBFHASbvXbo2Pk8nLOBvxslO0+Ca72XN7CXqMMeMjWkdqQXhbSq3Lv
    z//2TZQvaso9j+jYqJt9PhohpmQ0OHAhyujiekwAOJZhAp7Who+G58KRLVf/U3B3
    BrNj72YktCEKH188BB5NFOom7gE7TAqIzkJp6/kg5fPN4WqD7zucL1ERdPWzFe1C
    2lB6o2chD0VnwGo3a2Hj/uE/HrXLRA84Ef26R+EBqIiRYwmagZsJAuFT1iohr06A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iRoPagdX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iRoPagdX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdektdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejieehfeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeCSPuu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:50:50 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:63552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934088AbeCSPun (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 124/124] thermal: int3400_thermal: fix error
 handling in int3400_thermal_probe()
Thread-Topic: [PATCH AUTOSEL for 4.15 124/124] thermal: int3400_thermal: fix
 error handling in int3400_thermal_probe()
Thread-Index: AQHTv5nZ9HjMQTXqo0O4cDCfIDQdVw==
Date: Mon, 19 Mar 2018 15:49:21 +0000
Message-ID: <20180319154645.11350-124-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:rX1jxPGCJLPFxCbxBSlxal+w69I5H5v6pdMqZLwJloVncRWYtSckE960rhGNxK1PLumAXzh4491E0Siz6kkjgT4WTSbY3NtHOCT6aeOrzj8X2zRea7rXBj/+qcEMO07aSxnemkmXgeNQ3K0m7O6iIeuJXOZcsjNKjanu9E4wUT8J+Xe3uwtntzs04XfTRscsaadpK46w4YKNDybODqd3V0Sa6eO6ge3Rgbbv+M4qYVbz9CgoDq9Sz/byJdYPWe8F;20:RqxDB4TuKpEL35GBt+7h0ZZFEzqUzpprmfec9gbjJxoRVD1DVPyI0prFK8Kdl/eehjSUxksiLINA79tAnx7Zy3ad2nsZrz00GMGQlMkdQYVaVV/+phtSBlfGPULXfdnmPzfHr2eDCnitJiFozbuXNxlym7Y6ncBPcuL3mu3mnus=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6a75b68-651e-445a-b65f-08d58db129dc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063DFAF5965B6ADF78982E7FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(10290500003)(68736007)(110136005)(478600001)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(15760500003)(2950100002)(107886003)(76176011)(26005)(6436002)(86612001)(54906003)(6486002)(4326008)(186003)(3660700001)(25786009)(53936002)(81166006)(2906002)(2501003)(81156014)(5250100002)(86362001)(2900100001)(5660300001)(8936002)(6116002)(8676002)(1076002)(3846002)(3280700002)(66066001)(316002)(59450400001)(6506007)(14454004)(106356001)(4477795004)(22452003)(105586002)(102836004)(6512007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Yj6DRJg70pswhS9gyqiviC91iYkzI4pUNq0GtvNff72CarEW5z1uzyO2x5OdJ5SwVaYlHjmd3K5/KbwkuOd+Hn1FHFZEQHKiEHmTQegY1WVVNkRY4gkSlyoC+QFh2Tv1DhXY8f+3ybSXjLkKVG4krzcURL1DwT1j0SRXzv18stvQwoCw5s0FSmNa2PtVynH+sez00QEtG399TrFB3xE5P9OueoWzBIGSUpoYUQY00HZzQi0DcRbq+aRZczE90nKxgD2kngHY8i/OroC7InSdR2iXa2Agu1DanvUNx3ncEHzhv1y9uhJ4wPpsQ/XC9XnG3mJh3ttkKQK6ZWNK+lL6CA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a75b68-651e-445a-b65f-08d58db129dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:22.0020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 0be86969ae385c5c944286bd9f66068525de15ee ]

There are resources that are not dealocated on failure path
in int3400_thermal_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/th=
ermal/int340x_thermal/int3400_thermal.c
index 8ee38f55c7f3..43b90fd577e4 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -319,17 +319,21 @@ static int int3400_thermal_probe(struct platform_devi=
ce *pdev)
=20
 	result =3D sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
 	if (result)
-		goto free_zone;
+		goto free_rel_misc;
=20
 	result =3D acpi_install_notify_handler(
 			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
 			(void *)priv);
 	if (result)
-		goto free_zone;
+		goto free_sysfs;
=20
 	return 0;
=20
-free_zone:
+free_sysfs:
+	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
+free_rel_misc:
+	if (!priv->rel_misc_dev_res)
+		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_art_trt:
 	kfree(priv->trts);
--=20
2.14.1
