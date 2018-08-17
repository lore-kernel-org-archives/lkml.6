Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A02C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F91621878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiJAofL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F91621878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeHQNvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:51:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34764 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:51:08 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so8228876qth.1;
        Fri, 17 Aug 2018 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xQQf3cStb3Ng1psp+EpRKQUQvNp0hPjXa9IBv648SfY=;
        b=IiJAofL3EPIwDnkSTgCUAa9hIpm69KvP3b+qi6e4CRFLQVueNp+UyaCqg57ifj6aJN
         d16ePGU7ndFw/GY13IQdupw+0ove34nDT4obHMeZZKvPGgFK1TQRS5sBSXrnqEZx5e1N
         VPvPTkmnr9u1BPq/V7MUFfuA5yufz7uDIlnqYFb28SLoxhXciX6r/nZZlUo37EWdRjoC
         DiPBFDAj9FffJ0RpU2ymo0kFYzOUWhxszo8+Rw1bpVqb5YUVJhf2YXaFoKgyh/eFOpEX
         Q8Exp8yjGBf1Ib3hJpKRrkxeDRImxeKrLtZcKi0EUoHrfWi7zcdCjZgBgFktKtycdEFM
         gFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xQQf3cStb3Ng1psp+EpRKQUQvNp0hPjXa9IBv648SfY=;
        b=IFBrNY1vMG2h9M2i+kq/rPBf73P/1urvKJZzGScJnrBnXVT5Gth6WYn/x9ahBAYHAb
         jgfTMQ3IJmFyBLjEDnccclgtnItDVtLaTDPPx/ed77tvS2IA/CVK2gxuUEyZExdMUhik
         ruIKm2T2Nob0eH4DjiShRLZOIVqLPiQaSy+g5ONeZk1hznvmq44D15dsPQfjlcO3F5va
         d4AZYV1THXEZIf7LucaEiS/y+gXTm9oz9n2LLfklpvXCJVPuNAWGDLRgOIdCG01OBjks
         VbrgcJIidqAlfHrK25xe3GUBL6V0DdMihcOgyeiDfgJg554EwN/l2stnYoQSiumF+XqS
         ZjWg==
X-Gm-Message-State: AOUpUlERoYXmZbii3XYA2xAr3cQCrZ4eVvXqJ9VHCuO+QAAj6T+sBbzp
        MNaZV9Vc1nCGoyOn2HKrYzjJtudIuP3C9MA7MRY=
X-Google-Smtp-Source: AA+uWPwp9hblaQVGBdnq3zSs6KymE2lYeCoCqWrLJI/8mJVEdOk6tpn7A7gGb2eimzunOtNkY3Sxj1k7aH5q+WELwUY=
X-Received: by 2002:ac8:22f2:: with SMTP id g47-v6mr33657093qta.105.1534502889649;
 Fri, 17 Aug 2018 03:48:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 03:48:09
 -0700 (PDT)
In-Reply-To: <20180817095131.2557798-1-arnd@arndb.de>
References: <20180817095131.2557798-1-arnd@arndb.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 13:48:09 +0300
Message-ID: <CAHp75Vf2sad4PtS+97c7pWUxRpRc2zizsrZJs+Oumj+HD1KmdQ@mail.gmail.com>
Subject: Re: [PATCH] intel_punit_ipc: include linux/io.h
To:     Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> After we stop including linux/irq.h implicitly, we don't see linux/io.h
> in intel_punit_ipc.c, leading to a build failure:
>
> drivers/platform/x86/intel_punit_ipc.c: In function 'ipc_read_status':
> drivers/platform/x86/intel_punit_ipc.c:55:9: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
>
> Add back the include that is clearly needed.
>

Thanks, Randy already sent a patch

> Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
> Cc: Nicolai Stange <nstange@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/intel_punit_ipc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
> index f1afc0ebbc68..2efeab650345 100644
> --- a/drivers/platform/x86/intel_punit_ipc.c
> +++ b/drivers/platform/x86/intel_punit_ipc.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <asm/intel_punit_ipc.h>
>
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
