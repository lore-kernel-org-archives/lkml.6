Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8234DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDBE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kmzZdzxU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kmzZdzxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDBE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbeK1FUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:20:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeK1FUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:20:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB8A96020A; Tue, 27 Nov 2018 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543342885;
        bh=Zo6eQZ5xb0LG5TMt47WSqM3/tIekgNiQlyk4b6SezOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmzZdzxURpFrmZBi76Kbn1iLcnsmO5m7z9ETNDGudZe3y6stMo46JwDvskLNY33hA
         WicD3TpvkQ0CjWusgLu6hIX5zu725wBffrKxMZBb+Bt1809rKFsngksBObrpKX0ESy
         YA0nz1xguZd+yEgZhki441Tzos4wul8T2lZ5X+VI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF20A6020A;
        Tue, 27 Nov 2018 18:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543342885;
        bh=Zo6eQZ5xb0LG5TMt47WSqM3/tIekgNiQlyk4b6SezOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmzZdzxURpFrmZBi76Kbn1iLcnsmO5m7z9ETNDGudZe3y6stMo46JwDvskLNY33hA
         WicD3TpvkQ0CjWusgLu6hIX5zu725wBffrKxMZBb+Bt1809rKFsngksBObrpKX0ESy
         YA0nz1xguZd+yEgZhki441Tzos4wul8T2lZ5X+VI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF20A6020A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 27 Nov 2018 11:21:23 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20181127182123.GC28236@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-11-26 08:14:55)
>> On Wed, Nov 21 2018 at 14:36 -0700, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2018-11-20 16:06:47)
>> >> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
>> >> routed to the PDC as interrupts that can be used to wake the system up
>> >> from deep low power modes and suspend.
>> >>
>> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> >> ---
>> >>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 31 ++++++++++++++++++-
>> >>  1 file changed, 30 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> index 665aadb5ea28..bedfa0b57fa6 100644
>> >> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> >> @@ -29,6 +29,17 @@ SDM845 platform.
>> >>         Definition: must be 2. Specifying the pin number and flags, as defined
>> >>                     in <dt-bindings/interrupt-controller/irq.h>
>> >>
>> >> +- wakeup-parent:
>> >> +       Usage: optional
>> >> +       Value type: <phandle>
>> >> +       Definition: A phandle to the wakeup interrupt controller for the SoC.
>> >> +
>> >> +- wakeup-irq:
>> >
>> >This shouldn't be needed. TLMM driver can probe for the possibility of
>> >wakeup capable irqs from irq allocation step. The only place we should
>> >need to know what TLMM pins map to what PDC lines is in the PDC driver.
>> >
>> Why? Every driver seems to translate the hardware IRQ and pass it to
>> it's parent. Why should this be any different ? The PDC is an interrupt
>> controller that just knows an interrupt port and maps it to the GIC. Not
>> sure, I understand the reasoning for this. It seems to add more
>> confusing relationship with the PDC interrupt controller, that way.
>>
>
>Two reasons. First, simplicity. The TLMM driver just needs to pass the
>gpio number up to the PDC gpio domain and then that domain can figure
>out what hwirq it maps to within the PDC hw irq space. I don't see any
>reason why we have to know the hwirq of PDC within the TLMM driver
>besides "let's not be different".
>
>And second, it makes it easier for us to implement the MPM case in the
>TLMM driver by letting the TLMM code just ask "should I mask the irq
>here or not?" by passing that with a wrapper struct around the fwspec
>and a dedicated domain in the PDC/MPM driver. Keeping less things in the
>TLMM driver and not driving the decision from DT but from tables in the
>PDC driver also keeps things simple and reduces DT parsing code/time.
>
Couldn't this be simply achieved by matching the compatible flags for
PDC/MPM bindings for the wakeup-parent in the TLMM driver? 

Thanks,
Lina
