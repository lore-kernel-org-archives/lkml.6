Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02395ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B113F21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tjckJiG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B113F21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeITSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:43:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52785 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeITSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:43:19 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so12953949ita.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngu4w6s9AdGDjn8xwKv2bIWVr5gDVr2rZ8xldkaEhUg=;
        b=tjckJiG3sSg9Sdj0QPVZQBPlkU4dirzPDpD8lkNp5rIzthc0CQpObUioo/xoSueXHH
         HDIscUVb2uk7521R9WraX7xmsZI9bTBOwa+zQJIVRMRQ4y5K+2+8OQRFCl5Jqv2X6Yl9
         mBMhzlZsNL8zWxdyVTvidKHGQ31zKJKeOsEzWtWN/U3sxdidMsyaMH04fG4c1vNEKH/X
         Ta0QSEw6f7ldPupZb5ae7Xi8hu66a4V2EJl+grfBsQ262X7w7jwtAwM1UAdXG7+48+h/
         E92upP8BnT2vxmIdMO2KTkDWwNxUzC6M+H7BEv8tzReZCz56P4hB/Yf3YUZswtxmEStd
         AHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngu4w6s9AdGDjn8xwKv2bIWVr5gDVr2rZ8xldkaEhUg=;
        b=PVTXQP8WSUtFJpnGxalClhpDVaVaasHkVWBPW8x99uKjZmjccvZOnsDgZ/pOPUnr7b
         jXlfknuPO2BAHgcIPNy0A5SITgXnSoU6wuzTJXUW2Rev6GmToi+GZ/yuc0gHzXor1EVo
         aXpyaIit9B1pdwJEtMoxyEsFxOEK5tNkwIRr5KQkweGnS4vngc4XW0ezctBpmtMclVTn
         o63RamyDpC0HXC7X2hb+NUwDE3rbK64V7ThwmxfiVt1eKbATYX82FwTCZtbQkGYg/iJh
         VBO5JVUAzy1+B9WS43rTZHGHKFlgB+7ZUVVqUHCfd+8rHjKtraiZ2MmYbD1vtWAhZJBR
         LQCQ==
X-Gm-Message-State: APzg51CqmE1FJNh+T5vR/lY6e//3+442gBFhS0rlsXn9YusAiiSKi3/w
        lU/NlolAOAot2k6fnLjcG/kH2obptxl4Ggdj/pSUYA==
X-Google-Smtp-Source: ANB0VdZ2sHLL6NgxoXSskBL0zgPn0YfQ002YVvdpaqVxYVEYdUdPABA9DEfB+L6xJMuezun9USRueClr/btgu/LSBAQ=
X-Received: by 2002:a24:a20f:: with SMTP id j15-v6mr1852100itf.125.1537448395026;
 Thu, 20 Sep 2018 05:59:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 05:59:54
 -0700 (PDT)
In-Reply-To: <20180828093332.20674-1-brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Sep 2018 14:59:54 +0200
Message-ID: <CAMRc=McmvkWEKV71pX9_PbNaYYf2VpovO2JrUQckWJ_0taqCZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] devres: provide and use devm_kstrdup_const()
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-28 11:33 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> This series implements devm_kstrdup_const() together with some
> prerequisite changes and uses it in pmc-atom driver.
>
> v1 -> v2:
> - fixed the changelog in the patch implementing devm_kstrdup_const()
> - fixed the kernel doc
> - moved is_kernel_rodata() to asm-generic/sections.h
> - fixed constness
>
> Bartosz Golaszewski (4):
>   devres: constify p in devm_kfree()
>   mm: move is_kernel_rodata() to asm-generic/sections.h
>   devres: provide devm_kstrdup_const()
>   clk: pmc-atom: use devm_kstrdup_const()
>
>  drivers/base/devres.c          | 43 ++++++++++++++++++++++++++++++++--
>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++-----------
>  include/asm-generic/sections.h | 14 +++++++++++
>  include/linux/device.h         |  5 +++-
>  mm/util.c                      |  7 ------
>  5 files changed, 63 insertions(+), 25 deletions(-)
>
> --
> 2.18.0
>

If there are no objections - can this be picked up for 4.20?

Thanks,
Bartosz
