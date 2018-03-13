Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELvqYon1XhZUMb5bYJUe6x2LTGywafUBg4JVAEBZlp75ca1TftJwtJaBV5JM9aTwGlvRgbhT
ARC-Seal: i=1; a=rsa-sha256; t=1520935063; cv=none;
        d=google.com; s=arc-20160816;
        b=VzERBPlSJ7ypZ6iHufMzkJttbfsMQ2H2T8eOpH91oueiKWDfPA1TfMANiK1atBdtCO
         aXUhiiYm48qPouhfpWid3ev6ZWcYpandSf97A6vPiO3yXQHFj996E2M/zCk+YMceQioa
         0r1SqXsMVNTKLbL6mL7j3sV4JbLrxXY1h9WVcUevyEtvmpBMLqEe79nFaeSQJkfSJXyk
         S1+Nus7IM3PkQF8Mraz3F351Z6SLuVKfnqgqclx4zWjWjz5Ol7T5lh40KR4zXDUibNUx
         UKIDjM3wqdSzjO6VWztbHZbt21FkB2gIH9p9rIIq/+Vwy6xUOnDQs61tZvBJrUQP3XJ2
         hfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=sVz7FnYifl/BNxU22U/8I6cqgmyVoVperlOKpVbX0/A=;
        b=jBqIIgF+5jxpDfm8rf0NZa2k8XmlfXyI9BA5Ewq3aUktXiCU3QtNUrRPnGd9dNVzRP
         nx8nEr+v2p/YbW5HLJmeQnXKFuvjAK2Kwx+0yZgqMSd4cVSeT7ZC9FPl3LKI3dKvcp1c
         d9enLRGcLwrdsliyEP7libD8oal0Za45cfdoUyGb3ZtHrohcJXJA1lVMz+i+S5B/DYAr
         U+2N1ykKuWE91jVR++fBntcVGkrQXt19L0TSAMxafNuTTWF1Lpip6ZoUdxUCS6YL9zxf
         pVTd3XYn35uhycN8K0B0f3rZGd5ZDYRC7/VyMhFerRBDvPHtCvbvyu4lD9rcxW0F7bZh
         XYHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=plON9A50;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.4.66 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=plON9A50;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.4.66 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: RE: [PATCH 1/3] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH 1/3] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTtjQexfPnB3EJWkeApMJaRzBDq6PITp4AgAWeNSA=
Date: Tue, 13 Mar 2018 09:57:36 +0000
Message-ID: <HE1PR04MB3212C7D32214AC5045FB0949E0D20@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1520440367.git.ioana.ciornei@nxp.com>
 <e3d050dcdc575d65f9786eaa1b7a55aaa197dfc3.1520440367.git.ioana.ciornei@nxp.com>
 <20180309193334.GA20133@kroah.com>
In-Reply-To: <20180309193334.GA20133@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1660;6:KBadxnXpjXiKXPQWnJV94Oi4K/ewOB2hE3dJ+6JvwAOxEeNnvlFxSvMf7KUiekSPC83TY7JShKHFAsHyHY1DjrRGv4ssMY4xLUyDAL0zT4ocB9QRLPgOR2fLMA772ozVAUQcVwDbAUQXK2FrzgKCW95TaKTTh+3RaWe//He0Yy01oAgI2/kEMn33K9k/+KGeH5n/EX/pZyIBcWF7QHHD07oMdA76azHbydoC/bNbDDwfoyC0HrGn8xFCogoS4YAYBkinHnQ6AVVBkrjVDnspa8uuiN/vbiqV5WXqBAcAS1QYuvXmP/NoQjwoG8UidfMhde7XZ4BUl6FIRiahEP/kU3oI81BksLeM64Ufus/SkMKIH/nywpw0drPI/d+g54kL;5:Y0WEv6ZzqxNHAjeFc2jXfs5rozY0LF5cUVRyhC8oN4Yc21jkb0OBPOy86GvHeJtaKoa4Vpauss/iqBBVSitEXPfRiTgo/zBTxbIfxjBpvlHhXmQ+XNAI3qjXR6d9NSJVsThw7nxAqUDG9CsQIJ5FwULxyKV3zBFgV0QVej9TaH4=;24:6VIqJpw3R/drOqHF8ULEhRt3ImEgUshuOEfCN/RXoYfUGy/YYtM/hGRhflAVluPswKq3SbAOzw3dPWZgMR9bycX8E6HmsjhdozdcUz+YGZU=;7:sjhIcl8SLEfT0wzB/RlftAws9uNavXqHiENrRXsVGzvUmPPaiLfTadH4DKyin6PlRnQF5iPms6odJe7zuKBJDCWeHCuM/VwuZbcYhZZqr/PraYbJSSZgJQfJR9Mu2vhd9l+xerZmrwFUkeecRHy4UTV2Sfjnfpyv6qBIb/cs1cZUET0v1Kwsr1TDaU2Ii02fEC2KxNTtA75CWzJouKIiTKxaNGm6PpxAfVVFfsUkClVfhZC0YtFsEv2usmLzcW60
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39380400002)(39860400002)(376002)(199004)(189003)(68736007)(6246003)(55016002)(99286004)(5250100002)(305945005)(6116002)(3846002)(3280700002)(102836004)(54906003)(316002)(6346003)(6916009)(6306002)(229853002)(26005)(76176011)(53936002)(7696005)(74316002)(105586002)(9686003)(97736004)(2950100002)(7736002)(4326008)(186003)(5660300001)(478600001)(8676002)(81166006)(966005)(33656002)(86362001)(8936002)(6436002)(66066001)(25786009)(81156014)(2900100001)(106356001)(6506007)(39060400002)(3660700001)(2906002)(14454004)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1660;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4799fe52-60af-420e-5b8f-08d588c8d9bf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1660;
x-ms-traffictypediagnostic: HE1PR04MB1660:
x-microsoft-antispam-prvs: <HE1PR04MB166051B75CA3ABD78B5E5E79E0D20@HE1PR04MB1660.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(35073007944872)(185117386973197)(275809806118684);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1660;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1660;
x-forefront-prvs: 0610D16BBE
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-microsoft-antispam-message-info: ORUdBPZ7C44WjcoIAFiDX2RhkC6IWTk/6yc5KGLCfY6Ldq9Fm+O9sRK4ScfyN4faSwGIQ7ysOX2T9aWtg9ha5Yr/dib1rN2RJ18De65rzWwcnM/+MKeODR8N3iWGTMESPvpCfrgyHglTGxVEGjZcVgBNDzu9GrGDBLj8c0TNBbBMtMKP9eaxxg8LuX6bT5BXeWD/ifiF/3G3SNuWKHsCQW5Z+8zWLRZcRVskOOpRzaZth4GWxh8pSTtXSBHIu0ZdQU94d7SmSMbL2GLqzVnI9zCqJcTQ8ExVueanshUbI5/V/ATmG/OXAfjutVHJMYZ4nKKI/cVfRaIPMSwqNISbmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4799fe52-60af-420e-5b8f-08d588c8d9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 09:57:36.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1660
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298563831180783?=
X-GMAIL-MSGID: =?utf-8?q?1594816004966106169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,=20

Comments inline.

> > Adding kernel support for restool, a userspace tool for resource
> > management, means exporting an ioctl capable device file representing
> > the root resource container.
> > This new functionality in the fsl-mc bus driver intends to provide
> > restool an interface to interact with the MC firmware.
> > Commands that are composed in userspace are sent to the MC firmware
> > through the RESTOOL_SEND_MC_COMMAND ioctl.
> > By default the implicit MC I/O portal is used for this operation, but
> > if the implicit one is busy, a dynamic portal is allocated and then
> > freed upon execution.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  Documentation/ioctl/ioctl-number.txt        |   1 +
> >  Documentation/networking/dpaa2/overview.rst |   4 +
> >  drivers/bus/fsl-mc/Kconfig                  |   7 +
> >  drivers/bus/fsl-mc/Makefile                 |   3 +
> >  drivers/bus/fsl-mc/fsl-mc-allocator.c       |   5 +
> >  drivers/bus/fsl-mc/fsl-mc-bus.c             |  19 +++
> >  drivers/bus/fsl-mc/fsl-mc-private.h         |  56 +++++++
> >  drivers/bus/fsl-mc/fsl-mc-restool.c         | 219
> ++++++++++++++++++++++++++++
>=20
> This is a "tiny" patch, yet I think it needs to be broken up more, as you=
 are
> mixing a few different things in the same patch, and you forgot one big t=
hing...

I will break the patch into multiple ones in the next version.

>=20
> >  8 files changed, 314 insertions(+)
> >  create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c
> >
> > diff --git a/Documentation/ioctl/ioctl-number.txt
> > b/Documentation/ioctl/ioctl-number.txt
> > index 6501389..d427397 100644
> > --- a/Documentation/ioctl/ioctl-number.txt
> > +++ b/Documentation/ioctl/ioctl-number.txt
> > @@ -170,6 +170,7 @@ Code  Seq#(hex)	Include File
> 	Comments
> >  'R'	00-1F	linux/random.h		conflict!
> >  'R'	01	linux/rfkill.h		conflict!
> >  'R'	C0-DF	net/bluetooth/rfcomm.h
> > +'R'	E0	drivers/bus/fsl-mc/fsl-mc-private.h
> >  'S'	all	linux/cdrom.h		conflict!
> >  'S'	80-81	scsi/scsi_ioctl.h	conflict!
> >  'S'	82-FF	scsi/scsi.h		conflict!
> > diff --git a/Documentation/networking/dpaa2/overview.rst
> > b/Documentation/networking/dpaa2/overview.rst
> > index 79fede4..1056445 100644
> > --- a/Documentation/networking/dpaa2/overview.rst
> > +++ b/Documentation/networking/dpaa2/overview.rst
> > @@ -127,6 +127,10 @@ level.
> >
> >  DPRCs can be defined statically and populated with objects  via a
> > config file passed to the MC when firmware starts it.
> > +There is also a Linux user space tool called "restool" that can be
> > +used to create/destroy containers and objects dynamically. The latest
> > +version of restool can be found at:
> > +
> > + https://github.com/qoriq-open-source/restool
> >  DPAA2 Objects for an Ethernet Network Interface
> >  -----------------------------------------------
> > diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
> > index c23c77c..66ec3b9 100644
> > --- a/drivers/bus/fsl-mc/Kconfig
> > +++ b/drivers/bus/fsl-mc/Kconfig
> > @@ -14,3 +14,10 @@ config FSL_MC_BUS
> >  	  architecture.  The fsl-mc bus driver handles discovery of
> >  	  DPAA2 objects (which are represented as Linux devices) and
> >  	  binding objects to drivers.
> > +
> > +config FSL_MC_RESTOOL
> > +	bool "Management Complex (MC) restool support"
> > +	depends on FSL_MC_BUS
> > +	help
> > +	  Provides kernel support for the Management Complex resource
> > +	  manager user-space tool - restool.
>=20
> Why would you want to make this a build option?  Why would you ever _not_
> want this?

Using the restool user-space tool for managing MC resources is not the only=
 possibility for creating/destroying MC objects, changing their properties,=
 etc.
While restool's  intended use is in a dynamic context, users also have the =
option to deploy a static configuration using a Data Path Layout file that =
describes the MC resource configuration.
In this case, the restool support is no longer needed.
=20
>=20
>=20
> > diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> > index 6a97f2c..9a155e3 100644
> > --- a/drivers/bus/fsl-mc/Makefile
> > +++ b/drivers/bus/fsl-mc/Makefile
> > @@ -14,3 +14,6 @@ mc-bus-driver-objs :=3D fsl-mc-bus.o \
> >  		      fsl-mc-allocator.o \
> >  		      fsl-mc-msi.o \
> >  		      dpmcp.o
> > +
> > +# MC restool kernel support
> > +obj-$(CONFIG_FSL_MC_RESTOOL) +=3D fsl-mc-restool.o
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > index 452c5d7..fb1442b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> > @@ -646,3 +646,8 @@ int __init fsl_mc_allocator_driver_init(void)
> >  {
> >  	return fsl_mc_driver_register(&fsl_mc_allocator_driver);
> >  }
> > +
> > +void fsl_mc_allocator_driver_exit(void)
> > +{
> > +	fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
> > +}
>=20
> Why are you mixing the bus/driver changes in with the addition of the ioc=
tl?
> That should be broken out into the "first" patch of this series, to make =
the
> addition of the ioctl easier to see and review.

Will split the bus changes into a separate patch.

>=20
> > +#define RESTOOL_IOCTL_TYPE	'R'
> > +#define RESTOOL_IOCTL_SEQ	0xE0
> > +
> > +#define RESTOOL_SEND_MC_COMMAND \
> > +	_IOWR(RESTOOL_IOCTL_TYPE, RESTOOL_IOCTL_SEQ, struct
> mc_command)
>=20
> "struct mc_command" is not defined as a structure that can cross the
> user/kernel boundry at all.  At the least it is not in a public uapi head=
er file.  It
> also does not use the correct variable types, and it is a very generic na=
me for
> a global kernel structure that the whole world is now going to be able to=
 see.
>=20
> Please fix all of that up first, before adding the ioctl itself :)

I will move the mc_command structure into a uapi header file for the fsl-mc=
 bus in the next version of the patchset.


>=20
> > +static int fsl_mc_restool_send_command(unsigned long arg,
> > +				       struct fsl_mc_io *mc_io)
> > +{
> > +	struct mc_command mc_cmd;
> > +	int error;
> > +
> > +	error =3D copy_from_user(&mc_cmd, (void __user *)arg,
> sizeof(mc_cmd));
> > +	if (error)
> > +		return -EFAULT;
> > +
> > +	error =3D mc_send_command(mc_io, &mc_cmd);
>=20
> are you doing correct error and validation checking of this user-provided
> structure?  Remember, you can not trust this data at all.

The Management Complex is the one validating the commands received.
The restool support in the bus driver is just a passthrough for the command=
s passed from user-space and their associated responses from the MC firmwar=
e.

>=20
> All input is evil.
>=20
> thanks,
>=20
> greg k-h
