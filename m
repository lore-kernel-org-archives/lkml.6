Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83056ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BC0208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fE+/9FDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BC0208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeIOGzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:49 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:29586
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728658AbeIOGwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlXtQs6Qxk6Z7t0yL+tS/lqey4ygiZvGmIy8XWIa+sA=;
 b=fE+/9FDo0DbntdEtptIIh7fg9i+mrVooZiwVuJlHQPk0BX9snlNz2mCgXiyPKfKXDUVCcTwCijG07xSrCdiCLIhzLc4Gsbdba2n7iT8ct5IP735lY/J8CviNTePfbFGG1EemRyH33eJdvZhQ5arf6pMUIX7yeQpsPZJMQM+cCCA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:35:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 32/34] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH AUTOSEL 4.9 32/34] IB/nes: Fix a compiler warning
Thread-Index: AQHUTJRIAhuprAW6t0C6amQ1J45XkQ==
Date:   Sat, 15 Sep 2018 01:34:46 +0000
Message-ID: <20180915013422.180023-32-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:/UjFIsSbSVuRrxkneL6Z9mTGMijxnIEmX1qwor40HWclsQRlpD1ScC0an+K4xmvqCN0LzG8HUIA1MTLSn6WSSjDFtceemhQceh7L1HVONSHmg6+ulVn3/QV3zrH9LvqSHCHzuFDYqC3/FrtPpRMwuKQKK5k2BpXrFyhk3sonqy9pxoiOtPqnUKn3fOZvNek7EdjisuKCsxyhTc1inLO5x/SESG03GSwKB3f8GG/eAYr9puHOiBKWbYFNQUNRJ6SJbPEhjxA4BaufDR2XOx0vvyvU1QXC1kl6jL0B4ubHzEbT88qGsv+/NTBKIqAkOUNUv5u5XnLsXwhazc+wWPj1PGf/bW+77au09PVZ1f96pfejblljQ1KySGqZX6gT2JDhR0zROlNwKITDyteqLqv8VqnJezBYF5k9CATpLv7kJ9arT86/UIGvDLVY3SIHRd26Rq8PLpI3k+Ru/NGu9lLtNA==;5:5izumIDxH/gI9ryP8p0gdxk+BKEHoL5bJJkeaQg5Bx8nWjPeV+P9XPY647k0+ex74J9mw+q5x2cfZCOur1K9d7VaPVYIa0lce65JcEh53EHMDjLazONUSuRXCChIF7m+GVK2BPEfYlR9umQDvyCPmoEGHXV0D7r/4zwJHtL+iis=;7:eVsoz7SXgT/B/B+ohWdclwgBrvzKll0gcVvrYneuufc+vaq0oUBMQwkJaxlGGLmO9+bhXUBbeFiMPCKdV/qoR+5MWnclnffLzNuGiRfQnPlH84BPILky97BZxnXFoUKSeNV/wAOkowNy5eRh8AsXoaqv4YZZn0suBSlvFXfHEyCrv35C92sG18NI6OiJa45DwJHbJR2J17uyAROtqyImC86/9QH1NiOGscNoemJg6sptOXOB8v2z2BBR4ZIueDnw
x-ms-office365-filtering-correlation-id: 28f5bf20-4457-45ab-ed1e-08d61aab7d29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08231CCD0B3A910720CADBA8FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(6666003)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RILxcPfrLMaIkQ75q0gaiYRzelLW1kQW45nBq5ZdK4lBf5AJwqK8MgqtfBRV9KH8RgE2FTkdiAUACw99UU4RMIGVkbXnPi0Ufd0CYvTRq2n/J3HJ4AluF/DkXy2TSwdbsKr6isA0jHAd4ENHx6PM30FxmZjvIrkmwJ0F4t8VBWQovxIFcS2czCxG90HAs9fi3CnF3HUwogT3esOXy9Y4xVAwq7Yml5oUV2p0lY5Lw17quXJMumBGUYKBLZQUDBDBPK407ij9d2AQOGIOzKojj3/iEX1ilGeS1SnDzBk3TpEVYR2gvtFo4HhS20sF7nspj/RTIiZNiZXb/GBdMBSL2iU7W6PtQrge3eDb7kN89tQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f5bf20-4457-45ab-ed1e-08d61aab7d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:46.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4c5743bc4fe3233cecc1c184a773c79c8ee45bbe ]

Avoid that the following compiler warning is reported when building with
W=3D1:

drivers/infiniband/hw/nes/nes_hw.c:646:51: warning: suggest braces around e=
mpty body in an 'if' statement [-Wempty-body]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/nes/nes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/ne=
s.h
index e7430c9254d3..206512636fbe 100644
--- a/drivers/infiniband/hw/nes/nes.h
+++ b/drivers/infiniband/hw/nes/nes.h
@@ -156,7 +156,7 @@ do { \
=20
 #define NES_EVENT_TIMEOUT   1200000
 #else
-#define nes_debug(level, fmt, args...)
+#define nes_debug(level, fmt, args...) do {} while (0)
 #define assert(expr)          do {} while (0)
=20
 #define NES_EVENT_TIMEOUT   100000
--=20
2.17.1
