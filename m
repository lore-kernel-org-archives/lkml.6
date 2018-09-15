Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B67DECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D2421477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TLcQoq6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D2421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeIOHEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:04:36 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728244AbeIOGsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0DDUnG/w6a727ni9wJ1jBhtUL6lhy7QvVJdAAtnneI=;
 b=TLcQoq6vxK6cKCufvUm3NKSrpQgmgL8v/qqwtJB8RwHiOxWmdYxlPtAzaP9TLBO9Oe4Sf1iNhUqSoezV65spqcVximbeTkVHYjUVG+5zsrquEjECTKhS+qrioRvazXtx/qkhUHYAkXwrAUjUD3twq4rE0nDf8yjtX7q4YbKJIzw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 67/92] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Topic: [PATCH AUTOSEL 4.18 67/92] rtc: bq4802: add error handling for
 devm_ioremap
Thread-Index: AQHUTJOzIbH38r3vBEq+Jl5ls3kGnA==
Date:   Sat, 15 Sep 2018 01:30:36 +0000
Message-ID: <20180915012944.179481-66-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:FfX41mmz6B1PIWgI/NX6V3qNUnR3ci8QIKlF5UkFU6WNFtGrorZXD5sBwde3gGMFksh0U8pbkAWSRUEibWIb7GsW0C3ut7vgrBQgSBjCXFgi40wJtDJR67uh8t7GSdacwgxsWLkYssQW7jPqUWBvs3fPFogyE/c6koHak/flM5vmpIkuMGw/eQ0jLrr02poFZTR3ccIBGQOzb4CDHU1A7iKytI0kzFlO89oX+s7Pb0gL4CdzxPctxATqH5+oZ9hgqF3y7TcSMQiLLtnjCEjh9UXNE3mTFwZPS5j2ZQnHk++rL7cv08UFGa2sdZAZxPD5j7N2W13/McUX5wcXcA6ZE+j1CrgSS6ebmqeTjOlNpv3mfSGfRMZYGU272CnK+LLFCfLz1g5hrMHsR77BnXuTmuikVwJvqYMUlukc7J/8PH9evcnbTFBFNaLEqN5yoE7ycxRWRGcDjJFmEAXT1bwzUg==;5:O3l9XbT3PNUxOD66L9hcmAL1jBBGeWCaO06CShuwkzMcywbPyZBAzR3CVIlVLAxrHw7CPhjxnStMKj38C5WVG5LCjuN6ApP8+KiEkq9adFodjB6fBO/660ZtUplsOuF5ji/IMeVBIvCONS2WSXhakVCIV6iaDuMPfbaCaQXbvC4=;7:CG1aQUK2JqyuHLLQ3+SHfv9uRglivA6f5xaviPDNDboIxb0sf+CLjylynbO96QG3bLiPQTHxcfTmKQemfEv/8k1nNHCR9NfEM8/rHIROJA8NoCVuOUNU2/q/giG630R/TF/yIdMdmS2qzrJ7CYUwl5UUr26CNjgvaGnJnUwSXp8vOVWpJqXbsVEY/PHJ/BAvUMHq6kop7gVkxU09ieyYo2yZUEuqOTBpzGQaNrRML+qpvGpqCCCDrmJA2BOEOX1t
x-ms-office365-filtering-correlation-id: bba9f682-ea3f-45ac-bc67-08d61aaaf825
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470AEA2C649E07F0A2CE553FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zFbHvrUMAwyJl8Wb5sr3mUSYaAljYAWpMxjwIyZWWcoRoPFFWoHgyJRO4DFpR4soUorSTLGvbuXwVp2yrwNvV5FV+bBYRSHvp/C389NixySeEO878aGlFRD5HiJuGi2loxuxMvpLc1Nee9Re8BcabAlxk96IVTTrnTIyT51eLlbTbcNZOC3ceAKEN7YVNUuYnnWxORW9MQLNGrUNKRp//Q7qjxvDwKtEVAZETxJQu5uOGDtPGiWpQ3pXSeq8WZEuf6I/Y0y9tx4V2yWoBN6iXQ7NDNxc1PKOfJAg2spAwgEpzFPE8/xl1UdNXGWGXDAB6v7WJgynzdku9g0LDkGFpoZ9OAPivCSwcHt9YpbSpzg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba9f682-ea3f-45ac-bc67-08d61aaaf825
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:36.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 7874b919866ba91bac253fa219d3d4c82bb944df ]

When devm_ioremap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling devm_ioremap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-bq4802.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index d768f6747961..113493b52149 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -162,6 +162,10 @@ static int bq4802_probe(struct platform_device *pdev)
 	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs =3D devm_ioremap(&pdev->dev, p->r->start,
 					resource_size(p->r));
+		if (!p->regs){
+			err =3D -ENOMEM;
+			goto out;
+		}
 		p->read =3D bq4802_read_mem;
 		p->write =3D bq4802_write_mem;
 	} else {
--=20
2.17.1
