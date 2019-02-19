Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D85C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804ED21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGqk0SDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfBSC5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:57:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53984 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBSC5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:57:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so428428wmg.3;
        Mon, 18 Feb 2019 18:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gO6vc7xum8py5gP5ku5FxgUVgHrQ4suiwlWXv/prIbk=;
        b=aGqk0SDDMEEXENEqTkBp7Qk/gNEjqS/4ACqfVHh5Zcyb39Dzhr6Q+8q0d+2G/klDhL
         uU0LYFS/bLrljmIHL8SwgWqycZ3V2MCDoF9Jma7ryzry76gQtWHahxn+mj8/+om03EWm
         aBsYoFeM1QTTKq5e/d+yR634DdyHSFN++fYe9iEiR2kwTah7pLdY0d315AGZtQHAEJst
         QieautyqzYyuxW+iT4kSP4pCrMM2vSCte6L+DM2ON//1aD+bHFcOpM+tS8UF5cWR8jWj
         7SdSjnoqDJ9eFvXV629DzpCdQdrD2BUoBAtJG85VAbjXhZcR17YdBVScpx8RA0sSbCSK
         yLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gO6vc7xum8py5gP5ku5FxgUVgHrQ4suiwlWXv/prIbk=;
        b=CnfgBA6G8qrpxybFYtAttHQHeq7Hpj5G4HvfKEHRTs9Cea3AK3t6D1HwfVHDkvJWvs
         AFBa+0dyr7oaN3pkZqwXWCSzf6lU8xhAMJyZl4K9UpbHCNgxr3Aukx4mTw6Ex1Qa7tyq
         ma7b03cdu+wVWXUlRfehJcEPArKEoseKsaBxPtPOkDLuO6Bkv0cvP+7XATGmKFsx7pLX
         e6R2F5v8eiix960n8aoIdimcy8NACjElJmJr5UJc+hMGb9tYiSQV1uzdKWCbbSl92fsV
         mIO/22ll9N829k1fGgTzG+pkh4wepyXG/usOrqigU9H4vmwgtm9heflMtHHZXKntw2QM
         zi6g==
X-Gm-Message-State: AHQUAuaTYrs1Daq4TsVIbCZuUozmOKBYX0nmUwPwhhBS5cE/c5zLJ/eP
        Zxfz4Tmy1PW8X2zQ3v+9ZuT44iwAoTRBc3P2/wZ5nBiUpKA=
X-Google-Smtp-Source: AHgI3Ia67Glq7F9CAGwqHyVFW8GvyL1vTaVKYACuHw4vtWrWQOGHpG2JZYFszI1Uj1iaC97/1UkvFKRdEfQAWtE6IiY=
X-Received: by 2002:a1c:230e:: with SMTP id j14mr1128723wmj.9.1550545055511;
 Mon, 18 Feb 2019 18:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20190218112310.17860-1-chenyu56@huawei.com> <20190218112310.17860-8-chenyu56@huawei.com>
In-Reply-To: <20190218112310.17860-8-chenyu56@huawei.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 19 Feb 2019 10:57:23 +0800
Message-ID: <CAKgpwJXgiJYkpTxddwLFJRSvadcCw7fMbd=d510NFkyRSKaswA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] usb: dwc3: Registering a role switch in the DRD code.
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Li Jun <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Yu Chen <chenyu56@huawei.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.
>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v2:
> * Assign fwnode in dwc3_role_switch.
> ---
> ---
>  drivers/usb/dwc3/core.h |  2 ++
>  drivers/usb/dwc3/drd.c  | 45 +++++++++++++++++++++++++++++++++++++++++++=
++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 402b3c29eb26..7385544b9936 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -25,6 +25,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/role.h>
>  #include <linux/ulpi/interface.h>
>
>  #include <linux/phy/phy.h>
> @@ -1083,6 +1084,7 @@ struct dwc3 {
>         struct extcon_dev       *edev;
>         struct notifier_block   edev_nb;
>         enum usb_phy_interface  hsphy_mode;
> +       struct usb_role_switch  *role_sw;
>
>         u32                     fladj;
>         u32                     irq_gadget;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 869725d15c74..cf977bb0d62e 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -474,8 +474,42 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc=
3 *dwc)
>         return edev;
>  }
>
> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role ro=
le)
> +{
> +       u32 mode;
> +
> +       switch (role) {
> +       case USB_ROLE_HOST:
> +               mode =3D DWC3_GCTL_PRTCAP_HOST;
> +               break;
> +       case USB_ROLE_DEVICE:
> +               mode =3D DWC3_GCTL_PRTCAP_DEVICE;
> +               break;
> +       default:
> +               mode =3D DWC3_GCTL_PRTCAP_HOST;

I'd propose let dwc3 stay at device mode at default case.

> +               break;
> +       };
> +
> +       dwc3_set_mode(dev_get_drvdata(dev), mode);
> +       return 0;
> +}
> +
> +static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
> +{
> +       struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +       unsigned long flags;
> +       enum usb_role role;
> +
> +       spin_lock_irqsave(&dwc->lock, flags);
> +       role =3D dwc->current_otg_role;
> +       spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +       return role;
> +}
> +
>  int dwc3_drd_init(struct dwc3 *dwc)
>  {
> +       struct usb_role_switch_desc dwc3_role_switch =3D {0};
>         int ret, irq;
>
>         dwc->edev =3D dwc3_get_extcon(dwc);
> @@ -522,6 +556,15 @@ int dwc3_drd_init(struct dwc3 *dwc)
>                 dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>         }
>
> +       dwc3_role_switch.fwnode =3D dev_fwnode(dwc->dev);
> +       dwc3_role_switch.set =3D dwc3_usb_role_switch_set;
> +       dwc3_role_switch.get =3D dwc3_usb_role_switch_get;
> +       dwc->role_sw =3D usb_role_switch_register(dwc->dev, &dwc3_role_sw=
itch);
> +       if (ret) {
> +               dwc3_drd_exit(dwc);
> +               return PTR_ERR(dwc->role_sw);
> +       }
> +

My understanding is, if you use usb role switch, you don't need either edev=
 or
OTG block event, so this should be like:

if (device_property_read_bool(dwc->dev, "usb-role-switch")) {
           usb role switch register;
} else if (edev) {
...
} else {
...
}

Jun
>         return 0;
>  }
>
> @@ -557,4 +600,6 @@ void dwc3_drd_exit(struct dwc3 *dwc)
>
>         if (!dwc->edev)
>                 free_irq(dwc->otg_irq, dwc);
> +
> +       usb_role_switch_unregister(dwc->role_sw);
>  }
> --
> 2.15.0-rc2
>
