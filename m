Return-Path: <bogdan.purcareata@nxp.com>
X-Google-Smtp-Source: AG47ELvzijEdorroqnc2RrIUL2XWEJ18/wOI/MmIcOV6Ho3BXk6jD4hBgAyyJt9Fn6TcQ82xB0+f
ARC-Seal: i=1; a=rsa-sha256; t=1519984554; cv=none;
        d=google.com; s=arc-20160816;
        b=LJcjpguZjwST4MvBln4dA89GnHAAvWchqFc8hSBLrg7z+mhocroAXGB1MwV9SA0y9e
         XeGmiG/3qLtIXcQhTX+VINc+fnkiLWywFm7L9lgOaQ5mUUHms9VKnIt25cKDfMwf+VHB
         g8OrKYl6UC9Oiw4/56vaSklg4Jp27ItvZpjCi151GqeFPCe2ezHx68c+v6FPQVRh7+C3
         bpkNO5SsibHfcdqxKQmUdJoC9IVCWrHkawzZrlsxaUFfOgTwG5nhQl6JViIKl4t2UGv2
         pF8mhaWgAgazE9QRKKJlrQ9n2QFyDZmYY8/51y6JsR26kRsPHvq2+kqCjWEaOPmSDpKX
         1wtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Jk2aCq5/WVeaA+XRjWiuZXQusNipYLLwfsmTi6Wl5rI=;
        b=r9O82dHU1/mOKFez/QlI5bcPShUhr17/6D7vh23r3Getal0rFLTHTOheA0/1JnfKbv
         Rj6XzhwSTQqpughHZqutjA7664FFA2o6nwli4luZAZOS8i4RPYc7t/S7f7Pmp5Rv78j5
         WA+GQ3bZvVUoxMfn0y/GDx1zDMsHz8Eia1hm2H9+xvhZGPHwbsEiGVq5S4JaUlMAwEVy
         xdDH61PumDqK7BKhYBhesPu+KrCLcb0gQcyHm7Z1Fjs00hZrRY8k2uaAmiafQx80JNSJ
         +gQlBaJZncSl6/7b0Nux74qQE+8hjUNhUAQtd2smVdczBwpOw4K0ubWmlbw+etPMBHrO
         McAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UaqeoGF0;
       spf=pass (google.com: domain of bogdan.purcareata@nxp.com designates 40.107.5.60 as permitted sender) smtp.mailfrom=bogdan.purcareata@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=UaqeoGF0;
       spf=pass (google.com: domain of bogdan.purcareata@nxp.com designates 40.107.5.60 as permitted sender) smtp.mailfrom=bogdan.purcareata@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>
CC: "stuyoder@gmail.com" <stuyoder@gmail.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>, =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
Thread-Topic: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
Thread-Index: AQHTsYVts6v1kMgvV0a/7f34+gySWaO8q6SAgAAKSEA=
Date: Fri, 2 Mar 2018 09:55:43 +0000
Message-ID: <AM0PR0402MB364957B0E5A21228C1D8BD1DEAC50@AM0PR0402MB3649.eurprd04.prod.outlook.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
 <20180301174712.2660-3-bogdan.purcareata@nxp.com> <5A9916C0.6090804@nxp.com>
In-Reply-To: <5A9916C0.6090804@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3570;7:dd09A1s7Vu0Um/8sUGPTzrovieBYLKiOzMkkY7kymyTZNFY6/4K4oAoLJwvKm5nHaDA7KSrafVHKV10AxLCsv3CsFPb5OQkxtq9DyBikOB5XWboG44HiHDsVQPM/HvYOt14DD5uZaSv6aYC3QfF1cS60/IVbMDg/FFNrd8JuaWev2ZVdV33ip1dQxZ4KfFxg4x/RHVgdXGkRy/BqGYDUITZQ098igiiyq9i8l/8ERcqkg8QcQScREHo7CYbFiiJp
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(39380400002)(376002)(346002)(13464003)(189003)(199004)(316002)(6246003)(68736007)(86362001)(3660700001)(97736004)(74316002)(26005)(102836004)(6506007)(53546011)(59450400001)(305945005)(3846002)(106356001)(6116002)(7736002)(33656002)(5250100002)(2501003)(229853002)(478600001)(2950100002)(2900100001)(6636002)(14454004)(2906002)(105586002)(25786009)(4326008)(9686003)(54906003)(81156014)(99286004)(66066001)(3280700002)(39060400002)(76176011)(81166006)(110136005)(5660300001)(8936002)(53936002)(7696005)(8676002)(6436002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3570;H:AM0PR0402MB3649.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 638cf9d6-5085-4bda-819d-08d58023c3a9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM0PR0402MB3570;
x-ms-traffictypediagnostic: AM0PR0402MB3570:
x-microsoft-antispam-prvs: <AM0PR0402MB3570FC88C306EB4C72CF5D65EAC50@AM0PR0402MB3570.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501237)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR0402MB3570;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3570;
x-forefront-prvs: 05991796DF
x-microsoft-antispam-message-info: 5my4TEDRI2AHjJ6hxWoNR3ZJdNds2uvtlvvmoCi5GeGQJqPesgahYD9lOx3vBGJkxNcrt5vh2hLOU2PdHRV9AtsqxQrW4xLABM69SIBfGK018EtgGz9/wYwU5LsIX+YyZXggYXj0ooSsW/sl7xzfgrpkE67pxfbATeWIXSa0XSY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638cf9d6-5085-4bda-819d-08d58023c3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 09:55:43.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3570
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593758425788529784?=
X-GMAIL-MSGID: =?utf-8?q?1593819323993137042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Friday, March 02, 2018 11:18 AM
> To: Bogdan Purcareata <bogdan.purcareata@nxp.com>; gregkh@linuxfoundation=
.org;
> Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: stuyoder@gmail.com; Ioana Ciornei <ioana.ciornei@nxp.com>; Nipun Gupt=
a
> <nipun.gupta@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; Horia Geant=E3
> <horia.geanta@nxp.com>; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
>=20
> Hi Bogdan,
>=20
> On 03/01/2018 07:47 PM, Bogdan Purcareata wrote:
> > Move the source files out of staging into their final locations:
> > - dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
> > - dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
> >    to the other internally used APIs
> > - dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
> >    API
> >
> > Update references in the dpaa2-eth staging driver.
> >
> > DPBP stands for Data Path Buffer Pool - you can read more about the
> > object in Documentation/networking/dpaa2/overview.rst
> >
> > Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/Makefile                       |  1 +
> >   drivers/{staging/fsl-mc/bus =3D> bus/fsl-mc}/dpbp.c |  4 +-
> >   drivers/bus/fsl-mc/fsl-mc-private.h               | 39 ++++++++++++++=
+++
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
> >   drivers/staging/fsl-mc/bus/Makefile               |  3 +-
> >   drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 --------------=
-----
> >   drivers/staging/fsl-mc/include/dpbp.h             | 53 --------------=
------
> ---
> >   include/linux/fsl/mc.h                            | 42 ++++++++++++++=
++++
> >   8 files changed, 86 insertions(+), 102 deletions(-)
> >   rename drivers/{staging/fsl-mc/bus =3D> bus/fsl-mc}/dpbp.c (98%)
> >   delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
> >   delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
> >
> > diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> > index 6a97f2c..da26e52 100644
> > --- a/drivers/bus/fsl-mc/Makefile
> > +++ b/drivers/bus/fsl-mc/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) +=3D mc-bus-driver.o
> >   mc-bus-driver-objs :=3D fsl-mc-bus.o \
> >   		      mc-sys.o \
> >   		      mc-io.o \
> > +		      dpbp.o \
> >   		      dprc.o \
> >   		      dprc-driver.o \
> >   		      fsl-mc-allocator.o \
> > diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpb=
p.c
> > similarity index 98%
> > rename from drivers/staging/fsl-mc/bus/dpbp.c
> > rename to drivers/bus/fsl-mc/dpbp.c
> > index 85735bb..31a360b 100644
> > --- a/drivers/staging/fsl-mc/bus/dpbp.c
> > +++ b/drivers/bus/fsl-mc/dpbp.c
> > @@ -5,9 +5,9 @@
> >    */
> >   #include <linux/kernel.h>
> >   #include <linux/fsl/mc.h>
> > -#include "../include/dpbp.h"
> > +#include "linux/fsl/mc.h"
>=20
> I think we can use <> here, same comment for patch 3/3.
>=20
> Other than that, the series looks ok to me so for all the patches:
>=20
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thank you!
I will update the patchset - seeing that the cleanup one has already been a=
pplied - and will send a v2 shortly.

Best regards,
Bogdan
