Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C662C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3992B20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KzH0Cjkt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pFRUt46m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3992B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHBD7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:59:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeHBD7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:59:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C3ED6079C; Thu,  2 Aug 2018 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533175859;
        bh=dRla8oLLe98xYL+OLyHjH5Omuisr/paH8ZsFcIFXv9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzH0CjktPR1TAJhbByCDcJg6BzpIKwxt9rkm8oHzUrK9hEga+I1UF0JWjbUaOChWk
         DYxpBG150fYUnp4RZa1PBFVHjMdv+lh+jn17ZZ4GI7eCfp0+qF244oIVcuMqB4n6bf
         M5kPnZ47DsFib/9EH7zEYNGIOeJ2e+/atXfHis5U=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6273560275;
        Thu,  2 Aug 2018 02:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533175858;
        bh=dRla8oLLe98xYL+OLyHjH5Omuisr/paH8ZsFcIFXv9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFRUt46mxp8eZwqyB1szbG9+3gA8psD6+hZE36o9EAdLEc/ub3HX/CthI/jjZ5DWt
         r8KPFyHLs+2EcG+fGLtBMrJ4/DFGE8yJhCTGS1ZmBHFO++KPPUOulxzeTauaWTumJg
         sM9wbNwBP42ZJul0wZmJx7YTjcdQrnh9avKv9BX8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6273560275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 1 Aug 2018 20:10:57 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, swboyd@chromium.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180802021057.GC6422@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com>
 <20180801194538.GA6422@codeaurora.org>
 <20180801223635.GO30024@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180801223635.GO30024@minitux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01 2018 at 16:38 -0600, Bjorn Andersson wrote:
>On Wed 01 Aug 12:45 PDT 2018, Lina Iyer wrote:
>
>> Thanks for the feedback, Marc.
>>
>> On Wed, Aug 01 2018 at 00:31 -0600, Marc Zyngier wrote:
>> > On Wed, 01 Aug 2018 03:00:18 +0100,
>> > Lina Iyer <ilina@codeaurora.org> wrote:
>[..]
>> > Why isn't that the case? And if that's because the HW is broken and
>> > doesn't buffer edge interrupts, why can't you use the resend mechanism
>> > instead?
>> >
>> The PDC hardware can replay the interrupts accurately. However, it will
>> replay only the pin and its not the TLMM summary IRQ. The handler here,
>> needs to notify the driver that the wakeup interrupt happened and needs
>> to take action. If I could trip the summary IRQ in this handler that
>> would work too. Can it be done?
>>
>
>Does this means that the intr_status_reg will not hold the information
>about the interrupt events that occurred before we powered on the TLMM
>again? Or is the problem limited to it not triggering the TLMM IRQ?
>
It doesn't. The TLMM is in low power state and cannot sense interrupts.

>Can the PDC (and MPM) be used in the non-sleep use cases as well?
>
Yes. We use PDC to modify polarity of falling edge and low level
interrupts to rising edge and high level interrupt so they may be sensed
at the GIC. I am not sure about the MPM. I suspect it is not.

-- Lina
