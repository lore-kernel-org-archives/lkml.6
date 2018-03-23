Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELu01sUmGrpKZ/ManiDjNhXcm9/kMwQ9Dq9x4xEFHgUTSfOK3fcZhL1NSqXQy4QFtFsmT/yu
ARC-Seal: i=1; a=rsa-sha256; t=1521820863; cv=none;
        d=google.com; s=arc-20160816;
        b=sMcqiUlp/ZBkDF5HdxrH44HoCBDpBarSWcY4p/3ToXiFwj1rDd2n2iZsH6bFUSWfmh
         ciHXTK1/WLxkfKrjrHmntnNyNnPfJGR/fpp5RaOVhaiUbPx3RJZER2PLoMQWz15h1aHH
         jZfp324QE43EaWHBhz0W9TkkyquHzLtlVwvX9jRyspX8c/5o4jeSb26LlMdyiDLbIM+6
         x822f0VGGQE9jIXQjzPHT392cSwCUR0UeVIKHXPYw/kWcoyxDUyWYJ0dAIaEexLPwpnS
         STRicAkN8DlvXz9VD1JiiaZeOBg+i861hPEEcYpn34vMwnDlqP17aD1zoBogup45rVk0
         G9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=yAyBBFXfjaxWGvdtUR9TdDaISVtDwnOmDAqe9GaiBjk=;
        b=k9lNexDKqRI1+qCgRQ7NAAhDS/S5xf1dNQEH3OO6QGK5oyhaHxvhYvK6JgpGTheI4r
         1VQt33yZ6tLI1YJtkf4m/V31sg5pl7G0c9POgo5Is6QL8yF6Z0wGicwQoI2PaE2+Mo6g
         fr1Lq03H1b9f+lgLtXoZvAopMpo0eu4oH2h/Tpcd2HBtWaYVxroqemJ/U0s7ydnfO1FY
         e+lMn4WijhZ8+cekIguPVoJHaJfA6boJ1ldf2u0oGuoeeN7CLitjPS0xfNJZV3C1g0su
         oO19BRnKeFQpbFQr30vCnzlEvuWimRkDS4ITCj9tXdmXf8x1JpRcO4jjVokOYL1D4lRc
         QPNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bYfrkJ6H;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.0.78 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bYfrkJ6H;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.0.78 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>, Razvan Stefanescu <razvan.stefanescu@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>
Subject: RE: [PATCH v3 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Topic: [PATCH v3 3/4] bus: fsl-mc: add root dprc rescan attribute
Thread-Index: AQHTwr0u4Np2wZs43UCrIWnz74n4aKPd9zgAgAADJ+A=
Date: Fri, 23 Mar 2018 16:00:58 +0000
Message-ID: <HE1PR04MB321264B6F966E05777881CF7E0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <7d4c4463871d4129c6c062265d83d886432af6aa.1521818403.git.ioana.ciornei@nxp.com>
 <20180323154812.GB382@kroah.com>
In-Reply-To: <20180323154812.GB382@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1001;7:GkwI9QO/m8mXIilZlHxS9nK3xS6wH57ccbyTi10rGLLGHOfmOQHKTj+OcmpB3ZhM6OlhsBe32AFAV1+2tWgnZcU/v8iV18GI8fjrGiv9xQVOyMFSd+KnLdCaGFQj2gfthvv7gxzPWOgflgQ2/NFHbcgt5MYBWyoGmlXdljUTb6nspag9VQlzuO+Hs00/EwjZH9RRMWst/ltGcBcv4TUlLDhoeIjy37mMMgMywdnRwVmXsolpqmz//yLakQr4vORe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 547a4a11-462e-4cc5-f2ec-08d590d744de
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1001;
x-ms-traffictypediagnostic: HE1PR04MB1001:
x-microsoft-antispam-prvs: <HE1PR04MB1001A8D430B5CDDEE4B97DCDE0A80@HE1PR04MB1001.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB1001;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1001;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(376002)(39860400002)(346002)(50944005)(199004)(189003)(66066001)(39060400002)(33656002)(76176011)(106356001)(59450400001)(74316002)(5660300001)(99286004)(7696005)(305945005)(97736004)(54906003)(105586002)(11346002)(2900100001)(5250100002)(4326008)(316002)(7736002)(6916009)(6246003)(25786009)(6506007)(229853002)(9686003)(8676002)(81166006)(81156014)(8936002)(53936002)(6436002)(2906002)(102836004)(26005)(3280700002)(55016002)(186003)(3846002)(6116002)(446003)(68736007)(86362001)(3660700001)(14454004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1001;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zrzqzzn6hV55I4o1UtvGcSPStTITEom3AGAmQmGeSCV8RYKjV6gHn+/BsJh4K6xzmaksJK3pzfsS/bDMARkbbWrIuObAGOfkPdPVln+UT0HTjoY8beJ0wOmbnt/AaCmURqlxxwUj4T3UqCiS7Bm3TF6EU/VV5npX8qU/QT+NdAxzFKBpoLvVLGoH6KqcS41BKddWKMEepcuMu61zxbHzPeflxaaEDgZyzAi5GyIVY7M7KKYPAfbrwPTIbFqhFGc7l0C24NTjgncGBCHzx435GlDuL5sd7Al87lPYqO0PoQUrXRGcPQ87ef4Rn6B1cgundCH5FLIQnqxCYHF2xetOQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547a4a11-462e-4cc5-f2ec-08d590d744de
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 16:00:58.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743500993999304?=
X-GMAIL-MSGID: =?utf-8?q?1595744833922252064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Fri, Mar 23, 2018 at 10:38:57AM -0500, Ioana Ciornei wrote:
> > Introduce the rescan attribute as a device attribute to synchronize
> > the fsl-mc bus objects and the MC firmware.
> >
> > To rescan the root dprc only, e.g.
> > echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan
> >
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v2:
> >   - added proper documentation in /Documentation/ABI/
> >   - updated the MAINTAINERS file
> > Changes in v3:
> >   - no change
> >
> >  Documentation/ABI/stable/sysfs-bus-fsl-mc |  6 ++++++
> >  MAINTAINERS                               |  1 +
> >  drivers/bus/fsl-mc/dprc-driver.c          |  4 ++--
> >  drivers/bus/fsl-mc/fsl-mc-bus.c           | 28 +++++++++++++++++++++++=
+++++
> >  drivers/bus/fsl-mc/fsl-mc-private.h       |  3 +++
> >  5 files changed, 40 insertions(+), 2 deletions(-)  create mode 100644
> > Documentation/ABI/stable/sysfs-bus-fsl-mc
> >
> > diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > new file mode 100644
> > index 0000000..e530e8c
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
> > @@ -0,0 +1,6 @@
> > +What:		/sys/bus/fsl-mc/devices/dprc.*/rescan
> > +Date:		March. 2018
>=20
> "."?
>=20
> > +KernelVersion:	4.16
>=20
> 4.17 :)

Sorry for this. Will fix.

>=20
> > +Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
> > +Description:	Root dprc rescan attribute
>=20
> What does this do?  A bit more description please.

Will update the description in the next version for both attributes.
>=20
> thanks,
>=20
> greg k-h
