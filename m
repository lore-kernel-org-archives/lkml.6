Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F1AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6E420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jHbQhFX7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I60AMTvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6E420664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKABIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:08:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKABIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:08:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3734C60744; Wed, 31 Oct 2018 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541002206;
        bh=ycK0xkun4yoHBQPwyKqbHHO4j3JE7htlThPO/XOq0Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHbQhFX7TbOKOgvI+llGGsMl9sGJLQSYHEJk2A7MEkoV2CoJ8K7w9jD96J8dmr90s
         AWwof34OisiKI3OzXPVs5ElFhnzK/XMLqs2E84CEietvzOfactFICeONV2UABAjn3B
         v/89wn3ul3Vf/AhRT2rigTgBWcpGsfQb3vp42CeQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6273F6072E;
        Wed, 31 Oct 2018 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541002205;
        bh=ycK0xkun4yoHBQPwyKqbHHO4j3JE7htlThPO/XOq0Ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I60AMTvbqEkUJX0WeFLkaAj5DjbRqxyGt0IMEZefBJ59L2AzpdxwZO2LOaEIWF+LL
         TUyqr+q0MJ7Ilwah/dFYl4VDbG4qTQmfiDIyKXj38qnbs8S3HnVhKnbJuSGR5J/ATH
         j6IQd+LKpH++I/nhANDqNd5L6GaQXDmP2esd8zg8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6273F6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 31 Oct 2018 10:10:04 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, evgreen@chromium.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20181031161004.GI17444@codeaurora.org>
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
I should have removed this paragraph. This is not relevant to the
$SUBJECT patch anymore.

>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>
> So we may need
>to change #4 up above to always allocate the irq from PDC and somehow
>communicate that the irq is wakeup capable in PDC back to the TLMM
>driver so TLMM knows to keep the irq masked in the hardware forever.
>That way it can't cause the summary irq line to trigger in addition to
>the PDC one. Given that we have allocation hooks with domain hierarchy
>it may be easy enough to remove TLMM irqs from the summary irq domain
>when they can be allocated from the parent PDC domain.
>
This is exactly what this patch does. We dont want to use the GPIO IRQ
and the summary line and instead always use the PDC for all wakeup
capable GPIO IRQs. The configuration of the IRQ registers is avoided
here and therefore the TLMM never triggers the summary line at the GIC
for GPIOs that are specified in the DT. PDC is the only way to detect
the GPIO interrupt whether the system is active or not. That way we
avoid any mishaps in handshakes between the two interrupts.

Thanks,
Lina

