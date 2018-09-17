Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56917ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C14208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="icc+/Fvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C14208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeIQIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:48:08 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730194AbeIQI3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/piMTC/rP8LihI9pFJANq7emtJsBJy2fZ4XjxEP4YI=;
 b=icc+/Fvd3cMNL5dZ7muAQQgX5D7f6Q+AowsA8ueoKp1rfKvvqyc6ClFnS7f/4I89X6P2svEtYYKrdkPjxYqfSppYZmolxqaqezVu2WymdbiDh3uSh7m5ouSAsNc9OL8jC8euck+quPCJQoSrBldbecXZYKv3SfAh+aVmPbL2ZQk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 42/87] s390/sysinfo: add missing #ifdef
 CONFIG_PROC_FS
Thread-Topic: [PATCH AUTOSEL 4.14 42/87] s390/sysinfo: add missing #ifdef
 CONFIG_PROC_FS
Thread-Index: AQHUTjLrOwmFtORim0+yTD+SdiqGIw==
Date:   Mon, 17 Sep 2018 03:02:50 +0000
Message-ID: <20180917030220.245686-42-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:DfB0J6WSjVAq61k5mB3+M2i1A+8uvlKxZFM/NUVALdCPgdbqZVJd9DoVBZoH6D6XUufEiZxG9MUKl23Z5J12G7Mn1Ewn+ySPaO6Vw6DJ1hdQmmSIsFPcVc6iXFfDU0oIfeQ0rx5I8+kCyC5nxsRej7IIb1IvTmmLkTwTkYU3OdlpNPWTXUFT3j8Xq8Uha/jYoKL9odC/cb/m4tfg1w7Bk9tLoZ7n1CXHxMginHOfC3niy/3NL2N3M/nEqCVM02To0+fmxKKcgYbl3Z2hUQcnay43qnEoGMmui9aYvvGQEzUcw9tXHAxiZfXMCSLqjOfTN9Jz1bUoW8NaOda+Ogg3uEbgwBvGj3xriy5RcFwK0iuqfhLBeKhiKpX+lbCjgOKnYAcSznJb94hRT0HHBq26FdBfurP87wAi8KML7JV+VDh85ihmWtBMUlpHOPuKoERYKik7XQVsHDUIcGQ8O7X55g==;5:6Sv/zmemPi1+k8sLySW04fwXGO5mPoXVeJ22AIM6ereskYK8KuILk6AGKpEgAoeA0TOXCzy3fKOx5wvJdQO0vZ4idqTzFbhvAqucF33okYBiIG4bayIRkgXY6foZS6xvZODGVobU4V5RKfWe2vbe3/Nl98c+aBx5G5byh6L+bP4=;7:pt3pmWR7doarsDwdI+aVvUm1erzoySWb49Ru4LXBNo0CPrBvmU8YKSrHZcePMcARMJA1liIo6DDdMfRN9T0WXlbBZ/1tSlXJMPhT3dQvKoHMos+Es22ui/jL0+LbyF1H/BcBEbGjET1knGDGXRA9ASD3FYyzCQ+rKOxUAHJUKqtDXYAtcahJUAad5X9nXHVoGK0qZ+lA/d9XGKiF8s1i0UiYZFfSa+NrSctqdWb6skYGRmG2nxfN/THw5c451vWI
x-ms-office365-filtering-correlation-id: 5e768ab2-9925-4f27-f5c0-08d61c4a40ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776D2D1CC1498A271ABFE7FFB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190383065149520)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(575784001)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2kiza62uUTM7L9TQ0Os7LhSkCDxvyxFBSv9qBu9OvQXU6fX9TJxh9Zq6vwlGJUgA9f14AvyLebgEc1k4HjaBliidp6tPFnXAY5utFwWv9tiGGGjYu4rv4aNtvzaukHC5Oj/+Rb5RXWLMUIhU1BMEqVwpMSanPhsosIvLRHjf3fJw0BV+HpaRXdAaXZ3ID2aerPX/JhC6Xh90AYpGsb/JRI2E6YsljhVmsSZcFL4TrolWQQnJP+GOMCCMRVkF5A8+9/+9CO62eTnkIq7LpQoUrpecZRyuuWOJF+mbBPzdVVkroXZ7kKU4h1xJALmWO1tF56bq2aXbDdIyoug1RjS2yxvAdCwY7MRFVItVzyHcSKk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e768ab2-9925-4f27-f5c0-08d61c4a40ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:50.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 9f35b818a2f90fb6cb291aa0c9f835d4f0974a9a ]

Get rid of this compile warning for !PROC_FS:

  CC      arch/s390/kernel/sysinfo.o
arch/s390/kernel/sysinfo.c:275:12: warning: 'sysinfo_show' defined but not =
used [-Wunused-function]
 static int sysinfo_show(struct seq_file *m, void *v)

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kernel/sysinfo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index a441cba8d165..b0fad29c1427 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -59,6 +59,8 @@ int stsi(void *sysinfo, int fc, int sel1, int sel2)
 }
 EXPORT_SYMBOL(stsi);
=20
+#ifdef CONFIG_PROC_FS
+
 static bool convert_ext_name(unsigned char encoding, char *name, size_t le=
n)
 {
 	switch (encoding) {
@@ -311,6 +313,8 @@ static int __init sysinfo_create_proc(void)
 }
 device_initcall(sysinfo_create_proc);
=20
+#endif /* CONFIG_PROC_FS */
+
 /*
  * Service levels interface.
  */
--=20
2.17.1
