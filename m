Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF494C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F21B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="owmXxEwT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g88qM4cP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAIRbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:31:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfAIRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:31:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3EAA460300; Wed,  9 Jan 2019 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547055073;
        bh=rPCPIXxG89REZGu/ivCRa5MBizJWl0u9JOb045U/Z2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owmXxEwTLWs7PuWv1O+aOVn2vLhw32bvRXvZJANYwZ/5TgNuOWCwutegyJjsZ+A4k
         iu+roZpXuHBBfnL2RXlA446Om3pUOgr+ee0DyiH67v4tS2s4YudnhW7ZKNmjH5m0Vz
         OTOjyOkoLXaSJg8HK86/eunVlagM7OPVvjmo0jIM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D67D8601DA;
        Wed,  9 Jan 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547055072;
        bh=rPCPIXxG89REZGu/ivCRa5MBizJWl0u9JOb045U/Z2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g88qM4cPZaKjOhpp6kQM03REx8uJtT8TZJusexqLdQ3tOQG+IIAuXlS5DmT6Z9KaZ
         TQuPuShfIrpHaco4biwuXl3fgJiHizkwqj6Hcy4GIIi7fFcX/gkBY7tqgZAykj6jyo
         Ig4o+tAP2c3j1EvlAu3A4a99Vd7bHg9BJHpF1cBo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D67D8601DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 9 Jan 2019 10:31:11 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20190109173111.GB22547@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-5-ilina@codeaurora.org>
 <20181229000714.GA3654@bogus>
 <20190107185113.GH14960@codeaurora.org>
 <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+McuN5F9_a2bmECegR65vziNATpUqt4hysKL7FT=b9RA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08 2019 at 07:49 -0700, Rob Herring wrote:
>On Mon, Jan 7, 2019 at 12:51 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Fri, Dec 28 2018 at 17:07 -0700, Rob Herring wrote:
>> >On Wed, Dec 19, 2018 at 03:11:02PM -0700, Lina Iyer wrote:
>> >> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
>> >> routed to the PDC as interrupts that can be used to wake the system up
>> >> from deep low power modes and suspend.
>> >>
>> >> Cc: devicetree@vger.kernel.org
>> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> >> ---
>> >>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
>> >>  1 file changed, 6 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> index 665aadb5ea28..a522ca46667d 100644
>> >> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> @@ -29,6 +29,11 @@ SDM845 platform.
>> >>      Definition: must be 2. Specifying the pin number and flags, as defined
>> >>                  in <dt-bindings/interrupt-controller/irq.h>
>> >>
>> >> +- wakeup-parent:
>> >> +    Usage: optional
>> >> +    Value type: <phandle>
>> >> +    Definition: A phandle to the wakeup interrupt controller for the SoC.
>> >
>> >Is this really necessary? Is there more than one possible wakeup-parent
>> >node?
>> >
>> No.  There is only one but depending on the architecture, the wakeup
>> interrupt controller could be different device like PDC on SDM845 or MPM
>> on SDM820.
>>
>> What do you have in mind? Let me know if you have a better idea than
>> referencing in DT.
>
>If there's only one possibility for a given platform, then you can
>just use of_find_compatible_node(). I don't think it matters that
>different platforms have a different device here. It's not going to be
>a large table and you may need to know the differences if there's not
>an abstracted interface to it (seems there is in your case).
The GPIO irqchip would be in hierarchy with the wakeup-parent
irqchip and no device specific functions would be called directly.
We could achieve this with compatible strings to the irqchip.

>Alternatively, if the PDC/MPM code knows what interrupt controller it
>is associated with, then it could setup that relationship and the
>interrupt controller code could retrieve that. Maybe the stacked
>domain support doesn't work in that direction (I haven't looked at the
>irq code much since that was added).
>
The PDC/MPM do not know about the association.

>However, my main concern is documenting something genericish in a
>device specific binding. It looks like Tegra is trying to add the same
>thing, so this needs to be documented in a common place. One question
>is whether wakeup is the only use or if this should be more generally
>a secondary interrupt parent?
>
Yes, wakeup is the only use of this interrupt parent. It is powered by
an always-on rail and therefore can detect some interrupts that are
routed to it even when the GIC is powered off. Though Tegra's
implementation of the irqchip is a bit different from QCOM, the idea is
generally the same. It would be helpful, if we could make this a
generic enough binding.

-- Lina

