Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F77C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B75120673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MZ3xSNKl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OvuxKNE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B75120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeK3Iwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:52:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeK3Iwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:52:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57D8960B11; Thu, 29 Nov 2018 21:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543527941;
        bh=E4r21ACLbPtG15/TmqxOL5+bYnBFeK+L4fD3X6RTpaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZ3xSNKlLuyabybMIcHIf4wezCKJEaTHZyEmBnxFw8XCI7i4IVyOAfUvaHzq/XKFV
         lFnzvC8GSbyOQRv+hOfCXn7BgfvslN2XenikQI4+ZKzKIT86PpwcsHHNM7q+j0tHma
         DwNm79YmVXQHC1bFpwbkVWVYxt8JWbuPEgXOT5PE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B77460722;
        Thu, 29 Nov 2018 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543527940;
        bh=E4r21ACLbPtG15/TmqxOL5+bYnBFeK+L4fD3X6RTpaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvuxKNE6cSF2KsnIAdSyS7BgHMvldGLlQpo7jktJaXfPJUwKwCg42tN18nsdsN/qP
         VwQy7760d9/1s7NZaoop2L+m6oWbeHcOWTY28BvxYya4L0tbjoAQ7jI1k1J5kNcCQs
         E8OW49Lknd+Mk0/oWO7s8R1m5U+ThzhfDvIGAyYA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B77460722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 29 Nov 2018 14:45:39 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, evgreen@chromium.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20181129214539.GG18262@codeaurora.org>
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
 <20181127182123.GC28236@codeaurora.org>
 <154335513853.88331.9713562640538396853@swboyd.mtv.corp.google.com>
 <20181128173959.GC18262@codeaurora.org>
 <20181129002457.GJ24969@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181129002457.GJ24969@minitux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28 2018 at 17:25 -0700, Bjorn Andersson wrote:
>On Wed 28 Nov 09:39 PST 2018, Lina Iyer wrote:
>
>> On Tue, Nov 27 2018 at 14:45 -0700, Stephen Boyd wrote:
>> > Quoting Lina Iyer (2018-11-27 10:21:23)
>> > > On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
>> > > >
>> > > >Two reasons. First, simplicity. The TLMM driver just needs to pass the
>> > > >gpio number up to the PDC gpio domain and then that domain can figure
>> > > >out what hwirq it maps to within the PDC hw irq space. I don't see any
>> > > >reason why we have to know the hwirq of PDC within the TLMM driver
>> > > >besides "let's not be different".
>> > > >
>> > > >And second, it makes it easier for us to implement the MPM case in the
>> > > >TLMM driver by letting the TLMM code just ask "should I mask the irq
>> > > >here or not?" by passing that with a wrapper struct around the fwspec
>> > > >and a dedicated domain in the PDC/MPM driver. Keeping less things in the
>> > > >TLMM driver and not driving the decision from DT but from tables in the
>> > > >PDC driver also keeps things simple and reduces DT parsing code/time.
>> > > >
>> > > Couldn't this be simply achieved by matching the compatible flags for
>> > > PDC/MPM bindings for the wakeup-parent in the TLMM driver?
>> > >
>> >
>> > It could be, but then we would be making TLMM highly aware of the wakeup
>> > parent
>> It is is not aware of anything about the wakeup parent, just the
>> compatible that indicates whether it needs to be mask locally or not.
>>
>
>But the information related to how the PDC is wired to GPIO pins is a
>property related to the PDC not of the TLMM, so it does make sense to
>represent this information there.
>
Hmm.. But we are inconsistent in what we provide as input into the PDC
driver.
From the PDC driver perspective, it gets a hwirq number either when
driver requests a wakeup interrupt specified in DT as
	<&pdc 5 IRQ_TYPE_LEVEL_HIGH>
or from GPIO, which translates the GPIO to the PDC hwirq and requests
that.

>And iiuc it also makes sense to not encode it in DT because it's
>physical wiring, not configuration.
>
I would agree.

>> > and have to do compatible string matching in two places, instead
>> > of making TLMM more abstractly aware that it needs to keep things masked
>> > while irq parent deals with the interrupts.
>> >
>> Your approach seems too complex just to circumvent a simple match node.
>> I think we are stretching too much to support something that is not a
>> priority.
>>
>
>What "something" are you referring to here?
>
MPM :)

BTW, I am discussing with the internal folks here on if we need to mask
TLMM when the wakeup-parent is MPM. If we don't have to, we should be
able to follow the same model as we done in this patch and don't even
have to check the compatible or use the approach suggested by Stephen.

-- Lina
