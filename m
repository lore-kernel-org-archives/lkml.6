Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A1CFBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477C1208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MbfHwAma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477C1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935735AbeFMTvh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:51:37 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:38506 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935291AbeFMTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:51:36 -0400
Received: by mail-ot0-f182.google.com with SMTP id p95-v6so4384421ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p4EHI2ckgnoY/MUT2kmii0i0XU5CENUMZWHELsTd+P8=;
        b=MbfHwAmacthNUmt42PtZ2iC7LeJdUb52iJ3+eMszq4iW1eq5wP/g1HSwMOEFsCeM/E
         RzCItu2j3d9JucXJYiOZddWO8J5xtnErd/LUvOdAdbj31ECkUE1tLwi/9H2yiFK9I1oD
         WYr+ohtPnep/wgWBBuQvus9s0ygPe/gepprmsK476uqMKeeDT7HlB+hjqSNmJL0qr7w3
         4tQJsm/7esf6sbfseQX4wXJf1crtdaBlimaKjaibI7O1eE0WGLf/knpJ8PhQFF1x2Vdo
         iOjtTUXdd7cadeZC67V6EDreo5Y2y+avWKSba92SnulKxhIVmfLTWEWpj+xauiWseZ6z
         4iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p4EHI2ckgnoY/MUT2kmii0i0XU5CENUMZWHELsTd+P8=;
        b=ruzaw9p3gjm4Z56fyHuNoVC2x7P0kBW1DuQoGZzzDeEoUyDPs/CWkoZDSu07Hx6Bf2
         2+0r3UVFCtmU1fHd9juONDNT652aUp27bluEPYmsrYWjU7qE6l4xJ565Jb5VJrbr+QqB
         3HvtFOB1tIC6NoNfaMPIE7i7mGcFo9Pfis0+usDBUdrw9jgwRP+qF6+e+YikL6NV9Enz
         hID9Gu1hrODcSS2aDZX/S1AYEpyJ64hhCzis+UyyDui6HxPUfs16XUaNzVEAom6J5d/p
         2s1RD9YILPaWKjFaLLkzv27HuBszikjviYif61wfw85C7Q5yGwl+GV8BmuHOmkWGi6ul
         kddg==
X-Gm-Message-State: APt69E0ktzw+qM/8mGmp9xIkS6gKPGDRnve1Nu+oMZ5wum/DBBKxTk2m
        9tH/Q4KIpdsvGA5Z4Pt0z2a4r9fU53SpegSZL0b3hg==
X-Google-Smtp-Source: ADUXVKKGWiI5+jnx0BSWocm8JV2WGgNvqNNS3fv8xiF80kGzaVPoAzPVF4myClKUbcbNu8pVnlpB73qpyecTdg7tHM4=
X-Received: by 2002:a9d:1076:: with SMTP id o51-v6mr3716258oto.292.1528919495705;
 Wed, 13 Jun 2018 12:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:51:34
 -0700 (PDT)
In-Reply-To: <CAFhSwD9RNcsaTNdT-4DiE_BKK6zrsdBbNbGBEkBoJuwQn1JdQA@mail.gmail.com>
References: <CAFhSwD9RNcsaTNdT-4DiE_BKK6zrsdBbNbGBEkBoJuwQn1JdQA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Jun 2018 12:51:34 -0700
Message-ID: <CAPcyv4hpjNaUz6qpJ0_Wh1SAz9tS9a5HLsYSgeCh_pNZKfY74A@mail.gmail.com>
Subject: Re: OpenAFS module libafs.ko uses GPL-only symbol '__put_devmap_managed_page'
To:     Joe Gorse <jhgorse@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Andrew, Christoph, and linux-mm ]

On Wed, Jun 13, 2018 at 12:33 PM, Joe Gorse <jhgorse@gmail.com> wrote:
> Greetings,
>
> Please CC answers & comments to this email. Thanks! =)
>
> Our build is breaking as of
> commit e7638488434415aa478e78435cac8f0365737638
> Author: Dan Williams <dan.j.williams@intel.com>
> Date: Wed May 16 11:46:08 2018 -0700
>
> mm: introduce MEMORY_DEVICE_FS_DAX and CONFIG_DEV_PAGEMAP_OPS
> ... snip ...
> https://patchwork.kernel.org/patch/10412459/
>
> We do not directly use the GPL-only symbol '__put_devmap_managed_page'. It
> appears to be picked up from static-inlining in put_page(), which we need.
>
> How shall we proceed? Would it be reasonable to request the change of the
> GPL-only exports for this commit?
>
> Cheers,
> Joe Gorse
>
> P.S. The build failure, for the morbidly curious:
>> FATAL: modpost: GPL-incompatible module libafs.ko uses GPL-only symbol
>> '__put_devmap_managed_page'
>> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
>> make[6]: *** [__modpost] Error 1

I think the right answer here is to make __put_devmap_managed_page()
EXPORT_SYMBOL(), since features like devm_memremap_pages() want to
change the behavior of all users of put_page(). It again holds that
devm_memremap_pages() needs to become EXPORT_SYMBOL_GPL() because it,
not put_page(), is the interface that is leaking control of core
kernel state/infrastructure to its users.
