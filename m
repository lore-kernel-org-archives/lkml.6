Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755167AbeE2HwK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:52:10 -0400
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:45063
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755076AbeE2HwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:52:07 -0400
From: Peng Fan <peng.fan@nxp.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC] platform: detach from PM domains on shutdown
Thread-Topic: [RFC] platform: detach from PM domains on shutdown
Thread-Index: AQHT7CrPBBBLFSj2dES+Rs6FNBbw8qQyHuOAgADENwCAAE+14IAAXz4AgAASkBCAAX4QAIAADy7ggA+pc8CAAAjuAIABhwyA
Date: Tue, 29 May 2018 07:52:00 +0000
Message-ID: <HE1PR04MB30046668C9F4FFAB5C07E693886D0@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180515090110.26820-1-peng.fan@nxp.com>
 <HE1PR04MB30041C742230314926032D4D88900@HE1PR04MB3004.eurprd04.prod.outlook.com>
 <HE1PR04MB300481B481F96F875DCBFB2B886E0@HE1PR04MB3004.eurprd04.prod.outlook.com>
 <3452357.3GIrXi3WAv@aspire.rjw.lan>
In-Reply-To: <3452357.3GIrXi3WAv@aspire.rjw.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1643;7:4K7J8NB/JDlhIZOXzrnqkIcLEE5WjQXTLhSqeE5lGErv+d+zv8y4Mt91WT/jlJ+9zaZ94gilCE+U5Ig2lDG/YsrrL3BGaxvWOx9B2wYB6h70TExIeEBJy5EqOvbdXUphx4oayXdnyquAXDsy/StLwrMEKAeW0lIjFqhPP4E3zAR2AV0gihrKxQ/9dDSLgZ2IZIrB6RfCVuBRI7AG5SWqILKaJwmxiz/3s676jQJo8Xnr9fYVJj3RmgBI4jz7fSXi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1643;
x-ms-traffictypediagnostic: HE1PR04MB1643:
x-microsoft-antispam-prvs: <HE1PR04MB1643146B22749FB24D15E025886D0@HE1PR04MB1643.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1643;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1643;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39380400002)(39860400002)(376002)(189003)(199004)(13464003)(43544003)(52314003)(66066001)(3280700002)(2906002)(53546011)(59450400001)(6506007)(7696005)(11346002)(6916009)(2900100001)(446003)(476003)(6436002)(5250100002)(316002)(8936002)(478600001)(305945005)(7736002)(74316002)(86362001)(575784001)(5890100001)(81156014)(81166006)(8676002)(53936002)(229853002)(25786009)(26005)(4326008)(54906003)(14454004)(44832011)(3846002)(9686003)(6246003)(68736007)(33656002)(3660700001)(76176011)(102836004)(5660300001)(105586002)(106356001)(186003)(55016002)(93886005)(6116002)(97736004)(486006)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1643;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
x-microsoft-antispam-message-info: y9QIrpdUxQkigZnVLJZVAsAMPvXbTA52A7IlbDeVfzACjC5pjyf0sK22ZDX6E2rLEAQKAgofod4SHDp1AbCvEXx/1WMta82k+XQx8F6MbSrHlcESk5s7vVSVlJqr7LCca8YAJoqlMgUNiBp9/NwJMC9JHYST9UxygGFePOx30OkOcRTqgsVC636CmhDzJrAb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 02f3bfc8-4500-46e2-b95e-08d5c5390f82
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f3bfc8-4500-46e2-b95e-08d5c5390f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 07:52:00.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1643
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4T7qFMo005430



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: 2018年5月28日 16:32
> To: Peng Fan <peng.fan@nxp.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> <ulf.hansson@linaro.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>;
> Fabio Estevam <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [RFC] platform: detach from PM domains on shutdown
> 
> On Monday, May 28, 2018 10:01:09 AM CEST Peng Fan wrote:
> > Hi, Rafael & Uffe
> >
> > > -----Original Message-----
> > > From: Peng Fan
> > > Sent: 2018年5月18日 16:53
> > > To: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> > > <ulf.hansson@linaro.org>; Rafael J. Wysocki
> > > <rafael.j.wysocki@intel.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Linux Kernel
> > > Mailing List <linux-kernel@vger.kernel.org>; Linux PM
> > > <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: RE: [RFC] platform: detach from PM domains on shutdown
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > Sent: 2018年5月18日 15:55
> > > > To: Peng Fan <peng.fan@nxp.com>
> > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> > > > <ulf.hansson@linaro.org>; Rafael J. Wysocki
> > > > <rafael.j.wysocki@intel.com>; Fabio Estevam
> > > > <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> > > > <linux-kernel@vger.kernel.org>; Linux PM
> > > > <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [RFC] platform: detach from PM domains on shutdown
> > > >
> > > > On Thursday, May 17, 2018 2:37:31 PM CEST Peng Fan wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On
> > > > > > Behalf Of Rafael J. Wysocki
> > > > > > Sent: 2018年5月17日 16:01
> > > > > > To: Peng Fan <peng.fan@nxp.com>
> > > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> > > > > > <ulf.hansson@linaro.org>; Rafael J. Wysocki
> > > > > > <rafael.j.wysocki@intel.com>; Fabio Estevam
> > > > > > <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> > > > > > <linux-kernel@vger.kernel.org>; Linux PM
> > > > > > <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > > > > Subject: Re: [RFC] platform: detach from PM domains on
> > > > > > shutdown
> > > > > >
> > > > > > On Thu, May 17, 2018 at 4:33 AM, Peng Fan <peng.fan@nxp.com>
> wrote:
> > > > > > >
> > > > > > >
> > > > > > >> -----Original Message-----
> > > > > > >> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On
> > > > > > >> Behalf Of Rafael J. Wysocki
> > > > > > >> Sent: 2018年5月17日 5:35
> > > > > > >> To: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > >> Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > > > > > >> <rafael.j.wysocki@intel.com>; Fabio Estevam
> > > > > > >> <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> > > > > > >> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> > > > > > >> <linux-kernel@vger.kernel.org>; Linux PM
> > > > > > >> <linux-pm@vger.kernel.org>; dl-linux-imx
> > > > > > >> <linux-imx@nxp.com>
> > > > > > >> Subject: Re: [RFC] platform: detach from PM domains on
> > > > > > >> shutdown
> > > > > > >>
> > > > > > >> On Wed, May 16, 2018 at 11:52 AM, Ulf Hansson
> > > > > > >> <ulf.hansson@linaro.org>
> > > > > > >> wrote:
> > > > > > >> > On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > >> >> When reboot Linux, the PM domains attached to a device
> > > > > > >> >> are not shutdown. To SoCs which relys on reset the whole
> > > > > > >> >> SoC, there is no need to shutdown PM domains, but to
> > > > > > >> >> Linux running in a virtual machine with devices
> > > > > > >> >> pass-through, we could not reset the
> > > > whole SoC.
> > > > > > >> >> Currently we need Linux to shutdown its PM domains when
> reboot.
> > > > > > >> >
> > > > > > >> > I am not sure I understand exactly why the PM domain
> > > > > > >> > needs to be shutdown for these cases, could you please elaborate
> a bit on that.
> > > > > > >> >
> > > > > > >> > BTW, what platform are you running on and also what PM
> > > > > > >> > domains are being
> > > > > > >> used?
> > > > > > >> >
> > > > > > >> > Anyway, it seems like there may be need for certain
> > > > > > >> > cases, but certainly not all - especially since it may
> > > > > > >> > slow down the shutdown process, when not needed.
> > > > > > >> >
> > > > > > >> > Can we make this runtime configurable, via sysfs or
> > > > > > >> > whatever that makes
> > > > > > >> sense!?
> > > > > > >> >
> > > > > > >> >>
> > > > > > >> >> commit 2d30bb0b3889 ("platform: Do not detach from PM
> > > > > > >> >> domains on shutdown"), removes what this patch tries to
> > > > > > >> >> add, because of a
> > > > warning.
> > > > > > >> >> commit e79aee49bcf9 ("PM: Avoid false-positive warnings
> > > > > > >> >> in
> > > > > > >> >> dev_pm_domain_set()") already fixes the false alarm warning.
> > > > > > >> >> So let's detach the power domain to shutdown PM domains
> > > > > > >> >> after driver
> > > > > > shutdown.
> > > > > > >> >>
> > > > > > >> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > >> >> ---
> > > > > > >> >>
> > > > > > >> >> I do not find a better place to shutdown power domain
> > > > > > >> >> when reboot Linux, so add back the line that commit
> > > > > > >> >> 2d30bb0b3889 removes, because it is a false alarm
> > > > > > >> >> warning as commit
> > > > > > >> >> e79aee49bcf9
> > > > describes.
> > > > > > >> >>
> > > > > > >> >>  drivers/base/platform.c | 1 +
> > > > > > >> >>  1 file changed, 1 insertion(+)
> > > > > > >> >>
> > > > > > >> >> diff --git a/drivers/base/platform.c
> > > > > > >> >> b/drivers/base/platform.c index
> > > > > > >> >> 8075ddc70a17..a5929f24dc3c
> > > > > > >> >> 100644
> > > > > > >> >> --- a/drivers/base/platform.c
> > > > > > >> >> +++ b/drivers/base/platform.c
> > > > > > >> >> @@ -616,6 +616,7 @@ static void
> > > > > > >> >> platform_drv_shutdown(struct device
> > > > > > >> >> *_dev)
> > > > > > >> >>
> > > > > > >> >>         if (drv->shutdown)
> > > > > > >> >>                 drv->shutdown(dev);
> > > > > > >> >> +       dev_pm_domain_detach(_dev, true);
> > > > > > >> >
> > > > > > >> > This would somewhat work, but only for platform devices.
> > > > > > >> > To make this fully work, we need to call
> > > > > > >> > dev_pm_domain_detach() from amba, spi, etc as well.
> > > > > > >> >
> > > > > > >> > Perhaps another option to manage this more generally, an
> > > > > > >> > without having detach devices, could be to extend the
> > > > > > >> > struct dev_pm_domain with a new callback, "->shutdown()"
> > > > > > >> > and then make the driver core call it from device_shutdown().
> > > > > > >>
> > > > > > >> I'm sensing a possible ordering slippery slope with this
> > > > > > >> (it will only work if all of the drivers/bus types etc do
> > > > > > >> the right thing in their
> > > > > > >> ->shutdown callbacks so nothing depends on the domain going
> > > forward).
> > > > > > >>
> > > > > > >> > Typically, for genpd, I would probably count the number
> > > > > > >> > of calls being made to ->shutdown() per PM domain, then
> > > > > > >> > when it reaches the number of attached devices to it, allow to
> power off it.
> > > > > > >> >
> > > > > > >> > Let's see what Rafael thinks about it.
> > > > > > >>
> > > > > > >> I'm not sure about the use case.  The hypervisor should be
> > > > > > >> able to take care of turning power domains off on the
> > > > > > >> client OS reboot in theory.  If the client OS leaving the
> > > > > > >> hypervisor needs to worry about what state it leaves
> > > > > > >> behind, the design of the hypervisor is sort of
> > > > > > questionable IMO.
> > > > > > >
> > > > > > > This is valid concern. But moving the power domain logic
> > > > > > > into hypervisor mostly micro-kernel design will introduce
> > > > > > > more complexity and
> > > > > > make certification harder.
> > > > > > > Currently, Let Linux shutdown it's power domain is the
> > > > > > > easiest way to me and make things work well after reboot.
> > > > > >
> > > > > > Well, to put it bluntly, if your hypervisor depends on the
> > > > > > guest to do the right thing on exit, it doesn't do its job.  I
> > > > > > wouldn't have certified it for you if that was my decision.
> > > > >
> > > > > It is guest os not work well after guest os reboot. The
> > > > > hypervisor is not
> > > > affected.
> > > > >
> > > > > Thinking another case without hypervisor, M4 core run RTOS, A35
> > > > > Core run Linux, when Linux rebooting, RTOS should not be
> > > > > affected. After Linux reboot itself, because its power domain is
> > > > > not paired with
> > > > open/shutdown, some devices not function well.
> > > >
> > > > The question boils down to whether or not devices should be
> > > > detached from PM domains on shutdown IMO.
> > > >
> > > > They are detached from PM domains on driver removal, so I guess
> > > > one answer is "yes, in analogy with that".  However, the point
> > > > about performace brought up by Ulf seems to be valid too.
> > > >
> > > > In any case, the change should be made for all of the bus types
> > > > using PM domains, not just one.
> > >
> > > Understand, it will increase shutdown time. How about shutdown the
> > > power domain in platform_driver->shutdown, let the driver handle
> > > it's power domain sthudown by itself?
> > > Then no need common framework change.
> >
> > Do you have more suggestions on how to handle this the power domain
> shutdown?
> 
> I think you could add a platform syscore_shutdown hook to turn all power
> domains off.

Thanks, Rafael. This is simple enough to me.

Thanks,
Peng.
