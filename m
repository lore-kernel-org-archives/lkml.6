Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B625C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF6E20863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aeDWhHns";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j3p7wxhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfAaQek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:34:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbfAaQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:34:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD47D609CA; Thu, 31 Jan 2019 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548952478;
        bh=TgSG6OLYr1Q8S+PQ4cO/OWuvT8OqQFjjsmfDy94JTkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeDWhHnsHaQuYLWt98ECOGVAvkybapV8tpGe+dhy2w1t97A98nlsmn2TN+aZEqtlb
         PEPOLDyJRdzf8Tpq2YEhDd2f8WlmI/ARo841FT3D6ZlI747kgWpgVhvYLMqMXDzqWj
         QohNeAdXhoXPVQrn5xVYIu9vHStW/8aH3adch7DI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D77660A73;
        Thu, 31 Jan 2019 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548952476;
        bh=TgSG6OLYr1Q8S+PQ4cO/OWuvT8OqQFjjsmfDy94JTkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3p7wxhVaH+Tel/TqWj5JvnxBETDFjhT3ME4Vf+6SjBDvVB6+kRhCjqcdJeoIhBw+
         k5niEaeNPIalrgwYmzA2tkiYvvpgT960RNE79TmFac9IOrPqNkL18Z24dnACcKiVm6
         ds0qb7qCV/g0isReaqBB9xAog8FudENFYCK6H3Nk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D77660A73
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 31 Jan 2019 09:34:35 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v2 5/8] drivers: pinctrl: msm: setup GPIO irqchip
 hierarchy
Message-ID: <20190131163435.GB6069@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org>
 <20190124202205.7940-6-ilina@codeaurora.org>
 <154888832839.169292.6913084380036629941@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154888832839.169292.6913084380036629941@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30 2019 at 15:45 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-01-24 12:22:02)
>> To allow GPIOs to wakeup the system from suspend or deep idle, the
>> wakeup capable GPIOs are setup in hierarchy with interrupts from the
>> wakeup-parent irqchip.
>>
>> In older SoC's, the TLMM will handover detection to the parent irqchip
>> and in newer SoC's, the parent irqchip may also be active as well as the
>> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
>> duplicate interrupts. To enable both these configurations to exist,
>> allow the parent irqchip to dictate the TLMM irqchip's behavior when
>> masking/unmasking the interrupt.
>>
>> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>
>> ---
>> Changes in v2:
>>         - Fix bug when unmaksing PDC interrupt
>
>What was the bug? 
The problem was an incorrect merge (possibly manual), causing the PDC to
be not used at all. This is what I had -

 static void msm_gpio_irq_mask(struct irq_data *d)                                  
 {                                                                                  
         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);                      
         struct msm_pinctrl *pctrl = gpiochip_get_data(gc);                         
         const struct msm_pingroup *g;                                              
         unsigned long flags;                                                       
         u32 val;                                                                   
                                                                                    
         g = &pctrl->soc->groups[d->hwirq];                                         
                                                                                    
         if (d->parent_data)                                                        
                 irq_chip_unmask_parent(d);                                         
                                                                                    
         /* Monitored by parent wakeup controller? Keep masked */                   
         if (test_bit(d->hwirq, pctrl->wakeup_masked_irqs))                         
                 return;                                                            
                                                                                    

The above unmask_parent() call in an irq_mask() callback was the bug.

>Is that why the mask callback in this gpio chip no
>longer calls the parent irq chip? We should keep calling the parent
>irqchip from what I can tell. Otherwise, we may never mask the irq at
>the PDC and only mask it at the GPIO level, which may not even care
>about it if it's being monitored by the PDC.
>
>This causes me to get a bunch of interrupts on my touchscreen when I
>touch it once vs. only a handful (like 4) when I fix it with the below
>patch:
>
Hmm... I did not see an issue in my local testing :(
Thanks for the fix.

>Can you fold it in?
>
Yes, I will fold it in and send a rev out with the fix.

Thanks,
Lina

>diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>index dd72ec8fb8db..9b45219893bd 100644
>--- a/drivers/pinctrl/qcom/pinctrl-msm.c
>+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>@@ -682,6 +682,9 @@ static void msm_gpio_irq_mask(struct irq_data *d)
> 	clear_bit(d->hwirq, pctrl->enabled_irqs);
>
> 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>+
>+	if (d->parent_data)
>+		irq_chip_mask_parent(d);
> }
>
> static void msm_gpio_irq_unmask(struct irq_data *d)
