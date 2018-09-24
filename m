Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E33C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC00F20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZLKesRwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC00F20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbeIXUwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:17 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:46976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730550AbeIXUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c27jE00YUq66LU2+xoCbLqwVW4KSukz+o7XagzCEPJs=;
 b=ZLKesRwVzCAzv0aXdnc78LQLggJQN/OCDS05AmG75ap8CzZUPEeRfJ8EehSWEHv0RM13lT5K2BCJl0ZAfdcBZra2giXuapDIgkc8kiQGH/rcksyMbpx9/lrI2dzGfMooBqlRluX01QHL416uz0eLb5vc2LPQ+NGgyZV5nE2I7Ao=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 70/76] nds32: fix build error because of wrong
 semicolon
Thread-Topic: [PATCH AUTOSEL 4.18 70/76] nds32: fix build error because of
 wrong semicolon
Thread-Index: AQHUVBWwIKwGDFLmhUS9UXtBwj9a/Q==
Date:   Mon, 24 Sep 2018 14:48:42 +0000
Message-ID: <20180924144751.164410-69-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:+J2wc8jJGc7yDhCT1ee6EHbq6FnHu9nUABWcZsvexTPWu6ItRET24AZ6qM9OVmKF9kMwsXl8zwcqPQi96Vg2E3Gm+0gq1GbejBbbUo9vzn2WiburD96QEFT+2vJ5TqhjSrLRfvXF3jgw31Gkg5/+jzb42il5ul78FGoEjD2bAPTdzEqcjd1rUi18tmFLfKSExYFkXQkON8qE/wKMpD2J2D/81KjDEghgr/rOUUicKNqZLBv5IKU9Fignu7UML2lf6I/IWXHuWY0LjpNKVRbcYWtB0rjKTvuSbnRIHCEw7IS3idqTKe7FgH12MMfXVCH7IqrtqBauETPlGpb8cI3JuGq+ppT7iQWd3HG0aO/DADrPN6/k8XkntwgOIBvQ/pPHIBWaWBF+UL60dHKrYzBtmxw6TJom9XGGopKEJtGh6fCiBakwxd6mN9vNf0FdS30dQHUKzvI9gfsxu8d7BG6OoQ==;5:kcJqXLFW9SO+UHc6R0kd1Wg8J+ur0xsJcEpjL9beORe4KqnmZtVIM3oxQPmOX0qPHvmTYvZhSc2GZK0ZweO8j3YbsEBxfZXm04gUo/iVzZFRkpbNGbjlls08wqzPP/L9Y27NrsVmC0dNjDBz4ckauu857zUngmIvVvQ1teob294=;7:T/rhzYeKLSildm5DnXK8RtUB2GELSuE0BH1tsRib5sTIztBkKWwQ7t9kzc07RoL9PYpkHtHp3TIS2uElyIBfZEADGHh8QWrJvQhwtDg4fU37ovLRmIO+p85TvEPvPaqSHhMEIvyGsPWJb3N3SxzZXxh5MmeedVbqxFLhUzq9PMicYOpmZLVSgHPkijytm88JlU+bDK2O83+FYsVHDssK+A3B1h+xOVSfkCTrri0PGfr9dWYBg8NMHx8F4rU36sn+
x-ms-office365-filtering-correlation-id: 3d9c9c0c-44d0-479e-61ef-08d6222cf2ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04714F4A64CAE4D71E581BB1FB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6fCLItzhRQxBdOy1oKsGjSkibGeb7/xL4ReK8kXMXwURg+SX3xetLVaf/KZ6j0AOuMGQMA3iGKKloZevfydB3pXPH2NCAykJn+teNMAVFoBO/8V5fHeHx1hkvcakw8pMup67HJoMlPPCYh1GJ3Di+Gm5gXp5UQEuckalxhTa6pOy31svLiGPNbeMKgp3ofSs056yWLkk/58chT+HY8l9qQQiL9inxWLtaDjWTBOSb7Kv7p7t6nHXJAfRI+zqy8pwlzu1A7TttycAWQz24+qukdEJqTqAqsNEOTEuWx1BKDzJP5uBjLVLZajd55KR6mY/QKV5lgLjSOf1na08VfeO2aIQzO8HKJ0JabZ3uMIML/s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9c9c0c-44d0-479e-61ef-08d6222cf2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:42.7824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit ec865393292f5ad8d52da20788b3685ebce44c48 ]

It shall be removed in the define usage. We shall not put a semicolon there=
.

/kisskb/src/arch/nds32/include/asm/elf.h:126:29: error: expected '}' before=
 ';' token
 #define ELF_DATA ELFDATA2LSB;
                             ^
/kisskb/src/fs/proc/kcore.c:318:17: note: in expansion of macro 'ELF_DATA'
     [EI_DATA] =3D ELF_DATA,
                 ^~~~~~~~
/kisskb/src/fs/proc/kcore.c:312:15: note: to match this '{'
    .e_ident =3D {
               ^
/kisskb/src/scripts/Makefile.build:307: recipe for target 'fs/proc/kcore.o'=
 failed

Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 56c479058802..f5f9cf7e0544 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -121,9 +121,9 @@ struct elf32_hdr;
  */
 #define ELF_CLASS	ELFCLASS32
 #ifdef __NDS32_EB__
-#define ELF_DATA	ELFDATA2MSB;
+#define ELF_DATA	ELFDATA2MSB
 #else
-#define ELF_DATA	ELFDATA2LSB;
+#define ELF_DATA	ELFDATA2LSB
 #endif
 #define ELF_ARCH	EM_NDS32
 #define USE_ELF_CORE_DUMP
--=20
2.17.1
