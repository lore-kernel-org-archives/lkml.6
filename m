Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF43C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18B0218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="If/wAqJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGKQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:16:11 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2164 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBGKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:16:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26411786"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 03:16:09 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 03:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OocYwaDgGgEkcmIkMxGJMbrj8WR+9YDQRhmrDncw/aE=;
 b=If/wAqJpe9fuFj9RFe8RatYGuK/R6GYRDl1+2yO09czaZ4oOVqkCmujbFPvQouHm74/fHG3xulR+he9Jc3+SmmhvaxMgHT8I1kfqo3f0jC/M6SVm2vnbK1UxSAMdrn7IVEnPAZvWV3FHSfDsbenpfz92VtwhgH2FV3G9Xvrg2cc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1395.namprd11.prod.outlook.com (10.173.31.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 10:16:05 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 10:16:05 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>
CC:     <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Index: AQHUsvEnBk05JSMTaE23Hh40f7Dva6XOJEMAgAX+zQCAABNIgA==
Date:   Thu, 7 Feb 2019 10:16:05 +0000
Message-ID: <5bdbd64f-bacd-8192-b7eb-6ec4c06baec0@microchip.com>
References: <20190123075538.12681-1-frieder.schrempf@kontron.de>
 <f0b2c97b-419a-1e3e-4624-52c60fe32065@microchip.com>
 <52338dfe-aca1-503d-6871-c4be09f1f3ac@kontron.de>
In-Reply-To: <52338dfe-aca1-503d-6871-c4be09f1f3ac@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:803:1::29) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.52.185]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1395;6:UBGdhYNU2VksNKzqjF+1jIp+yOAIDGIpq+Pjuymkcy31V5KKe2Twvka2YBnvIGBS3JcJE7Hw1tyL3ee56vlK9MeVFFTou9o8jK8IwC/Mj62XWOq/vJYFe8LVIj+69CSbFuFpOiarYebqdNz0uCAaRo57ad3+fndWRdy/7ljwzyclDPju7QNUMOYFSX+2BVs1/X2JjC1WkzX8aZgYo+C15e14v6RrOrddQTMa5Zp5y/5uR+79Y0hNpZmkpCUvxZzCf/ZIql40Pz+FtfdjMM4DjTzLhUGecsmqrnIpi5XfzR5wTxJ1umTuhJBXX6vEJyn89dxrp+RmR1X/kWb4Svk2cGN7COHOIXOwHUHBPF7QfcEXriNBS+hmL3DKwP2t0P+fqXQo8yeTOQUGPhB8wa1q4Pg3+o1qqxdIczqez3qrJFhegX6jQhhG0hvo7+5ca9BTrXu2758lojWXY7Np9UuKfQ==;5:vYXFIsY/AX25vNZKhFVb2xqs4nRB8VbmhiEH9BEXIPDrgwCGmW83pPHpLzeSi6RpHISO3+JOXTGtSAa8Xez/Csyg8UjLSOcc7FaFiMfrc4yUQnEy4rKjmCd9ERlFOH5syl4zmtEc2pVOHcHC0hzf+W/AnXZqqPkE6hKb4+iU1KF5hKqzCJGBTh2uEKzEi+bUJV80PPyV3DQmoKO+sJdNuw==;7:ayWmmsE30LcDqBa8ltbnecLEZaMKXW4r0yW1fTNC4exfjK3eexQk9nh90xmump+8O/XvaET4T1Wsp2Y7HCTflIK7AwPpA4m26B+egO5cHQj2/Gt7/EFIKBBe9M2KJH9EqkDaWZwUEhGUNRfC5pPieA==
x-ms-office365-filtering-correlation-id: a9eeb8f2-aee6-48c0-c5b7-08d68ce5451c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1395;
x-ms-traffictypediagnostic: BN6PR11MB1395:
x-microsoft-antispam-prvs: <BN6PR11MB13959A614DD2B4C82E984252F0680@BN6PR11MB1395.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(99286004)(14454004)(86362001)(81166006)(81156014)(2906002)(6116002)(3846002)(486006)(72206003)(76176011)(4744005)(6512007)(4326008)(478600001)(31696002)(476003)(8676002)(52116002)(446003)(2501003)(6246003)(11346002)(2616005)(7736002)(105586002)(106356001)(71190400001)(71200400001)(53936002)(229853002)(54906003)(186003)(6436002)(316002)(31686004)(68736007)(305945005)(26005)(36756003)(110136005)(97736004)(102836004)(53546011)(6486002)(66066001)(8936002)(256004)(386003)(6506007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1395;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t545v9qwGYKvyPNBjr2Zjn/uyEsHUo3RR5LHVn6Vfj1lNlWFtrfXEEuYd7T3QyfPAiqwS3XbnkQrpA0s5xSwdhI2DCWgGj2Ug4WbtCgDa5Xv6AG3Mqkq5zNmLWWXjKhTpozvV5RMVwfTAIcc1IzNrI4GyT/4ToCD447uMA7WTpU1qdiiTKIzQ6HVdlXiF3dQlb3+F9q56whKJmAY0OX3cq3eHxleRtHM1ezdR00HP55cJhTTHkATWcK0CiJISLv2Nui76T/qzZSjZtHg/3YV7Qcb6QhSPtVIs0NEdi+WowBU2IfXahYp5BCGKBT4dg0Ym2D2/eQgsBbe+rMOpgL9bgKarucjbDyotT2YNtQvGN/1U4+0xLilY2P4tly/DwodRAkq41H8x+lb3ILRmcEIrCgkEmXOsGgad0CQKGzmR9o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99B0DF6776D71468F28514BF1C14753@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eeb8f2-aee6-48c0-c5b7-08d68ce5451c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 10:16:04.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1395
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZyaWVkZXIsDQoNCk9uIDAyLzA3LzIwMTkgMTI6MDYgUE0sIFNjaHJlbXBmIEZyaWVkZXIg
d3JvdGU6DQo+IEhpIFR1ZG9yLA0KPiANCj4gT24gMDMuMDIuMTkgMTQ6MzMsIFR1ZG9yLkFtYmFy
dXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpLCBGcmllZGVyLA0KPj4NCj4+IE9uIDAxLzIz
LzIwMTkgMDk6NTYgQU0sIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+Pj4gRnJvbTogRnJpZWRl
ciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPj4+DQo+Pj4gVGhpcyBh
ZGRzIHN1cHBvcnQgZm9yIHRoZSBFT04gRU4yNVE4MEEsIGEgOE1iIFNQSSBOT1IgY2hpcC4NCj4+
IEkgd291bGQgc3VnZ2VzdCB0byBzcGVjaWZ5IHdobyBpcyB1c2luZyB0aGlzIGZsYXNoIGFuZCBo
b3cgZGlkIHlvdSB0ZXN0IGl0LiBUaGlzDQo+PiB3YXkgd2Ugd2lsbCBub3QgZW5kIHVwIHdpdGgg
c3VwcG9ydCBmb3IgZmxhc2hlcyB0aGF0IGFyZSBub3QgYWN0dWFsbHkgdXNlZC4NCj4gT2suIFRo
ZSBmbGFzaCBpcyB1c2VkIGJ5IGEgYm9hcmQgdGhhdCBJIHBsYW4gdG8gdXBzdHJlYW0uIE1heWJl
IEkgc2hvdWxkIA0KPiBqdXN0IHJlc3VibWl0IHRoaXMgdG9nZXRoZXIgd2l0aCB0aGUgYWN0dWFs
IGJvYXJkIHN1cHBvcnQgcGF0Y2hlcz8NCj4gDQo+IExpa2V3aXNlIGZvciBteSBvdGhlciBwYXRj
aCAoTVgyNVY4MDM1RiksIHRoaXMgaXMgZm9yIGFub3RoZXIgYm9hcmQgSSANCj4gcGxhbiB0byB1
cHN0cmVhbSBzb29uLg0KPiANCg0KU291bmRzIGdvb2QuDQoNCkNoZWVycywNCnRhDQo=
