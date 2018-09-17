Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAD6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A3A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dtCvzvES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A3A2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbeIQI0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:30 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:52685
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbeIQI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z50XFkbwIpnCLv1O0Z7xyho5i4qKdtDFmznpz9/kZ78=;
 b=dtCvzvESEOTMKNT0Mv9v9iEDRvFyUV23mI1FRobiDVwL8w587PtsM1yhAGF238b04Z61c6Lmo+PnqmjTDxJpUAQWWqApaqkzBk1BaLDae5MsBv68jumgQc/VmmwDvAKeGC0WZ9p9HAkV67lss9py278uzl5qLuRBabZw9JUzeCQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 046/136] ARM: dts: ls1021a: Add missing cooling
 device properties for CPUs
Thread-Topic: [PATCH AUTOSEL 4.18 046/136] ARM: dts: ls1021a: Add missing
 cooling device properties for CPUs
Thread-Index: AQHUTjKeTB1u9AtegUWtUwnu4cq+hw==
Date:   Mon, 17 Sep 2018 03:00:41 +0000
Message-ID: <20180917030006.245495-46-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:wwl2MSh3Xl7Eomy2BAioEeEtAlgXYHKXmhyiRpUnURNMusY+uTL1oJMv+4xF+KC7P+x2E8qA/akQP1gAuYeay18dBJTAdRAavNJzVHM4RHWwXMA/nCEk+f5YxQdaHddhFw7Nm7ZKe3yx4WbwefRZ57HzEG2pVfERBIe8gs55kQhNCfnXxduTc8lwn3tj3j6YB/mw+NL11VUvKGxLc2uhVSX33VwWZ4cXEMM5GOUbFpTdt4F/HOlbT0MfwLitMPqV88iSdi4Pqw8H/H3F8UDz9TgLXtwWqKClz4Zd0w9SkvGgEgjMmuHC1f1aTE/oSH6yQQZlUeXH+7GLoGOP4F6VDwtR68kWR+OdCBNGLA8/O2aOspu2tW5EfrKYxiGqvaLB66KK0djZnlq4b2Cl3eEibCtusarKDqg0aoMzmHsGITEESQKxdgeTomTVlQ+ae1+nWGw99HUi6MZidfn/dHEXEA==;5:b/eV+qJ7Sg4pF8EiVLry3YOdranHyTppZIAUEzAQPSPLg8pkJL3IuZhwz4CNJLK+B7o6BWAA183BqUsVqA/j7arnBwXRnvcA5RloVg2Wik53Vfwwlovuf1WSMPMdHTaeTOUQ9tsPGzHe9Io7U3QIvyBx7erIw4ZxPkGPuAWdcAc=;7:bpE8xmmUfhGvq6iDUATytOFfC1Wrpxkt9fkx2OJb0cjxyE5/mFqG2GM6U0PnkSDB/yHuNkt1m2m4r0jyJrUhrMVluNNIWb1L4j0uRTSjEpz8CMK0d/yqROXYE0pf44hu8yw7SwxA7dPdy/AXYZw81XVRdrk7RX6E58dhLXXE8uhCvw/kNtMnNZoTsuWZKOvHglsOt4fwRhsygksx7X04nyhJt8cauHW/1x+qIqJT3G6GG3HErkjXp/vYUsRpfyfK
x-ms-office365-filtering-correlation-id: f45b2ecb-0728-4ebc-3d1f-08d61c49d279
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167B01CD90340D8364C5AD8FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(5660300001)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Q21VhgQGXSH9dfcbkbuz63tUpZgO3xmvHNWCptNvj3zh5g20YKl3hrMLwX+5Da7F/MpyAkTY7FYRb/kbT4Nbqhkvp5b/e21lM4AbVnb05tzCEO938lHI9D4iCOjTU9bS89FT2rYYW5TjVHoTrlsggCDYckhymeksRK01BPFA5A5vyUCb7nMsqmaSWDLC0poMiJNbugk54QuYmsVnC8d5aw7LGwD9m5LFSVf5REAUqpeWvZomN3ayR6a2n3Cp2gtMBjnVIyxbchb4TR6dt2TdWVF2LBPNfwDHfru141oPCG95x/hs3lhNb9OnjJWLm3GIki8RZopFu2y/HGySU7n0mksgdv++O/8nVtf3ut1QeXY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b2ecb-0728-4ebc-3d1f-08d61c49d279
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:41.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index c55d479971cc..f18490548c78 100644
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
