Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbeE1IBU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:01:20 -0400
Received: from mail-db5eur01on0086.outbound.protection.outlook.com ([104.47.2.86]:16668
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753886AbeE1IBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:01:16 -0400
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
Thread-Index: AQHT7CrPBBBLFSj2dES+Rs6FNBbw8qQyHuOAgADENwCAAE+14IAAXz4AgAASkBCAAX4QAIAADy7ggA+pc8A=
Date: Mon, 28 May 2018 08:01:09 +0000
Message-ID: <HE1PR04MB300481B481F96F875DCBFB2B886E0@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180515090110.26820-1-peng.fan@nxp.com>
 <CAJZ5v0ibwRXqaGJW0vFcy+YqMEc_ao9itBErP_w1YjLQWVVtQg@mail.gmail.com>
 <HE1PR04MB3004EF83E7AE2250E44C49A088910@HE1PR04MB3004.eurprd04.prod.outlook.com>
 <1580300.sK9GS2NB4b@aspire.rjw.lan>
 <HE1PR04MB30041C742230314926032D4D88900@HE1PR04MB3004.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR04MB30041C742230314926032D4D88900@HE1PR04MB3004.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3177;7:vk98Do6QvXrA+CRDp7bUDgWm1hXk3sB+rzkTWZxCFdMXzt8VU34Bi5sDV3Xsumy4bt63fDWKGmq5jlJQwFQBvWlUd/ZjWm84SKtufK8yEbLy8mIbOpaUbpLDazV7Ljasa96S9KYONfC1kE6AxmWej4jhFGP3a9Z/tneVflqE7bZmay+R6kLXkAQsXT1CWW9J6PiypOM4kJO454fYYkV+BYkDyk7+m+KktzFrC3jjTMdGpINoUkgtKg8kSKY89J8p
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3177;
x-ms-traffictypediagnostic: HE1PR04MB3177:
x-microsoft-antispam-prvs: <HE1PR04MB3177F52855EE067F9C84E3A0886E0@HE1PR04MB3177.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB3177;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3177;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(376002)(346002)(39860400002)(43544003)(13464003)(189003)(199004)(52314003)(5660300001)(6916009)(186003)(3660700001)(6436002)(2906002)(68736007)(4326008)(97736004)(55016002)(9686003)(6246003)(74316002)(53936002)(102836004)(11346002)(53546011)(6116002)(446003)(3846002)(44832011)(93886005)(2900100001)(86362001)(575784001)(7736002)(476003)(3280700002)(486006)(6506007)(316002)(305945005)(59450400001)(54906003)(229853002)(33656002)(25786009)(81166006)(81156014)(8676002)(66066001)(106356001)(105586002)(8936002)(26005)(99286004)(7696005)(5250100002)(5890100001)(14454004)(478600001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3177;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zej09AGzmmR0bApcdl8GEfHsKJKsQmkPt4nPDDu1lXxAYNJ6tgq30GB8fd3r/oNjspCl9hMy5Fah9g/ib/e8L42T9gIfmF2NFOv4wG9u9vW4Kv2Lp941XbnDuXGJK4ZOsMy9oIyhgbGSxCuQvGqATR1Puu8U5ZWuSh8guTCxxcHdv+tdP6ZGorFYZyR/oH6s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f99dd66e-957b-456e-dcd9-08d5c4712c7d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99dd66e-957b-456e-dcd9-08d5c4712c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 08:01:09.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4S81RIA003226

Hi, Rafael & Uffe

> -----Original Message-----
> From: Peng Fan
> Sent: 2018年5月18日 16:53
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> <ulf.hansson@linaro.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>;
> Fabio Estevam <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [RFC] platform: detach from PM domains on shutdown
> 
> 
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: 2018年5月18日 15:55
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> > <ulf.hansson@linaro.org>; Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Linux Kernel Mailing
> > List <linux-kernel@vger.kernel.org>; Linux PM
> > <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [RFC] platform: detach from PM domains on shutdown
> >
> > On Thursday, May 17, 2018 2:37:31 PM CEST Peng Fan wrote:
> > >
> > > > -----Original Message-----
> > > > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf
> > > > Of Rafael J. Wysocki
> > > > Sent: 2018年5月17日 16:01
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
> > > > On Thu, May 17, 2018 at 4:33 AM, Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > >
> > > > >> -----Original Message-----
> > > > >> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On
> > > > >> Behalf Of Rafael J. Wysocki
> > > > >> Sent: 2018年5月17日 5:35
> > > > >> To: Ulf Hansson <ulf.hansson@linaro.org>
> > > > >> Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > > > >> <rafael.j.wysocki@intel.com>; Fabio Estevam
> > > > >> <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> > > > >> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> > > > >> <linux-kernel@vger.kernel.org>; Linux PM
> > > > >> <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > > > >> Subject: Re: [RFC] platform: detach from PM domains on shutdown
> > > > >>
> > > > >> On Wed, May 16, 2018 at 11:52 AM, Ulf Hansson
> > > > >> <ulf.hansson@linaro.org>
> > > > >> wrote:
> > > > >> > On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
> > > > >> >> When reboot Linux, the PM domains attached to a device are
> > > > >> >> not shutdown. To SoCs which relys on reset the whole SoC,
> > > > >> >> there is no need to shutdown PM domains, but to Linux
> > > > >> >> running in a virtual machine with devices pass-through, we
> > > > >> >> could not reset the
> > whole SoC.
> > > > >> >> Currently we need Linux to shutdown its PM domains when reboot.
> > > > >> >
> > > > >> > I am not sure I understand exactly why the PM domain needs to
> > > > >> > be shutdown for these cases, could you please elaborate a bit on that.
> > > > >> >
> > > > >> > BTW, what platform are you running on and also what PM
> > > > >> > domains are being
> > > > >> used?
> > > > >> >
> > > > >> > Anyway, it seems like there may be need for certain cases,
> > > > >> > but certainly not all - especially since it may slow down the
> > > > >> > shutdown process, when not needed.
> > > > >> >
> > > > >> > Can we make this runtime configurable, via sysfs or whatever
> > > > >> > that makes
> > > > >> sense!?
> > > > >> >
> > > > >> >>
> > > > >> >> commit 2d30bb0b3889 ("platform: Do not detach from PM
> > > > >> >> domains on shutdown"), removes what this patch tries to add,
> > > > >> >> because of a
> > warning.
> > > > >> >> commit e79aee49bcf9 ("PM: Avoid false-positive warnings in
> > > > >> >> dev_pm_domain_set()") already fixes the false alarm warning.
> > > > >> >> So let's detach the power domain to shutdown PM domains
> > > > >> >> after driver
> > > > shutdown.
> > > > >> >>
> > > > >> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >> >> ---
> > > > >> >>
> > > > >> >> I do not find a better place to shutdown power domain when
> > > > >> >> reboot Linux, so add back the line that commit 2d30bb0b3889
> > > > >> >> removes, because it is a false alarm warning as commit
> > > > >> >> e79aee49bcf9
> > describes.
> > > > >> >>
> > > > >> >>  drivers/base/platform.c | 1 +
> > > > >> >>  1 file changed, 1 insertion(+)
> > > > >> >>
> > > > >> >> diff --git a/drivers/base/platform.c
> > > > >> >> b/drivers/base/platform.c index 8075ddc70a17..a5929f24dc3c
> > > > >> >> 100644
> > > > >> >> --- a/drivers/base/platform.c
> > > > >> >> +++ b/drivers/base/platform.c
> > > > >> >> @@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct
> > > > >> >> device
> > > > >> >> *_dev)
> > > > >> >>
> > > > >> >>         if (drv->shutdown)
> > > > >> >>                 drv->shutdown(dev);
> > > > >> >> +       dev_pm_domain_detach(_dev, true);
> > > > >> >
> > > > >> > This would somewhat work, but only for platform devices. To
> > > > >> > make this fully work, we need to call dev_pm_domain_detach()
> > > > >> > from amba, spi, etc as well.
> > > > >> >
> > > > >> > Perhaps another option to manage this more generally, an
> > > > >> > without having detach devices, could be to extend the struct
> > > > >> > dev_pm_domain with a new callback, "->shutdown()" and then
> > > > >> > make the driver core call it from device_shutdown().
> > > > >>
> > > > >> I'm sensing a possible ordering slippery slope with this (it
> > > > >> will only work if all of the drivers/bus types etc do the right
> > > > >> thing in their
> > > > >> ->shutdown callbacks so nothing depends on the domain going
> forward).
> > > > >>
> > > > >> > Typically, for genpd, I would probably count the number of
> > > > >> > calls being made to ->shutdown() per PM domain, then when it
> > > > >> > reaches the number of attached devices to it, allow to power off it.
> > > > >> >
> > > > >> > Let's see what Rafael thinks about it.
> > > > >>
> > > > >> I'm not sure about the use case.  The hypervisor should be able
> > > > >> to take care of turning power domains off on the client OS
> > > > >> reboot in theory.  If the client OS leaving the hypervisor
> > > > >> needs to worry about what state it leaves behind, the design of
> > > > >> the hypervisor is sort of
> > > > questionable IMO.
> > > > >
> > > > > This is valid concern. But moving the power domain logic into
> > > > > hypervisor mostly micro-kernel design will introduce more
> > > > > complexity and
> > > > make certification harder.
> > > > > Currently, Let Linux shutdown it's power domain is the easiest
> > > > > way to me and make things work well after reboot.
> > > >
> > > > Well, to put it bluntly, if your hypervisor depends on the guest
> > > > to do the right thing on exit, it doesn't do its job.  I wouldn't
> > > > have certified it for you if that was my decision.
> > >
> > > It is guest os not work well after guest os reboot. The hypervisor
> > > is not
> > affected.
> > >
> > > Thinking another case without hypervisor, M4 core run RTOS, A35 Core
> > > run Linux, when Linux rebooting, RTOS should not be affected. After
> > > Linux reboot itself, because its power domain is not paired with
> > open/shutdown, some devices not function well.
> >
> > The question boils down to whether or not devices should be detached
> > from PM domains on shutdown IMO.
> >
> > They are detached from PM domains on driver removal, so I guess one
> > answer is "yes, in analogy with that".  However, the point about
> > performace brought up by Ulf seems to be valid too.
> >
> > In any case, the change should be made for all of the bus types using
> > PM domains, not just one.
> 
> Understand, it will increase shutdown time. How about shutdown the power
> domain in platform_driver->shutdown, let the driver handle it's power domain
> sthudown by itself?
> Then no need common framework change.

Do you have more suggestions on how to handle this the power domain shutdown?

Thanks,
Peng.

> 
> Thanks,
> Peng
