Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809BCC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC702075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He88ijGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC702075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeLNBef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:34:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36380 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeLNBee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:34:34 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so7064275itj.1;
        Thu, 13 Dec 2018 17:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S8rmiMd94574Ryr5fqpe0AjQ+3eIiRjc9sdUxU2AJ4M=;
        b=He88ijGhz+a8RgLEVPFs9hN1pRfvaPCcLTttnqZyG5bpko+FxEwXO2ktGvCuT6Mc+9
         uihQ6kCkBqksPjAxVyxvtOAvjIhhXbQ/aGIED+ZzxoI9bHGbQisyOIahSx09RfOCURFS
         DX39odli1IzMkcQYIZC3tb693/RB0ltS1Lknt8b1ieWQDR0+93pe7sOYpU9uOlZSuRKW
         s41dUJBAYeUFKbF4iV8jJCUIU4qkmKqs647VFr/AnheK9aCLWWGFq/qfV721U7AFZb49
         xgIsNCm/LWu1w46kPJ0AzlPhsotAf0eOw+MaDLZkM7ppq/8n29i8B8cGL/06Lin9IvUV
         MnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S8rmiMd94574Ryr5fqpe0AjQ+3eIiRjc9sdUxU2AJ4M=;
        b=eH0uAfC3jF3a58QVdduZqA8w5jtqYH8vW42//aqvWAOjmn9ZmuiERRt2Gi495Ax0iD
         QYkO1Vkma/BPcGNAg/RZmSbHYnwBd68AAkdbUKB2Tgs0lqtdE/MV9+vKQqpYFnkqpG1a
         VhBSFM0AQyPgA5g1GGPlq7Z+spmeiCdW/xm79Wi5KWazw5i3uWRK+yqa0TA5+lT64ZuW
         V5fiDuYtuw/toNicNj1qstOoCzZ5MrwT6WqaFkbolxse8Ig1dZFrCyYSgOx587YRIEn2
         G48sEbx+StVmyOym+oOhrkv0W9fvaUv7FgyMxXN+n3bvIp8Z2nqK8KPAr9A7wzGDRvmY
         uxSw==
X-Gm-Message-State: AA+aEWbn5b96eGgvW4RIz4zdLggn5BrV52pGAv9Hid3cJzFJgaiDN3Xx
        pX3u3PLDC91tNJvmhW4ZOeVICiic129YrYT534E=
X-Google-Smtp-Source: AFSGD/WO+LIqIa5LzKNUv1a4tT8N2FPXrvvuH6gPeWbUFGKhZAANHB9Kt3ph93vdRxPz0Un1zhNb6D31mxWjJ8/z1bQ=
X-Received: by 2002:a24:c601:: with SMTP id j1mr1711528itg.130.1544751273593;
 Thu, 13 Dec 2018 17:34:33 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-9-git-send-email-pawell@cadence.com> <5BFE8883.7090802@ti.com>
 <CAL411-oKvu3EADStit=JtbcxVzM_fFGF2uPn67-wmXxPzUK6GQ@mail.gmail.com>
 <6b19b55c-66d7-439e-df8f-7b311b45af5e@ti.com> <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB470972A525D85B03C3037D3BDDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Fri, 14 Dec 2018 09:34:21 +0800
Message-ID: <CAL411-oc-_0H88egpHsc06ptL12UsaE63rWwjN7novuFFx_qbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/15] usb:cdns3: Implements device operations part
 of the API
To:     pawell@cadence.com
Cc:     nsekhar@ti.com, rogerq@ti.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        adouglas@cadence.com, jbergsagel@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com, balbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:49 AM Pawel Laszczak <pawell@cadence.com> wrote:
>
> Hi,
>
> >On 10/12/18 7:42 AM, Peter Chen wrote:
> >>>> +static struct usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadg=
et,
> >>>> +                                         struct usb_endpoint_descri=
ptor *desc,
> >>>> +                                         struct usb_ss_ep_comp_desc=
riptor *comp_desc)
> >>>> +{
> >>>> +     struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadge=
t);
> >>>> +     struct cdns3_endpoint *priv_ep;
> >>>> +     unsigned long flags;
> >>>> +
> >>>> +     priv_ep =3D cdns3_find_available_ss_ep(priv_dev, desc);
> >>>> +     if (IS_ERR(priv_ep)) {
> >>>> +             dev_err(&priv_dev->dev, "no available ep\n");
> >>>> +             return NULL;
> >>>> +     }
> >>>> +
> >>>> +     dev_dbg(&priv_dev->dev, "match endpoint: %s\n", priv_ep->name)=
;
> >>>> +
> >>>> +     spin_lock_irqsave(&priv_dev->lock, flags);
> >>>> +     priv_ep->endpoint.desc =3D desc;
> >>>> +     priv_ep->dir  =3D usb_endpoint_dir_in(desc) ? USB_DIR_IN : USB=
_DIR_OUT;
> >>>> +     priv_ep->type =3D usb_endpoint_type(desc);
> >>>> +
> >>>> +     list_add_tail(&priv_ep->ep_match_pending_list,
> >>>> +                   &priv_dev->ep_match_list);
> >>>> +     spin_unlock_irqrestore(&priv_dev->lock, flags);
> >>>> +     return &priv_ep->endpoint;
> >>>> +}
> >>> Why do you need a custom match_ep?
> >>> doesn't usb_ep_autoconfig suffice?
> >>>
> >>> You can check if EP is claimed or not by checking the ep->claimed fla=
g.
> >>>
> >> It is a special requirement for this IP, the EP type and MaxPacketSize
> >> changing can't be done at runtime, eg, at ep->enable. See below commit
> >> for detail.
> >>
> >>     usb: cdns3: gadget: configure all endpoints before set configurati=
on
> >>
> >>     Cadence IP has one limitation that all endpoints must be configure=
d
> >>     (Type & MaxPacketSize) before setting configuration through hardwa=
re
> >>     register, it means we can't change endpoints configuration after
> >>     set_configuration.
> >>
> >>     In this patch, we add non-control endpoint through usb_ss->ep_matc=
h_list,
> >>     which is added when the gadget driver uses usb_ep_autoconfig to co=
nfigure
> >>     specific endpoint; When the udc driver receives set_configurion re=
quest,
> >>     it goes through usb_ss->ep_match_list, and configure all endpoints
> >>     accordingly.
> >>
> >>     At usb_ep_ops.enable/disable, we only enable and disable endpoint =
through
> >>     ep_cfg register which can be changed after set_configuration, and =
do
> >>     some software operation accordingly.
> >
> >All this should be part of comments in code along with information about
> >controller versions which suffer from the errata.
> >
> >Is there a version of controller available which does not have the
> >defect? Is there a future plan to fix this?
> >
> >If any of that is yes, you probably want to handle this with runtime
> >detection of version (like done with DWC3_REVISION_XXX macros).
> >Sometimes the hardware-read versions themselves are incorrect, so its
> >better to introduce a version specific compatible too like
> >"cdns,usb-1.0.0" (as hinted to by Rob Herring as well).
> >
>
> custom match_ep is used and works with all versions of the gen1
> controller. Future (gen2) releases of the controller won=E2=80=99t have s=
uch
> limitation but there is no plan to change current (gen1) functionality
> of the controller.
>
> I will add comment before cdns3_gadget_match_ep function.
> Also I will change cdns,usb3 to cdns,usb3-1.0.0 and add additional
> cdns,usb3-1.0.1 compatible.
>
> cdns,usb3-1.0.1 will be for current version of controller which I use.
> cdns,usb3-1.0.0 will be for older version - Peter Chan platform.
> I now that I have some changes in controller, and one of them require
> some changes in DRD driver. It will be safer to add two separate
> version in compatibles.
>

Pawel, could we have correct register to show controller version? It is
better we could version judgement at runtime instead of static compatible.

Peter
