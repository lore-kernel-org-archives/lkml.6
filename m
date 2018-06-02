Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFBGa0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:30:26 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:61536
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750750AbeFBGaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:30:22 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Topic: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Index: AQHT9cpODr9QzRxb9Emq6LXLM2SHNqRDrwmAgAAB1nCAAAQGgIAH8XWAgADhDqA=
Date: Sat, 2 Jun 2018 06:30:19 +0000
Message-ID: <HE1PR0502MB3753C365AA5F961AC6D79D5AA2610@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1527439664-127317-1-git-send-email-vadimp@mellanox.com>
 <20180527151347.GA15487@kroah.com>
 <HE1PR0502MB375324E5F279A2733339365FA26F0@HE1PR0502MB3753.eurprd05.prod.outlook.com>
 <20180527153445.GA11051@kroah.com>
 <20180601165247.GB3599@localhost.localdomain>
In-Reply-To: <20180601165247.GB3599@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3017;7:NjosWP8nTHQxlW5WaH5QLwmyWw1ochATEAyKWDkNjBbZos/M3WGnL7D1u/9CMSCYOSGi7w8fwSnu2VPUvaYkPvPw7DLOLJpcoZfP0mckcmJwlPaUhYDjfaIj5IJN0Vcqh0ouZWEx1jbT93mjtz5Sp8NQCohbcsKERHCdqYlZhDmDCyL9Q//SG58saU4kZCwcFoiIV3NDbwm4/nNaSP9gSbKvE+0w0D7NoT1m7pli3Dx6cUt0OAgqrHlxHWqmF1TD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3017;
x-ms-traffictypediagnostic: HE1PR0502MB3017:
x-microsoft-antispam-prvs: <HE1PR0502MB30178172EC62B834CF8AD85EA2610@HE1PR0502MB3017.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB3017;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3017;
x-forefront-prvs: 06911FE69E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(13464003)(199004)(189003)(97736004)(229853002)(55016002)(476003)(486006)(68736007)(2900100001)(76176011)(478600001)(14454004)(59450400001)(53546011)(3846002)(6116002)(99286004)(86362001)(186003)(7696005)(6506007)(2906002)(106356001)(81156014)(8676002)(105586002)(316002)(7736002)(4326008)(74316002)(6436002)(5250100002)(8936002)(26005)(102836004)(54906003)(110136005)(81166006)(93886005)(66066001)(9686003)(3660700001)(6246003)(5660300001)(53936002)(11346002)(39060400002)(305945005)(25786009)(3280700002)(33656002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3017;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2xwAh6syn1q2JOqTftV4f7+hRxosGtX5YKzammIjNHqf2cajGYgHN8d7Xb5y73r96XvBvCOwOpnaIBe0TTqLWbOFzil4NbGwYkyEd+zWOKbiRw8R6gupyiUx+m5jMO9ZazC0alcpPslGM04LGc8xPcI/SOCsz8ziNb0yhG4YaJVjhETQWoSAl8xE3rFiRy5n
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e8fe5516-c9d3-429b-433c-08d5c8524fef
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fe5516-c9d3-429b-433c-08d5c8524fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2018 06:30:19.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526UV2J004041



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, June 01, 2018 7:53 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: Vadim Pasternak <vadimp@mellanox.com>; andy.shevchenko@gmail.com;
> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> jiri@resnulli.us; Michael Shych <michaelsh@mellanox.com>;
> ivecera@redhat.com
> Subject: Re: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
> register access driver
> 
> On Sun, May 27, 2018 at 05:34:45PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, May 27, 2018 at 03:22:06PM +0000, Vadim Pasternak wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Sunday, May 27, 2018 6:14 PM
> > > > To: Vadim Pasternak <vadimp@mellanox.com>
> > > > Cc: dvhart@infradead.org; andy.shevchenko@gmail.com; linux-
> > > > kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> > > > jiri@resnulli.us; Michael Shych <michaelsh@mellanox.com>;
> > > > ivecera@redhat.com
> > > > Subject: Re: [PATCH v3 6/7] platform/mellanox: Introduce support
> > > > for Mellanox register access driver
> > > >
> > > > On Sun, May 27, 2018 at 04:47:43PM +0000, Vadim Pasternak wrote:
> > > > > Introduce new Mellanox platform driver to allow access to
> > > > > Mellanox programmable device register space trough sysfs interface.
> > > > > The driver purpose is to provide sysfs interface for user space
> > > > > for the registers essential for system control and monitoring.
> > > > > The sets of registers for sysfs access are supposed to be
> > > > > defined per system type bases and include the registers related
> > > > > to system resets operation, system reset causes monitoring and some
> kinds of mux selection.
> > > > >
> > > > > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > > > > ---
> > > > > v1->v2:
> > > > >  Changed added by Vadim:
> > > > >  - Change ---help--- to help in Kconfig, according to new
> > > > > requirements;
> > > > > v2->v3:
> > > > >  Comments pointed out by Darren:
> > > > >  - Remove conditional assignment per attribute mode type, because
> mode
> > > > >    will guard against not permitted access.
> > > > >    Verified by Vadim.
> > > > > ---
> > > > >  drivers/platform/mellanox/Kconfig     |  11 ++
> > > > >  drivers/platform/mellanox/Makefile    |   1 +
> > > > >  drivers/platform/mellanox/mlxreg-io.c | 203
> > > > > ++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 215 insertions(+)  create mode 100644
> > > > > drivers/platform/mellanox/mlxreg-io.c
> > > > >
> > > > > diff --git a/drivers/platform/mellanox/Kconfig
> > > > > b/drivers/platform/mellanox/Kconfig
> > > > > index 591bccd..ddfae9fc 100644
> > > > > --- a/drivers/platform/mellanox/Kconfig
> > > > > +++ b/drivers/platform/mellanox/Kconfig
> > > > > @@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
> > > > >  	  This driver handles hot-plug events for the power suppliers, power
> > > > >  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
> > > > >
> > > > > +config MLXREG_IO
> > > > > +	tristate "Mellanox platform register access driver support"
> > > > > +	depends on REGMAP
> > > > > +	depends on HWMON
> > > > > +	help
> > > > > +	  This driver allows access to Mellanox programmable device
> register
> > > > > +	  space trough sysfs interface. The sets of registers for sysfs
> access
> > > > > +	  are defined per system type bases and includes the registers
> related
> > > > > +	  to system resets operation, system reset causes monitoring
> and some
> > > > > +	  kinds of mux selection.
> > > >
> > > > No Documentation/ABI/ entries for these new sysfs files?  Not good
> > > > :(
> > > >
> > >
> > > Thanks Greg for your comment.
> > >
> > > Should I call doc file like:
> > > Documentation/ABI/stable/sysfs-driver-mlxreg-io
> > > ?
> >
> > What ever matches the naming scheme for the driver, yes.
> 
> Vadim, I'm happy to help out with the docs if you like.
> 
> Will you be able to document this in a static way, or is this likely to change
> significantly from platform to platform? I ask because of the automated
> attribute creation in the code.
> 
> 
Hi Darren,

Will be great if you can help.
I actually already sent next version of patch with this file.
It'll be not have significant differences  between the different
platforms. However it'll be not the same.
I didn't mention I my file the systems for which the particular
attributes are relevant.

Thanks,
Vadim.

> --
> Darren Hart
> VMware Open Source Technology Center
