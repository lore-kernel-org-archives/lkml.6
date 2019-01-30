Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1BBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2532086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF0Evtym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfA3QwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:52:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42571 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732276AbfA3QwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:52:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so59969pga.9;
        Wed, 30 Jan 2019 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAe4oiL7XpgSGsiadTBswX+8TZB0jnLCSBEdhXq10K4=;
        b=SF0Evtymv/YaSglivJmZ2qViB3KvU+MzkTo7CYX2zTr4ORpxLVUROYETfibEGjyAqQ
         qTHTgyeqmlOu2hseG/xYzRpNPPNi+v0eLcNDrVCObuQ9XEtm8rhEury3qfMjClO+a9Tn
         j/6x66PTExSSMzCPrBdayrCtt0qXFJrvXt1YiXOyfbE8RRzgmEE6k/+KBobeOhcVL5Z2
         Ruw4GhPmyfhoEwptg4eRnG5Q4MBnGZBS4WcoKHSdT7oOF5MWNnPFbD8uBEHNb7H7HVdn
         onjhUdFZoG/ug+MG0kOBAUnMcxQNbMLaxTZeL3d/kyLyGUkcL/7SCbspr8fmebf6IZmd
         E8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAe4oiL7XpgSGsiadTBswX+8TZB0jnLCSBEdhXq10K4=;
        b=bt4pQ9sZDdptC457vMij13lFagsLqMMRnuWiPfNORn5QUjuluqxTnQeOdAOPxurBkE
         MGU2X/1to85RI4vP/7p3VVBmFfrCaebBQy6D4bIveLn41OKITpZU87XjfhHnB9EJP4FQ
         R2ahuP9vLBxfEll3y7uXmlezJ3OXOJkQaSureToEi9BVDHH1hR1Mk3Jnsn73E/2Yq4be
         w8WU7I0uGNqHhEgvFVXuwCvkM7qzsXInPtr7rXNPflbJyg3uJR9DbMfbZlESrPrwmQA+
         3/RdonwtJ4d+u7um7tiDzhiAK007GSRBeqXv6WGHZHeIirOgCm65XDimdH30WqXgI4MK
         ykWw==
X-Gm-Message-State: AJcUukc4UiHa/89SZaLT5vtNESSwc/Vhl3sxOTb7iV1442gviJ7OSiiN
        ycM0hSvt5R11ui+8e11UZIKbOMHUNgkFOGV4qEI=
X-Google-Smtp-Source: ALg8bN55xp+bvjuNdeSPvLwY2896GMT26fTTUqXN88vIDVzBTMQp9f4y7sN6qSyZsOUcJe3fVy1fmLw3Xgm7fKMvtO4=
X-Received: by 2002:a63:3287:: with SMTP id y129mr28296301pgy.337.1548867127883;
 Wed, 30 Jan 2019 08:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com> <20190130160259.46919-8-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190130160259.46919-8-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 18:51:56 +0200
Message-ID: <CAHp75Vdq+T4vKsihhUJjV85-mkWfY2G=npJLPaGiGjbzD_m32w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] usb: typec: Find the ports by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 6:03 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.

> +       /*
> +        * FIXME: Check does the fwnode supports the requested SVID. If it does
> +        * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
> +        */
> +       if (con->fwnode)
> +               return class_find_device(typec_class, NULL, con->fwnode,
> +                                        typec_port_fwnode_match);
> +
> +       dev = class_find_device(typec_class, NULL, con->endpoint[ep],
> +                               typec_port_name_match);
> +
> +       return dev ? dev : ERR_PTR(-EPROBE_DEFER);

Just  to be clear, this one takes a reference on dev. Is it taken into account?

-- 
With Best Regards,
Andy Shevchenko
