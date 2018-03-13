Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELsBx/wkXhgEdaOeOFCeriIeQNzOQQH/0fWZRTUD341uwULm3v0pymHkVM2/31zAmj7zd0DV
ARC-Seal: i=1; a=rsa-sha256; t=1520935168; cv=none;
        d=google.com; s=arc-20160816;
        b=CCRWB+9lsrXwEq4k4UqIMPksljWFqfQB9npFa5CoP/LXDDhgcdmiLKL4Y96EcC9N/u
         S1QLovl73Ke9/AQTeQRJFmHriiVGaFGp0U3mr4o+11cU3ubrHxD8Np/6CmWSJuCZr9lh
         uP2RnsgXVWQy9WO6CdAgNDUJ9np/8/AIsS7ue7Wg+ng0JjfssffBbQN0wL+ATsLlDv1n
         x5ZbxexY0asK8Owa2Rnrq+J1MDUjxLD3JRP5CJRgM2Ek2InGVj+uUy1g4mXhv09jqr4B
         NAQbldTM0kqynGRuQExtVg/kYvG4/6qmzC3TutLPcLvZZoHmKE+srBCBeLlDjZLR6P4r
         gQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=7kDDKCxYl7EIHSHGsTnS1Ww5I8rXxEMSpGPU8zqxzkU=;
        b=pWHMz35nhn+Ia/7eTdImbzPPf3EFOWTOsC6UWZQ2oJ8VdVuufNQy9+Pf9IfQu6e0Fo
         sXaN+uaSrefk+9DgOBprGz02p25gUxNiSxGuBFLckUmbCvra2/q1koBV+/iDmfh2uvMt
         2+zPQjTY9nM3T7wilbPYxB0P2jMDB/zJ2bv47mvNELnQgrJnxhIbau3K/xLdf5Xu3FLW
         O9qJ1VW/x5THSXJ8PG1JYmbkAJnQPmXVr4GP9XkUWnmthuQIhG4A77iZ2J2MHd08RgRR
         ehRsJurGbzhPhN2nQjNaofShnLPjXTMrclm2CQVbRrxsNFeBgsCwwZnwNKpShNsHdxto
         K3rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=RPZU/qPf;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.0.80 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=RPZU/qPf;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.0.80 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: RE: [PATCH 2/3] bus: fsl-mc: add root dprc rescan attribute
Thread-Topic: [PATCH 2/3] bus: fsl-mc: add root dprc rescan attribute
Thread-Index: AQHTtjQeTz/978xKFUSK+pEJXTCmO6PITt+AgAWoUKA=
Date: Tue, 13 Mar 2018 09:59:23 +0000
Message-ID: <HE1PR04MB3212EDDC9D1BB2DD43476BFEE0D20@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1520440367.git.ioana.ciornei@nxp.com>
 <0705c56d5b4c4cf0b4d9bacbd160982f12c7f953.1520440367.git.ioana.ciornei@nxp.com>
 <20180309193429.GB20133@kroah.com>
In-Reply-To: <20180309193429.GB20133@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1516;6:jw0/zICWNafJFSEf2l3T2xa5xYL+oxyggonKGSEHVgZ+aiXPPFQrpA0n361bpEb1IyUf3I0Qi9eVeLWvERGxvO6B+FcLZMRWcaZ8Fnn8NSAA+rEcsaV3FLgtvBu2KsQpwF0BeoYh7sauWAhITxKo3eZDLBXfI7U23ml1zlBc8Mb6DuCIhwTal86/x5LVDChoRfSALlpUOvtxREpP7ztSKe9d66fmrJNPs/BecLw7+FW1AZNyjOEb0x65VwHWi34dAXlDYHkMnCYeJv4oTdznJRhiDiBUEZgmfmXyQUPREtziABqUjxQuB5ts+LzBEWt98zGOJ8pOf+m4Zv35BeGOmOnx/6bwN1v/81YT/p2fZb7JvyDe7jswbyUf2u3avZZm;5:qa//Y9rdg4C2ASBdPk1oKSkl7JLq3wR+JBMqAll0xzpRqpzHm9lmab/EPbrbcYhkPY3SRVXv1FYlaKeAkKSTWhGFjDcDv06JmH3klKZS/LwKkp8TwGfadWThp7oXJaZ5qfxlN+PEdqVfzxzvR8P9HTNKYGr1cDZ8JBVB+OFap9g=;24:cGfvrZQfBvr4Vl9KDYqLfNtmH7XB726pBNf4xMkaS1DzoIAruETYNxW5xnwvH0Mg5j+1gH4m1KBn5huLalCecpGluqUsme4SFCnjnD3UiEs=;7:U75K5sntczfRwILVUypvmCreIfiHRzQUFnN6GtivJO/IQLlo2FEZHyGAxirtzEB33U6FhWaqfB9PRbJTsDG8q4QlJcRrdXQE5dkZH0SftG6hWV0HN+hSgYGXgUGtZ3Nyhpqb8HaYiFZasl/PQiQdoBliTcV7MjCONka+6uFOPLIVbZQ/LlA9ZgTx+IaMamQoAJQUEM3U/DCBowCRm9gL2QTFfbeW8m23DrCBC99/ti3eNe5cFjD1mBz9XTwXYp64
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(14454004)(99286004)(81166006)(2906002)(4326008)(39060400002)(25786009)(53936002)(3280700002)(8676002)(54906003)(6246003)(6436002)(68736007)(55016002)(5250100002)(81156014)(33656002)(74316002)(3660700001)(6116002)(3846002)(8936002)(305945005)(9686003)(5660300001)(105586002)(7736002)(2950100002)(186003)(6916009)(66066001)(97736004)(7696005)(229853002)(76176011)(106356001)(86362001)(478600001)(26005)(102836004)(2900100001)(316002)(59450400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1516;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2fd4bcb-4a0c-4eb4-0769-08d588c9195e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1516;
x-ms-traffictypediagnostic: HE1PR04MB1516:
x-microsoft-antispam-prvs: <HE1PR04MB1516B22C96B00FDDB95575F8E0D20@HE1PR04MB1516.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1516;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1516;
x-forefront-prvs: 0610D16BBE
x-microsoft-antispam-message-info: /swIX62THuGrKhprNiCnyJtLhvADiZetYj2tlBx197Odinz+UTzK1qRp5wI1h2nsPxOykgHqTq58Hp4/0jWNHtGvsDiXrDub/M/RrDKspCg2uFGFWM3DUAikcRMnYsKY79yx5gYyFUZ7KN/gyo80oCcej3s7yB/mO/TaHHC7qXEnE74qHAXbxHOeHl2yY4pQyTiRAtoTIXYp8QUw36xbVW9yIpBDkB/a30UKSgayzO7Ita19OpadLnguGIeRgAlIlI6w2IZ4P0Roy04MUU6ZKGfcmS1HGlUqNHYcS+JZ/A3+PGQJMazfHvxz5IT6nSFFgbx62ulFf6rbBipNspMbgA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fd4bcb-4a0c-4eb4-0769-08d588c9195e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 09:59:23.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1516
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298564594377895?=
X-GMAIL-MSGID: =?utf-8?q?1594816114888553541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> > Introduce the rescan attribute as a device attribute to synchronize
> > the fsl-mc bus objects and the MC firmware.
> >
> > To rescan the root dprc only, e.g.
> > echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  drivers/bus/fsl-mc/dprc-driver.c    |  4 ++--
> >  drivers/bus/fsl-mc/fsl-mc-bus.c     | 28 ++++++++++++++++++++++++++++
> >  drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
> >  3 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/dprc-driver.c
> > b/drivers/bus/fsl-mc/dprc-driver.c
> > index 52c7e15..be80e3a 100644
> > --- a/drivers/bus/fsl-mc/dprc-driver.c
> > +++ b/drivers/bus/fsl-mc/dprc-driver.c
> > @@ -214,8 +214,8 @@ static void dprc_add_new_devices(struct
> fsl_mc_device *mc_bus_dev,
> >   * populated before they can get allocation requests from probe callba=
cks
> >   * of the device drivers for the non-allocatable devices.
> >   */
> > -static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
> > -			     unsigned int *total_irq_count)
> > +int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
> > +		      unsigned int *total_irq_count)
> >  {
> >  	int num_child_objects;
> >  	int dprc_get_obj_failures;
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > b/drivers/bus/fsl-mc/fsl-mc-bus.c index 240b99d..763cbeb 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -137,8 +137,36 @@ static ssize_t modalias_show(struct device *dev,
> > struct device_attribute *attr,  }  static DEVICE_ATTR_RO(modalias);
> >
> > +static ssize_t rescan_store(struct device *dev,
> > +			    struct device_attribute *attr,
> > +			    const char *buf, size_t count) {
> > +	struct fsl_mc_device *root_mc_dev;
> > +	struct fsl_mc_bus *root_mc_bus;
> > +	unsigned long val;
> > +
> > +	if (!fsl_mc_is_root_dprc(dev))
> > +		return -EINVAL;
> > +
> > +	root_mc_dev =3D to_fsl_mc_device(dev);
> > +	root_mc_bus =3D to_fsl_mc_bus(root_mc_dev);
> > +
> > +	if (kstrtoul(buf, 0, &val) < 0)
> > +		return -EINVAL;
> > +
> > +	if (val) {
> > +		mutex_lock(&root_mc_bus->scan_mutex);
> > +		dprc_scan_objects(root_mc_dev, NULL);
> > +		mutex_unlock(&root_mc_bus->scan_mutex);
> > +	}
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(rescan);
>=20
> You did not add the correct new documentation in Documentation/ABI/ for
> the new sysfs attributes you are creating.  Please do so as part of this =
patch
> series.

Sorry for that. Will add the proper Documentation in the next version.

Ioana

>=20
> thanks,
>=20
> greg k-h
