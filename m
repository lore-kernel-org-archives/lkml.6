Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-317938-1524189629-2-16957270734263353427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IN'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524189628; b=p+CebF+lYI6vJ8DEEw9OLD0jvp4ECM6e7PLifV+/q6B2W3BjCd
    JwHw/jrXUZPVNHaj6QGIKsk8Du54jN4ZyWJh7tgwxX1dq+HbQ6R88CGeDlKoluFt
    UJ3B+hrRSZXoYAT0eEXCKy1mX4aa205R/2OM6Y0j8e4tqN40tO/dtMk+QovvbOnH
    AY2AzmeWcMkV9llPrEOKmsTFFCbc7AGvWgnbq4tN+P0+XP+Lt8H8+tctJW3gKKUZ
    crYxHh+wLiTz2G/zGyPi2xeuJeeS77HG0O0Vbqw95oFSlkxB9Rz46ktjvd6Tzm/5
    B98CbbX1OYi8/i6ksMphHDDZ5JTz+QQdG/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524189628; bh=UTvZHI1qIa
    NF4hpjGxbgFJmQgUnaKhSxr0oTbBYgO7E=; b=VqndUEUkGjxxbAn5IgVbUwjDvF
    tbrvejd8P9jQSC5zS3XRhFK5kD0mSZ2nHnUxrNQC/MnTR+F6Vgr8LOpUvnvaoccN
    rpUKV1NyLBelWt9hTE9g1sSBCCCLy7dTKpeIM/avfxjR2JDsSQXaLWDEywB2xC1G
    U+JFPlhOq/stQOgJMbF0UXgKhpUkegkNVeV+Vqj1ls/2TGpFYUXrKpQAUKdo6TqO
    mCq56ebVHsJFgg8nZeM6CqPM4+3l215O48RMpV/vKnQBoRk07Z93N/Zasy0kapVg
    cyoIBVcoLL0hjDY9Go2YLV0jgCRSO+MixuJmjGCOkag+7MgCi9HCtJCNJhCw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=xbRdHxcZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=xbRdHxcZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFnuFPa7lMvajDFXCcnkXpWTJSZvCW6BnJB+v7RFqLHqTU5b0v/wNfLyMQCvkEiwg7MtrPy24eprbFUZMCyYSoTWKWTLxfP7liqrjPuMEpnS3+6cQgZO
    y8O7SbWZE5zypc3aElk2Uc/T9uIrGp3T0nfmxcoOw1c8MEg2OlM0xG0kS2w5KkJGsoRSL90yVP12/A631qyj00z1sjf4VPX6MucMAphbdT+f8UZgswgJkY+Q
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=m-XU2MN_NUEA:10 a=-Vr38N3OkxwA:10
    a=FZ-paitokdoA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=dw2S5ISiLjYA:10 a=VwQbUJbxAAAA:8 a=C5cPR7-2tUV0cx8x4SAA:9
    a=pCeYs4wQXgDA5_vZ:21 a=IEnrT-rVf2BChD2q:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDTCAO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 22:00:14 -0400
Received: from mail-ve1eur01on0071.outbound.protection.outlook.com ([104.47.1.71]:51504
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753784AbeDTCAM (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 19 Apr 2018 22:00:12 -0400
From: Peter Chen <peter.chen@nxp.com>
To: Yossi Mansharoff <yossim@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        Peter Rosin <peda@axentia.se>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: RE: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
Thread-Topic: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
Thread-Index: AQHT1lN0/EEznR23NUSUmIox/rpIi6QI53Fw
Date: Fri, 20 Apr 2018 02:00:08 +0000
Message-ID: <HE1PR04MB14504981D8B409CD8F9E7B7D8BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
In-Reply-To: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1498;7:Kj7yRYPw7a7dykz25P6cTDn41WMSYjUWvXZSb+fg8Venyj/VRpBaGsB3ZGWn5xRjwZvAORL4mQk2v4TnOvyQA6r3cpNDfe4+vmR9gtHVpvkSahl42UXhOvNu4EXMl8cPT9crLJ4dvlVdT8SiyZvIHf5XdLY/sLSK+DHyeOCxpe2aS3lihVyV/V/h9uBOLCoKDofOgpH3PXXaZ7LbbndpzeU0VMQVIRAHtze0Evrv5XtElqX8f6gaDo+Q9hmjPr9n
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1498;
x-ms-traffictypediagnostic: HE1PR04MB1498:
x-microsoft-antispam-prvs: <HE1PR04MB1498459DD05C3B1E32F78B3A8BB40@HE1PR04MB1498.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1498;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1498;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(476003)(446003)(5660300001)(11346002)(76176011)(8936002)(8676002)(66066001)(81166006)(54906003)(316002)(7736002)(229853002)(102836004)(7696005)(5250100002)(44832011)(110136005)(6246003)(3846002)(25786009)(478600001)(74316002)(53936002)(55016002)(186003)(26005)(4326008)(6116002)(33656002)(86362001)(9686003)(2900100001)(2906002)(305945005)(6436002)(6506007)(3280700002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1498;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: +Maod2YLn3zZYLhOwD2yygANdk7KykfMyo1630knCTLca46buYMUvWdef5f10pRw0uv8ZTpoZZ5GCyDrg7Pe7egjT0hdS8Dom+Q7+Yxls9tA3ChmQHIzBegx2D/9ujJ1GCvtkF5gPMwmYaz1YL60Q/SVQenvwNHkNsr2UAtry/jMfd/jUAF7qrmzZkiyUTq+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8fcfa9b0-0958-4dc1-0193-08d5a662718d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcfa9b0-0958-4dc1-0193-08d5a662718d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 02:00:08.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1498
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=20
=20
> --- a/drivers/usb/chipidea/Kconfig
> +++ b/drivers/usb/chipidea/Kconfig
> @@ -3,6 +3,8 @@ config USB_CHIPIDEA
>  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD
> && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
>  	select EXTCON
>  	select RESET_CONTROLLER
> +	select MULTIPLEXER
> +	select MUX_GPIO

The above two configurations are only used at your specific platforms, plea=
se add
them at either your platform defconfig or the related hardware driver's Kco=
nfig.=20

>  	help
>  	  Say Y here if your system has a dual role high speed USB
>  	  controller based on ChipIdea silicon IP. It supports:
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c in=
dex
> 33ae87f..8fa0991 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -61,6 +61,7 @@
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/ehci_def.h>
> +#include <linux/mux/consumer.h>
>=20
>  #include "ci.h"
>  #include "udc.h"
> @@ -687,6 +688,10 @@ static int ci_get_platdata(struct device *dev,
>  	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
>  		platdata->flags |=3D CI_HDRC_SET_NON_ZERO_TTHA;
>=20
> +	platdata->usb_switch =3D devm_mux_control_get_optional(dev, "usb_switch=
");
> +	if (IS_ERR(platdata->usb_switch))
> +		return PTR_ERR(platdata->usb_switch);
> +
>  	ext_id =3D ERR_PTR(-ENODEV);
>  	ext_vbus =3D ERR_PTR(-ENODEV);
>  	if (of_property_read_bool(dev->of_node, "extcon")) { diff --git
> a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c index af45aa3=
2..d9d2d00
> 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -13,6 +13,7 @@
>  #include <linux/usb/hcd.h>
>  #include <linux/usb/chipidea.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/mux/consumer.h>
>=20
>  #include "../host/ehci.h"
>=20
> @@ -161,6 +162,10 @@ static int host_start(struct ci_hdrc *ci)
>  		if (ci_otg_is_fsm_mode(ci)) {
>  			otg->host =3D &hcd->self;
>  			hcd->self.otg_port =3D 1;
> +		} else {
> +			ret =3D mux_control_select(ci->platdata->usb_switch, 1);
> +			if (ret)
> +				goto disable_reg;

What will happen if ci->platdata->usb_switch  is NULL?

>  		}
>  	}
>=20
> @@ -181,6 +186,8 @@ static void host_stop(struct ci_hdrc *ci)
>  	struct usb_hcd *hcd =3D ci->hcd;
>=20
>  	if (hcd) {
> +		if (!ci_otg_is_fsm_mode(ci))
> +			mux_control_deselect(ci->platdata->usb_switch);

Ditto.

>  		if (ci->platdata->notify_event)
>  			ci->platdata->notify_event(ci,
>  				CI_HDRC_CONTROLLER_STOPPED_EVENT);
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c inde=
x
> 9852ec5..209d3f6 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -19,6 +19,7 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg-fsm.h>
>  #include <linux/usb/chipidea.h>
> +#include <linux/mux/consumer.h>
>=20
>  #include "ci.h"
>  #include "udc.h"
> @@ -1965,16 +1966,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
>=20
>  static int udc_id_switch_for_device(struct ci_hdrc *ci)  {
> +	int ret =3D 0;
> +
>  	if (ci->is_otg)
>  		/* Clear and enable BSV irq */
>  		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
>  					OTGSC_BSVIS | OTGSC_BSVIE);
>=20
> -	return 0;
> +	if (!ci_otg_is_fsm_mode(ci))
> +		ret =3D mux_control_select(ci->platdata->usb_switch, 0);
> +

Ditto

> +	if (ci->is_otg && ret)
> +		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS,
> OTGSC_BSVIS);
> +
> +	return ret;
>  }
>=20
>  static void udc_id_switch_for_host(struct ci_hdrc *ci)  {
> +	mux_control_deselect(ci->platdata->usb_switch);
> +
>  	/*
>  	 * host doesn't care B_SESSION_VALID event
>  	 * so clear and disbale BSV irq
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h =
index
> 07f9936..9ea55a1 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -10,6 +10,7 @@
>  #include <linux/usb/otg.h>
>=20
>  struct ci_hdrc;
> +struct mux_control;
>=20
>  /**
>   * struct ci_hdrc_cable - structure for external connector cable state t=
racking @@ -
> 76,6 +77,7 @@ struct ci_hdrc_platform_data {
>  	/* VBUS and ID signal state tracking, using extcon framework */
>  	struct ci_hdrc_cable		vbus_extcon;
>  	struct ci_hdrc_cable		id_extcon;
> +	struct mux_control		*usb_switch;
>  	u32			phy_clkgate_delay_us;
=20
If CONFIG_USB_CHIPIDEA_HOST is not defined, it may cause build error

Peter
=20
