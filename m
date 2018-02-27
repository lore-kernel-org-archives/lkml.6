Return-Path: <psroka@cadence.com>
X-Google-Smtp-Source: AH8x225uTIp+0jkPwkwdDcDB04Y2rJfU34FDSgAYrnPlqxOYfoYevpRUl4gFvEvCqNGAR6VlQauX
ARC-Seal: i=1; a=rsa-sha256; t=1519763087; cv=none;
        d=google.com; s=arc-20160816;
        b=F7fJSUQwCQuadRVup11sV74/KNcmwT+Elu5sS+J2euWGX534uGlLVmk4wJFEEx0RwT
         GocC5IZF9TVffbbmtf8iQICjyTj6Mfk776YLfyqSI1FNx2TY6rFvwvHYvVKYfmUpP7fv
         ZTBH1GNXHYf89sa+yrTDl+inoSHmqh7Cu71VslNqQXprl0isn0VkG+WxrRgAzuKJMrk2
         GnPfm3Ht3pPnYe8/AHv9LWCbJGaZFnJFbj8Kcs7sA8srm7NFX9dOsg9nt6sgYIvrvCbi
         gYoT4sfm92/SU88ieBYkd7TZfGraE5BhXBEpr2sBMPwd6ArCtBD4sktl+GuaSnxOqjqe
         vj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=8D2xIAn2VsFN/MUssITbfkWqrQ/jBe/wF/mJHawnudk=;
        b=EAmKN9s1oKvdYCl1UMqjvVD9FTuVSxSnqQeyYOgH8kAMRq9vtIRiffwrt8CzZOiBYV
         Z9IN5jCstx0p0tlSxzxMNw1a/g1Qweof01lGFV1wYBNIv4XCyuAS4nesqmlAuCCoqn//
         qxi7Kng9pvsImXSZ3UDtg2kJP4GnIjHRgVMyC4Q9Vb3bcXPeryCV3IYvCnshC9B0tSPL
         p6yYsnfsFGRwXQfsd4PTr8QC9K515RWkk6YyLZjMPAxeGLl43URnY03eU74WWfVSAUZg
         0p4bVzwfabOk6+7LiJDHu98fcDalXrHkXHXo0BPz9uNA+LLI8UB2b76Vc0d7kKWA8T9s
         VAXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cadence.com header.s=selector1 header.b=J8F8I3LQ;
       spf=pass (google.com: domain of psroka@cadence.com designates 104.47.42.63 as permitted sender) smtp.mailfrom=psroka@cadence.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cadence.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cadence.com header.s=selector1 header.b=J8F8I3LQ;
       spf=pass (google.com: domain of psroka@cadence.com designates 104.47.42.63 as permitted sender) smtp.mailfrom=psroka@cadence.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cadence.com
From: Przemyslaw Sroka <psroka@cadence.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: Vitor Soares <Vitor.Soares@synopsys.com>, Boris Brezillon
	<boris.brezillon@free-electrons.com>, Wolfram Sang <wsa@the-dreams.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann
	<arnd@arndb.de>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas
	<adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos
	<dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian
 Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas
 Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Thread-Index: AQHTdO6AxszKxo1J0Uumo+/8HJ1DX6OypJAAgAA7ugCABJ1cgIAAG1iAgAFGSwCAAAVdwIAAQDkAgAAA4aA=
Date: Tue, 27 Feb 2018 20:24:43 +0000
Message-ID: <MWHPR07MB278357B74A7D7E31EB109DC5CAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
	<20171214151610.19153-3-boris.brezillon@free-electrons.com>
	<b39f9016-b2ff-6d8d-96b3-945f32ab2b67@synopsys.com>
	<20180223213000.407461d2@bbrezillon>
	<1b8fe82f-079b-6f55-0e59-5773027faa8e@synopsys.com>
	<20180226213607.7161bb0a@bbrezillon>
	<b9c057ad-47a0-fa35-0f30-8d465d40b6f0@synopsys.com>
	<MWHPR07MB27833F0CAD2597BFDD37CE6CCAC00@MWHPR07MB2783.namprd07.prod.outlook.com>
 <20180227211302.26f76427@bbrezillon>
In-Reply-To: <20180227211302.26f76427@bbrezillon>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHNyb2thXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNDc2NWRjNzUtMWJmYy0xMWU4LTg2ZTktY2MyZjcxNmRjMjFhXGFtZS10ZXN0XDQ3NjVkYzc3LTFiZmMtMTFlOC04NmU5LWNjMmY3MTZkYzIxYWJvZHkudHh0IiBzej0iNDMxNiIgdD0iMTMxNjQyMzY2OTg4NTQ3MDcxIiBoPSJBNC9hMXVvUm9paG04d01obW5qU2NXU0xZdGM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=psroka@cadence.com;
x-originating-ip: [213.131.238.28]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2973;7:MNKw80q98N73YGKyWXPr6hRpPL1/GjRdJImqpbqECw5xj7112otOjveKAUEU/0WVk1lZqr2l39QKD3L0L/3rLhpZBi7V2ofInv4qgzNfj08xHD6/YHeB4lGRRGbFQCks3+DrH9pHSVnEwuC6dlmk9hePumqo+t0yLrhLiq865+smVayXi510n+Gjf6zacj4hBqFhISZMebsBLhExKJpLW7766NW5aisc22D5RVR2I0Y4HHB6q0lF49TEr+s6uKJe;20:fDpjJM1BFUknZ6MtkE0BFX0LFA8+2mG4LolCIfK+v1FN6/2bCb2GOSTQpUSAd08YlrZ3G6uMLxQvxloLNdYQXP/otZvkSUtnBMeW48a5dcjVntBHVCxZVTHj4OgZTUNs1VH3ItAxBZvdkNLe00Yo7nFricK6I8bbKnKW4zi9mHwFWtvn00cITe/nJdQQv7Vn1TIW4ZXMffCai9YAL/t/bLC3cud7r/9xv+no9y+d/lpMu8mYwUUAViWJ1RW7NCoT
x-ms-office365-filtering-correlation-id: fd75d81f-3783-4ce8-79ed-08d57e20235c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB2973;
x-ms-traffictypediagnostic: MWHPR07MB2973:
x-microsoft-antispam-prvs: <MWHPR07MB29736D872913777EE92B4978CAC00@MWHPR07MB2973.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(31051911155226)(278428928389397)(9452136761055)(58145275503218)(72806322054110)(10436049006162);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR07MB2973;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2973;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(13464003)(36092001)(199004)(189003)(81156014)(81166006)(229853002)(8936002)(55016002)(6246003)(3660700001)(8676002)(74316002)(186003)(59450400001)(3846002)(3280700002)(2906002)(68736007)(54906003)(6116002)(6306002)(2900100001)(9686003)(14454004)(53936002)(76176011)(966005)(316002)(97736004)(6506007)(25786009)(5660300001)(106356001)(2950100002)(7736002)(53546011)(86362001)(305945005)(93886005)(575784001)(6916009)(4326008)(26005)(99286004)(33656002)(7416002)(77096007)(478600001)(105586002)(6436002)(102836004)(7696005)(66066001)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2973;H:MWHPR07MB2783.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MbrLoUHJCQ5zE2gtT8Ica33HYH5LbmgRL6lFy+S3ip7v9aprsbV1Equ1GxHeSxy2Q+S/nBnEOBYXjI1l1mRdYkKCm/MCCdJTdIr9xRSBta4v6GmePDOWYw8Gt2q5GZ/NiXAXK1+sLocbO+SqM+jC2/sJ8IcehEkzRMdwGAiPMLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd75d81f-3783-4ce8-79ed-08d57e20235c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 20:24:43.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2973
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586772916728163872?=
X-GMAIL-MSGID: =?utf-8?q?1593587100125578719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Boris

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, February 27, 2018 9:13 PM
> To: Przemyslaw Sroka <psroka@cadence.com>
> Cc: Vitor Soares <Vitor.Soares@synopsys.com>; Boris Brezillon
> <boris.brezillon@free-electrons.com>; Wolfram Sang <wsa@the-
> dreams.de>; linux-i2c@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>;
> linux-doc@vger.kernel.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>;
> Arkadiusz Golec <agolec@cadence.com>; Alan Douglas
> <adouglas@cadence.com>; Bartosz Folta <bfolta@cadence.com>; Damian
> Kos <dkos@cadence.com>; Alicja Jurasik-Urbaniak <alicja@cadence.com>;
> Cyprian Wronka <cwronka@cadence.com>; Suresh Punnoose
> <sureshp@cadence.com>; Thomas Petazzoni <thomas.petazzoni@free-
> electrons.com>; Nishanth Menon <nm@ti.com>; Rob Herring
> <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Rutland
> <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Geert Uytterhoeven <geert@linux-m68k.org>; Linus
> Walleij <linus.walleij@linaro.org>
> Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
>=20
> EXTERNAL MAIL
>=20
>=20
> Hi Przemek,
>=20
> On Tue, 27 Feb 2018 16:43:27 +0000
> Przemyslaw Sroka <psroka@cadence.com> wrote:
>=20
> > >
> > > >> Either important is the SETDASA for declared I3C devices. So the
> > > >> DAA process should start by send an SETDASA and them ENTDAA
> CCC
> > > command.
> > > > My understanding was that SETDASA was not mandatory, and was
> only
> > > > useful when one wants to assign a specific dynamic address to a
> > > > slave that has a static address (which is again not mandatory).
> > > > I've tested it, and even devices with a static address participate
> > > > to the DAA procedure if they've not been assigned a dynamic
> > > > address yet, so I don't see the need for this SETDASA step if you
> > > > don't need to assign a particular dynamic address to the device.
> > > >
> > > > Could you tell me why you think SETDASA is required?
> > >
> > > Yes, you are right... But in my opinion it is required as it does
> > > part of DAA process.
> >
> > SETDASA is simply faster than ENTDAA, but only if there is no need to
> > collect BCR/DCR/PID of such devices. I think most applications would
> > like to have them as an status information so  after all ENTDAA can be
> > regarded as an generic approach (unless I'm mistaken).
>=20
> Actually, we could retrieve BCR/DCR/PID (and all other relevant
> information, like MAXDS) even with the SETDASA approach. We just need to
> send the according CCC commands after SETDASA.
>=20
I agree, what I meant by "SETDASA is simply faster than ENTDAA, but only if=
 there is no need to collect BCR/DCR/PID of such devices." Is that it is fa=
ster than DAA but only if not followed by GET CCC commands to gather BCR/DC=
R/PID. I think we are on the same page here.

> But that's also my understanding that ENTDAA should always work, and
> SETDASA usage is only needed if you want to reserve a dynamic address
> and assign it to a device before DAA takes place. This way you can enforc=
e
> the device priority (WRT IBIs). But honestly, that's the only use case I =
can
> think of, and to me, it sounds like an advanced feature we may want to
> support at some point, but don't need in the initial implementation.
>
Still ENTDAA seems to be sufficient for IBI prioritization but I can imagin=
e some use cases where people would like to use it for such purposes. Note =
that SETDASA is applicable only for devices with SA so it is self-explanato=
ry that it cannot be considered as utility to define priorities for all dev=
ices before ENTDAA.=20

> --
> Boris Brezillon, Bootlin (formerly Free Electrons) Embedded Linux and
> Kernel engineering https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__bootlin.com&d=3DDwICAg&c=3DaUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3G
> Z-_haXqY&r=3Db0WPdqYyu0KH4-vSatt-ViJE1riZ603zdXl3hHHp_TU&m=3DwM54-
> BGcSfHEklVRsw02O-bnyNkLTe9c0RyBP_ExzPA&s=3DpxQrogG-
> Nq4XOMU7SPZ2FZNbgnbnjdERtMm_h7ZcdCE&e=3D

Regards,
Przemek
