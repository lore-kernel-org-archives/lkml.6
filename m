Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF169C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EE720842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OBvjxjwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EE720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZDSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:18:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44406 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZDSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:18:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so25922610oth.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VIrmWjYtoNYdfeC+NQJSEOShHMdfoFJSzWnXP+YA/M=;
        b=OBvjxjwy34IecrdpcxjpLufXtKx65HJ4nCXrawAVOPNJJ76mZ2OowxTJFWlkJ+6jBX
         T/nTp6Lc0leUhitFplPqh3S0T2PP0Eq0IlgvZ/dTdGj5jOzNdUY3eec4NBR5TlsD2Xcn
         4R8XUvwHUqklOEWCkPIiHwouh2j2j0fzy+OoSon8dZlqfOS1ABJh3YaTgtBaHgJG0SU1
         86q3+frHC95+0mDdf+mKUzF+OtyZP4b4/geKJHKBRGMROMxl5j9PGgtoZx4N2sCe4dfn
         gl9Ko+kF0fwzfpbt5rIKnJ4jB4j0IpZyINcDIGatKJ3YkHmtPjsmLNI5H5TdkSq6tx3W
         Fw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VIrmWjYtoNYdfeC+NQJSEOShHMdfoFJSzWnXP+YA/M=;
        b=Bv4P1lbIXdXkPpgcXvH66zWLTPwJrvdth3iz37w8p3ke3JE4qcAzwBrg3ngLABJjm4
         +qUw5DysilqPrnB+DkrfdEffz6UkxVwrIFmsRnE7OVkwhFmVxmEugKln/mva1dujCdLl
         j8vZ8W3ADwAZ9GoTn/4s3DqwJvE1jibBcUgxD/pQmVlX1zR/KAKa571EYrySsNCZNxDb
         YVpPIsZt9gOA17XVHRvhrI3hYo5zQqayUB+tt2PhesVWZR3M5gNLeyENI056FFV4YiMr
         drnyJ8sJcBXu8A+GNo1tTnSM4kHkvqdPNoz+hSOcr6L7Se4k2MwgFkF6hO+C5nfBQWWA
         s3Ug==
X-Gm-Message-State: ABuFfogsxYpMdc+qcOb9TbmKvzQLB3Ih4yrZ/NhDXeKjpdbR0Y6H0GXY
        yK+9S/olUqAJp115PA/OHrwsR6+CfQ3YFXOowLMhdg==
X-Google-Smtp-Source: ACcGV63Zo5sE0KK8psJ60LwvPssdpuSRyPbvgQeza4i9y+B8g2laTMQ10eoPXzjHIrRs72KCbgioKVcLXUqwT71m9T8=
X-Received: by 2002:a9d:7555:: with SMTP id b21-v6mr908455otl.73.1537909747595;
 Tue, 25 Sep 2018 14:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180925204801.6182.73167.stgit@localhost.localdomain> <20180925205307.6182.26453.stgit@localhost.localdomain>
In-Reply-To: <20180925205307.6182.26453.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 14:08:56 -0700
Message-ID: <CAPcyv4jpUNP4mySPr5jYogpf5ZMPgpTu9oOjC89ZYHa=vL1JwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvdimm: Set device node in nd_device_register
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:56 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we don't repeatedly overwrite the device node
> for nvdimm regions. The earliest we can set the node is immediately after
> calling device init, so I have moved the code there so we can avoid
> rewriting the node with each uevent.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/nvdimm/bus.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 9148015ed803..96f4d0e1706a 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -54,12 +54,6 @@ static int to_nd_device_type(struct device *dev)
>
>  static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -       /*
> -        * Ensure that region devices always have their numa node set as
> -        * early as possible.
> -        */
> -       if (is_nd_region(dev))
> -               set_dev_node(dev, to_nd_region(dev)->numa_node);
>         return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
>                         to_nd_device_type(dev));
>  }
> @@ -519,6 +513,16 @@ void __nd_device_register(struct device *dev)
>  void nd_device_register(struct device *dev)
>  {
>         device_initialize(dev);
> +
> +       /*
> +        * Ensure that region devices always have their NUMA node set as
> +        * early as possible. This way we are able to make certain that any
> +        * memory associated with the creation and the creation itself of
> +        * the region is associated with the correct node.
> +        */
> +       if (is_nd_region(dev))
> +               set_dev_node(dev, to_nd_region(dev)->numa_node);
> +
>         __nd_device_register(dev);

Any reason to not put this inside __nd_device_register()? If you're ok
with that I can just fix up when applying.
