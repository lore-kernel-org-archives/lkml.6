Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B11ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A320866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PfXk4aoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553A320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeIOG7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:55 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728767AbeIOGuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/PwbyLGabWxOhktqwKiNnY3KIaGI2xXVH+bN/hPT7o=;
 b=PfXk4aoVcpcOIPX7CJ/4KnAjUdym/1l26Ha3WqVC9Kcf//ORNexoCSz4qcLZLbb+ImgINs60nkmY7+KO5rU66cGTSrHTL3B+Ck/tyl0otD5Oo8A9teinINCpMZWM7PqYZNTeTE3B45J6srTmB3O9GnXRhQQBQ3tNrJCn37FXC8Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 36/57] coresight: ETM: Add support for Arm
 Cortex-A73 and Cortex-A35
Thread-Topic: [PATCH AUTOSEL 4.14 36/57] coresight: ETM: Add support for Arm
 Cortex-A73 and Cortex-A35
Thread-Index: AQHUTJQF9/D8c/Y3UUeqM9x+cmxgAQ==
Date:   Sat, 15 Sep 2018 01:32:52 +0000
Message-ID: <20180915013223.179909-36-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:ru5G7Z8izAn7rPzDC0iZWg1U/PsKvx1HK48ri6YiBHPzC7wtMNamTFNOF37awjSnjpEJKxDnsXl6G1lsJhp+UWWvBQUvSyJDy0nM+ucDmAof1Yx/HyNkSx6cQ/JxSQSbfTM9P+jtzf9J8u0YiPLFpcNZhANj+JjFqbO0HOqSdFwf2qx4Dg10YuUBHNYm+8oh5lP3c/IxulJbZ9NzBIN9fBFkafDX8+8AxW70S0WGvjZ3KOHeo+iBq8gBXrVvAihIq27SsFWvnnhe9Y2dH7vgBf29s7tsN8UPY2JqdInlGwxn0P51HD8tXUGpsoSiXpRoJzX6/zV7REiZRSORY7Z1vmJWxaQoejhXsOFHQcocvp0Px1Vc1pfnVDcAfA9LBGiJPjo3rXnDSe995+RhnjAJnQ7Cb3lBWcukWwabY5kUoRuNqtzZkgIlZKd0lguKdkSNwwdt87acNWnTXsK14U+9og==;5:vsl/bJ6AaZ9G4TuaOe84bu9xbeNxJSSpvYLhhMsHvN7JMxdtn/DpQvR0ekGbDanRvygBAZSk8RCE23N4n532fDCSQT/Exm05p8f3RoVPCtFm/4poN9hx9pmLeTjSv6JNmAInN71sVsWI66gNjl1HSnEURVU/7KQBQS4lC0OxA5k=;7:GK+huUGmSx1s43TIdPUMGBXeG2uwhoX6MIjQD0e3Jtsa2GjlDJS9p8katuZvoCg3ouXJkPVrIx4hlSkmnaec3bOZACJLd+SytMGTUCl0zNXjmPBvt+D/pwQ89drkQUsZ5X1NdRivv58djEncjxdI67efu1PO0RxZ4U1NRva6OTwUWX8VkwksM0d6dPB5yL8zj/WQkjMeEyHUOtKKeO/SVVRifUdX96w0q6OGO3Cq0FvjDQxg+dfqmi/HOgxFaUQH
x-ms-office365-filtering-correlation-id: 01300ff4-63b5-46b7-413a-08d61aab3882
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471F0F4E5B171BA6AD17B61FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vI4GTwxPHzbP4dVwBcGATktmsGomeXsagn5afeoNVYtCnwGM4l2DBPnXUDL8Hx7tKHuKpEOfUlaB9puh8cKnI954/ufarXgONqSTMVvSHQSy0Ip8TI20cDaaVMi977NZGoE5VBwJNLQ8GJTJTuFCNsAxixG4VCjzvBnxgv8BYaHYfh6twQ2oQvMtn2ZUQdblYq/oR4uVMt6FmvBzdz6yWp9BTX5wsU4PJ9/nPKJJEnbcDYGDUQ1tdtgKLlgSkPq4yg2gzYca+h/kHuzAChtSqaL6+l0a08z95Uhs8YBPGVj9n5nfkgM+moYj/H2UtyPwuAAduPV99uzjJ3Wn/c7wHVY57Q6VHxloNQLPUpoM9j4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01300ff4-63b5-46b7-413a-08d61aab3882
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:52.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 5cedd22370a0a460b663c06de1fc10b4ba3c5d0b ]

Add ETM PIDs of the Arm cortex-A CPUs to the white list of ETMs.
While at it add a helper macro to make it easier to add the new
entries.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 31 +++++++++----------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtrac=
ing/coresight/coresight-etm4x.c
index cf364a514c12..5a1a14bcae72 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,7 +1034,8 @@ static int etm4_probe(struct amba_device *adev, const=
 struct amba_id *id)
 	}
=20
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: ETM v%d.%d initialized\n",
+		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
=20
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1052,23 +1053,19 @@ err_arch_supported:
 	return ret;
 }
=20
+#define ETM4x_AMBA_ID(pid)			\
+	{					\
+		.id	=3D pid,			\
+		.mask	=3D 0x000fffff,		\
+	}
+
 static const struct amba_id etm4_ids[] =3D {
-	{       /* ETM 4.0 - Cortex-A53  */
-		.id	=3D 0x000bb95d,
-		.mask	=3D 0x000fffff,
-		.data	=3D "ETM 4.0",
-	},
-	{       /* ETM 4.0 - Cortex-A57 */
-		.id	=3D 0x000bb95e,
-		.mask	=3D 0x000fffff,
-		.data	=3D "ETM 4.0",
-	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id =3D 0x000bb95a,
-		.mask =3D 0x000fffff,
-		.data =3D "ETM 4.0",
-	},
-	{ 0, 0},
+	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	{},
 };
=20
 static struct amba_driver etm4x_driver =3D {
--=20
2.17.1
