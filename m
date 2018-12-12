Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0832086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0sXy34jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeLLLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:22:41 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:28430 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeLLLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:22:41 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="24120443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 04:22:40 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 04:22:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJvOw+R0xiIVp1qaq+sCbAQNK+g2JGamZtCffnRuqAE=;
 b=0sXy34jWqeDzln0aS/refulbw3EHTBeQRCfqtBRI5mH1KaMz0wDPo1gsALbbX82pb4CeoYqTZkL2e92JmOPa6e+35/5ffsv7TPvtyfpUo+muvGQiHYXwM38YWT3i5nM1ahvj++wO1sqLEarnpkyhu/lpWd+rSRAnBerofQWdSiY=
Received: from BY2PR11MB0631.namprd11.prod.outlook.com (10.163.159.21) by
 BY2PR11MB0758.namprd11.prod.outlook.com (10.163.112.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 11:22:37 +0000
Received: from BY2PR11MB0631.namprd11.prod.outlook.com
 ([fe80::85ee:24e9:e957:1b3c]) by BY2PR11MB0631.namprd11.prod.outlook.com
 ([fe80::85ee:24e9:e957:1b3c%2]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 11:22:36 +0000
From:   <Allan.Nielsen@microchip.com>
To:     <quentin.schulz@bootlin.com>, <jwboyer@kernel.org>,
        <thomas.petazzoni@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <antoine.tenart@bootlin.com>, <Steen.Hegelund@microchip.com>
CC:     <linux-firmware@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL firmware] microchip: add firmware for VSC8574 and
 VSC8584 Ethernet PHYs
Thread-Topic: [GIT PULL firmware] microchip: add firmware for VSC8574 and
 VSC8584 Ethernet PHYs
Thread-Index: AQHUjU9qsN+1Xd1mlE6/XQdV4h2+o6V6/uLg
Date:   Wed, 12 Dec 2018 11:22:36 +0000
Message-ID: <BY2PR11MB0631EF6395F23E6AB4B54E55EBA70@BY2PR11MB0631.namprd11.prod.outlook.com>
References: <20181206103348.m7dtld3hccuhfeuf@qschulz>
In-Reply-To: <20181206103348.m7dtld3hccuhfeuf@qschulz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Allan.Nielsen@microchip.com; 
x-originating-ip: [82.163.121.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0758;6:e/FfZpvJI6+QMSlgFk0MvFW+hLBTlc2Somk89GWh49DjN1OMmb/ALHgBbZ+6OE3h3eVnJTyytFZ32AtA6Rfc/w2W8aurd+9Ak65b3g5Tw4KaUfZ19wFuYTsUWEP43o6DHS4IIX/0AW+6dGS3NvDPDxogYkzy9MbQmXdNf8Dhqnmdfm4HK8eVQZFS5WcxtPcMGobBssxeesCXSXnab+KpC/VW01hx1JZrgR4bQ0xL5fTU5UD3VboJTGiv8SqxhKg7eeuZvUo9rdduf54zaqWsuNOIcWtz70XJvggLYUfkbU4bkkJ2hwdtRv6xmICtGKelsmZfoWu/KmB2bNIap8fqUXITDRgPcjIyx1d9Zd6TNwUDWbCeOjiOwd+AC37oHVERClwttZ29ad9cSv/cQ06Rzkr1Gf59WwtYl3s9ZtnnoYFcBrJ/AiKnNgVG8TdFBmXv8kVumL1Q44DIbN0H545/cyBlL4/0737yQdO7QZnEqWI=;5:vFtDengnK6dwx9kIOGduyF8YjzzS/dE8LMuIHYvHVaB41Yh+O8ncXHvKZjBrwlCpeMcsfR5PzjQP14nAGE9AkW/5bcrRjYEKkEkNH1CSqbSUyiZybPIG8vnQPg82lGulrPr9Im9Cdyk98jFX7drF5TJy3QLoGUaCP3iGCcOX9G4=;7:zx9Bytn5kQ/z68H5KTAmPG6Eo8neC+Xz8/3jjW9oB0EtfcDgqQ7nvXiiEXTTGLQQXGjtsNuUFUip7+jv25bGKf1BKK6Ql0+nxCJX9f0EOnrfdLEKbcqf2ilbcwq8Va6LdRMptWHlwbsMia/OUIwd3Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(8676002)(97736004)(105586002)(186003)(6436002)(74316002)(2501003)(6506007)(106356001)(76176011)(53936002)(102836004)(26005)(478600001)(54906003)(305945005)(476003)(99286004)(72206003)(11346002)(4326008)(7736002)(110136005)(66066001)(68736007)(7696005)(5660300001)(446003)(486006)(229853002)(6636002)(14454004)(71190400001)(71200400001)(6116002)(2201001)(6246003)(81156014)(86362001)(558084003)(2906002)(256004)(81166006)(9686003)(4270600006)(217873002)(8936002)(55016002)(316002)(33656002)(588024002)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0758;H:BY2PR11MB0631.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: bdbee534-bbb1-41df-ed56-08d660241e3e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0758;
x-ms-traffictypediagnostic: BY2PR11MB0758:
x-microsoft-antispam-prvs: <BY2PR11MB0758EDDD7AFFE0DEC9636B84EBA70@BY2PR11MB0758.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0758;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0758;
x-forefront-prvs: 0884AAA693
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bOtYeJVVsDqVaPgOiTOdFpQf32v5Ndq3RflNPb1taRLD1DO63dZ6XzIMO9oG3cWF0dH6Jh5SE92s17nyXLQqhni2hxXlt0qv/ZvlbjM76eLLf9aV2K1W6vftE+ZLJ4bWT/f7sP4jrQugkVBMxtuCqSvzk0z/90THieVIkhymEctyQHzF8E+Kz8U81QtlJaVw4GxeIbbfgcDmuJpwlNNtQEf2pDpmzTacNUfcEHaLy7CliotdBoqJ2FqXRbxGSTzHNd+PvIHC3hjA7AWtm8hggEy7qbWqxTpKw/Q+ftBXWUHJf92z5PWYnSZhY6tZ3sWx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbee534-bbb1-41df-ed56-08d660241e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 11:22:36.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0758
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Allan Nielsen <allan.nielsen@microchip.com>

/Allan=
