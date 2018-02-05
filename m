Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3587241-1517868551-2-5749570162485837229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517868550; b=B2ulznxvcNQ1NvWchFZru+mwLQpkZ72fZFYc+7GPBY0ZQob
    Vh1bmhC7KcIx+Ks41GK210coOVVmXNqCltQixilsmMY77MakR8ihqLiqKIO2T3tP
    15wTje/JQMm15I02ISkocXyog0IsAChUYqspfING569qtX56Vf+KuQO3JabxcA+q
    LUdHSqxjxHQ0eIrA2t3wQVWwv1pEJK/ikcFawRkjgY013C/xAEcfNf7jB2oyRK+T
    /H+WmOvsxQbLFkODsJxLQfLwEljlyPIDkLoD8lJ31O2zDpRQqhS+XF6jhiosKeTN
    aeJ3+hJwDKJyo2h6Of8m/X1Hg0cdBETuqfir2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517868550; bh=8KmRsB2wuRHLGwv2gTnfaBAhQj9S/KPQK/4rZy
    RJB78=; b=tIaFOXZjwFHWMxOC9QIs+8ftrwP/lPI9NbeKKn9qyf8vm4HLIWAwrR
    Lnoqg94hNRdQxc9znnit5SF/2vtJGhy5zus+YU5KmVOQCmZ6Ru0vC0pJQQEUohGo
    AWoYeh2iRAkwgQBsSzbl2rz8k5Lz0vYTiMiVrkxx2T7/Y1ZG21XCLZBUGkpzSGdr
    QYanVlaTBb4k2/8cmt6DakbtGZLPUhKOcpPXHzdLBKVMzOhYvfbkC0Pd5EwWvUiG
    0ssplZ4Yvb+AQKCftu8iaRNWW5LCL26C/u5o5rTw81K8qCgDjO16/YlMTfRimFi0
    AeXUXGXMooxG66p0wO5z9a6T8pAaoxrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBEWJC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 17:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbeBEWJB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 5 Feb 2018 17:09:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D656217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x227cXDSSP8o6mNS7QW7KhRbCHAdiqFPzcgAt3Ihm/UMK0ekwKwQhlTCSNyLjX1bNJwO+JwKbz/GIJ0J2X+rvKUw=
MIME-Version: 1.0
In-Reply-To: <1511764948-20972-7-git-send-email-hao.wu@intel.com>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com> <1511764948-20972-7-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 5 Feb 2018 16:08:19 -0600
X-Gmail-Original-Message-ID: <CANk1AXSNEX_pUTdWDOsXFsgogU2xbBBZwoLJFssqzF+q=hBssA@mail.gmail.com>
Message-ID: <CANk1AXSNEX_pUTdWDOsXFsgogU2xbBBZwoLJFssqzF+q=hBssA@mail.gmail.com>
Subject: Re: [PATCH v3 06/21] fpga: dfl: adds fpga_cdev_find_port
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Nov 27, 2017 at 12:42 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

A couple comments below.

> For feature devices, e.g FPGA Management Engine (FME),

The first use I see of this function in this patchset is the FME PR,
not the FME, or am I misunderstanding?

> it may
> require fpga_cdev_find_port function to find dedicate port for
> further actions, so export this function from feature device
> driver module.

I understand the need for this function, but I'm having a hard time
following this explanation here.   Suggestion: "For feature devices,
we need a method to find the port dedicated to the device.  Add a
function fpga_cdev_find_port to do that"

>
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ----
> v3: s/fpga_for_each_port/fpga_cdev_find_port/
>     move fpga_cdev_find_port to fpga-dfl module.
> ---
>  drivers/fpga/fpga-dfl.c | 27 +++++++++++++++++++++++++++
>  drivers/fpga/fpga-dfl.h | 16 ++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/drivers/fpga/fpga-dfl.c b/drivers/fpga/fpga-dfl.c
> index 9294c0a..ce03b17 100644
> --- a/drivers/fpga/fpga-dfl.c
> +++ b/drivers/fpga/fpga-dfl.c
> @@ -873,6 +873,33 @@ void fpga_remove_feature_devs(struct fpga_cdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(fpga_remove_feature_devs);
>
> +/**
> + * __fpga_cdev_find_port - find a port under given container device
> + * @cdev: container device
> + * @data: data passed to match function
> + * @match: match function used to find specific port from the port device list
> + *
> + * Find a port device under container device. This function needs to be
> + * invoked with lock held.
> + */
> +struct platform_device *
> +__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
> +                     int (*match)(struct platform_device *, void *))
> +{
> +       struct feature_platform_data *pdata;
> +       struct platform_device *port_dev;
> +
> +       list_for_each_entry(pdata, &cdev->port_dev_list, node) {
> +               port_dev = pdata->dev;
> +
> +               if (match(port_dev, data) && get_device(&port_dev->dev))
> +                       return port_dev;

The caller will need to put the port_dev->dev.  Please document that
in the function header.  I mentioned that in v2.

Alan
