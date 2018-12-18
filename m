Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217C421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F79QD7pK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F79QD7pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeLRSBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:01:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeLRSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:01:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D617E607CA; Tue, 18 Dec 2018 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545156112;
        bh=xoXEQo2oSV42KIejP6sHE6rxna2zx2yBedBcnZ4lxx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F79QD7pK0wvO5wRwF7xA7zpqmLfS0922FORYAWm2oQUIBoNRTy0aIUnCwAAP9/Fxv
         JllgF8cCR3MZ9WkvTyQJVJ/ZCK7VQHcAQsReWVSDQs4TzBfU+1KsMGAhnjFwR1vdNo
         px3Hrqz3v5qBOYZiR7SD4g4IN0NImspZVidUURWE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF26D6055D;
        Tue, 18 Dec 2018 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545156112;
        bh=xoXEQo2oSV42KIejP6sHE6rxna2zx2yBedBcnZ4lxx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F79QD7pK0wvO5wRwF7xA7zpqmLfS0922FORYAWm2oQUIBoNRTy0aIUnCwAAP9/Fxv
         JllgF8cCR3MZ9WkvTyQJVJ/ZCK7VQHcAQsReWVSDQs4TzBfU+1KsMGAhnjFwR1vdNo
         px3Hrqz3v5qBOYZiR7SD4g4IN0NImspZVidUURWE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF26D6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 18 Dec 2018 11:01:51 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20181218180151.GD24024@codeaurora.org>
References: <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
 <20181127182123.GC28236@codeaurora.org>
 <154335513853.88331.9713562640538396853@swboyd.mtv.corp.google.com>
 <20181128173959.GC18262@codeaurora.org>
 <20181129002457.GJ24969@minitux>
 <20181129214539.GG18262@codeaurora.org>
 <20181130183317.GL18262@codeaurora.org>
 <154388090959.88331.13819513007141877197@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154388090959.88331.13819513007141877197@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03 2018 at 16:48 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-11-30 10:33:17)
>> On Thu, Nov 29 2018 at 14:45 -0700, Lina Iyer wrote:
>> >On Wed, Nov 28 2018 at 17:25 -0700, Bjorn Andersson wrote:
>> >>On Wed 28 Nov 09:39 PST 2018, Lina Iyer wrote:
>> >>
>> >>>On Tue, Nov 27 2018 at 14:45 -0700, Stephen Boyd wrote:
>> >>>> Quoting Lina Iyer (2018-11-27 10:21:23)
>> >>>> > On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
>>
>> [...]
>> >BTW, I am discussing with the internal folks here on if we need to mask
>> >TLMM when the wakeup-parent is MPM. If we don't have to, we should be
>> >able to follow the same model as we done in this patch and don't even
>> >have to check the compatible or use the approach suggested by Stephen.
>> >
>> The TLMM and the MPM are not active at the same time. However, there is
>> a small chance they might be (a few clock cycles) when the system is
>> going down, but even then, since we replay the interrupt from the MPM
>> driver before the interrupts are serviced by Linux, we would not see
>> multiple GPIO interrupts.
>>
>> The way we have MPM working downstream, for a wakeup GPIO IRQ -
>>
>> a. Application cores gets a wakeup interrupt either from RPM or GIC (if
>> TLMM was not powered down) while still in the interrupt locked context.
>>
>> b. In the hardware, apps core handshakes with the RPM and then starts
>> resuming from the platform's system idle driver.
>>
>> c. The first CPU to wake up calls MPM driver from the idle driver, which
>> reads the shared memory to find the MPM pins that are set. Converts the
>> MPM pins to their corresponding linux interrupt and replays the
>> interrupt.
>>
>> d. Idle driver exits and wakeup GPIO interrupt is handled.
>>
>> The MPM pins are not updated after the RPM lets the application core to
>> run. Since TLMM is functional after the RPM handshake, it takes over.
>>
>
>Thanks for the background info. I don't think it really changes anything
>that we've discussed though. We still need to mask the IRQ in TLMM all
>the time when we're using the PDC and we need to leave it unmasked and
>replay edges that the MPM sees when we use the MPM. Should I clean up my
>RFC patch and post it to the list?
I have started to work on this. But feel free to post your version if
you have it ready.

Thanks for the review Stephen. I think I understand now where you are
getting with it. Sorry about all the back and forth.

Thanks,
Lina

>I'd like to see hierarchical gpio
>irqs work in general for this problem and also the SSBI/SPMI gpio irq
>problem that Linus pointed out last week.
>
