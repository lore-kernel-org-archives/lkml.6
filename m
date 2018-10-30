Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C5821104
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvJTxctE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C5821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeJ3SXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:23:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35775 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ3SXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:23:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id a10-v6so12625216qtp.2;
        Tue, 30 Oct 2018 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCj5bvoK1ZhgrUUVnfu3FBI1letkywx3bH4arwV+UJo=;
        b=hvJTxctEZeaaVYJ/NvFF5wAsigqhcQTVCBjybmD/KKvUkAHW+Sq7I3MDUJilHYo+ja
         7+Pf6BSN75rMzV2rNAdc/IIAMLTrRkJlD6SgDcYbHJRg8xBUxdppZ9JsYD6ptYFirgFe
         b8W6m5eLXbeQgHrl8f4SfyRq/uOM0OSC5HpEc7Lhc1XI5ip9LQ6YuxJRL7qJ9q1dWKIb
         +g1z6JoJLMw7GMMMPkDvkTZsvUr3ippFzYq60sdmdN5JK3hi3+5HeqSW0K6WHHm9ikS0
         o68P0a1gDVsgI9Niprt1OdvWkIO0sMQe6Wm6o6HIP1tuI8kHXOkCVYs5l9GFPUMCaH9T
         bhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCj5bvoK1ZhgrUUVnfu3FBI1letkywx3bH4arwV+UJo=;
        b=bU1KvQfPzFpEbef3Yh048e0dAa63M0Q341rWUJeeFs8sU9BaVoy4NPRDkGxtOG/yML
         Dfsskczmo/aDlrUzX8m4BSQGLh1CbduzBEPU7rJw4IaBIba4pd682IDcEEo7rsCTN5wt
         UzQ6VLssc0lYK8IFociFtWnKXJK073gzuwNjRvzB6L4c5Silsulhv0h8P/Wm4/15QyqX
         Wbg/Nubcyz4kMdTyTfHSL+97PXHzqSCGACrkydkqXz8LLA9Cr0Lb1S7Ddm1bbYGdgSMr
         qjD3idAYKGynoVTSNjYvsHilvFOQIYGBUMLjAUYfITo5DYwOGQSDdPSn4EUdUq/ZYbSS
         lKhQ==
X-Gm-Message-State: AGRZ1gLLY9ThFs3ohK1n7Kpbe3OUo6m61u4vtVSjrM/ctJidSAvuklbO
        bJ+izXMnrhS2HlE1+aJZ0oOknh1KxTOC4zdp7q+K1xqqrw0=
X-Google-Smtp-Source: AJdET5fDXeIwodjPG07EEBg9OsHWoYupOE8DS9zc/kW6f7Fsv4XSu6+x6zqo88gF+W8QvPkJ4jrloPzQj6W9KsXBIWE=
X-Received: by 2002:ac8:1909:: with SMTP id t9mr382956qtj.327.1540891869550;
 Tue, 30 Oct 2018 02:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcQ3SDQ4X9+LX+y2vB4PWQURid4R=qy5+5PkWHC5nGqQA@mail.gmail.com> <a839e9d3-838b-0fb1-55ac-07562ec71313@linux.intel.com>
In-Reply-To: <a839e9d3-838b-0fb1-55ac-07562ec71313@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 11:30:50 +0200
Message-ID: <CAHp75Vd8zUR9LYOj1X-3FgqnB_XVZD5hbA+WPN_7T_6kZBAQ5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:25 AM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> + Srinivas
>
>
> On 19-Oct-18 5:42 PM, Andy Shevchenko wrote:
> > On Sat, Oct 6, 2018 at 9:54 AM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:
> >> This adds support to show the Latency Tolerance Reporting for the IPs on
> >> the PCH as reported by the PMC. The format shown here is raw LTR data
> >> payload that can further be decoded as per the PCI specification.
> >>
> >> This also fixes some minor alignment issues in the header file by
> >> removing spaces and converting to tabs at some places.
> >>
> > I have pushed slightly modified variant of this patch to my review and
> > testing queue.
> > Though this series needs a bit more work.
>
> Thanks again for your review Andy. I see that the infradead server is
> down at the moment so i haven't seen your modifications yet.
> http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy
> says gateway timeout.

Oops, yesterday it worked perfectly.

> > I see inconsistency now with the output with the rest of nodes there.
>
> index printing is not needed for those nodes hence i never added.
>
> > I don't care much, though some can be addressed for no regression.
> >
> > For example, index printing. Please, remove it. I completely forgot
> > about userspace powerful tools. At least two very old and nice can
> > enumerate lines for you.
> > Obviously the index printing is redundant.
>
> Index printing is required here (for LTR Show and LTR Ignore) because it
> paves an obvious and easy way for the users of this driver to know the
> IP number to be used for LTR ignore. This was specifically requested by
> some customer and Srinivas asked me to implement this so adding him for
> his inputs.

So, why it should be in kernel? When user prints this, they usually
call `cat /.../file`, right?
Is it too hard to call `cat -n /.../file` instead? The benefit of such
approach is that it's independent on the file we are printing.

(Note, `grep -n <PATTERN> /.../file` does the same`)

For more variants
https://stackoverflow.com/questions/8206370/add-numbers-to-the-beginning-of-every-line-in-a-file

> I am also planning to add some documentation for this driver later so
> please consider this in current form.

Good.

-- 
With Best Regards,
Andy Shevchenko
