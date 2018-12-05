Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA92084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU4oxF7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FA92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeLEI5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:57:25 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36057 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:57:25 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so16053809ioh.3;
        Wed, 05 Dec 2018 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zERybKQJd2x47hfhSLTf44xTTD9wdxtlCkhng0jSipg=;
        b=kU4oxF7Au11Hb3CwmCYodQDJp54822xanGFsv3ZDtfifvmi9ZYr5KzJGJe1RMWAzGU
         I54ZBK7tEKkPbYbI5v471BxJwJN8WsmwB4iLN+hSrdZqb5xZ0l42o0WYgd4iWTNjwUK8
         5nHXTiU0uVzmTWKiryfQO5No942WnSCM8TerHwOyg17JQo/82Bw7yPxy8+5JFpd1iZTM
         spVSZBPnsAKgfm1BY2u3fROL2Gw6EAeFOr7FObSo3/6JAZ0HYrlu2tfvaOmzNSzsvF6F
         fkm6sbjKnvgpheNI2s/R7PdqIwHqxzAXVe1pe+xXxhp3/y9QL5YddfaA6C8IBJk+fT9+
         200Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zERybKQJd2x47hfhSLTf44xTTD9wdxtlCkhng0jSipg=;
        b=t+Jrd/q/DpD7ivZzF21kz7l4JWixpP2g79/xT8zfkwB9DxNaQqwmEXimkGMp5czfpd
         hm8ukwMQJQzeDjjVNhZ/C9xu99i+vKl+kgx785KxPc+BPNZj3Jo5YbfEovx3T4tnIELV
         AFotIhmDDtQNVBUZX/nJ3SGb3aR93xZOKRIcAMWQO6Ulsv3RRjwUcpXMFgnNYKtwchL2
         RZaiDLhOGpzfXeGemWmSKpRvexPPe9ZP92JeWsm4EgasUXPQtezcMYt+CHy//hUu3Hvp
         KrJkd+lAQbuBoYmE7hYN90MJMj4SqIFA0xIAnzL7OxnHDmquoks850qskFidNvV1fBJ6
         khPQ==
X-Gm-Message-State: AA+aEWZRPGb1LPq5gSNdZyjCDn+aaO2aOS8h9oKyKvJXgTuszgem63Wh
        cnJ8xetwadXbRwLqAodLdPHLfWWQMqVg9x9Wi/4=
X-Google-Smtp-Source: AFSGD/XfXY6LkhTIe776Y1LWSm62+8xBj5DN70c4gOjmjwTZzRPHmAM4kYv7RSeUQOI7HqzoA+PDjViEMYKMRnlkCKU=
X-Received: by 2002:a6b:8b0a:: with SMTP id n10mr19425414iod.2.1544000243348;
 Wed, 05 Dec 2018 00:57:23 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com> <5BF7E5E8.3090406@ti.com>
 <CAL411-rWc23fbP0Ny9Kfdpe9ESUSVt5X00G1uFjJf+rj-2jWzg@mail.gmail.com> <5C065AEE.4010205@ti.com>
In-Reply-To: <5C065AEE.4010205@ti.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 5 Dec 2018 16:57:12 +0800
Message-ID: <CAL411-rdMjjWBB0sKV690kpGdqiTPpMTaKsJ6aEaABgzig=cFw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
To:     rogerq@ti.com
Cc:     pawell@cadence.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        adouglas@cadence.com, jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com,
        sureshp@cadence.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
> On 04/12/18 10:50, Peter Chen wrote:
> >>> + * Cadence USBSS DRD Driver.
> >>> + *
> >>> + * Copyright (C) 2018 Cadence.
> >>> + *
> >>> + * Author: Peter Chen <peter.chen@nxp.com>
> >>> + *         Pawel Laszczak <pawell@cadence.com>
> >>> + */
> >>> +
> >>> +#include <linux/module.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/pm_runtime.h>
> >>> +
> >>> +#include "gadget.h"
> >>> +#include "core.h"
> >>> +
> >>> +static inline struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
> >>> +{
> >>> +     WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
> >>> +     return cdns->roles[cdns->role];
> >>> +}
> >>> +
> >>> +static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     if (role >= CDNS3_ROLE_END)
> >>
> >> WARN_ON()?
> >>
> >>> +             return 0;
> >>> +
> >>> +     if (!cdns->roles[role])
> >>> +             return -ENXIO;
> >>> +
> >>> +     mutex_lock(&cdns->mutex);
> >>> +     cdns->role = role;
> >>> +     ret = cdns->roles[role]->start(cdns);
> >>> +     mutex_unlock(&cdns->mutex);
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static inline void cdns3_role_stop(struct cdns3 *cdns)
> >>> +{
> >>> +     enum cdns3_roles role = cdns->role;
> >>> +
> >>> +     if (role == CDNS3_ROLE_END)
> >>
> >> WARN_ON(role >= CNDS3_ROLE_END) ?
> >>
> >>> +             return;
> >>> +
> >>> +     mutex_lock(&cdns->mutex);
> >>> +     cdns->roles[role]->stop(cdns);
> >>> +     cdns->role = CDNS3_ROLE_END;
> >>
> >> Why change the role here? You are just stopping the role not changing it.
> >> I think cdns->role should remain unchanged, so we can call cdns3_role_start()
> >> if required without error.
> >>
> >
> > The current version of this IP has some issues to detect vbus status correctly,
> > we have to force vbus status accordingly, so we need a status to indicate
> > vbus disconnection, and add some code to let controller know vbus
> > removal, in that case, the controller's state machine can be correct.
> > So, we increase one role 'CDNS3_ROLE_END' to for this purpose.
> >
> > CDNS3_ROLE_GADGET: gadget mode and VBUS on
> > CDNS3_ROLE_HOST: host mode and VBUS on
> > CDNS3_ROLE_END: VBUS off, eg either host or device cable on the port.
> >
> > So, we may start role from CDNS3_ROLE_END at probe when nothing is connected,
> > and need to set role as CDNS3_ROLE_END at ->stop for further handling at
> > role switch routine.
>
> OK. but still this (changing to ROLE_END) must be moved to the role switch routine
> and the explanation you just mentioned must be added there.
>

If we use host part as separate driver, something may need to change.
The ROLE_END
may need to add at role switch routine as your said.

> >
> >>> +     mutex_unlock(&cdns->mutex);
> >>> +}
> >>> +
> >>> +static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
> >>> +{
> >>> +     if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
> >>> +             //TODO: implements selecting device/host mode
> >>> +             return CDNS3_ROLE_HOST;
> >>> +     }
> >>> +     return cdns->roles[CDNS3_ROLE_HOST]
> >>> +             ? CDNS3_ROLE_HOST
> >>> +             : CDNS3_ROLE_GADGET;
> >>
> >> Why not just
> >>         return cdns->role;
> >>
> >> I'm wondering if we really need this function.
> >
> > cdns->role gets from cdns3_get_role, and this API tells role at the runtime.
> > If both roles are supported, the role is decided by external
> > conditions, eg, vbus/id
> > or external connector. If only single role is supported, only one role structure
> > is allocated, cdns->roles[CDNS3_ROLE_HOST] or cdns->roles[CDNS3_ROLE_GADGET]
> >
>
> How about adding this description in function documentation.
>

Sure, but may need to redesign it due to host part as a standalone driver.


> >>
> >> Then you can move cdns3_role_start() as well to core_init_role().
> >>
> >
> > Usually, we request irq after hardware initialization has finished, if not,
> > there may unexpected interrupt.
>
> Doesn't kernel warn if interrupt happens and there is no handler?
> To avoid that I was suggesting to request_irq first.
>

The interrupt will not happen (related bit at GIC is masked) until we
call request_irq.
And we don't want to handle interrupts until hardware initialization, don't we?

Peter
