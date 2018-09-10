Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B482086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2Ur9Fpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B482086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIJITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:19:52 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:65046
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbeIJITw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0BmM4szB6Yq6rk/p22HvjoOlhwwt4M1AHi1R4ipUc=;
 b=a2Ur9FpoD4+vUDvi6OIgAyPhhnudtT2p6WvsP8MW7lQzdZAWuBTXdm1K4R6ORdUmMTOvn+skWtO4+QBeP9GfzgqublMgRcmcrhOp2kDeys2I0fb1/ScaFBMhg/JwSvLCIqJjHT13cS9nn00W96orxEqtiWLPFOrdM1FG4S7m8hA=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2753.eurprd04.prod.outlook.com (10.175.41.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 03:27:52 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::71ae:eae6:c08c:4766%9]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 03:27:52 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@lists.linux-foundation.org" 
        <linux-pm@lists.linux-foundation.org>
Subject: RE: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Topic: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Index: AQHUQN58CVZQFHBBjEyvga7omBlOu6To5pkQ
Date:   Mon, 10 Sep 2018 03:27:51 +0000
Message-ID: <AM5PR0402MB28658124F24A83D8715F9C6DF1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
 <AM5PR0402MB2865774C03981F9808AB3A13F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2753;6:B6PBNMqk+iMfZflS3pVoWlzPLrj7DgzvLpbErpJvhVMPhA8clXUL6Z/O4ViJojZ6258Ht6+KR4o22j5PPHbkric30DICQgvUfLB7swLLgBrBeQRM+9GgR4XGkKhJmVlC6IGwYpMLp+++J51UFMLi4pGCsdAybMfuTECoFtJnJr1/BhxTStrDEfbTWPWhjTbr7vHobNq/EgI1ZGVe6wYLXNV3Bwx9JV72fXRIKsw4Cphb6CCihsPCcousVPKowQ/ITr2KtoTU4rJv5W4tIxMBRsrPVk6NnEa5VcQt38A52RQUoR8LgUmzMN6LJ9CmgoQ0E2qkRXQ9fSQuQO7VQ+fbDsH0KVGdRFcmaH0KwigWOP6GApO1OFx7+7mX4yGypskJstjZe2xqYBz9swi5Vwva4ZJsnEvuvz2bw2FPQeS9sCC3574puWNNzE2+LzkN8ikXBfUmkZyxwRdnMu6UjZ4vQg==;5:/hN6kfgUPWiINsnmUmMVz5PDIo07DB7QVMfXF+BaG2jvmm3xTICEyJZMofbfR81BQgEHp3tW5qKptdQmETLdvcJUiNIOiyy6obSQBTLtInhN5zsf8CLs5GlfJhsZOIl6EY7s9hQ/Inlo98YEYmK1DYTad+lC7/5AvHN1nGmKmqs=;7:Rbsp20zBPsQCStaTm+Zhimn/v5p2bRZDuQMRPgQWzAKkyBRENTGFMJtd+aRrP+n1oYTcEiYR2H/zmxWAu0x/RY0H0mOGoLn5OYgrcZYkjNtHaoZPD8rAVQjWsZHZf6hhZ21cpYW5UGd2vADfUN8aydmeHFV4j+0Kt1PKp3J0LWLtFhs3dlFLKFIMotNBVR+fE5qIC39R2OpBobWhbxkADVM35wCC7ZGxNFyZn3cy/6cv6XJVCc7xgzQmnEer5ioG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 01d3dc26-cba3-485a-14c2-08d616cd63f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2753;
x-ms-traffictypediagnostic: AM5PR0402MB2753:
x-microsoft-antispam-prvs: <AM5PR0402MB2753338C10715B440ECF4162F1050@AM5PR0402MB2753.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:AM5PR0402MB2753;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2753;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(55016002)(8676002)(7696005)(229853002)(14454004)(54906003)(6506007)(53546011)(53936002)(316002)(6916009)(9686003)(93886005)(5660300001)(26005)(99286004)(186003)(86362001)(8936002)(2900100001)(102836004)(76176011)(6436002)(74316002)(486006)(7736002)(446003)(11346002)(305945005)(97736004)(6246003)(106356001)(25786009)(5250100002)(476003)(105586002)(33656002)(2906002)(81156014)(81166006)(3846002)(6116002)(68736007)(4326008)(66066001)(14444005)(478600001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2753;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y8+3zJJSIPRjk/48oroT165XlHxFnxPndKwUZIe4ARCoOBIW1ch5xyZ/yje9Ezoy7LJqKEj1tAhMdGhprEGsz1sJJfyfK4NFCVPb0pCqYgjoWfEuCweoW9hzh/8gPxEFFHGAMhNqdtf1Fu+jbM5I9UDbqup9ZC4rRRnk7Ur/XWgydy+AJLeI0dZz2e/d3xRARDCrjGieroH40gV1Db0ThDS9gzeorr4sR7UHQbRAmgJr7FuFpeNavrwQxIRyD639fdhbjU5vgzJ9wdbOS4exvB9+HhWfbbKK7Mr3EOS42jkxlqNbYc6dK2uAEEdm5weY+2p0ScAxX1nqjcUInAu6w37Qszooruc0kkFMbjKVHWo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d3dc26-cba3-485a-14c2-08d616cd63f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 03:27:51.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongsheng,

On 2018/9/7 18:16, Dongsheng Wang wrote:
>=20
> On 2018/9/7 16:49, Ran Wang wrote:
> > Hi Dongsheng
> >
> >> On 2018/9/5 11:05, Dongsheng Wang wrote:
> >>
> >> Please change your comments style.
> >>
> >> On 2018/8/31 11:57, Ran Wang wrote:
> >>> This driver is to provide a independent framework for PM service
> >>> provider and consumer to configure system level wake up feature. For
> >>> example, RCPM driver could register a callback function on this
> >>> platform first, and Flex timer driver who want to enable timer wake
> >>> up feature, will call generic API provided by this platform driver,
> >>> and then it will trigger RCPM driver to do it. The benefit is to
> >>> isolate the user and service, such as flex timer driver will not
> >>> have to know the implement details of wakeup function it require.
> >>> Besides, it is also easy for service side to upgrade its logic when
> >>> design is changed and remain user side unchanged.
> >>>
> >>> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> >>> ---
> >>>  drivers/soc/fsl/Kconfig   |   14 +++++
> >>>  drivers/soc/fsl/Makefile  |    1 +
> >>>  drivers/soc/fsl/plat_pm.c |  144
> >> +++++++++++++++++++++++++++++++++++++++++++++
> >>>  include/soc/fsl/plat_pm.h |   22 +++++++
> >>>  4 files changed, 181 insertions(+), 0 deletions(-)  create mode
> >>> 100644 drivers/soc/fsl/plat_pm.c  create mode 100644
> >>> include/soc/fsl/plat_pm.h
> >>>
> >>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> >>> 7a9fb9b..6517412 100644
> >>> --- a/drivers/soc/fsl/Kconfig
> >>> +++ b/drivers/soc/fsl/Kconfig
> >>> @@ -16,3 +16,17 @@ config FSL_GUTS
> >>>  	  Initially only reading SVR and registering soc device are support=
ed.
> >>>  	  Other guts accesses, such as reading RCW, should eventually be
> >> moved
> >>>  	  into this driver as well.
> >>> +
> >>> +config FSL_PLAT_PM
> >>> +	bool "Freescale platform PM framework"
> >>> +	help
> >>> +	  This driver is to provide a independent framework for PM service
> >>> +	  provider and consumer to configure system level wake up feature.
> >> For
> >>> +	  example, RCPM driver could register a callback function on this
> >>> +	  platform first, and Flex timer driver who want to enable timer wa=
ke
> >>> +	  up feature, will call generic API provided by this platform drive=
r,
> >>> +	  and then it will trigger RCPM driver to do it. The benefit is to
> >>> +	  isolate the user and service, such as  flex timer driver will not
> >>> +	  have to know the implement details of wakeup function it require.
> >>> +	  Besides, it is also easy for service side to upgrade its logic wh=
en
> >>> +	  design changed and remain user side unchanged.
> >>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> >>> index
> >>> 44b3beb..8f9db23 100644
> >>> --- a/drivers/soc/fsl/Makefile
> >>> +++ b/drivers/soc/fsl/Makefile
> >>> @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/
> >>>  obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
> >>>  obj-$(CONFIG_CPM)			+=3D qe/
> >>>  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
> >>> +obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o
> >>> diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c
> >>> new file mode 100644 index 0000000..19ea14e
> >>> --- /dev/null
> >>> +++ b/drivers/soc/fsl/plat_pm.c
> >>> @@ -0,0 +1,144 @@
> >>> +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.c - Freescale
> >>> +platform PM framework // // Copyright 2018 NXP // // Author: Ran
> >>> +Wang <ran.wang_1@nxp.com>,
> >>> +
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/list.h>
> >>> +#include <linux/slab.h>
> >>> +#include <linux/err.h>
> >>> +#include <soc/fsl/plat_pm.h>
> >>> +
> >>> +
> >>> +struct plat_pm_t {
> >>> +	struct list_head node;
> >>> +	fsl_plat_pm_handle handle;
> >>> +	void *handle_priv;
> >>> +	spinlock_t	lock;
> >>> +};
> >>> +
> >>> +static struct plat_pm_t plat_pm;
> >>> +
> >>> +// register_fsl_platform_wakeup_source - Register callback function
> >>> +to plat_pm // @handle: Pointer to handle PM feature requirement //
> >>> +@handle_priv: Handler specific data struct // // Return 0 on
> >>> +success other negative errno int
> >>> +register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> >>> +		void *handle_priv)
> >>> +{
> >>> +	struct plat_pm_t *p;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	if (!handle) {
> >>> +		pr_err("FSL plat_pm: Handler invalid, reject\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	p =3D kmalloc(sizeof(*p), GFP_KERNEL);
> >>> +	if (!p)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	p->handle =3D handle;
> >>> +	p->handle_priv =3D handle_priv;
> >>> +
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_add_tail(&p->node, &plat_pm.node);
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);
> >>> +
> >>> +// Deregister_fsl_platform_wakeup_source - deregister callback
> >>> +function // @handle_priv: Handler specific data struct // // Return
> >>> +0 on success other negative errno int
> >>> +deregister_fsl_platform_wakeup_source(void *handle_priv) {
> >>> +	struct plat_pm_t *p, *tmp;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {
> >>> +		if (p->handle_priv =3D=3D handle_priv) {
> >>> +			list_del(&p->node);
> >>> +			kfree(p);
> >>> +		}
> >>> +	}
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);
> >>> +
> >>> +// fsl_platform_wakeup_config - Configure wakeup source by calling
> >>> +handlers // @dev: pointer to user's device struct // @flag: to tell
> >>> +enable or disable wakeup source // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_config(struct device *dev,
> >>> +bool flag) {
> >>> +	struct plat_pm_t *p;
> >>> +	int ret;
> >>> +	bool success_handled;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	success_handled =3D false;
> >>> +
> >>> +	// Will consider success if at least one callback return 0.
> >>> +	// Also, rest handles still get oppertunity to be executed
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_for_each_entry(p, &plat_pm.node, node) {
> >>> +		if (p->handle) {
> >>> +			ret =3D p->handle(dev, flag, p->handle_priv);
> >>> +			if (!ret)
> >>> +				success_handled =3D true;
> >> Miss a break?
> > Actually my idea is to allow more than one registered handler to
> > handle this request, so I define a flag rather than return to
> > indicated if there is at least one handler successfully do it. This des=
ign
> might give more flexibility to framework when running.
> There is only one flag(success_handled) here, how did know which handler
> failed?
>=20
> BTW, I don't think we need this flag. We can only use the return value.

Well, the plat_pm driver will not handle most errors returned by registered
handlers, except -NODEV. For -NODEV, plat_pm driver consider that handler
cannot support this request and will go to call next one.=20

Besides, actually it doesn't restrict that request can be served by only on=
e=20
handler. So I add that flag to cover the case of more than one handler can=
=20
successfully support and others might return -NODEV.

Regards,
Ran

> Cheers,
> Dongsheng
>=20
> >>> +			else if (ret !=3D -ENODEV) {
> >>> +				pr_err("FSL plat_pm: Failed to config wakeup
> >> source:%d\n", ret);
> >> Please unlock before return.
> > Yes, will fix it in next version, thanks for pointing out!
> >
> >>> +				return ret;
> >>> +			}
> >>> +		} else
> >>> +			pr_warn("FSL plat_pm: Invalid handler detected,
> >> skip\n");
> >>> +	}
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +
> >>> +	if (success_handled =3D=3D false) {
> >>> +		pr_err("FSL plat_pm: Cannot find the matchhed handler for
> >> wakeup source config\n");
> >>> +		return -ENODEV;
> >>> +	}
> >> Add this into the loop.
> > My design is that if the 1st handler return -ENODEV to indicated this
> > device it doesn't support, then the framework will continue try 2nd
> handler...
> >
> > So I think it is needed to place this checking out of loop, what do you=
 say?
> >
> > Regards,
> > Ran
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +// fsl_platform_wakeup_enable - Enable wakeup source // @dev:
> >>> +pointer to user's device struct // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_enable(struct device *dev) {
> >>> +	return fsl_platform_wakeup_config(dev, true); }
> >>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);
> >>> +
> >>> +// fsl_platform_wakeup_disable - Disable wakeup source // @dev:
> >>> +pointer to user's device struct // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_disable(struct device *dev) {
> >>> +	return fsl_platform_wakeup_config(dev, false); }
> >>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);
> >>> +
> >>> +static int __init fsl_plat_pm_init(void) {
> >>> +	spin_lock_init(&plat_pm.lock);
> >>> +	INIT_LIST_HEAD(&plat_pm.node);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +core_initcall(fsl_plat_pm_init);
> >>> diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h
> >>> new file mode 100644 index 0000000..bbe151e
> >>> --- /dev/null
> >>> +++ b/include/soc/fsl/plat_pm.h
> >>> @@ -0,0 +1,22 @@
> >>> +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.h - Freescale
> >>> +platform PM Header // // Copyright 2018 NXP // // Author: Ran Wang
> >>> +<ran.wang_1@nxp.com>,
> >>> +
> >>> +#ifndef __FSL_PLAT_PM_H
> >>> +#define __FSL_PLAT_PM_H
> >>> +
> >>> +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,
> >>> +		void *handle_priv);
> >>> +
> >>> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> >>> +		void *handle_priv);
> >>> +int deregister_fsl_platform_wakeup_source(void *handle_priv); int
> >>> +fsl_platform_wakeup_config(struct device *dev, bool flag); int
> >>> +fsl_platform_wakeup_enable(struct device *dev); int
> >>> +fsl_platform_wakeup_disable(struct device *dev);
> >>> +
> >>> +#endif	// __FSL_PLAT_PM_H
> >

