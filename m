Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B2D20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvvMkTSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfAQWQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:16:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41919 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfAQWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:16:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so5353724plm.8;
        Thu, 17 Jan 2019 14:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdahKI5qvFE77liIMcmpVMYG5NoyEyW11vWWTFWwD+c=;
        b=TvvMkTSwRKm2AvcH7R/Y5mLvKHTwicqC0pNN46iNMWOaif93w9uSj1PNZ4v7aBtnYZ
         K3eToNUG6JeXzY1H876X5FSrpgECoZMyQJpUKA+qP7cSVjuhO353BzjBXjmbkgvjmtFW
         9V54n9AxwWZfQzrtxTCSrpAYzxuUlHguvCXHjoOWyFoGaA6+B5Kw7dyRHnf/xLQYCVaN
         FJFHyNpj3F5ciGsVwXr+3atQDfG+/MhG/OI/9Faui++Oqn2W2k05zsSbftUmarWvArqv
         2hLbrKv7Z8daqsZyzG9KwIlwJjtVXDNRqOnK8DSCgpb91h3PcaFI0pRelAvQKUDHwLDG
         lXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdahKI5qvFE77liIMcmpVMYG5NoyEyW11vWWTFWwD+c=;
        b=YljbMf85Qea/c8wG3BRCLxK0oZdDv+seJbXV+4/7pxnCrmafF92ibTB6h4yvF/UZTV
         qDHY1Wj7b1te12ztW2/V9bk6HrN7DCCFpo6HXA4prXWcYiaWt0Nqi6y7/MuyNmpVHwIL
         tJysfgSSDfvikXAMj0H8flpqIGqA0CFHJSlD6GjIlbGHAjguuutnFUg8NmHoS2nntj+p
         SKYdA/UAVrbCh4hCiPjew/Iw+AYhAoMdBCnmxZsjsdlpCb+lRtiT7yQNwIAFKs2w1dkr
         Z+aQJlFNAnxGe47wM1a/PrOUY65x1ichMwIqROoRxNNcIKSwMOVr6wIGb/tdBy0HwKUz
         /1ew==
X-Gm-Message-State: AJcUukcOgmWIlvJ1e3S+k+m+V262J0Y3fGSreCl9SJnVvE2FE875b2GX
        4Q/DWcu1DdlmM4AGrBgsizjL+iaS
X-Google-Smtp-Source: ALg8bN7bX0Xx3uj2mhA2uOU7FihHO9iyfkRwfXiNJSoFQQpNLvV/N6LQXaCSF/C5At6eay6A/tsNxA==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr16585073plc.62.1547763390903;
        Thu, 17 Jan 2019 14:16:30 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184sm2999908pgd.34.2019.01.17.14.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 14:16:29 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:16:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
Message-ID: <20190117221628.GA21979@roeck-us.net>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> From: Thara Gopinath <thara.gopinath@linaro.org>
> 
> This patch replaces jiffies based accounting for runtime_active_time
> and runtime_suspended_time with ktime base accounting. This makes the
> runtime debug counters inline with genpd and other pm subsytems which
> uses ktime based accounting.
> 
> timekeeping is initialized before pm_runtime_init() so ktime_get() will
> be ready before first call. In fact, timekeeping_init() is called early
> in start_kernel() which is way before driver_init() (and that's when
> devices can start to be initialized) called from rest_init() via
> kernel_init_freeable() and do_basic_setup().
> 
This is not (always) correct. My qemu "collie" boot test fails with this
patch applied. Reverting the patch fixes the problem. Bisect log attached.

With some added debugging:

...
IRQS: 16, nr_irqs: 65, preallocated irqs: 65
irq: Cannot allocate irq_descs @ IRQ1, assuming pre-allocated
gpio gpiochip0: ############### pm_runtime_init() ############
irq: Cannot allocate irq_descs @ IRQ33, assuming pre-allocated
############## timekeeping_init() ####################
sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 582542222200ns^M
...

This is with:

void pm_runtime_init(struct device *dev)
{
+       dev_info(dev, "############### pm_runtime_init() ############\n");
+
...
@@ -1526,6 +1526,8 @@ void __init timekeeping_init(void)
	struct clocksource *clock;
	unsigned long flags;
		 
+       pr_info("############## timekeeping_init() ####################\n");
+

Guenter

---
# bad: [a37d50ca3b837c19a297f349365d11a20c1087d0] Add linux-next specific files for 20190117
# good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
git bisect start 'HEAD' 'v5.0-rc2'
# bad: [4edb817d29fdf19fb5d52784bb3c29c40e00f586] Merge remote-tracking branch 'pm/linux-next'
git bisect bad 4edb817d29fdf19fb5d52784bb3c29c40e00f586
# good: [6d95886720d306a1914a7c9a8aeb0bcbc7aef018] Merge remote-tracking branch 'omap/for-next'
git bisect good 6d95886720d306a1914a7c9a8aeb0bcbc7aef018
# good: [975b5cdd74430bc8a04f832d65a47cdb95b73fec] Merge remote-tracking branch 'fuse/for-next'
git bisect good 975b5cdd74430bc8a04f832d65a47cdb95b73fec
# good: [112386d2189fc54b979c3a8bf64b2908df91e123] Merge remote-tracking branch 'i2c/i2c/for-next'
git bisect good 112386d2189fc54b979c3a8bf64b2908df91e123
# good: [3943f059823b6e15884387f31618b84826e924b3] media: coda: Add control for h.264 chroma qp index offset
git bisect good 3943f059823b6e15884387f31618b84826e924b3
# good: [44970bbbbb5079ee100875b06e45db5d6e91a16e] Merge remote-tracking branch 'v4l-dvb/master'
git bisect good 44970bbbbb5079ee100875b06e45db5d6e91a16e
# bad: [599170c2b860aca3364574f833bb9cc801c9668d] Merge branch 'pm-core' into linux-next
git bisect bad 599170c2b860aca3364574f833bb9cc801c9668d
# good: [347d570919ca9a3a3653ce9cbb7399c7c0ba8248] Merge branch 'acpi-pci' into linux-next
git bisect good 347d570919ca9a3a3653ce9cbb7399c7c0ba8248
# good: [e0a9fde86ba1bc26dd754c733b32e70cd8f1c187] Merge branches 'acpi-tables' and 'acpi-apei' into linux-next
git bisect good e0a9fde86ba1bc26dd754c733b32e70cd8f1c187
# good: [3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567] drm/i915: Move on the new pm runtime interface
git bisect good 3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567
# bad: [c75c303933a68c547f3352d1d708843f9449d3f4] PM: clock_ops: fix missing clk_prepare() return value check
git bisect bad c75c303933a68c547f3352d1d708843f9449d3f4
# bad: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting
git bisect bad 3982ab9ce433efc72ca31eb9ddc85d9355966444
# first bad commit: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting
