Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30CC20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n7jV22YQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30CC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeKSU4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:56:21 -0500
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:16748
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbeKSU4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0V4yjh+AzPaA6rNLlmGV0fTgk2l4O8ygC+wme/U62w=;
 b=n7jV22YQdaov1xTHG/HAYXXociSzNNYg3heesuXKMrsGQxiXElsBFo8tLTCA8Yiz4t6krymLYyH0Fr5tisFq10V9xWf8UeqkdAEmWc3lbLoegAkVkEqRhrxt8I3GG62OdJ3Pb+0HDciJ2IRpNSZrCaeeieqF4bWz9UmdWnHWxEU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3391.eurprd04.prod.outlook.com (52.134.1.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 10:33:02 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Mon, 19 Nov 2018
 10:33:02 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v2 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Topic: [PATCH v2 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Index: AQHUfdWWsu9NfPdpDEipLgPtUDhagKVSzsOAgAQKskA=
Date:   Mon, 19 Nov 2018 10:33:02 +0000
Message-ID: <VI1PR0402MB2800404173FCC18BB8604A89E0D80@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
 <1542390890-3270-3-git-send-email-ioana.ciornei@nxp.com>
 <20181116194733.GA7785@kroah.com>
In-Reply-To: <20181116194733.GA7785@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3391;6:2fLLqeJMuDUbCG0pbJyG/QK2NnJaNCidTaTfG7dTOhadgzQ4gmoynz3YyJfYlMZbT44YyqTa/YeSD5DVvY3gL/4WQTwHjXlRDj13jSjb0JyWDeaXyx6r+mBK3W4EbPbWUUoIeo45gbn562ylSJPlY49A0BqL9SHkS9yJYr5Jp2Jc9NzdvbD6VAmkgahaBnE2h4DDinQcLFAmgDvBQPj8T22zjXkob8iOJUSpUUixwgzfU7u3W6fTRCkND/LQqzIVncyDlV8Wrlk8rpu6XrAkQr3SCqZDZ/Z8dftlJeUnHDDoBXMtkyPZNlS50PiaNYd4JtYseypd+hbskopgLntDZLKL9kDeGfAPgrDsCRXMLxG0yKqpMkUakupTVfRu+HGyZxOsQqyD0/DNVTi+XyNnWCdj4sFooGNWE1egjT71ThTKIMyTA18x94Qr+vVZpPMxPHtb7BxJ/mokNj/RPVagGQ==;5:wHINLNL8vUrlA8+iU8FSC4g+o1JCQ9tqhCK+FShwMecSg6P5ny1vGm3uhmgjrHZ2kx+Cr0T354pT3xKaRzxj+1GMQhLkvK1Z3R+hMWyhb4OvtYOd9JJCMoJlz4tBhB6goLeDj0smbD7VmNUMxe7HEpDYaz7gAg31qZiI+/VhFzU=;7:cRkzUW0ddvQe085W+c5KAirLJ2xwX/oFcNBt15g9C4amOezGhbj6VWdW0mME08OX44Bm0KS/1T+Rcz4QDQetXsSQc13Ls1gz2AfnEjwkydRbQu4i6OEdbE9Mr9GsdIBIUjW8NsQm6dHj/+jM3FjAxg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8bcf4e25-a23e-4260-e6ee-08d64e0a6229
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3391;
x-ms-traffictypediagnostic: VI1PR0402MB3391:
x-microsoft-antispam-prvs: <VI1PR0402MB33918D46A602DF736226580EE0D80@VI1PR0402MB3391.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231431)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3391;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3391;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(229853002)(7696005)(2501003)(25786009)(97736004)(3846002)(6116002)(102836004)(478600001)(14444005)(26005)(71190400001)(76176011)(71200400001)(575784001)(4326008)(86362001)(256004)(6506007)(99286004)(186003)(14454004)(7736002)(106356001)(6246003)(44832011)(9686003)(33656002)(5640700003)(105586002)(53946003)(81166006)(5660300001)(11346002)(68736007)(6436002)(8676002)(2906002)(1730700003)(8936002)(2351001)(81156014)(486006)(446003)(2900100001)(66066001)(55016002)(305945005)(74316002)(53936002)(54906003)(4744004)(476003)(6916009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3391;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7DzkKwy09E8JRrM50E0PGeB5xyYXad4zpwhsNX6EdcqwCjSBWApnUcanmkLpCgM8gxMzs8kVRRwzVqDazZuVpwcVFLG4476Pei2X8AUh9qHGnIiqLNiLYlfJLRPuil1BPpiZ764mWDWI6XN2V9cQZRZvIyxtTg/tbS5qgjZ+Gep41GHJAqizpX9dC3d3ZQ5Zu5Lq4BVvfoey29mlRehSjIS6Ryq2Y9qETAPnpfHhn5lBzVGXd1YzEe4TooT5X5ec4WxCBq+I9VdQhUA0jSeninCeN47Ki1PRILU0nw17pxKT+TeWTApteSId00gs3VMGqLksN+cYGQspWohCuR28BDwBJNTuP4guLVcsVOGaSzo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcf4e25-a23e-4260-e6ee-08d64e0a6229
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 10:33:02.1475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3391
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Adding userspace support for the MC (Management Complex) means
> > exporting an ioctl capable device file representing the root resource c=
ontainer.
> >
> > This new functionality in the fsl-mc bus driver intends to provide
> > userspace applications an interface to interact with the MC firmware.
> >
> > Commands that are composed in userspace are sent to the MC firmware
> > through the FSL_MC_SEND_MC_COMMAND ioctl.  By default the implicit MC
> > I/O portal is used for this operation, but if the implicit one is
> > busy, a dynamic portal is allocated and then freed upon execution.
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>=20
> Overall, this looks almost sane :)
>=20
> But I do have some minor comments below on the code after only a quick
> review.
>=20
>=20
> > ---
> > Changes in v2:
> >    - use root dprc MC portal by default
> >    - create the uapi misc device from the root dprc probe function
> >
> >  Documentation/ioctl/ioctl-number.txt |   1 +
> >  drivers/bus/fsl-mc/Kconfig           |   7 ++
> >  drivers/bus/fsl-mc/Makefile          |   3 +
> >  drivers/bus/fsl-mc/dprc-driver.c     |  14 ++-
> >  drivers/bus/fsl-mc/fsl-mc-private.h  |  41 ++++++++
> >  drivers/bus/fsl-mc/fsl-mc-uapi.c     | 179
> +++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fsl_mc.h          |   9 ++
> >  7 files changed, 253 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/bus/fsl-mc/fsl-mc-uapi.c
> >
> > diff --git a/Documentation/ioctl/ioctl-number.txt
> > b/Documentation/ioctl/ioctl-number.txt
> > index af6f6ba..eaae7bf 100644
> > --- a/Documentation/ioctl/ioctl-number.txt
> > +++ b/Documentation/ioctl/ioctl-number.txt
> > @@ -171,6 +171,7 @@ Code  Seq#(hex)	Include File
> 	Comments
> >  'R'	00-1F	linux/random.h		conflict!
> >  'R'	01	linux/rfkill.h		conflict!
> >  'R'	C0-DF	net/bluetooth/rfcomm.h
> > +'R'	E0	uapi/linux/fsl_mc.h
> >  'S'	all	linux/cdrom.h		conflict!
> >  'S'	80-81	scsi/scsi_ioctl.h	conflict!
> >  'S'	82-FF	scsi/scsi.h		conflict!
> > diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
> > index c23c77c..cde6f40 100644
> > --- a/drivers/bus/fsl-mc/Kconfig
> > +++ b/drivers/bus/fsl-mc/Kconfig
> > @@ -14,3 +14,10 @@ config FSL_MC_BUS
> >  	  architecture.  The fsl-mc bus driver handles discovery of
> >  	  DPAA2 objects (which are represented as Linux devices) and
> >  	  binding objects to drivers.
> > +
> > +config FSL_MC_UAPI_SUPPORT
> > +	bool "Management Complex (MC) userspace support"
> > +	depends on FSL_MC_BUS
> > +	help
> > +	  Provides userspace support for creating/destroying/configuring
> > +	  DPAA2 objects in the Management Complex.
> > diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> > index 3c518c7..4ae292a 100644
> > --- a/drivers/bus/fsl-mc/Makefile
> > +++ b/drivers/bus/fsl-mc/Makefile
> > @@ -16,3 +16,6 @@ mc-bus-driver-objs :=3D fsl-mc-bus.o \
> >  		      fsl-mc-allocator.o \
> >  		      fsl-mc-msi.o \
> >  		      dpmcp.o
> > +
> > +# MC userspace support
> > +obj-$(CONFIG_FSL_MC_UAPI_SUPPORT) +=3D fsl-mc-uapi.o
> > diff --git a/drivers/bus/fsl-mc/dprc-driver.c
> > b/drivers/bus/fsl-mc/dprc-driver.c
> > index 52c7e15..3919d9b 100644
> > --- a/drivers/bus/fsl-mc/dprc-driver.c
> > +++ b/drivers/bus/fsl-mc/dprc-driver.c
> > @@ -593,6 +593,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
> >  	struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc_dev);
> >  	bool mc_io_created =3D false;
> >  	bool msi_domain_set =3D false;
> > +	bool uapi_created =3D false;
>=20
> I dont understand this "created" need/use.  Why is that needed?

The misc device should be created only for the root dprc device probed by t=
his driver. The uapi_created flag is used to keep track if we are trying to=
 probe the root dprc and if we succeeded in creating its misc device. Also,=
 this is used on the cleanup path. If there are any other errors afterwards=
, we should know if the misc device is to be deregistered or not.

>=20
> >  	u16 major_ver, minor_ver;
> >
> >  	if (!is_fsl_mc_bus_dprc(mc_dev))
> > @@ -647,6 +648,11 @@ static int dprc_probe(struct fsl_mc_device *mc_dev=
)
> >  		} else {
> >  			dev_set_msi_domain(&mc_dev->dev,
> mc_msi_domain);
> >  			msi_domain_set =3D true;
> > +
> > +			error =3D fsl_mc_uapi_create_device_file(mc_bus);
> > +			if (error < 0)
> > +				goto error_cleanup_msi_domain;
> > +			uapi_created =3D true;
>=20
> Why are you setting this, can't you always just "know" if the misc file w=
as
> created so when you clean up from errors you can remove it?  Or is the lo=
gic
> here just too complex?
>=20

We end up here if the dprc-driver is probing a root device. If this is the =
case, the misc_register called from fsl_mc_uapi_create_device_file could st=
ill fail if the misc driver is not yet probed. If this is the case, we just=
 want to delay the probe.

This being said, I can just check for the root dprc and cleanup its misc de=
vice on the error path (in the error_cleanup_uapi label) without the need o=
f the created flag.

>=20
> >  		}
> >  	}
> >
> > @@ -654,7 +660,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
> >  			  &mc_dev->mc_handle);
> >  	if (error < 0) {
> >  		dev_err(&mc_dev->dev, "dprc_open() failed: %d\n", error);
> > -		goto error_cleanup_msi_domain;
> > +		goto error_cleanup_uapi;
> >  	}
> >
> >  	error =3D dprc_get_attributes(mc_dev->mc_io, 0, mc_dev->mc_handle,
> @@
> > -706,6 +712,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
> >  error_cleanup_open:
> >  	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
> >
> > +error_cleanup_uapi:
> > +	if (uapi_created)
> > +		fsl_mc_uapi_remove_device_file(mc_bus);
> > +
> >  error_cleanup_msi_domain:
> >  	if (msi_domain_set)
> >  		dev_set_msi_domain(&mc_dev->dev, NULL); @@ -774,6
> +784,8 @@ static
> > int dprc_remove(struct fsl_mc_device *mc_dev)
> >  	if (!fsl_mc_is_root_dprc(&mc_dev->dev)) {
> >  		fsl_destroy_mc_io(mc_dev->mc_io);
> >  		mc_dev->mc_io =3D NULL;
> > +	} else {
> > +		fsl_mc_uapi_remove_device_file(mc_bus);
>=20
> You aren't checkig that bool flag here, which kind of implies that you di=
dn't need
> it above as well.

In the _probe function, the uapi_created flag has somewhat the same meaning=
 as the fsl_mc_is_root_dprc() here. I will change the probe function to use=
 it also.

>=20
> >  	}
> >
> >  	dev_info(&mc_dev->dev, "DPRC device unbound from driver"); diff
> > --git a/drivers/bus/fsl-mc/fsl-mc-private.h
> > b/drivers/bus/fsl-mc/fsl-mc-private.h
> > index ea11b4f..16902f9 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> > +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> > @@ -10,6 +10,8 @@
> >
> >  #include <linux/fsl/mc.h>
> >  #include <linux/mutex.h>
> > +#include <linux/ioctl.h>
> > +#include <linux/miscdevice.h>
> >
> >  /*
> >   * Data Path Management Complex (DPMNG) General API @@ -492,6 +494,24
> > @@ struct fsl_mc_resource_pool {  };
> >
> >  /**
> > + * struct fsl_mc_uapi - information associated with a device file
> > + * @misc: struct miscdevice linked to the root dprc
> > + * @device: newly created device in /dev
> > + * @mutex: mutex lock to serialize the open/release operations
> > + * @local_instance_in_use: local MC I/O instance in use or not
> > + * @dynamic_instance_count: number of dynamically created MC I/O
> > +instances
> > + * @static_mc_io: pointer to the static MC I/O object  */ struct
> > +fsl_mc_uapi {
> > +	struct miscdevice misc;
> > +	struct device *device;
> > +	struct mutex mutex; /* serialize open/release operations */
> > +	u32 local_instance_in_use;
>=20
> Why do you care/need to know if it is in use or not?
> Why does it matter, that's a userspace decision to make, not the kernel's=
.

If the userspace is trying to make concurrent calls to the MC, those should=
 be made using different MC portals.
A default/local portal is used by default so we keep track if this is in us=
e or not so that we can make the next decision, whether we need to dynamica=
lly allocate another one when we encounter concurrent calls.=20
I do not see how this is a userspace decision to make.

>=20
>=20
> > +	u32 dynamic_instance_count;
> > +	struct fsl_mc_io *static_mc_io;
> > +};
> > +
> > +/**
> >   * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
> >   * @mc_dev: fsl-mc device for the bus device itself.
> >   * @resource_pools: array of resource pools (one pool per resource
> > type) @@ -500,6 +520,7 @@ struct fsl_mc_resource_pool {
> >   * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
> >   * @scan_mutex: Serializes bus scanning
> >   * @dprc_attr: DPRC attributes
> > + * @uapi_misc: struct that abstracts the interaction with userspace
> >   */
> >  struct fsl_mc_bus {
> >  	struct fsl_mc_device mc_dev;
> > @@ -507,6 +528,7 @@ struct fsl_mc_bus {
> >  	struct fsl_mc_device_irq *irq_resources;
> >  	struct mutex scan_mutex;    /* serializes bus scanning */
> >  	struct dprc_attributes dprc_attr;
> > +	struct fsl_mc_uapi uapi_misc;
> >  };
> >
> >  #define to_fsl_mc_bus(_mc_dev) \
> > @@ -561,4 +583,23 @@ int __must_check fsl_create_mc_io(struct device
> > *dev,
> >
> >  bool fsl_mc_is_root_dprc(struct device *dev);
> >
> > +#ifdef CONFIG_FSL_MC_UAPI_SUPPORT
> > +
> > +int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus);
> > +
> > +void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus);
> > +
> > +#else
> > +
> > +static inline int fsl_mc_uapi_create_device_file(struct fsl_mc_bus
> > +*mc_bus) {
> > +	return 0;
> > +}
> > +
> > +static inline void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus
> > +*mc_bus) { }
> > +
> > +#endif
> > +
> >  #endif /* _FSL_MC_PRIVATE_H_ */
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c
> > b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> > new file mode 100644
> > index 0000000..8c9debb
> > --- /dev/null
> > +++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Management Complex (MC) userspace support
> > + *
> > + * Copyright 2018 NXP
> > + *
> > + */
> > +
> > +#include <linux/slab.h>
> > +#include <linux/fs.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/miscdevice.h>
> > +
> > +#include "fsl-mc-private.h"
> > +
> > +struct uapi_priv_data {
> > +	struct fsl_mc_uapi *uapi;
> > +	struct fsl_mc_io *mc_io;
> > +};
> > +
> > +static int fsl_mc_uapi_send_command(unsigned long arg,
> > +				    struct fsl_mc_io *mc_io)
> > +{
> > +	struct fsl_mc_command mc_cmd;
> > +	int error;
> > +
> > +	error =3D copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd))=
;
> > +	if (error)
> > +		return -EFAULT;
> > +
> > +	error =3D mc_send_command(mc_io, &mc_cmd);
>=20
> Is there no need for any type of validation of the command at all?
> Previously you were always sending "known good" commands from within the
> kernel.  THat is suddenly changed here, how good and robust is your error
> handling in this function?

The only measure taken here is the fact that we only accept data of fsl_mc_=
command size.
This is because we are relying on the MC firmware, which already has valida=
tion logic, to parse the commands and return an error in case the command i=
s malformed or with invalid parameters
Also, doubling the command validation code inside the kernel would create u=
nnecessary complexity.

>=20
>=20
> > +	if (error)
> > +		return error;
> > +
> > +	error =3D copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
> > +	if (error)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int fsl_mc_uapi_dev_open(struct inode *inode, struct file
> > +*filep) {
> > +	struct fsl_mc_device *root_mc_device;
> > +	struct uapi_priv_data *priv_data;
> > +	struct fsl_mc_io *dynamic_mc_io;
> > +	struct fsl_mc_uapi *mc_uapi;
> > +	struct fsl_mc_bus *mc_bus;
> > +	int error;
> > +
> > +	priv_data =3D kzalloc(sizeof(*priv_data), GFP_KERNEL);
> > +	if (!priv_data)
> > +		return -ENOMEM;
> > +
> > +	mc_uapi =3D container_of(filep->private_data, struct fsl_mc_uapi, mis=
c);
> > +	mc_bus =3D container_of(mc_uapi, struct fsl_mc_bus, uapi_misc);
> > +	root_mc_device =3D &mc_bus->mc_dev;
> > +
> > +	mutex_lock(&mc_uapi->mutex);
> > +
> > +	if (!mc_uapi->local_instance_in_use) {
> > +		priv_data->mc_io =3D mc_uapi->static_mc_io;
> > +		mc_uapi->local_instance_in_use =3D true;
>=20
> You are setting a u32 to "true"?  The compiler did not complain?
>=20

Sorry for this, will fix. The compiler did not complain.. maybe I should up=
grade.

> And again, why is this needed, I don't understand the distinction.

I tried to answer this question above. We should know if the default MC por=
tal is in use so that we can allocate a new one if this the case.

>=20
> > +	} else {
> > +		error =3D fsl_mc_portal_allocate(root_mc_device, 0,
> > +					       &dynamic_mc_io);
> > +		if (error) {
> > +			pr_err("Could not allocate MC portal\n");
> > +			goto error_portal_allocate;
> > +		}
> > +
> > +		mc_uapi->dynamic_instance_count++;
>=20
> Why care about the "count"?

We can certainly live without it. It was mainly used as a debug counter to =
check of everything is freed properly.

>=20
>=20
> > +		priv_data->mc_io =3D dynamic_mc_io;
> > +	}
> > +	priv_data->uapi =3D mc_uapi;
> > +	filep->private_data =3D priv_data;
> > +
> > +	mutex_unlock(&mc_uapi->mutex);
> > +
> > +	return 0;
> > +
> > +error_portal_allocate:
> > +	mutex_unlock(&mc_uapi->mutex);
> > +
> > +	return error;
> > +}
> > +
> > +static int fsl_mc_uapi_dev_release(struct inode *inode, struct file
> > +*filep) {
> > +	struct uapi_priv_data *priv_data;
> > +	struct fsl_mc_uapi *mc_uapi;
> > +	struct fsl_mc_io *mc_io;
> > +
> > +	priv_data =3D filep->private_data;
> > +	mc_uapi =3D priv_data->uapi;
> > +	mc_io =3D priv_data->mc_io;
> > +
> > +	mutex_lock(&mc_uapi->mutex);
> > +
> > +	if (WARN_ON(!mc_uapi->local_instance_in_use &&
> > +		    mc_uapi->dynamic_instance_count =3D=3D 0)) {
> > +		mutex_unlock(&mc_uapi->mutex);
> > +		return -EINVAL;
>=20
> Never have a WARN_ON() on a path that userspace can generate, otherwise
> when you run with panic_on_warn enabled, you just crashed the machine.
>=20
> If this really is such a horrible error, do a "dev_warn()" and move on.
> But again, do not print something if userspace can trigger it all the tim=
e, that's a
> local DoS.

The entire WARN_ON can be removed. This could never happen.

>=20
>=20
> > +	}
> > +
> > +	if (mc_io =3D=3D mc_uapi->static_mc_io) {
> > +		mc_uapi->local_instance_in_use =3D false;
> > +	} else {
> > +		fsl_mc_portal_free(mc_io);
> > +		mc_uapi->dynamic_instance_count--;
> > +	}
> > +
> > +	kfree(filep->private_data);
> > +	filep->private_data =3D  NULL;
> > +
> > +	mutex_unlock(&mc_uapi->mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +static long fsl_mc_uapi_dev_ioctl(struct file *file,
> > +				  unsigned int cmd,
> > +				  unsigned long arg)
> > +{
> > +	struct uapi_priv_data *priv_data =3D file->private_data;
> > +	int error;
> > +
> > +	switch (cmd) {
> > +	case FSL_MC_SEND_MC_COMMAND:
> > +		error =3D fsl_mc_uapi_send_command(arg, priv_data->mc_io);
> > +		break;
> > +	default:
> > +		pr_err("%s: unexpected ioctl call number\n", __func__);
> > +		error =3D -EINVAL;
>=20
> dev_err()?  Same for all of your pr_* calls, use the dev_* calls instead.
>=20
> And again, this is something that userspace can easily trigger, do not sp=
am the
> logs with this type of message.  Make it dev_dbg() instead for your own
> debugging use.
>=20

Will do.

>=20
> > +	}
> > +
> > +	return error;
> > +}
> > +
> > +static const struct file_operations fsl_mc_uapi_dev_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D fsl_mc_uapi_dev_open,
> > +	.release =3D fsl_mc_uapi_dev_release,
> > +	.unlocked_ioctl =3D fsl_mc_uapi_dev_ioctl, };
> > +
> > +int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus) {
> > +	struct fsl_mc_device *mc_dev =3D &mc_bus->mc_dev;
> > +	struct fsl_mc_uapi *mc_uapi =3D &mc_bus->uapi_misc;
> > +	int error;
> > +
> > +	mc_uapi->misc.minor =3D MISC_DYNAMIC_MINOR;
> > +	mc_uapi->misc.name =3D dev_name(&mc_dev->dev);
> > +	mc_uapi->misc.fops =3D &fsl_mc_uapi_dev_fops;
> > +
> > +	error =3D misc_register(&mc_uapi->misc);
> > +	if (error)
> > +		return -EPROBE_DEFER;
>=20
> No, return the error given to you, don't eat it and make up a new one.

Ok. So the caller should make the decision to defer or not?

>=20
> > +
> > +	mc_uapi->static_mc_io =3D mc_bus->mc_dev.mc_io;
> > +
> > +	mutex_init(&mc_uapi->mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus) {
> > +	struct fsl_mc_uapi *mc_uapi =3D &mc_bus->uapi_misc;
> > +
> > +	if (WARN_ON(mc_uapi->local_instance_in_use))
> > +		return;
> > +
> > +	if (WARN_ON(mc_uapi->dynamic_instance_count !=3D 0))
> > +		return;
>=20
> Same comments as above on the WARN_ON(), don't do it.  make it
> dev_dbg() if you really just want to make sure your code is correct.  If =
it can
> happen "in the wild", then you need to refactor the code to prevent this =
from
> ever happening (hint, can it ever happen?  I don't think so but I might b=
e
> wrong...)

Yep, these are more paranoid checks and cannot ever happen. I will just rem=
ove them.=20

Will come back with a v3 to include the needed changes.

Thanks,
Ioana C

>=20
> thanks,
>=20
> greg k-h
