Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A652C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4198D2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="ROGaYjHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4198D2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeHXRdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:33:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeHXRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:33:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so6737794lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xzYYv2I0UbFTaqJtlOG+/E6PT6DAVNcTD7Q9DU+SY0=;
        b=ROGaYjHSxxyiSKLoR32oJlI5InofX5KKHMg/yqg647a0UXsnnwWbaAE18czWW3uSFy
         wfBM1IgBYyENZnsZlIKD0I5sXFYZp+K5vMXtBU3o6IRtOsbV9f43KBwnJtpwz4MYlCoI
         Bj79PacZsWwzcXPBnWbCqsuhSyzrMIHuqES5cOkhRSW8yerBYm7IIHgQw+Biom5+86yB
         7jO19hs6s0UHk2UywFs6tR09R5tr5ec890pyuh5CnlMC6DnzCJE1LXS0igsEozKJPjw7
         zM0IEDU1EVYvBeiiJlUb0ot0wnkftbXlGPsdnU+d4eKRNY7xQ86bivBggC+pRxIUasRv
         kD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xzYYv2I0UbFTaqJtlOG+/E6PT6DAVNcTD7Q9DU+SY0=;
        b=BVfc8SG9YcnDH5vmD7k5ZfZX5FZvsQ5MyMoI2miH+jH8wzjVT5+ZhlrezXoaAsb4mh
         eDZKNgZ82ycd6cILeG2O+DLLjhhlZVRKTzi/iGRdVhte8XgIRsmgFFHa1bscpkZ9Jedr
         cd5RVTsRydFXeeCSYe8vY7aRS7eLB9h8V2MIq6t7NlM44e6GCUlslWRGFKxUjm4T+q+E
         bwD7NtzH0d2saIm+HwDhAp0+8LpxO7WX+Su3MVjpS4lCp4JDR3v2Qg9uz1dd/z4a775O
         6P7BfVZtmsoPYdQzdQ0QT7aVAgpg+pPHcuArN6+L9Xd2xzuCywGfXqAMfRVD4RqzzLam
         TFlQ==
X-Gm-Message-State: APzg51Dn/285/M5MVzdA/W1cZ/amHMxw1og0hpF6yyLoapxHvIJmGlei
        uCnaSqpHDzR+hIjZGnPvjxTouRvQ2VMTUhG1ks4vgA==
X-Google-Smtp-Source: ANB0VdbbCKTzVVlwcEMG3Um8skSm8kcgp9KwcTXbWhSw/gisvoJ30PH8nK1674emyv7u0NEruoJyeaIxzi9ObtNUZ7I=
X-Received: by 2002:a19:db55:: with SMTP id s82-v6mr1425852lfg.127.1535119107633;
 Fri, 24 Aug 2018 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180727101302epcas5p22561edd1d60101e611933ccff3e3d008@epcas5p2.samsung.com>
 <20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z@epcas5p2.samsung.com>
In-Reply-To: <20180727101302epcas5p22561edd1d60101e611933ccff3e3d008~FMiUBZnCN2101321013epcas5p2Z@epcas5p2.samsung.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 24 Aug 2018 14:58:16 +0100
Message-ID: <CAPj87rPY6gTjTVdxZ4qtwtNhQPKyrfxeN2_=Z6qH3SoO9QYw+g@mail.gmail.com>
Subject: Re: [PATCH] drm/kms/crtc: Improving the func drm_mode_setcrtc
To:     Satendra Singh Thakur <satendra.t@samsung.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satendra,

On Fri, 27 Jul 2018 at 11:13, Satendra Singh Thakur
<satendra.t@samsung.com> wrote:
> Following changes are done to this func:

I would certainly agree with Sean, Martin, and Jani's comments. This
patch was difficult to follow as it made so many changes at once.
Being a crucial function which has many subtle details, it is
important to keep the _changes_ as readable as possible: not just the
final result, but the intermediate patches.

Another thing you might consider is running the igt test suite after
your patches, particularly when touching core code. Running igt
would've flagged the below:

> +       /* Check if the flag is set*/
> +       if (!crtc_req->mode_valid) {
> +               DRM_DEBUG_KMS("mode_valid flag [%d] is not set\n",
> +               crtc_req->mode_valid);
> +               return -EINVAL;
> +       }

This is a change from the previous behaviour, and not correct.
mode_valid is allowed to be NULL if there are also no connectors and
there is no FB: this disables the CRTC.

> +       /* Check the validity of count_connectors supplied by user */
> +       if (!crtc_req->count_connectors ||
> +               crtc_req->count_connectors > config->num_connector) {
> +               DRM_DEBUG_KMS("Invalid connectors' count %d\n",
> +               crtc_req->count_connectors);
> +               return -EINVAL;
> +       }

Same comment applies here.

Cheers,
Daniel
