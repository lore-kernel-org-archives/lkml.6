Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A42C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA0206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n6tOarLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DA0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeIGNVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:21:20 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:18807
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbeIGNVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSw0KsYb78O1k971bfxbjBkGWdqI3YewKlDTjF9dDgQ=;
 b=n6tOarLLmYsd17qnLinj56vbFhXm+HLIAmF7ni5tvAiO6aE15WYPhd/e6vRUufFYeMYusFyLKMyHCzeP/1lRASHX+AL9zUKQzvDS9TjcUFzWM5FKOxVD1jx1Ye8zaiu9DUcRk0sMHI8pM/U8TBmjXw3oYTZyJjJds/jYO9wMq5I=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2916.eurprd04.prod.outlook.com (10.175.42.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Fri, 7 Sep 2018 08:41:19 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%8]) with mapi id 15.20.1101.020; Fri, 7 Sep 2018
 08:41:19 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Topic: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Index: AQHUQN58CVZQFHBBjEyvga7omBlOu6TkhM4g
Date:   Fri, 7 Sep 2018 08:41:19 +0000
Message-ID: <AM5PR0402MB2865774C03981F9808AB3A13F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2916;6:uNn2g5R6MelKPTZHZ3BjMDNItLjcWeAlMoGdHN3f8P38zgYtuoIcQDQcwhg2r1NyCiq8+MRHgc9HAbjk2PD3tyQGFqdji9p/SkIvWF78xV2VBOvJWyDsKBjOYYRbIHgcLyTHjtXjFUEni3Vu6tiSf3zEvu1AT83WokyTj23W7W8SxrspdMKxE5kgIp4G9IRGMoHtodgEzxrjJyHDWucRuwJPe3b/LenVnm3EfPu5vUwCJv4BhomaNfKmodCIXSn0JnpUw8ufQ2CbM5kNBW+oV4fGAwBA4M/BgIFJv0I0f1TvLadblsxkAQCJ/rgjNkW1Lq4blnQhICmaU4sDO5Xg30L3HY/ZLY4Sn1NTuuIIAvSxTNcWfHqtxnNZ75bvmLtybnhCUkkYZUTlWX0/5wpl6832oQiqswfNREqNbZ8s+by1qWBRFm9kVPIkVex6zsN1+MEVBO/iSPkZEiUbjixvmQ==;5:9se3ZzDtN+1W/Lh8hYXQ+OY7ufqSVr3k90lACltPOnIJAx3ohV4CFJ0slcIK8IwTCtbeFwBO5aokwT4v/CRYHMslslVLKBY/e9Z33IJQjtcQmqSM6/87JeugC3okzPjXaCV8bXgwchGjuZ3W4W8l9yYSWOooKpyIb9dKeTVx5cQ=;7:HAMwR0UAwKqSAF9kuAnD0g4ApBFYt4I9aTu/yyEWpcMIgnZz/Qzf/exgqWhLnFXCG5LRjG+1ZKLZoA9qCuHtG6XQ5TrMV8b9pTvmmK0/dxhflNwtuFCwyXDg9GY3J7bBl6sNbKOgjr+Q5QcmthgzNrvPDrCCRvSJ+i1uNxiU0sY0c30zdVjqpK2//4/8iBO9AgUCh4KTdNRlzzvFnyTXl3L0Z0NkIh7r15F6URA8sQNsUvPlcQ6mk2j5jOjFoTIH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b8906d72-5014-449d-271d-08d6149daea5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2916;
x-ms-traffictypediagnostic: AM5PR0402MB2916:
x-microsoft-antispam-prvs: <AM5PR0402MB29169E8A851A3789F2EC1320F1000@AM5PR0402MB2916.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:AM5PR0402MB2916;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2916;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(8936002)(4326008)(229853002)(97736004)(81166006)(5250100002)(81156014)(106356001)(54906003)(55016002)(25786009)(9686003)(86362001)(53936002)(6436002)(11346002)(7696005)(476003)(76176011)(486006)(102836004)(6346003)(2900100001)(99286004)(186003)(26005)(446003)(53546011)(6506007)(33656002)(14454004)(105586002)(6246003)(256004)(14444005)(68736007)(66066001)(316002)(5660300001)(2906002)(74316002)(305945005)(6116002)(8676002)(6916009)(478600001)(3846002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2916;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-microsoft-antispam-message-info: FnH893EpFR1FoAJnx306rjK/LmK04vwCAZKuK9S78zwHsED+QJf9FjK/zi7xT4g6dB7IzIYmxbyHgmOzauA9RU7xL0Zs4/gzPgwii5NRAmpyhpfGfMEV1NthoNe3BlZ0tPhJ0jFaeXeaVEd10MuHMIpM6U6AWFy6frGrbC9FPJeA/h/v4dQfX9lDYRh28IW9/rWvDD0CzrSRb6f98qEt/E3GoPqCzaVaNvEQK000evDsj1zEqFFLuF1mK+XQ+He/92qHL7I+MDwPoSj8g4PjJIYv/EYYEutUxGk04qDh8mjDytxg+sNRA2J7N2Oix1eulO5OmQCC6qt9yfPiS3ZJyZkCze/mtDfJxe8M6fMkMLA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8906d72-5014-449d-271d-08d6149daea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 08:41:19.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongsheng

> On 2018/9/5 11:05, Dongsheng Wang wrote:
>=20
> Please change your comments style.
>=20
> On 2018/8/31 11:57, Ran Wang wrote:
> > This driver is to provide a independent framework for PM service
> > provider and consumer to configure system level wake up feature. For
> > example, RCPM driver could register a callback function on this
> > platform first, and Flex timer driver who want to enable timer wake up
> > feature, will call generic API provided by this platform driver, and
> > then it will trigger RCPM driver to do it. The benefit is to isolate
> > the user and service, such as flex timer driver will not have to know
> > the implement details of wakeup function it require. Besides, it is
> > also easy for service side to upgrade its logic when design is changed
> > and remain user side unchanged.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/soc/fsl/Kconfig   |   14 +++++
> >  drivers/soc/fsl/Makefile  |    1 +
> >  drivers/soc/fsl/plat_pm.c |  144
> +++++++++++++++++++++++++++++++++++++++++++++
> >  include/soc/fsl/plat_pm.h |   22 +++++++
> >  4 files changed, 181 insertions(+), 0 deletions(-)  create mode
> > 100644 drivers/soc/fsl/plat_pm.c  create mode 100644
> > include/soc/fsl/plat_pm.h
> >
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > 7a9fb9b..6517412 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -16,3 +16,17 @@ config FSL_GUTS
> >  	  Initially only reading SVR and registering soc device are supported=
.
> >  	  Other guts accesses, such as reading RCW, should eventually be
> moved
> >  	  into this driver as well.
> > +
> > +config FSL_PLAT_PM
> > +	bool "Freescale platform PM framework"
> > +	help
> > +	  This driver is to provide a independent framework for PM service
> > +	  provider and consumer to configure system level wake up feature.
> For
> > +	  example, RCPM driver could register a callback function on this
> > +	  platform first, and Flex timer driver who want to enable timer wake
> > +	  up feature, will call generic API provided by this platform driver,
> > +	  and then it will trigger RCPM driver to do it. The benefit is to
> > +	  isolate the user and service, such as  flex timer driver will not
> > +	  have to know the implement details of wakeup function it require.
> > +	  Besides, it is also easy for service side to upgrade its logic when
> > +	  design changed and remain user side unchanged.
> > diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile index
> > 44b3beb..8f9db23 100644
> > --- a/drivers/soc/fsl/Makefile
> > +++ b/drivers/soc/fsl/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/
> >  obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
> >  obj-$(CONFIG_CPM)			+=3D qe/
> >  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
> > +obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o
> > diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c new
> > file mode 100644 index 0000000..19ea14e
> > --- /dev/null
> > +++ b/drivers/soc/fsl/plat_pm.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// plat_pm.c - Freescale platform PM framework // // Copyright 2018
> > +NXP // // Author: Ran Wang <ran.wang_1@nxp.com>,
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <soc/fsl/plat_pm.h>
> > +
> > +
> > +struct plat_pm_t {
> > +	struct list_head node;
> > +	fsl_plat_pm_handle handle;
> > +	void *handle_priv;
> > +	spinlock_t	lock;
> > +};
> > +
> > +static struct plat_pm_t plat_pm;
> > +
> > +// register_fsl_platform_wakeup_source - Register callback function
> > +to plat_pm // @handle: Pointer to handle PM feature requirement //
> > +@handle_priv: Handler specific data struct // // Return 0 on success
> > +other negative errno int
> > +register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> > +		void *handle_priv)
> > +{
> > +	struct plat_pm_t *p;
> > +	unsigned long	flags;
> > +
> > +	if (!handle) {
> > +		pr_err("FSL plat_pm: Handler invalid, reject\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	p =3D kmalloc(sizeof(*p), GFP_KERNEL);
> > +	if (!p)
> > +		return -ENOMEM;
> > +
> > +	p->handle =3D handle;
> > +	p->handle_priv =3D handle_priv;
> > +
> > +	spin_lock_irqsave(&plat_pm.lock, flags);
> > +	list_add_tail(&p->node, &plat_pm.node);
> > +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);
> > +
> > +// Deregister_fsl_platform_wakeup_source - deregister callback
> > +function // @handle_priv: Handler specific data struct // // Return 0
> > +on success other negative errno int
> > +deregister_fsl_platform_wakeup_source(void *handle_priv) {
> > +	struct plat_pm_t *p, *tmp;
> > +	unsigned long	flags;
> > +
> > +	spin_lock_irqsave(&plat_pm.lock, flags);
> > +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {
> > +		if (p->handle_priv =3D=3D handle_priv) {
> > +			list_del(&p->node);
> > +			kfree(p);
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);
> > +
> > +// fsl_platform_wakeup_config - Configure wakeup source by calling
> > +handlers // @dev: pointer to user's device struct // @flag: to tell
> > +enable or disable wakeup source // // Return 0 on success other
> > +negative errno int fsl_platform_wakeup_config(struct device *dev,
> > +bool flag) {
> > +	struct plat_pm_t *p;
> > +	int ret;
> > +	bool success_handled;
> > +	unsigned long	flags;
> > +
> > +	success_handled =3D false;
> > +
> > +	// Will consider success if at least one callback return 0.
> > +	// Also, rest handles still get oppertunity to be executed
> > +	spin_lock_irqsave(&plat_pm.lock, flags);
> > +	list_for_each_entry(p, &plat_pm.node, node) {
> > +		if (p->handle) {
> > +			ret =3D p->handle(dev, flag, p->handle_priv);
> > +			if (!ret)
> > +				success_handled =3D true;
> Miss a break?

Actually my idea is to allow more than one registered handler to handle thi=
s
request, so I define a flag rather than return to indicated if there is at =
least one handler successfully
do it. This design might give more flexibility to framework when running.

> > +			else if (ret !=3D -ENODEV) {
> > +				pr_err("FSL plat_pm: Failed to config wakeup
> source:%d\n", ret);
> Please unlock before return.

Yes, will fix it in next version, thanks for pointing out!

> > +				return ret;
> > +			}
> > +		} else
> > +			pr_warn("FSL plat_pm: Invalid handler detected,
> skip\n");
> > +	}
> > +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> > +
> > +	if (success_handled =3D=3D false) {
> > +		pr_err("FSL plat_pm: Cannot find the matchhed handler for
> wakeup source config\n");
> > +		return -ENODEV;
> > +	}
> Add this into the loop.

My design is that if the 1st handler return -ENODEV to indicated this devic=
e it doesn't support,=20
then the framework will continue try 2nd handler...

So I think it is needed to place this checking out of loop, what do you say=
?

Regards,
Ran
> > +
> > +	return 0;
> > +}
> > +
> > +// fsl_platform_wakeup_enable - Enable wakeup source // @dev: pointer
> > +to user's device struct // // Return 0 on success other negative
> > +errno int fsl_platform_wakeup_enable(struct device *dev) {
> > +	return fsl_platform_wakeup_config(dev, true); }
> > +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);
> > +
> > +// fsl_platform_wakeup_disable - Disable wakeup source // @dev:
> > +pointer to user's device struct // // Return 0 on success other
> > +negative errno int fsl_platform_wakeup_disable(struct device *dev) {
> > +	return fsl_platform_wakeup_config(dev, false); }
> > +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);
> > +
> > +static int __init fsl_plat_pm_init(void) {
> > +	spin_lock_init(&plat_pm.lock);
> > +	INIT_LIST_HEAD(&plat_pm.node);
> > +	return 0;
> > +}
> > +
> > +core_initcall(fsl_plat_pm_init);
> > diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h new
> > file mode 100644 index 0000000..bbe151e
> > --- /dev/null
> > +++ b/include/soc/fsl/plat_pm.h
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// plat_pm.h - Freescale platform PM Header // // Copyright 2018 NXP
> > +// // Author: Ran Wang <ran.wang_1@nxp.com>,
> > +
> > +#ifndef __FSL_PLAT_PM_H
> > +#define __FSL_PLAT_PM_H
> > +
> > +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,
> > +		void *handle_priv);
> > +
> > +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> > +		void *handle_priv);
> > +int deregister_fsl_platform_wakeup_source(void *handle_priv); int
> > +fsl_platform_wakeup_config(struct device *dev, bool flag); int
> > +fsl_platform_wakeup_enable(struct device *dev); int
> > +fsl_platform_wakeup_disable(struct device *dev);
> > +
> > +#endif	// __FSL_PLAT_PM_H
>=20

