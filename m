Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0550C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8530920855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLU7WfVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfARKmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:42:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfARKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:42:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so14496573wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z1cnPhcJmCZ1RMSMplSqDUCnXR7tk58Xmb+ZyCDpN2A=;
        b=SLU7WfVciTFT1hWpyeMhtldPFTbJG8k2CRSG04V4h02TznTSWjgyxCADr9XvlyBlE6
         yXEd5acHN+q+jWPdtb1ctBGoloeGEyWVmehhbdcL3uiX0XpgCXp6uHQb5JaPNHsIY+XO
         jLrpm1SSKYPO7ZDq2MPYStKc4AsuljlFxHbbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z1cnPhcJmCZ1RMSMplSqDUCnXR7tk58Xmb+ZyCDpN2A=;
        b=FloOHEo2Dm54B9RG7pmLXNuDna5hGrzwT04eIBi9Mrict2GjAu9zu+AODAKqHTXnph
         rlwDdOgV4/cn/DcUaAqpsIuRgIvJVZR3eyPXZzdendQ8HhnfQ77k+R3k9Wr7o7Ii7rOS
         D8JQNCNy8gUHjcMiZLe9gztEUVqqwTixVY5PaZga0b8DiMixosDHn3nTtqkJDMb55Nx/
         5A7BhJo8no/VB4SZ2eLLcjP9yuKPqLLED70hJ6nkPxdOElP7xN007kba7UCIbEhujNYW
         TejkxN3ipCBnDY8ujEUnlQWiWMTRRe3xvluqZu97z0VT+mMDVLS0iS/vPkskMnHD0ZTz
         yJOQ==
X-Gm-Message-State: AJcUukeeFeoTaX5SB9HSsWSyRhZzbPRBFHk+5RkVDiqoJvjQQVpcdcvk
        QBJun5oTwIMZbjNZrTLFUf2j1A==
X-Google-Smtp-Source: ALg8bN4ezvNN/Be2ce9dhnFGqyV1iFnORTo6DHAcUKFHM+ozYHwjZ1OYLbxalVH0eACtoP1PcR8YnA==
X-Received: by 2002:adf:fa83:: with SMTP id h3mr16875038wrr.173.1547808138103;
        Fri, 18 Jan 2019 02:42:18 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:41ab:7b22:1341:1675])
        by smtp.gmail.com with ESMTPSA id e16sm131790328wrn.72.2019.01.18.02.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:42:17 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:42:15 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v5 3/3] PM/runtime:Replace jiffies based accounting with
 ktime based accounting
Message-ID: <20190118104215.GA13168@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
 <1545388436-7489-4-git-send-email-vincent.guittot@linaro.org>
 <20190117221628.GA21979@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117221628.GA21979@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le Thursday 17 Jan 2019 à 14:16:28 (-0800), Guenter Roeck a écrit :
> On Fri, Dec 21, 2018 at 11:33:56AM +0100, Vincent Guittot wrote:
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> > 
> > This patch replaces jiffies based accounting for runtime_active_time
> > and runtime_suspended_time with ktime base accounting. This makes the
> > runtime debug counters inline with genpd and other pm subsytems which
> > uses ktime based accounting.
> > 
> > timekeeping is initialized before pm_runtime_init() so ktime_get() will
> > be ready before first call. In fact, timekeeping_init() is called early
> > in start_kernel() which is way before driver_init() (and that's when
> > devices can start to be initialized) called from rest_init() via
> > kernel_init_freeable() and do_basic_setup().
> > 
> This is not (always) correct. My qemu "collie" boot test fails with this
> patch applied. Reverting the patch fixes the problem. Bisect log attached.
> 

Can you try the patch below ?
ktime_get_mono_fast_ns() has the advantage of being init with dummy clock so
it can be used at early_init.

---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ae1c728..118c7f6 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_to_ns(ktime_get());
+	u64 now = ktime_get_mono_fast_ns();
 	u64 delta;
 
 	delta = now - dev->power.accounting_timestamp;
@@ -1507,7 +1507,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
+	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4


> With some added debugging:
> 
> ...
> IRQS: 16, nr_irqs: 65, preallocated irqs: 65
> irq: Cannot allocate irq_descs @ IRQ1, assuming pre-allocated
> gpio gpiochip0: ############### pm_runtime_init() ############
> irq: Cannot allocate irq_descs @ IRQ33, assuming pre-allocated
> ############## timekeeping_init() ####################
> sched_clock: 32 bits at 3686kHz, resolution 271ns, wraps every 582542222200ns^M
> ...
> 
> This is with:
> 
> void pm_runtime_init(struct device *dev)
> {
> +       dev_info(dev, "############### pm_runtime_init() ############\n");
> +
> ...
> @@ -1526,6 +1526,8 @@ void __init timekeeping_init(void)
> 	struct clocksource *clock;
> 	unsigned long flags;
> 		 
> +       pr_info("############## timekeeping_init() ####################\n");
> +
> 
> Guenter
> 
> ---
> # bad: [a37d50ca3b837c19a297f349365d11a20c1087d0] Add linux-next specific files for 20190117
> # good: [1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8] Linux 5.0-rc2
> git bisect start 'HEAD' 'v5.0-rc2'
> # bad: [4edb817d29fdf19fb5d52784bb3c29c40e00f586] Merge remote-tracking branch 'pm/linux-next'
> git bisect bad 4edb817d29fdf19fb5d52784bb3c29c40e00f586
> # good: [6d95886720d306a1914a7c9a8aeb0bcbc7aef018] Merge remote-tracking branch 'omap/for-next'
> git bisect good 6d95886720d306a1914a7c9a8aeb0bcbc7aef018
> # good: [975b5cdd74430bc8a04f832d65a47cdb95b73fec] Merge remote-tracking branch 'fuse/for-next'
> git bisect good 975b5cdd74430bc8a04f832d65a47cdb95b73fec
> # good: [112386d2189fc54b979c3a8bf64b2908df91e123] Merge remote-tracking branch 'i2c/i2c/for-next'
> git bisect good 112386d2189fc54b979c3a8bf64b2908df91e123
> # good: [3943f059823b6e15884387f31618b84826e924b3] media: coda: Add control for h.264 chroma qp index offset
> git bisect good 3943f059823b6e15884387f31618b84826e924b3
> # good: [44970bbbbb5079ee100875b06e45db5d6e91a16e] Merge remote-tracking branch 'v4l-dvb/master'
> git bisect good 44970bbbbb5079ee100875b06e45db5d6e91a16e
> # bad: [599170c2b860aca3364574f833bb9cc801c9668d] Merge branch 'pm-core' into linux-next
> git bisect bad 599170c2b860aca3364574f833bb9cc801c9668d
> # good: [347d570919ca9a3a3653ce9cbb7399c7c0ba8248] Merge branch 'acpi-pci' into linux-next
> git bisect good 347d570919ca9a3a3653ce9cbb7399c7c0ba8248
> # good: [e0a9fde86ba1bc26dd754c733b32e70cd8f1c187] Merge branches 'acpi-tables' and 'acpi-apei' into linux-next
> git bisect good e0a9fde86ba1bc26dd754c733b32e70cd8f1c187
> # good: [3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567] drm/i915: Move on the new pm runtime interface
> git bisect good 3b4ed2e2eb5583774a1ed4aa4596a5a3c55f2567
> # bad: [c75c303933a68c547f3352d1d708843f9449d3f4] PM: clock_ops: fix missing clk_prepare() return value check
> git bisect bad c75c303933a68c547f3352d1d708843f9449d3f4
> # bad: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting
> git bisect bad 3982ab9ce433efc72ca31eb9ddc85d9355966444
> # first bad commit: [3982ab9ce433efc72ca31eb9ddc85d9355966444] PM-runtime: Replace jiffies based accounting with ktime-based accounting
