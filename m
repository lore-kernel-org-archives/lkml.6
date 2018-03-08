Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489271-2-9234674297359570319
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
    t=1520489270; b=MyJFYLjqMPF+KKhKBvjvWtYmP7pOs3f3S7bSu+yZ8LdwL2l
    JGrBEEZ6CZugeXCY6HpBkrfW35o56rfTC1jCRtPZG0cIAToYDOh6m8b1qpkwTdLL
    ODH1wgriD7qr4n6ALsFQFaXqmqQQvre5UZju6KfcUDunk/B6K/sQk8GfE0MlY1RL
    0R+Pbw6J0GB3ErzfJT0hwzDFxmnQ9QYCqqAEVToAbAgyVdYIolLKy8K8dV5h+Y1e
    ctj7/ATpExZnh2y7wyPw2+wqrUg3kedPsuqRSu7zVncAu1H9uk+bmz7DQummmwgm
    WQUu71xvIUH/YNd8PXWJHZneZa6Zp5KHSQuNRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489270; bh=ZW0YfR
    wxHxBG1EvbBQLOBUI4bB5HTKLctrbZKFSOp2k=; b=tyKeBZ74whrWPOBXzHo/tI
    1V1R7DbrfvNwKQ/GC1Q9l2J4FzlBJ7Q0HToAQSR7nmXcTC+u1czg4Kpn8C8McHmw
    N5SMWrC113lpAA4J5/w3cY8Qe9VZjkYhHyA6UYsfXZC/Nfj46fN+INmP+EZ6ua4+
    WGMhQsHrLtn/ZqTZR8u69gRyG76975dH2cDZONw79zKCrsJi4Vsr6zK3rlkn9Hw7
    avA1hzLK0LQe8AvUnKPYAaDtJ/2okSjcIXIQsC8qNBeud9yjFcnSI0pnm20yNN57
    +47Ob/Qi58WyHYQ2VO9CXGsfL/ZWcFgKQ5EUyZrZSqM4FLJ6/Vfv0s3PFtKkWjIg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LbOm9Tsd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LbOm9Tsd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeCHGHd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:07:33 -0500
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:23927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965807AbeCHFCQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 098/190] ACPICA: iasl: Fix IORT SMMU GSI
 disassembling
Thread-Topic: [PATCH AUTOSEL for 4.9 098/190] ACPICA: iasl: Fix IORT SMMU GSI
 disassembling
Thread-Index: AQHTtppAh/00rkcBiEuh1y3Cj+IYew==
Date: Thu, 8 Mar 2018 04:59:34 +0000
Message-ID: <20180308045810.8041-98-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:lDmrcbh3W/AIr9xGvTE8Mlsy14GPPfB9yM+6zK2eeJoRYrKA/Mr6v6rWwI5281A8Cx376VoskbKCjJ5+8/SYSLRwLw+KyDB1/4CsUV0xHYLI3f0L88DkOZyoqY/W8yHulM8Ibg6Qi3Xs5a1Yl+ljvnzkk3KxjamTDBTeM8BnC0l63Mf9hhRYUWCYWPV8l8yb6hPCr4vbZesoUr0FjPDxI6V6AhjrYzbLuzqWNqX9XcXM4LyQdOeN5qYnvcnv27Ay;20:n2CnTD+cZmwUOzDb1tFHuAr3QuCahUSjHrPgmPT+2B0pRognqHUas6hv2ZR7rW68HhbAQsnXrOxWZucU0mhGuKkWMpmpQpzdYNx8A/6tPDOlAnj7DcsDtta9HZ7kT9IYELhwC0U8dV1ov9gdWxiqwqZZiamzXAG7W4NkvbgIeuc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf5e5058-4d7e-4fdb-6d10-08d584b1bf5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10638889D0BD0DB10895CDC0FBDF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(166708455590820)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(36756003)(186003)(2900100001)(6512007)(3280700002)(6436002)(6306002)(110136005)(102836004)(5250100002)(99286004)(54906003)(2501003)(25786009)(26005)(4326008)(2906002)(10290500003)(86362001)(76176011)(6116002)(3846002)(6486002)(68736007)(106356001)(1076002)(22452003)(2950100002)(72206003)(6666003)(14454004)(478600001)(3660700001)(107886003)(81166006)(105586002)(316002)(66066001)(10090500001)(305945005)(6506007)(8936002)(7736002)(53936002)(81156014)(8676002)(97736004)(86612001)(5660300001)(966005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: JJpr6rQt3OYpfhkZXK3RG51juORDY8ETnjhbz1iuJNvi08yru0vehG1lGSltUhGaPitUeoCIoWEy4w7OTtQmC2L2uYHC/vHP7QwV+AX5oZFXXAewCzkD0R9zqQ2QLRcdnrWZt2DSiQ21bVE8b+m9QBQ7M+NBniWWKZ+qLCodIAG+eUnDKOM5nKzxrgGioC+ZgTQ8qrIx80AUafnl4W+ez/b9wIncaGmJl2+9CMWG23F1IEMWxxbJCsOlDRlSsPDpHmclSDLjaHOeggFGGPdn0kZPRC1N92msiGW27kiae/UbpZe4IJlxzMISTc/0RYabjW42mZpPrVzDSH6Z0l3VKQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5e5058-4d7e-4fdb-6d10-08d584b1bf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:34.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit bb1e23e66e6237ff7a1824b37366540a89149c33 ]

ACPICA commit 637b88de24a78c20478728d9d66632b06fcaa5bf

If the IORT template is compiled and then iort.aml binary disassembled to
iort.dsl, SMMUv1 node lists incorrect offset for SMMU_Nsg_cfg_irpt Interrup=
t:
[0ECh 0236   8]       SMMU_Nsg_irpt Interrupt : 0000000000000000
[0ECh 0236   8]    SMMU_Nsg_cfg_irpt Interrupt : 0000000000000000
This is because iasl hasn't implemented SMMU GSI decoding yet.

This patch fixes this issue by preparing structures for decoding IORT SMMU
GSI. ACPICA BZ 1340, reported by Alexei Fedorov, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/637b88de
Link: https://bugs.acpica.org/show_bug.cgi?id=3D1340
Reported-by: Alexei Fedorov <Alexei.Fedorov@arm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/acpi/actbl2.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c93dbadfc71d..db7d15b6a580 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -783,6 +783,15 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
 #define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)
=20
+/* Global interrupt format */
+
+struct acpi_iort_smmu_gsi {
+	u32 nsg_irpt;
+	u32 nsg_irpt_flags;
+	u32 nsg_cfg_irpt;
+	u32 nsg_cfg_irpt_flags;
+};
+
 struct acpi_iort_smmu_v3 {
 	u64 base_address;	/* SMMUv3 base address */
 	u32 flags;
--=20
2.14.1
