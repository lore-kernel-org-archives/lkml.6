Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AIpwx48+oghElHGMHV8IRuVftJj83LEcCwTgCd3PJNh7qTm82i4954YwR5OhnRJZYoq0xbbuyTK2
ARC-Seal: i=1; a=rsa-sha256; t=1522676778; cv=none;
        d=google.com; s=arc-20160816;
        b=A5tPtDykMwF45S53suc8DbJVUS+C7vCQZUBQwbILDAyN3uHmfFYMuyG+RWVeexBdhE
         Tdfn9dxzdKg85hZLPqoh2B0kffdhuE0x46Xjvl6W+yzb6677D1y3DflXJ8ahePa0Q+dp
         GQUtEFrz8cPMoiraEQVqihKYQ+KFNCeVdzaLSfZlVke+oo6saqlu2Rs5Bg8Tak3eflwW
         9IKkf0EyM7md49JdkTnaoy9o5rcNFLiLJ8JVyynpg5lRkpYxh4bNaYm6bi3K1TPyxlFL
         D2nK62lAKe7Xj6Wq7lHVqHnwW9URabqngicl199ABHvaDO/yu6j2s+7YJKX9u19kVSr7
         r4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=eW9thCxkYxU225AtNvcw/8HXV7nYxJpViolu8W9D1Bw=;
        b=m1VUIEtw+VxlHypOusIiebju0b5myBMaFX0TEofp3251K4PCewLHf/cxCWyQ7P6ap/
         OqS/mZ2+DuppfsuO0DyzG+Q6FHGx0HyJoXIAFlXfL+ZNRIIThogNNKclbhJ7mcCA38WC
         wr4GnUNb6SZXHD2oCgdP7DPm1eH2k8dkHZLF/bJWsxsM7zbnVH1FdYNign3mf472nI6K
         wpdzViTiAhyKtfZtrzKKNgVoXX+MCbqKXnjLEepltggz37iIkm3/bImYhnMSRybarqFW
         2yv4wOI0t3ydIWxwAQ6lDqvrycEp3IpjRF++0crJiBWpiW8b5JbKETY5BHKEyQ/amtgV
         kS/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=kXvsQInY;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.0.86 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=kXvsQInY;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.0.86 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>, Razvan Stefanescu <razvan.stefanescu@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>
Subject: RE: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Topic: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Thread-Index: AQHTwr0wQpewYSPXPk2gS/MBZ86FQqPd97CAgA+QFuA=
Date: Mon, 2 Apr 2018 13:46:13 +0000
Message-ID: <HE1PR04MB3212736F979C78C2269D9D6BE0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <2ea1db0e7d43255f8d13f6c3cb4ce3d12df89eef.1521818403.git.ioana.ciornei@nxp.com>
 <20180323154953.GC382@kroah.com>
In-Reply-To: <20180323154953.GC382@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3050;7:OAloT7W58cWx05AzQqBqnXhkzj7v8Zf04H/2kYWEjdJ47lUjnEQF/Y2yY6ZsyMv5D4fknSYTZ40Jfk7Hd0VrrfnJXGK4dITfx/kAyoBPyPII4Tv/Ey9emJl9fuXarF/F9BhAUuy/j2hO3e9P2H5q7PMU35FHpOYXeTZObmrhfFOMJ/KqMPvnWifGDfznDKzaMxz7alL6l6G6aSAfIWLf0ZDeHUVhtxWzlnS70UeWDXH5fbyAwjm+9iV246cpBufC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a5ce4cd-7c19-4e8b-d2d5-08d598a01abe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3050;
x-ms-traffictypediagnostic: HE1PR04MB3050:
x-microsoft-antispam-prvs: <HE1PR04MB3050B8F7BD46BB0FD5B9FE19E0A60@HE1PR04MB3050.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB3050;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3050;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(50944005)(199004)(189003)(76176011)(7696005)(4326008)(99286004)(105586002)(54906003)(2900100001)(59450400001)(6506007)(7736002)(305945005)(74316002)(39060400002)(5250100002)(14454004)(55016002)(446003)(316002)(478600001)(33656002)(6436002)(11346002)(3846002)(8676002)(68736007)(8936002)(81166006)(81156014)(25786009)(186003)(66066001)(97736004)(6246003)(3660700001)(3280700002)(106356001)(102836004)(2906002)(26005)(53936002)(6916009)(86362001)(229853002)(486005)(486005)(9686003)(6116002)(5660300001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3050;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9w6zJ64h+LYCrF7P9wfp3V3e0DXkMm5K8TkIjgWMDmgD7YQTbLNkZaMVaaFj5zqonJBgEqxq+fK3BQhpTi0a+TNDX3GoqTmEk29Sk89A3FQCmah7OwNa9uHWhoP+QAp2O6HKaFwmbnMzgdQOi9hTKrwe5fmRogYs0c4Iti+HoXdSnJRye8jcsRNH4xAUOMUMx9HybxJhZ1LEG7dCJPSAnMnG4ymxHQ5ePA6SiBmMA8fHi55GkXFiT1ToL+wkhJ+vDqLwvrrbeKhMdk3H5ExSMDGtYFyeFpLt+HcbZwMQEOPTFdwz/weWjgfgYt2aB+KBQyO4sY+K8OXlEWF4YGxdZ+qbcK1tZTO4diQpPfrf4eBb9QOKQr6pFbTa9f636Ef980F3ifQHoIFZ2yXdPII1j0H36WTLoB3VqzaYjHWWRe8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5ce4cd-7c19-4e8b-d2d5-08d598a01abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 13:46:13.9008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3050
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743505535969149?=
X-GMAIL-MSGID: =?utf-8?q?1596642326103699907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > Introduce the rescan attribute as a bus attribute to synchronize the
> > fsl-mc bus objects and the MC firmware.
> >
> > To rescan the fsl-mc bus, e.g.,
> > echo 1 > /sys/bus/fsl-mc/rescan
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v2:
> >   - added proper documentation in /Documentation/ABI/
> >   - updated the MAINTAINERS file
> > Changes in v3:
> >   - no change
> >
> >  Documentation/ABI/stable/sysfs-bus-fsl-mc |  7 +++++
> >  drivers/bus/fsl-mc/fsl-mc-bus.c           | 48
> +++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > index e530e8c..0663fbd 100644
> > --- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > +++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > @@ -4,3 +4,10 @@ KernelVersion:	4.16
> >  Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> >  Description:	Root dprc rescan attribute
> >  Users:		Userspace drivers and management tools
> > +
> > +What:		/sys/bus/fsl-mc/rescan
> > +Date:		March. 2018
> > +KernelVersion:	4.16
>=20
> Same comments as previous review.
>=20
> > +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> > +Description:	Bus rescan attribute
>=20
> Again, describe this better please.
>=20
> > +Users:		Userspace drivers and management tools
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > b/drivers/bus/fsl-mc/fsl-mc-bus.c index 9d02984..80010d1 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -172,11 +172,59 @@ static ssize_t rescan_store(struct device *dev,
> >
> >  ATTRIBUTE_GROUPS(fsl_mc_dev);
> >
> > +static int scan_fsl_mc_bus(struct device *dev, void *data) {
> > +	struct fsl_mc_device *root_mc_dev;
> > +	struct fsl_mc_bus *root_mc_bus;
> > +
> > +	if (!fsl_mc_is_root_dprc(dev))
> > +		goto exit;
> > +
> > +	root_mc_dev =3D to_fsl_mc_device(dev);
> > +	root_mc_bus =3D to_fsl_mc_bus(root_mc_dev);
> > +	mutex_lock(&root_mc_bus->scan_mutex);
> > +	dprc_scan_objects(root_mc_dev, NULL);
> > +	mutex_unlock(&root_mc_bus->scan_mutex);
> > +
> > +exit:
> > +	return 0;
> > +}
> > +
> > +static ssize_t bus_rescan_store(struct bus_type *bus,
> > +				const char *buf, size_t count)
> > +{
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 0, &val) < 0)
> > +		return -EINVAL;
> > +
> > +	if (val)
> > +		bus_for_each_dev(bus, NULL, NULL, scan_fsl_mc_bus);
> > +
> > +	return count;
> > +}
> > +static BUS_ATTR(rescan, 0220, NULL, bus_rescan_store);
>=20
> BUS_ATTR_RO()?
>=20
>=20

Since this is a write-only attribute, a BUS_ATTR_WO would be needed but the=
re is no WO macro defined.

Ioana

>=20
> > +
> > +static struct attribute *fsl_mc_bus_attrs[] =3D {
> > +	&bus_attr_rescan.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group fsl_mc_bus_group =3D {
> > +	.attrs =3D fsl_mc_bus_attrs,
> > +};
> > +
> > +static const struct attribute_group *fsl_mc_bus_groups[] =3D {
> > +	&fsl_mc_bus_group,
> > +	NULL,
> > +};
>=20
> ATTRIBUTE_GROUPS()?
>=20
> thanks,
>=20
> greg k-h
