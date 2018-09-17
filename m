Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E41ECE565
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="flXbwF94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BB62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeIQI3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:32 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:1680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728969AbeIQI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCTeZoIzuO/1UB42JOzPd8KBk8g5ZRNGFyj/7EpVYOM=;
 b=flXbwF94nN+WvXfTOLTiaYdodyZ3oJHmZh92QQTMQ+weXU0o/s6N++4Qc1MODb77vAWmS9NEh5OlNZzxSPeqHa/5VqC6305Enqsh9RoGVQSNfqYEE0JETZCSU2XsmkRRUkad3MMnwTIf2hJ4thQ8d/Sx/G56XLHgU9o8YKw10mo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 33/87] ARM: dts: ls1021a: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.14 33/87] ARM: dts: ls1021a: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTjLoQ8S9MQWzUUW1Fgv2mjE+pw==
Date:   Mon, 17 Sep 2018 03:02:44 +0000
Message-ID: <20180917030220.245686-33-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:tr4b7MFO5adM2MNXlJXoCKXU/0GlRfRHKNGef5zoZ+slmqCHNCPdNfCUdScPeKixMu8d3fbJjpRnDSnK9f0PCdlCHcu8mG3FZKjTf4t5fmhS/LSqDS7aZDavxAZ2tT+laxD3farYtweEafMigQZqr2E6D41oF85gdQeHw3d/fUgAUfBxRNqlPS27Beae1Ecd7pr4Two0HFReBGWhdeWbTI4pTLGoLGGVFvRH1S3eBUp/xRm2xtTxSSlcdfPsB9c37kaAwzLsuwsWPGFQo5L7gmMon6T46zs/Ibjg1EtaDVQoUWLCWDqeZ9yv+4GOOrBFZBCKF60uU/pefML161C58nqRjEooW9poohsjhigjjN7RJgMj3pwb5MlhXSVAhtPycsvJq69HyM0c80Cu799XQrrhjIqP1zf81V2aV+3L+NSUVR5VarCyF8k2SoluBvsK5CL48dg0JPteR2lvQEYOLg==;5:ojpSL3lFO05s4+ccVB7HQXVRTYfEAtogdA3FtcZ1GHqQxAa7yMGqZH90WKd7keA2Em4guVqfh1scMV31T+qGo7eSRFcrlN8E2wXdbpbBeVi0p8M3hqyJrKVSYCXKKpZndQS79EvGr8OcrzRUvnAWUAsv/xPbPtmToTl3FBS47+I=;7:OL0tSW1ZCgT8RWRfXMvCT4w+Q4+UUVer/mokrO3Z8ZtxiC5IXr7Wkho7xlYvuatVgvLqUOlZoujoLAOvaBJSD9EJ0OlxalP3q1tht73fOXvYKeIJAMAT8p7UUls6/Su0Cmqp0qIAjxl7QBII4pyc76QbKEAmeLvJZmYsL47SRCl2demEIEFEVF6+R8ECBYcNxZkr4wd+BzGzXjg13jjL6Rzi5gBW0dfw0Ylc3jHvZuJ+lg/PfyUsT6tNsjkfg9S5
x-ms-office365-filtering-correlation-id: 00142819-656c-4f55-3b42-08d61c4a3e86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776B513B359A6749F9384E7FB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(36756003)(305945005)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +Vm3DOQFr+FvgBgKv7B0yXEnes+f/1fZUQnPQhZmeFu3kEoz2CCJoxu5TdyCvWnrohLRwBPRR8DhvK7ykvKE50ttX88y4Yfp4DZVBtcegLqJJFW6ojoOLHu5nIhovucT1zPIcufXO/NEsrJ9P3XeJKjyJnJ4jCQUXVBi23OU/7AiS3rJ2jdpUty5uso/8bQ272HzejsN6iIG4Sh3gbWTvpTya2yarWf70wTd+y0fChIlthSlHPblfGAvVyDNem4DnJMoTWz5vL2WhWIGXEfhNXDp8baIjYqSzlykjuwZS/ZlFq8ngS/9mv6knjTEsS4BtcqaIzaQ31mbZBf0V7I5AT00gb54WGPQ9MMhvdbnLGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00142819-656c-4f55-3b42-08d61c4a3e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:44.8687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 47768f372eae030db6fab5225f9504a820d2c07f ]

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index 379b4a03cfe2..2d20f60947b9 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -84,6 +84,7 @@
 			device_type =3D "cpu";
 			reg =3D <0xf01>;
 			clocks =3D <&clockgen 1 0>;
+			#cooling-cells =3D <2>;
 		};
 	};
=20
--=20
2.17.1
