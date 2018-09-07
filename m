Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16540C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3372083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fwJT878k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3372083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeIGFRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:15 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:63798
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIGFRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLcnueVKbOBs/j4HehXXG8VDvehINooILZ5hoXxu9kw=;
 b=fwJT878kiZ9OJxqGgasKjY8dTA+i+TavZpfee8bc1djM2V4fIDgc7Fg9Iw//3k2dmVjCFMF0dm0NiLvJ6vCbTWVn4vSgMhixjlOvi8rRXfg3MnG0y+U78uMWRUwkiUjkJeT1q6IYn9cssCTDALUdA7BkwJ33J8QFgFQJ3UULf8w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0696.namprd21.prod.outlook.com (10.175.121.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 38/67] ARM: exynos: Clear global variable on init
 error path
Thread-Topic: [PATCH AUTOSEL 4.14 38/67] ARM: exynos: Clear global variable on
 init error path
Thread-Index: AQHURkMBQ0RybMyYqUOizNKljB1GaQ==
Date:   Fri, 7 Sep 2018 00:37:49 +0000
Message-ID: <20180907003716.57737-38-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0696;6:/L76gZvGgGBSFdgjWK6qsPrsLp+jVjHfAZY9nmokOx8BV9kQWSZV8kq++5HxP6C0wU77SIxENSiykfcZYYAIVgAQ3qW4vp9tyu8URci3Jf7TkYXqqNXQ94c0uJZBRP2yits9wVY1d+nKaekMiqyFxZI4PLBQTGscd/jd4FIEh0nYo5wsl9vkhXSV0UBXYBXGEnD8Zvbbgs5TU2r+jSfLxXaBgzgas132Y9z0RJ3yPJWDC/VfYbitqt1XsWPqyWLjwqr1hsaGS56FDhX0H089Q9xyMGCjTG04SN4cYsZNuhUpu1PEdvkNsJPkjQJ4AqBkDO4gucI8U/oEIkIJp4yU6TCnPXZ+GAUNHlPWKQSIuMGaVeNk12pm9FrPPaaiKV/kkItAmAMTy0jjOZt9d2RKvY1kzRms/8DEIaLo82E819oZxthrhtQ5by0H4jXcezgYFmEXjcp11hNyUFqivHaXJA==;5:ItMWrP3yTH1RuPdWD1qfHIXLY4Xk1SBcMdVQDd+ROoYbYmhUZ11g/pkKWrGGMQKWOHXEL7bqQq/qGK25bnViSIy9G6abFZZ3OTFxufc4+7Hb+wwUSaPdzy35yol7eRUF9pVvqrG2/K1ec4/ErQwhBYY3hQepI3R54nxW6RIIvoU=;7:zuGIlHV4Qnm4T0PIS2wbTUd/BM43gIPU4Gu7logx08uOOn8IweAOPP5BLGJoRSKQL4CDCdml3Ai+ldfwN8EbI5qZgy+dzyukJNe2PpM5nkvAkgQ0hdsE1gd/nspudi9NPQcZHsSwkSB9bWQ94OBwHsApQlRNht3kU/cueg242cQDnjkNS4i1M8zBqm5ZUKabSTQg4ydEcmo927aPmnLuZRo578l2DrMQRsthVbmKpKjL4M1vOABgIr7WCR84Sm0f
x-ms-office365-filtering-correlation-id: d397d064-f787-470f-c686-08d6145a4c65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0696;
x-ms-traffictypediagnostic: CY4PR21MB0696:
x-microsoft-antispam-prvs: <CY4PR21MB06965E14D70454B048735FA9FB000@CY4PR21MB0696.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0696;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0696;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(107886003)(36756003)(99286004)(97736004)(14454004)(105586002)(256004)(14444005)(106356001)(10090500001)(2900100001)(4326008)(86362001)(72206003)(25786009)(2501003)(5250100002)(6346003)(54906003)(22452003)(26005)(186003)(110136005)(316002)(446003)(2616005)(476003)(76176011)(11346002)(66066001)(8936002)(68736007)(6506007)(102836004)(86612001)(2906002)(6486002)(486006)(53936002)(478600001)(10290500003)(305945005)(6666003)(1076002)(7736002)(5660300001)(6116002)(8676002)(217873002)(3846002)(6512007)(6436002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0696;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Zo2Sl5wMw1s7Qh+5BLtTmGU0MHLa1rfNWzotmlgAV96svXmbpAqpis+9ppZdy2bIdvcrcy2AXoJb5g2gp8Vwr5jEqa8mRpzElxJJh1+YKotN5OtrG5OijMmUhmAp1MAmyxf26ZsbiOyWzc9cyNcetR2j2d5O8MC10hDvjmw4mqK/a7I752xrUW1YegriFtCExd6dUthhu8OBxckYknB+nawoBVAGOxNUiU+2JRhyVbY/AC5eHj3XzFs6Txdr1eg4PKDHq9ymG9I/1XQPh4PGkcma8Ju9KDfxTRDKPgK/cRqcwDq0RwZ9ulARSc0zowE3mitNYpDwlI9Jwnl6RkHUTU+ATY4NAbyLOf3wiRGRt54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d397d064-f787-470f-c686-08d6145a4c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:49.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit cd4806911cee3901bc2b5eb95603cf1958720b57 ]

For most of Exynos SoCs, Power Management Unit (PMU) address space is
mapped into global variable 'pmu_base_addr' very early when initializing
PMU interrupt controller.  A lot of other machine code depends on it so
when doing iounmap() on this address, clear the global as well to avoid
usage of invalid value (pointing to unmapped memory region).

Properly mapped PMU address space is a requirement for all other machine
code so this fix is purely theoretical.  Boot will fail immediately in
many other places after following this error path.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-exynos/suspend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.=
c
index a6a4ba334147..c7d28ed773fd 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -209,6 +209,7 @@ static int __init exynos_pmu_irq_init(struct device_nod=
e *node,
 					  NULL);
 	if (!domain) {
 		iounmap(pmu_base_addr);
+		pmu_base_addr =3D NULL;
 		return -ENOMEM;
 	}
=20
--=20
2.17.1
