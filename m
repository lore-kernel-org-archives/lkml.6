Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AG47ELtvk+YmDFaMP+PNmgqkVZGXtLn+qGr3gcNhdog9jDhhfs/dNSe71DvWmH5IA3PKIY8jdTt7
ARC-Seal: i=1; a=rsa-sha256; t=1521037853; cv=none;
        d=google.com; s=arc-20160816;
        b=qhqoPWk+vedwWWI3ee2If3ROEwqsTOQllDF/gLpV7JXKN0m8OzPMRiIozxDY21Jw8D
         Mm+yKxNOT0wQXQuYehuaZnXZ4Zyl1AFlClVe2HtR05NUlGqV8PkLk4hj5rGMC/4Qt3z9
         G9aFqM/lvJApHKWpuzUyrw824dJ3oUQz3oAxYu2Ve9lyZ+UWVWhml7rSCO7teKfX6LS2
         NAf/Vnpf/OEi5Irh/zz0apC3k76gc5abrA+5W8XVFY4KXmQTLLW933S3a0WnFslwRxaw
         ENwXh+ijdBCE34a8dNudDKmra+9parhwsnX+inrKWuASlnyqftLBKC0wH1Bsq0LxdZyx
         0KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=fJnFnfi9lMLtj5CFSa5wB5h+KVlYUcftFKHTfwq7GPs=;
        b=bTaQcBgaXAMO+NouKBytv1A5l/aJ2FrSYH9Qz2NU5jCqLPp1wJ9CtsVFaTjJPux3wX
         wd5fNKwR84IvyBN+jVDZUcO3wQkjyNivfT/nOpfPj/tPvEp+bhot3WdBsdEYZlkwtn7t
         z5adw8SWAqBO3pTz33PqmuCIM2aUbCRwvj/DwzLTmYyeCFiDpFxIViOSdXw9a9RRec1f
         2utKCvvidHE1PZdyKNeyLIRUneVmk0lWzULhbogNummtmTlall/7fwEBccvJALqGJSsP
         yCUCEqpojL/DvpHWIGRQj7lfda3Ca8kN4dG4rc2b6T6H5SSSY5/iWsnbAAM3hvvPYmKN
         FavQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oS6d8TJX;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.5.65 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=oS6d8TJX;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.5.65 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Alexandru
 Marginean <alexandru.marginean@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH v5 1/6] staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
Thread-Topic: [PATCH v5 1/6] staging: fsl-dpaa2/ethsw: Add APIs for DPSW
 object
Thread-Index: AQHTutKTsHS76vydi0KJF/2s++AYE6PPp1WAgAAkW1A=
Date: Wed, 14 Mar 2018 14:30:49 +0000
Message-ID: <AM3PR04MB07433547BF2FEB36282A176BE6D10@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-2-razvan.stefanescu@nxp.com>
 <20180314121759.GA22695@kroah.com>
In-Reply-To: <20180314121759.GA22695@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB321;7:qdx8xTPycq0IXdIihS2c3MBT5lFo4/IEbXPdBHGZM0PF7oxe9FiZCh3Zem7KsWH++BnQRW6kWu4Vut/kVETBf8B5u6qH2Ulx38DohHAB37LNwq8iaT+XNAdAvuJ5qFDcLXtMKEJj3KVyjdqyu9LDACSqmLcxh12O6Jb7wruwJsScuavFQt9XQK6qYGqb8T1E+udy1DgF15b12Iias+/7r64NHFAY+Nr0bMd2B5id/3POoatVDzlgJT13xiFvpLOl
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d8c5189-4185-4e54-7485-08d589b82ed2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB321;
x-ms-traffictypediagnostic: AM3PR04MB321:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB321EDF8287C5E6C18C27268E6D10@AM3PR04MB321.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB321;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB321;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(81156014)(9686003)(6506007)(3846002)(186003)(6246003)(7696005)(6916009)(81166006)(76176011)(8676002)(2950100002)(6116002)(478600001)(305945005)(74316002)(25786009)(3280700002)(2900100001)(102836004)(86362001)(68736007)(105586002)(53936002)(54906003)(59450400001)(26005)(5660300001)(316002)(6436002)(345774005)(55016002)(4326008)(33656002)(106356001)(3660700001)(99286004)(39060400002)(66066001)(97736004)(229853002)(7736002)(2906002)(8936002)(14454004)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB321;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: CCwi613xeEvoIsyXuAJkJMyFHM1Lfbrk/OOP+/WD4tY7jaDJvFcWp4Xg+Vnlqgbe4qcGelSVV9mGDXwCaMfTa7FMf4AtrcZgMDq2IcLjlNfCG+a45k9NuBSXiJwJegxgfKkJvSGIx7L7Hm+xeatyMmRx2c1r3o0doO4SbmUviGDo/8TmGFfDtJ0T2OFyH/wFd9pAgsR23R3yCqXfw+w4AbFS5W5WwWVym8NcNF3UNG5Dp7mevQM0QQbHVRk9D4cy8QyB4Orxl+nF1LoszOQf2rsMGQHROGzcunclesMamQECXbpFF5YTVMYXMEGpRLeZzwZrP2dONbmFiGVcyFJKnQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8c5189-4185-4e54-7485-08d589b82ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 14:30:49.3762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB321
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594830763348119708?=
X-GMAIL-MSGID: =?utf-8?q?1594923788195184400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>=20
> Can you resend this series and just use the correct SPDX identifiers for
> all of the new files, instead of all of this horrid boiler-plate code?
>=20
> That will save me time when I have to go delete all of this in the near
> future :)
>=20
> Also, why dual license it?  Are you _SURE_ you want to do that, and are
> totally aware of all of the crazy issues surrounding it?  Hint, it
> almost never means what you might think it does, and I have yet to know
> of anyone doing anything "real" with any dual-licensed Linux kernel
> code.
>=20
> Remember, BSD is not the license you want/need for GPL header files that
> are exposed to userspace...
>=20
>=20
> thanks,
>=20
> greg k-h

Thank you for your observation. I will update the patches with the SPDX ide=
ntifiers.

Razvan
