Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87286C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K+SA2acz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDB32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeIXVDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:03:31 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730043AbeIXUwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qdmsZpO5IG2S2DFx1cA1PiKLWHDLe6E7rGiJW+d6Gk=;
 b=K+SA2acz0ro9TElgeKbfnUzWQwX2N0uUH20OtRDv0fmt07zl4mKVlpIG3BFrz1AEG4QVdIihVp7sIl1PJW6SKsMhIDkDGFfxpv6QkcU9g18s2R3yfFKfL4rkePxJfqnAMOqD/ZWGLmc3sue1LC8hgTsYfo1ux0hLGxlXXEDL7vU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 67/76] nds32: add NULL entry to the end
 of_device_id array
Thread-Topic: [PATCH AUTOSEL 4.18 67/76] nds32: add NULL entry to the end
 of_device_id array
Thread-Index: AQHUVBWvmhQ0aRzLE0+8Qd/8L8TLvA==
Date:   Mon, 24 Sep 2018 14:48:41 +0000
Message-ID: <20180924144751.164410-66-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:bxtMuMGCsYmRw2lN3trwko/Xw0gx3FikeEtKCCxf6ixXRwjOiLAl9c2Rk2knlfBEpbneDKLUBIpcHS8F95Gkm2eBJm2+7iIBPLH/wFFmFevtr2l4RElp9iShV7/9um0UfVno3pxM84wN4c0xjmfBvat3sMdiTPQTFPnxnHVCML7aPWnBYvriAPcR6UkSdXTCJY89aCcgGTzmBKJcaFf0sO4I0n8e06QIuYZIyItT4NDLc0jof4fwQQAC7rtbrHcd7IR7NUd+gadZwzf4DvPjMhBGp4jqJSNt55beo2GmNw05rGv97TuFBJi8J38gQkdIoXhxNel8ouNFWSp1iKH4yigPI9cluzGOrC3stqDBvurgk0Y02JSV4eLMcGwVxODFDs0XtLSHRoPGDKBz8nD37eLbSuUpKmApcD32kWFw0VYueB+y9E3itImukCdekwzLHMaNFHFX5OfiIZ2v33k1kg==;5:N7Bgyp4QV1DltAeMiPtiX6lDfnvry0Dp5+GVmhQWBYkDb65fws6351PwlNUL2zi7Ji4dSa2PwFskvf1ZXYKVQVXMZJJcM4cjSSTmAEwYHzegblRzQTlt0mOz6T5AT4puM9trt+4n8N0crdAeh5GlDlnQGY7+fOrwmy8InRnqXo8=;7:KUn/XpMBVsJb8+IgCEne4gKgtFmyUGHTvMAYpkTDPrhIqGhm9N4WhWwoENLjvYXeGHQkd9lZ8dI5YYCf3N7AB6AL0HDQulJllo6m11lqLJ5GhXTICcv0aBPevoZlhHIyvqE116sdXyGtQClh3lRl1qFdEsKeqsVe/dw1iswQQhMYUVhAHwZEq0RBR1+cz9D5EyQluxrEYcMIOCK21QAHM0l+5hIjcqVS5jBwckGbQgwEMQQUN/7lkZtHK8gjx5M8
x-ms-office365-filtering-correlation-id: aea1c178-dcb2-4572-b15d-08d6222cf219
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04716DBADDBF21FA928F1408FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ejUhzdfj4491vrmkbR25TPqCK5ecDXHzspVTN7VpAi9KP9tB9fh/eqWQZ35QiwmHYK7t2a5DGQoudexRFsDglUxTXVIba5LUAoSTWz3MCdImnHJDxdgYQud48tMSMyWxupVko7QjGti6F2C2p8j3VJvTBv6tUGXPSEcdPyjCnKR4Xhtu0lFZNFDn+P7eVCZx4MuwYkO9GJm4ReYvMWnuoRo+HHAn/ElhOuF/AafjVhyTJW1N+CrjCKkynSd9NRDaMGBtd/YwW33hQIu0T8n4DuJW/UmiKTgNHXzcxTbOQUqcj1jZBTlwU+IFK2tkSIV+omlHaPXaKR4BBJL5Ie2Edut+6L7KTR+dfbHBgnNtZss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea1c178-dcb2-4572-b15d-08d6222cf219
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:41.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 1944a50859ec2b570b42b459ac25d607fc7c31f0 ]

Make sure of_device_id tables are NULL terminated.
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/kernel/atl2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/atl2c.c b/arch/nds32/kernel/atl2c.c
index 0c6d031a1c4a..0c5386e72098 100644
--- a/arch/nds32/kernel/atl2c.c
+++ b/arch/nds32/kernel/atl2c.c
@@ -9,7 +9,8 @@
=20
 void __iomem *atl2c_base;
 static const struct of_device_id atl2c_ids[] __initconst =3D {
-	{.compatible =3D "andestech,atl2c",}
+	{.compatible =3D "andestech,atl2c",},
+	{}
 };
=20
 static int __init atl2c_of_init(void)
--=20
2.17.1
