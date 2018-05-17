Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEQCd5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 22:33:57 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:43584
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeEQCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 22:33:55 -0400
From: Peng Fan <peng.fan@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC] platform: detach from PM domains on shutdown
Thread-Topic: [RFC] platform: detach from PM domains on shutdown
Thread-Index: AQHT7CrPBBBLFSj2dES+Rs6FNBbw8qQyHuOAgADENwCAAE+14A==
Date: Thu, 17 May 2018 02:33:50 +0000
Message-ID: <HE1PR04MB300483E474BE21D55720BCEC88910@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180515090110.26820-1-peng.fan@nxp.com>
 <CAPDyKFpKGhLrj-px1E3C_tq3_2GAxWpzSgr5TXJU7s8-jokf9g@mail.gmail.com>
 <CAJZ5v0h7zaNtSC6UCLJ8xEGKMSuBiZ_oAyB8bk1ROWCuH_-K4g@mail.gmail.com>
In-Reply-To: <CAJZ5v0h7zaNtSC6UCLJ8xEGKMSuBiZ_oAyB8bk1ROWCuH_-K4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1356;7:CqIxgk5j2YdYdiLbj+xnSy6wnE7UvwLqZMhmkcndeRTqdG9AYrn5hH5JRZtWSfx/di6p0J3fSgeRgheVNFmQoJB3SaJuecE/BWckVMHSBLLOBbWK3Sxa6YatCaSTx6bDpgP8058dBPLTcFUdMFs4jncKTNT6gphaJbdyxFM5xpo9v/LFezEFi/U+UCZkuwhtqF3lB7rsNScCksgVqKK0cX33HZPZBiC8125AWniOSmJ/0Br1ynnwo7eyYkOncY8C
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1356;
x-ms-traffictypediagnostic: HE1PR04MB1356:
x-microsoft-antispam-prvs: <HE1PR04MB1356D46501497BAFA0DC184488910@HE1PR04MB1356.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1356;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1356;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(366004)(376002)(396003)(13464003)(43544003)(52314003)(199004)(189003)(99286004)(229853002)(316002)(2900100001)(2906002)(110136005)(68736007)(3660700001)(25786009)(6246003)(26005)(4326008)(446003)(106356001)(105586002)(7736002)(3280700002)(81156014)(81166006)(54906003)(8676002)(97736004)(74316002)(575784001)(7696005)(8936002)(86362001)(76176011)(3846002)(476003)(6116002)(33656002)(478600001)(486006)(6506007)(55016002)(14454004)(11346002)(6436002)(59450400001)(53936002)(9686003)(44832011)(66066001)(53546011)(186003)(5250100002)(5890100001)(305945005)(102836004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1356;H:HE1PR04MB3004.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CqSbn77cxq/1IBRcwv1jkJm3KvnBPGq9z3Ts0z+nXSdx6p+u8Naq369NktVaUv6Jn1yBgknX1HhvFIBmlvyzt7zspzo4G0AzXhATIvi60CLvZdIzCmcMk9rc4uohN5Pd3DybNePVeMiJAV+vc2wgcZyiXwmJZV7LGemGp47oK6/g29xUEfbDwdQQ1G51yN4X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e216b3a2-5bab-471f-d202-08d5bb9e9fe7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e216b3a2-5bab-471f-d202-08d5bb9e9fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 02:33:50.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1356
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4H2Y599023071



> -----Original Message-----
> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael
> J. Wysocki
> Sent: 2018年5月17日 5:35
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> <rafael.j.wysocki@intel.com>; Fabio Estevam <fabio.estevam@nxp.com>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [RFC] platform: detach from PM domains on shutdown
> 
> On Wed, May 16, 2018 at 11:52 AM, Ulf Hansson <ulf.hansson@linaro.org>
> wrote:
> > On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
> >> When reboot Linux, the PM domains attached to a device are not
> >> shutdown. To SoCs which relys on reset the whole SoC, there is no
> >> need to shutdown PM domains, but to Linux running in a virtual
> >> machine with devices pass-through, we could not reset the whole SoC.
> >> Currently we need Linux to shutdown its PM domains when reboot.
> >
> > I am not sure I understand exactly why the PM domain needs to be
> > shutdown for these cases, could you please elaborate a bit on that.
> >
> > BTW, what platform are you running on and also what PM domains are being
> used?
> >
> > Anyway, it seems like there may be need for certain cases, but
> > certainly not all - especially since it may slow down the shutdown
> > process, when not needed.
> >
> > Can we make this runtime configurable, via sysfs or whatever that makes
> sense!?
> >
> >>
> >> commit 2d30bb0b3889 ("platform: Do not detach from PM domains on
> >> shutdown"), removes what this patch tries to add, because of a warning.
> >> commit e79aee49bcf9 ("PM: Avoid false-positive warnings in
> >> dev_pm_domain_set()") already fixes the false alarm warning. So let's
> >> detach the power domain to shutdown PM domains after driver shutdown.
> >>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>
> >> I do not find a better place to shutdown power domain when reboot
> >> Linux, so add back the line that commit 2d30bb0b3889 removes, because
> >> it is a false alarm warning as commit e79aee49bcf9 describes.
> >>
> >>  drivers/base/platform.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> >> 8075ddc70a17..a5929f24dc3c 100644
> >> --- a/drivers/base/platform.c
> >> +++ b/drivers/base/platform.c
> >> @@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct device
> >> *_dev)
> >>
> >>         if (drv->shutdown)
> >>                 drv->shutdown(dev);
> >> +       dev_pm_domain_detach(_dev, true);
> >
> > This would somewhat work, but only for platform devices. To make this
> > fully work, we need to call dev_pm_domain_detach() from amba, spi, etc
> > as well.
> >
> > Perhaps another option to manage this more generally, an without
> > having detach devices, could be to extend the struct dev_pm_domain
> > with a new callback, "->shutdown()" and then make the driver core call
> > it from device_shutdown().
> 
> I'm sensing a possible ordering slippery slope with this (it will only work if all of
> the drivers/bus types etc do the right thing in their
> ->shutdown callbacks so nothing depends on the domain going forward).
> 
> > Typically, for genpd, I would probably count the number of calls being
> > made to ->shutdown() per PM domain, then when it reaches the number of
> > attached devices to it, allow to power off it.
> >
> > Let's see what Rafael thinks about it.
> 
> I'm not sure about the use case.  The hypervisor should be able to take care of
> turning power domains off on the client OS reboot in theory.  If the client OS
> leaving the hypervisor needs to worry about what state it leaves behind, the
> design of the hypervisor is sort of questionable IMO.

This is valid concern. But moving the power domain logic into hypervisor mostly micro-kernel design
will introduce more complexity and make certification harder.
Currently, Let Linux shutdown it's power domain is the easiest way to me and make things work well
after reboot.

Thanks,
Peng
