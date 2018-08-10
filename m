Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676AB22433
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kBpGTNE/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kBpGTNE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676AB22433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeHJSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:46:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:46:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFEB460B7B; Fri, 10 Aug 2018 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533917757;
        bh=L+VUvWlgbx0w6qxx9lBIIf7MsMw+1OD25y0Obz1hb2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBpGTNE/l21403LqqqsK/dQx6Bs17Qtwz5LJytcEofnWZS6730WnsT1dbBBl/Tlzw
         Ro98XSJG2FvR2h4fMzQbzUM9ALZTN3c15KKcW3Y5Az7HhuIMaEHpNfp78mtRvSAD8j
         tq5fNRhn91Lqgc7EUJ+lQr8YbyC+CgoImTjly59g=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EED5E60214;
        Fri, 10 Aug 2018 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533917757;
        bh=L+VUvWlgbx0w6qxx9lBIIf7MsMw+1OD25y0Obz1hb2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBpGTNE/l21403LqqqsK/dQx6Bs17Qtwz5LJytcEofnWZS6730WnsT1dbBBl/Tlzw
         Ro98XSJG2FvR2h4fMzQbzUM9ALZTN3c15KKcW3Y5Az7HhuIMaEHpNfp78mtRvSAD8j
         tq5fNRhn91Lqgc7EUJ+lQr8YbyC+CgoImTjly59g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EED5E60214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 10 Aug 2018 10:15:56 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180810161556.GC5081@codeaurora.org>
References: <20180801194538.GA6422@codeaurora.org>
 <86wot9wb9u.wl-marc.zyngier@arm.com>
 <20180802065104.GA27850@codeaurora.org>
 <86sh3xw7m9.wl-marc.zyngier@arm.com>
 <20180802125827.GB27850@codeaurora.org>
 <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
 <20180808072632.21f076b6@why.wild-wind.fr.eu.org>
 <153383585322.220756.9422019201626837843@swboyd.mtv.corp.google.com>
 <86wosypsvr.wl-marc.zyngier@arm.com>
 <153391359077.37448.3410612264580038499@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <153391359077.37448.3410612264580038499@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10 2018 at 09:06 -0600, Stephen Boyd wrote:
>Quoting Marc Zyngier (2018-08-10 00:45:12)
>> On Thu, 09 Aug 2018 18:30:53 +0100,
>> Stephen Boyd <swboyd@chromium.org> wrote:
>> >
>> > Quoting Marc Zyngier (2018-08-07 23:26:32)
>> > >
>> > > Level interrupts should be taken care of without doing anything, by the
>> > > very nature of being a level signal.
>> >
>> > Right. I suspect we'll still need to configure the PDC to actually wake
>> > up on the level triggered signal though so PDC needs to be told to
>> > unmask the line.
>>
>> Surely this can be done at suspend time with the PDC driver tracking
>> the interrupts that are configured as a wake-up source (although it
>> needs to track an interrupt that is logically connected to the TLMM,
>> which sucks).
>
>The PDC also needs to be configured for wakeups from deep CPU idle
>states where the GIC and TLMM are powered down. Lina, can you confirm
>this?
>
Yes, it will need to be handled as part of CPU idle as well, when the
last CPU powers down.

>Hooking system suspend in that case won't work. Is your hope that we can
>avoid using hierarchical irqdomains here entirely?
>
Well, I wasn't trying to avoid hierarchical irqdomains, there were
restrictions in using it. Not all GPIO pins have parent in PDC and the
ones that have are all not from the same bank either.

-- Lina

