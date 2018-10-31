Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE5ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72C320838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iPH3BJmC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nvdoDvFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72C320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeKABpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbeKABpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C6E7A607E2; Wed, 31 Oct 2018 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541004413;
        bh=Qu4nuuk9Bg+2el6wlLAKpQupqQzb3HdvovxYZZKTxWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPH3BJmCiyoYKYfmjAS+YXkjPNLwhT8u8ZHYCIxERhKwYdB7/APQE0swGNZXxZPIh
         s5TnZaEAK74BxGyMGRxok5RIDXApxvl8d+Nha1ph9q2kK7FGOyuECLUQcFLr+rOzn+
         zHDfhKNRsm0MPvyKXbKJUC2Q/ukBVqTh91I5gnhU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 476CA6053D;
        Wed, 31 Oct 2018 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541004411;
        bh=Qu4nuuk9Bg+2el6wlLAKpQupqQzb3HdvovxYZZKTxWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvdoDvFg/cR2kBiuNywbRn4n98+9FUefi1aezOeZtFbvd/YukvY4aFH0fgj3m4TvE
         Z61WRfqsqyO2T/51htOz9DeIy74qxWUjIs7M2WrZlZYGMUp5b94bbDxuyJPRi7Qbyr
         IepyHksKs73x6LqWIPZUmeEFOcNd8BqnInhXnxD4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 476CA6053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 31 Oct 2018 10:46:50 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20181031164650.GJ17444@codeaurora.org>
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154096954339.98144.12348474096990107321@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31 2018 at 01:05 -0600, Stephen Boyd wrote:
>Hi Lina,
>
>Quoting Lina Iyer (2018-10-10 17:29:58)
>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> domain can wakeup the SoC, when interrupts and GPIOs are routed to its
>> interrupt controller. Only select GPIOs that are deemed wakeup capable
>> are routed to specific PDC pins. During low power state, the pinmux
>> interrupt controller may be non-functional but the PDC would be. The PDC
>> can detect the wakeup GPIO is triggered and bring the TLMM to an
>> operational state.
>>
>> Interrupts that are level triggered will be detected at the TLMM when
>> the controller becomes operational. Edge interrupts however need to be
>> replayed again.
>>
>> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>> but keep it disabled. During suspend, we can enable the PDC IRQ instead
>> of the GPIO IRQ, which may or not be detected.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>
>I spoke with Marc about this at ELCE last week and I think we came up
>with a plan for how to make this all work while keeping the TLMM driver
>largely unaware of what's happening. One important point that we need to
>keep in mind is that we don't want the interrupt to appear twice at the
>GIC for the same TLMM irq, once in TLMM and once in PDC. That situation
>would be quite bad and confuse things.
>
>So the plan is as follows:
>
> 1) Split PDC irqdomain into two domains. One for GIC interrupts and one
>    for TLMM interrupts
>
> 2) Support hierarchical irq domains in the TLMM driver and/or gpiolib
>
> 3) Stack the irq controllers into a hierarchy so that GIC is the parent
>    of PDC and PDC is the parent of TLMM while also leaving the TLMM
>    summary IRQ chained directly from the GIC irqdomain
>
> 4) Mask a TLMM irq in the TLMM driver and unmask the PDC irq in the PDC
>    driver when an irq_set_wake() call is made on a TLMM gpio irq that
>    PDC can monitor (and vice versa)
>
> 5) Have the PDC driver be the only driver that knows if a TLMM pin is
>    wakeup capable or not expressed in some DT table
>
>Implementing #4 will require changing TLMM irqchip to call
>irq_chip_set_wake_parent() for the .irq_set_wake op and then checking
>the return value to figure out if PDC is monitoring the pin or not and
>doing the mask/unmask dance. Furthermore, implementing #2 will be a bit
>of work that Thierry has already started for Nvidia Tegra pinctrl
>drivers.
>
We have been doing something similar downstream. But it has been quite
lot of code. The approach was to treat PDC-GPIO as a separate as
interrupt controller whose parent is the PDC. GPIOs that have PDC lines,
will be handled by the PDC-GPIO, while other GPIOs will continue to use
summary line. The hierarchy helps with the masking/unmasking and
prevents PDC interrupt from being detected as a separate interrupt than
the TLMM.

>The important part of #4 is that the irq can only happen in TLMM or in
>PDC, and not in both places because of how we mask and unmask in
>different drivers. The TLMM summary irq line can't be triggered when the
>PDC is monitoring the line.
>
>This also limits the usage of PDC to pins that are really waking up the
>system from some sort of sleep mode. Either the device driver is trying
>to wakeup from suspend so it's setting irq wake in the driver suspend
>path, or it's runtime suspending a device and wanting to wakeup from
>that device suspend state so it's again setting irq wake in runtime
>suspend. Either way, in "normal" active modes the irq path will be
>through the TLMM summary irq line and not through PDC. I don't know if
>a similar design would work for pre-PDC qcom hardware where the MPM is
>handled by RPM software.
>
Yes, we need a solution that works with both. But we can be assured that
the architecture will have either MPM or PDC, never both. The PDC is a
parallel line that is always active, while the MPM line is enabled only
when the SoC is in sleep mode.

>And finally, thinking about this after writing this mail I'm a little
>concerned that doing any sort of mask/unmask or irq movement from TLMM
>to PDC at runtime will miss edges for edge triggered interrupts. Is that
>also your concern? How is this handled with MPM? We would leave the TLMM
>interrupt enabled in that case and then have to replay the edge in
>software when resuming from suspend or idle paths but otherwise ignore
>the level type interrupts that MPM sees? I suppose MPM never gets an
>edge if TLMM gets the edge so this just works.
>
This is partly correct. Let me explain the key differences between the
current and the previous generation of the hardware to help with that.
(Let's call them PDC-based and MPM-based architectures respectively).

In MPM-based solution, the TLMM is active and is solely responsible for
notifying the CPU of the GPIOs until powered off (as part of
idle/suspend). At which point, the always-on MPM is configured for
wakeup from the GPIO. Upon sensing a signal will wake up the application
CPU using a separate MPM interrupt. The TLMM is powered on at the same
time. The CPU is interrupted by the MPM and if the GPIO was a level
interrupt the TLMM summary line will handle the GPIO. If the GPIO was an
edge interrupt the Linux MPM driver will replay the interrupt at TLMM.
Note that the MPM is not active after sending the interrupt to wakeup
the CPU.

With PDC-based solutions, the PDC is always active and can be used to
detect the interrupt even when the TLMM is active. But it could be a
problem if both the interrupt lines are configured. If we could use the
PDC interrupt line always for such GPIOs, it will solve the problem.
This patch does just that.

By using the PDC line for the PDC-based architectures, we will not
intersect the MPM-based architectures and they both can continue to use
the same driver. Only in the PDC-based architecture we will find a map
of the PDC interrupts in DT for the corresponding GPIOs. If the map is
missing or the PDC is not available, it will not be a error.

Stephen, I answered the last para in a separate email.

Thanks,
Lina


