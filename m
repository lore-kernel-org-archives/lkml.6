Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-727094-1517907443-2-12074692749110366671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: to='iso-8859-2', plain='iso-8859-2'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517907442; b=EDHFJIOQxRzUcRRdMzD/9fPZTdS89w4BtxZOeRwFTrPvoDy
    tTgxxBP9aNAhikQXEAZXpk1faR5ElnPCXdfksrek4gBetpEhDv5zBNKiHbVrtX2P
    g01YMpJf9QD1rRJFAKAo5uU2mlGGiXBwdnXi5B8biACntIZigvjEY+IsWvz6oeKx
    u6euiN3cupRXVQbtJC/g9Eb6Sm0TnR58nhy6H0zj+Vaw+nibyTnFIuNJbhmjVzi9
    qiFAtyoJ4y/mrSSO1hS7Ke2s4I7nrW0tWujoj5CPCZSsD2bLpYqzlwPHvtgA/ndJ
    fOqQlbWtWgFlFcgXks+jNDFU8RllKfj+ODRu6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517907442; bh=F
    Atcpz7WMo+/J5xHr8afDXRcWBzNqIYY9up6ge13vIg=; b=vjEyMgMML1+vakuFH
    9TOemBqwOMN8LioMZXHfPLDnvTzTnLvB3RJMp3TJDjHe4bRe474LO7MdjY5z0b4Y
    0uoEIr7R9dLvwaXu8Wtp3kXpdWs3dAVVUTUvKvY2U4oZH2wy8idFH4PT5jLsGXHp
    EuGXG3uNMuGjjNoSwHYPDGKhXSCpxWCA7O9Pkj0+4WsjH5QnOZZ1osBYPhs60LvK
    AfS3rNphXm9uY/cSmIxkjcmoaekLFyMw2QI5ODOVa4e40I7sWmBG7rEd8az5ShY3
    xSw+8DmIUStLTO32ycGwffxey4KfbMnExI+mxVD8zlDen1vQVG2fxA/IyORUR3Ii
    t0+jg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ivw4K9i9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ivw4K9i9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Ruxandra Ioana Ciocoi Radulescu
 <ruxandra.radulescu@nxp.com>
Subject: RE: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
Thread-Topic: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
Thread-Index: AQHTnorG7fJk+WIg1U6NBej+X5uKQKOXEVnA
Date: Tue, 6 Feb 2018 08:57:10 +0000
Message-ID: <AM0PR0402MB3649BC95F62CDAA921CF361DEAFD0@AM0PR0402MB3649.eurprd04.prod.outlook.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
 <20180205140743.29974-2-bogdan.purcareata@nxp.com>
 <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB33427D7D04239420F3FE7D5A98FD0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR0402MB3683;
 7:V41IzuCyzZyNTHr3TvSKIYn034GUQKTeIQdhGHhVuRAG8tWmYEMymMw5PUMgch9AMQKoN2vOzGmzSoB5lqVbs+xoUOYFJ1E0qekbquEUkoC4xqybRaScj9Ccneval19e0SCevpVQ/GSAdx/0CwWxjBhhQuy9KnbVbgtU0bSjdPjWt6XCGGUJW2opYQ4I3bQ5AwuKyE0nLacRhBhS7zOCdUEQstVeOPgdqzmGrNBt8uEkHWiJRZkihFIvu8f+7HAc
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(396003)(346002)(189003)(199004)(13464003)(14454004)(68736007)(2501003)(3280700002)(86362001)(5250100002)(3660700001)(25786009)(316002)(54906003)(110136005)(6436002)(229853002)(76176011)(53936002)(9686003)(66066001)(55016002)(99286004)(53546011)(6506007)(26005)(102836004)(105586002)(106356001)(7696005)(3846002)(6116002)(81166006)(81156014)(8676002)(97736004)(39060400002)(2906002)(5660300001)(6636002)(6246003)(7736002)(4326008)(2950100002)(33656002)(305945005)(74316002)(7416002)(8936002)(478600001)(2900100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3683;
 H:AM0PR0402MB3649.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e2c9fdc-86ec-4449-87e6-08d56d3f9b7e
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3683;
x-ms-traffictypediagnostic: AM0PR0402MB3683:
x-microsoft-antispam-prvs: <AM0PR0402MB36835DBA111A617C51BF0C52EAFD0@AM0PR0402MB3683.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3683; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3683;
x-forefront-prvs: 0575F81B58
x-microsoft-antispam-message-info: RK4V3kDBVb46AhEFrWSyzxjC94DrCYVtLnykM3jFG3Cv/78UNSPco08ln2CGLv5gge9MRZ7CSsWJYj41gDKlBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2c9fdc-86ec-4449-87e6-08d56d3f9b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 08:57:10.0827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3683
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "robh@kernel.org" <robh@kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Razvan Stefanescu <razvan.stefanescu@nxp.com>,
 Nipun Gupta <nipun.gupta@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Horia Geant=E3
> Sent: Tuesday, February 06, 2018 9:18 AM
> To: Bogdan Purcareata <bogdan.purcareata@nxp.com>; gregkh@linuxfoundation=
.org;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>
> Cc: stuyoder@gmail.com; arnd@arndb.de; robh@kernel.org; Razvan Stefanescu
> <razvan.stefanescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Nipun=
 Gupta
> <nipun.gupta@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; marc.zyngier@arm.=
com;
> tglx@linutronix.de; jason@lakedaemon.net; devel@driverdev.osuosl.org; lin=
ux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
> =

> On 2/5/2018 4:08 PM, Bogdan Purcareata wrote:
> > Move the source files out of staging into their final locations:
> >   -mc.h include file in drivers/staging/fsl-mc/include go to
> include/linux/fsl
> >   -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
> >   -overview.rst, providing an overview of DPAA2, goes to
> >    Documentation/networking/dpaa2/overview.rst
> [...]
> >  rename {drivers/staging/fsl-mc =3D>
> Documentation/networking/dpaa2}/overview.rst (100%)
> =

> Is this the proper location for documentation?
> The doc focuses on networking, however there's also information about fsl=
 mc
> bus, dpio.

Yes, after internal discussions we concluded it would be the best fit, since
the end usage scenario is a networking one. So far the main user of the fsl=
-mc
bus and dpio is dpaa2-eth, which is an Ethernet driver. It's also next to t=
he
previous DPAA generation driver documentation at Documentation/networking/d=
paa.txt.

> In the future, we might want to add doc for other dpaa2 objects sitting o=
n the
> fsl mc bus:
> -dpseci ("Data Path SEC Interface" - abstraction for the crypto engine)
> -dpdcei ("Data Path Decompression and Compression Engine Interface")
> =

> Would these fit under networking doc folder too?

IMO it would make sense to place them in the same Documentation/networking/=
dpaa2/
folder, since they're part of the same architecture. Of course, the end loc=
ation
can be changed based on later feedback.

Cheers,
Bogdan P.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
