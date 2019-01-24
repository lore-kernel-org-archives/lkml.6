Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD359C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77E21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BFHkNe/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfAXKe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:34:56 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:19918 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:34:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,515,1539673200"; 
   d="scan'208";a="26827529"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Jan 2019 03:34:53 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 24 Jan 2019 03:34:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f30V+qbfBuV88b2q2Qp9GmqMjvJnFu56HwNB0lPWQ5E=;
 b=BFHkNe/jF2GY46Xw3Wur2+Uu/2fisIRdOAajC0nL5g+u6+IddjGemaKh79GULoo7IvxLxcbNtg/gSEJJjwBi5VeWP+hjSGrlomlybZKQT0UBFyb4X19OG6jLmY+vy+32n8FkV/68ZEBa4ySIzCP82hbou7JwPOXNdV/MshNkxPk=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2013.namprd11.prod.outlook.com (10.169.234.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 10:34:50 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 10:34:50 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <sre@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>, <stern@rowland.harvard.edu>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60 SoC
Thread-Topic: [PATCH 6/8] power: reset: at91-reset: add support for sam9x60
 SoC
Thread-Index: AQHUs8tdXETHJiEk9kOBJGz8hjKFtqW+OTyA
Date:   Thu, 24 Jan 2019 10:34:50 +0000
Message-ID: <a74956fc-6085-eec2-c1b8-ed116b2297d8@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <7e68a0298b8802edaead1f9c011f9c2e191ecf6a.1547629763.git.nicolas.ferre@microchip.com>
 <20190123183443.ppxdfstmau2xtodi@earth.universe>
In-Reply-To: <20190123183443.ppxdfstmau2xtodi@earth.universe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:59::20) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2013;6:3c/iXhypUXK75R2d4DM04cHaLT4NDEFY7tfgUOczIeO8cKyXIymlC4axLSDeqr+r1SKFNYox8wXing7/yGSgjxHfwBtkGV2JAXK1C2RzMau4IqPhVBeVaWaTurEa6794e37QGr31YuNJzO90h2G4FG0/pGHMxquCcTfADXbAPQTV6xKvQ8tqTRi17UOtJSuhlgZsOjn/7f95r3pRDYocttq/bDkZm7yg3N4k/UKc/fChiWXfhWGuVDFO4HuzEYd1KiVCJ9D21JGDr4LMMtvRiTIsl24mOtSQrlIO2PAcWkorys2yrtMvB/pTAzJ/O1K+4/zk8srG8O/DcoVdahrbxU/4koVkd0rSPUk3eD5ubCarvvQeuGGIDcRtMrTW2lOpwIgtAdiN2p8GWH9p227ojuumfFVEW8LO0WCkOwkroSxcdT7JLa45YszDn+ekVsdEOCnVSMzkbMEoIeTW6yO6LA==;5:7dexNYkWGlcBw/w2R+w7VmHePZUZdq4lAeSI1dq9fD58H7P8ZU9LA0QUAqx5IDHOI83VqiCNHTse1cPNuGUO7FojoJP0MaqjtwCIvOylTc95cxrSsJjYEBvvE+Z8JKQ3bPAeqlgEf7L03z/GrufK9VAlUzDAY3N5CVPwGo+BXTujy2spvosaP4R293BKgkqD+KWjAaIl4LEH1nNG9lIHwQ==;7:C8YhkDRaDYK5eqAISAjo8WsS5RdBDlKnMVEKjJzNTWLtdiXY+txC+PQQwCeCebEwoe/9lD96bd8fc8RrnbzwMmvL4YBdjgYwwIwxJ8PSs/nAA78ynrZVle0uz0HiJ12Vs3QRQcAfYToAnA5DmwHEVw==
x-ms-office365-filtering-correlation-id: 3c7628c7-6b10-47b8-0c3d-08d681e79195
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2013;
x-ms-traffictypediagnostic: MWHPR11MB2013:
x-microsoft-antispam-prvs: <MWHPR11MB20131F4126E532E286AB6196E09A0@MWHPR11MB2013.namprd11.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(52116002)(97736004)(106356001)(486006)(7736002)(31696002)(76176011)(105586002)(31686004)(86362001)(446003)(72206003)(68736007)(305945005)(6512007)(8676002)(14454004)(81156014)(53936002)(186003)(26005)(66066001)(478600001)(102836004)(36756003)(53546011)(81166006)(71190400001)(316002)(6116002)(2906002)(7416002)(71200400001)(8936002)(386003)(6246003)(25786009)(6436002)(6486002)(229853002)(99286004)(6916009)(11346002)(476003)(6506007)(2616005)(54906003)(3846002)(256004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2013;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZVBOIF6faSWg6RX88/Sv4MbVhy81dorWf9LToTBjOf5nY6nVKgPLiOxfL9z/xttYYDxtATcQWkGvxbydGOD2QHgAJsYkozcomeDHVyAHV6KoJGhmUi1DcArcC9bEEWfpi2JUYP2zq9gKgzUfPQxqAMvZ0qDaJ7kM88up2fpmlIeYr83M18gnxy6ujoLh3QVYIFXkv2TehOor05e97xndgEK+fj1brNJFONua8Tz9dQVhV6b+C3tU90Hj4pSgmZo5MZjQGrHnIKlARIjJluhr/yXJJ9LPS7yaO52IoT3TrRe/92BsnMEp2O0DgyewcpSoYqsG37AVmlfaz2AjnKOU07Zvkv6hJhs6RvK79q12HaVFZ13vRM72SFYVKwiBXBKtsrXit2daBGPm2trI+OTUZgDs7Zg5jS3tEDtiU7ZESmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <642BCDF518A7F14D94401399BB09A101@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7628c7-6b10-47b8-0c3d-08d681e79195
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 10:34:46.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2013
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 23/01/2019 at 19:34, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Jan 16, 2019 at 10:57:42AM +0100, Nicolas Ferre wrote:
>> Add support for additional reset causes and the proper compatibility
>> string for sam9x60 SoC. The restart function is the same as the samx7.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> ---
>>   drivers/power/reset/at91-reset.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91=
-reset.c
>> index f44a9ffcc2ab..44ca983a49a1 100644
>> --- a/drivers/power/reset/at91-reset.c
>> +++ b/drivers/power/reset/at91-reset.c
>> @@ -44,6 +44,9 @@ enum reset_type {
>>   	RESET_TYPE_WATCHDOG	=3D 2,
>>   	RESET_TYPE_SOFTWARE	=3D 3,
>>   	RESET_TYPE_USER		=3D 4,
>> +	RESET_TYPE_CPU_FAIL	=3D 6,
>> +	RESET_TYPE_XTAL_FAIL	=3D 7,
>> +	RESET_TYPE_ULP2		=3D 8,
>=20
> what happened to 5? :)

That a good question ;-)

It's marked as "Reserved"... which opens up a whole new field of=20
speculation :-)

[..]

>>   	{ .compatible =3D "atmel,samx7-rstc", .data =3D samx7_restart },
>> +	{ .compatible =3D "microchip,sam9x60-rstc", .data =3D samx7_restart },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, at91_reset_of_match);
>=20
> Patch looks fine to me. But I will wait a bit with merging, so that
> Alexandre or Ludovic have a chance to provide feedback.

What about merging this patch with the whole series through the at91=20
then arm-soc trees?

Best regards,
--=20
Nicolas Ferre
