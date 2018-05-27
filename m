Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032784AbeE0PWN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:22:13 -0400
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:45236
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032595AbeE0PWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:22:11 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "dvhart@infradead.org" <dvhart@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
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
Thread-Index: AQHT9cpODr9QzRxb9Emq6LXLM2SHNqRDrwmAgAAB1nA=
Date: Sun, 27 May 2018 15:22:06 +0000
Message-ID: <HE1PR0502MB375324E5F279A2733339365FA26F0@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1527439664-127317-1-git-send-email-vadimp@mellanox.com>
 <20180527151347.GA15487@kroah.com>
In-Reply-To: <20180527151347.GA15487@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3692;7:4CTw17nUTtTnUAvThoM7/anrlVJIj6gw74UimXkHSEfAp/5DLgLiz209Syi1y3F718jisyMDAI8npuJ89eXfuP2y8zoKkW24OtznVobfyjil+eAQcf+6riDUnNQ5kRQA5Swh6xwL3sAOAPAD8RafFmbEhuwXc8aqlhE2YF2Byg0FKNr8uUtOY9wsZEPysgKSrm13lju5+DWXpa0VNXo0H9UaWqDQSOb5oC2TTN2wVSlpYEjByVUA65VgK6stw6jx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3692;
x-ms-traffictypediagnostic: HE1PR0502MB3692:
x-microsoft-antispam-prvs: <HE1PR0502MB36925F693C3B0A4E5E282C4AA26F0@HE1PR0502MB3692.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB3692;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3692;
x-forefront-prvs: 0685122203
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39380400002)(39860400002)(396003)(13464003)(199004)(189003)(66066001)(11346002)(229853002)(3660700001)(316002)(54906003)(14454004)(476003)(6246003)(39060400002)(446003)(5250100002)(186003)(3280700002)(486006)(2900100001)(33656002)(97736004)(478600001)(59450400001)(305945005)(53546011)(9686003)(6506007)(25786009)(102836004)(81156014)(7736002)(99286004)(8676002)(26005)(6436002)(3846002)(2906002)(74316002)(6116002)(86362001)(55016002)(7696005)(81166006)(5660300001)(4326008)(76176011)(8936002)(53936002)(6916009)(68736007)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3692;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YHPxnMS2tGjam79MMdZxPfTKdJBvzDfwLyeZd+wHT4is6KphN+J5kvJFOVBxTRCj5P+xrA67u4JwiK48NOe19Kz/FQYxx2LV6Y61Kc3ULATq+5q7n11w0X3n77mMSLnsrCV9jVlxGHObmuXE0Dn3goJrQHM7PeVNQLnum+m7JQqF7PXVsgUzmPOCw2xdo4fj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b418c29d-6792-4826-71d5-08d5c3e59bb5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b418c29d-6792-4826-71d5-08d5c3e59bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2018 15:22:06.8829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3692
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4RFNHGE007658



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Sunday, May 27, 2018 6:14 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: dvhart@infradead.org; andy.shevchenko@gmail.com; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v3 6/7] platform/mellanox: Introduce support for Mellanox
> register access driver
> 
> On Sun, May 27, 2018 at 04:47:43PM +0000, Vadim Pasternak wrote:
> > Introduce new Mellanox platform driver to allow access to Mellanox
> > programmable device register space trough sysfs interface.
> > The driver purpose is to provide sysfs interface for user space for
> > the registers essential for system control and monitoring.
> > The sets of registers for sysfs access are supposed to be defined per
> > system type bases and include the registers related to system resets
> > operation, system reset causes monitoring and some kinds of mux selection.
> >
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > ---
> > v1->v2:
> >  Changed added by Vadim:
> >  - Change ---help--- to help in Kconfig, according to new
> > requirements;
> > v2->v3:
> >  Comments pointed out by Darren:
> >  - Remove conditional assignment per attribute mode type, because mode
> >    will guard against not permitted access.
> >    Verified by Vadim.
> > ---
> >  drivers/platform/mellanox/Kconfig     |  11 ++
> >  drivers/platform/mellanox/Makefile    |   1 +
> >  drivers/platform/mellanox/mlxreg-io.c | 203
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 215 insertions(+)
> >  create mode 100644 drivers/platform/mellanox/mlxreg-io.c
> >
> > diff --git a/drivers/platform/mellanox/Kconfig
> > b/drivers/platform/mellanox/Kconfig
> > index 591bccd..ddfae9fc 100644
> > --- a/drivers/platform/mellanox/Kconfig
> > +++ b/drivers/platform/mellanox/Kconfig
> > @@ -23,4 +23,15 @@ config MLXREG_HOTPLUG
> >  	  This driver handles hot-plug events for the power suppliers, power
> >  	  cables and fans on the wide range Mellanox IB and Ethernet systems.
> >
> > +config MLXREG_IO
> > +	tristate "Mellanox platform register access driver support"
> > +	depends on REGMAP
> > +	depends on HWMON
> > +	help
> > +	  This driver allows access to Mellanox programmable device register
> > +	  space trough sysfs interface. The sets of registers for sysfs access
> > +	  are defined per system type bases and includes the registers related
> > +	  to system resets operation, system reset causes monitoring and some
> > +	  kinds of mux selection.
> 
> No Documentation/ABI/ entries for these new sysfs files?  Not good :(
> 

Thanks Greg for your comment.

Should I call doc file like:
Documentation/ABI/stable/sysfs-driver-mlxreg-io
?

> greg k-h
