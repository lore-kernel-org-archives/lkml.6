Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeEPMxx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:53:53 -0400
Received: from mail-ve1eur01on0074.outbound.protection.outlook.com ([104.47.1.74]:11904
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752986AbeEPMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:53:50 -0400
From: Peng Fan <peng.fan@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC] platform: detach from PM domains on shutdown
Thread-Topic: [RFC] platform: detach from PM domains on shutdown
Thread-Index: AQHT7CrPBBBLFSj2dES+Rs6FNBbw8qQyHuOAgAAAV1A=
Date: Wed, 16 May 2018 12:53:45 +0000
Message-ID: <HE1PR04MB30044B7419754EB54ADE1A9288920@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180515090110.26820-1-peng.fan@nxp.com>
 <CAPDyKFpKGhLrj-px1E3C_tq3_2GAxWpzSgr5TXJU7s8-jokf9g@mail.gmail.com>
In-Reply-To: <CAPDyKFpKGhLrj-px1E3C_tq3_2GAxWpzSgr5TXJU7s8-jokf9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
x-originating-ip: [114.217.188.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1657;7:ecc5kO+2qLnuxL2tgi7yA82PBvJSAzxKH4LAtTQwXkanPj6Zaall5+RQJSJ2FtrMU6PQPugJucF2ZVRBa1VUSoFNL4M0T+Rzv9YSKUSA7bBCbmgRyI6f3Zil/csPnMkW/Vulea1HXSLlU2p+VdvVYRP68Q6T/SW55VxODUb03UkVxzx93lEK97Xd1pUJGHpXLd9OhxQb0I3TZ9I19mszIZTHTBGSk4gb764Q48nQMIbcdgPGEKGgwl4FwDGhyika
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1657;
x-ms-traffictypediagnostic: HE1PR04MB1657:
x-microsoft-antispam-prvs: <HE1PR04MB165788FF546DBF12BEDFB3F688920@HE1PR04MB1657.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB1657;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1657;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(13464003)(52314003)(189003)(199004)(2900100001)(7696005)(5660300001)(102836004)(2906002)(76176011)(53546011)(59450400001)(6506007)(74316002)(305945005)(476003)(44832011)(3280700002)(446003)(478600001)(11346002)(106356001)(486006)(6916009)(25786009)(229853002)(6436002)(186003)(105586002)(26005)(68736007)(6116002)(8676002)(81166006)(81156014)(54906003)(3846002)(316002)(99286004)(8936002)(3660700001)(14454004)(66066001)(7736002)(5250100002)(5890100001)(6246003)(33656002)(4326008)(55016002)(575784001)(97736004)(86362001)(53936002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1657;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tC0yQgNyhhaPXtfT96Xgeg8lgQcuaQ+8sQVYuNvF3Kwl0/jCr1pQEkTFdI7rZAt7dgCQVXzI7m72D//ZojkT69fE1pwSAgw1oOHKGoDceBpl9PHDPt6eoJbtznqCvRwXcp+lNC4zskF8g1MoTjPl3U19216DxSbbJM4cmeAUOllDZikct5Aqy0ez1WLftcsf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0ac91508-26bf-415e-c89e-08d5bb2c0f99
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac91508-26bf-415e-c89e-08d5bb2c0f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 12:53:45.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1657
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GCrv1g005012

Hi Uffe,

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: 2018年5月16日 17:53
> To: Peng Fan <peng.fan@nxp.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [RFC] platform: detach from PM domains on shutdown
> 
> On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
> > When reboot Linux, the PM domains attached to a device are not
> > shutdown. To SoCs which relys on reset the whole SoC, there is no need
> > to shutdown PM domains, but to Linux running in a virtual machine with
> > devices pass-through, we could not reset the whole SoC. Currently we
> > need Linux to shutdown its PM domains when reboot.
> 
> I am not sure I understand exactly why the PM domain needs to be shutdown
> for these cases, could you please elaborate a bit on that.
> 
> BTW, what platform are you running on and also what PM domains are being
> used?

It is on i.MX8 platform, with two Linux OSes running on hypervisor.
OS2 is assigned a display controller with SMMU. When OS2 reboot, OS1 is
not affected.

When OS2 firstly boots up, the power domain of display controller is powered up,
and display works well; then I reboot OS2, with `#reboot` in OS2 bash; OS2 display
not work well, because of the power domain not shutdown. This might be something
in the firmware that handling power domain well if the power domain is opened twice.
But open power domain twice seems not good, because when OS2 shutdown, the power
domain is still on.

> 
> Anyway, it seems like there may be need for certain cases, but certainly not all -
> especially since it may slow down the shutdown process, when not needed.

Yes, adding this will slow down the shutdown process. I just thought
the line code was removed because of a false alarm warning, so add it back.

> 
> Can we make this runtime configurable, via sysfs or whatever that makes
> sense!?

In my case, I need all the power domains assigned to OS2 needs to be shutdown
when reboot or shutdown. If runtime configuration is for all the power domains in one OS,
I am ok.

Something like this?
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..bb34f00654da 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -616,6 +616,8 @@ static void platform_drv_shutdown(struct device *_dev)

        if (drv->shutdown)
                drv->shutdown(dev);
+       if (shutdown_pd)
+               dev_pm_domain_detach(_dev, true);
 }

And in kernel/power/main.c create an attribute exposed to userspace to read/write shutdown_pd variable.

Thanks,
Peng.

 /**

> 
> >
> > commit 2d30bb0b3889 ("platform: Do not detach from PM domains on
> > shutdown"), removes what this patch tries to add, because of a warning.
> > commit e79aee49bcf9 ("PM: Avoid false-positive warnings in
> > dev_pm_domain_set()") already fixes the false alarm warning. So let's
> > detach the power domain to shutdown PM domains after driver shutdown.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > I do not find a better place to shutdown power domain when reboot
> > Linux, so add back the line that commit 2d30bb0b3889 removes, because
> > it is a false alarm warning as commit e79aee49bcf9 describes.
> >
> >  drivers/base/platform.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> > 8075ddc70a17..a5929f24dc3c 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct device
> > *_dev)
> >
> >         if (drv->shutdown)
> >                 drv->shutdown(dev);
> > +       dev_pm_domain_detach(_dev, true);
> 
> This would somewhat work, but only for platform devices. To make this fully
> work, we need to call dev_pm_domain_detach() from amba, spi, etc as well.
> 
> Perhaps another option to manage this more generally, an without having
> detach devices, could be to extend the struct dev_pm_domain with a new
> callback, "->shutdown()" and then make the driver core call it from
> device_shutdown().
> 
> Typically, for genpd, I would probably count the number of calls being made to
> ->shutdown() per PM domain, then when it reaches the number of attached
> devices to it, allow to power off it.
> 
> Let's see what Rafael thinks about it.
> 
> Kind regards
> Uffe
