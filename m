Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F0EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF66208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K8M9DWn/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WAvCrM0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF66208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeH1FgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:36:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeH1FgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:36:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71452604BE; Tue, 28 Aug 2018 01:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535420814;
        bh=oaJgHnfIpOR5sk6Ay/x8VJ0oN7Ql+s8IyzsO1rZEL/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8M9DWn/XNyXLbUoF3C8APgPrDRn13rgHtBOqNGZXWXc/3GxpJUUv4O2SD52cgZU0
         S7EUmTKD6dSQ6cL4oOg2ITORBZ2eU0679kghW1lLyUAvYG8UpxCCzfl54Eur4Mwnv1
         MXxI7YZqvEHyNkxa+69Waq+CXa/JOZxRJBWg7SVU=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1301C60271;
        Tue, 28 Aug 2018 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535420813;
        bh=oaJgHnfIpOR5sk6Ay/x8VJ0oN7Ql+s8IyzsO1rZEL/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAvCrM0L0vKPZG0W5H0yzx8A26VcUqy2JFgv793dJzz15CvToAs8jsxdi6/Iciuwi
         1wBEzV8tPYwihWVPz1g8bFL9fQkKKK/qngxI+02sSulS0N8dV7Pb5H+POWKhWCE6yI
         uXr4LjTpPh+mL2owkQDqxVuwiTlnYmGOMurjrmes=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1301C60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 27 Aug 2018 19:46:52 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        rplsssn@codeaurora.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180828014652.GB13998@codeaurora.org>
References: <20180817163849.30750-1-ilina@codeaurora.org>
 <20180817163849.30750-2-ilina@codeaurora.org>
 <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
 <20180827165644.GR5081@codeaurora.org>
 <20180828002641.GC2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180828002641.GC2523@minitux>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27 2018 at 18:26 -0600, Bjorn Andersson wrote:
>On Mon 27 Aug 09:56 PDT 2018, Lina Iyer wrote:
>
>> On Sun, Aug 26 2018 at 08:33 -0600, Linus Walleij wrote:
>> > On Fri, Aug 17, 2018 at 6:39 PM Lina Iyer <ilina@codeaurora.org> wrote:
>> >
>> > > QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>> > > domain can wakeup the SoC, when interrupts and GPIOs are routed to the
>> > > its interrupt controller. Only select GPIOs that are deemed wakeup
>> > > capable are routed to specific PDC pins. During low power state, the
>> > > pinmux interrupt controller may be non-functional but the PDC would be.
>> > > The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
>> > > operational state.
>> > >
>> > > Interrupts that are level triggered will be detected at the TLMM when
>> > > the controller becomes operational. Edge interrupts however need to be
>> > > replayed again.
>> > >
>> > > Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>> > > but keep it disabled. During suspend, we can enable the PDC IRQ instead
>> > > of the GPIO IRQ, which may or not be detected.
>> > >
>> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> > > ---
>> > > Changes in v1:
>> > >         - Trigger GPIO in h/w from PDC IRQ handler
>> > >         - Avoid big tables for GPIO-PDC map, pick from DT instead
>> > >         - Use handler_data
>> >
>> > Just for the record this is an impressive and much needed patch
>> > set, no other SoC developer has yet taken on the task of making this
>> > work so I very much appreciate that Qualcomm show the way.
>> >
>> > > +static int msm_gpio_pdc_pin_request(struct irq_data *d)
>> > > +static int msm_gpio_pdc_pin_release(struct irq_data *d)
>> > > +static int msm_gpio_irq_reqres(struct irq_data *d)
>> > > +{
>> > (...)
>> > > +       if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
>> > (...)
>> > > +static void msm_gpio_irq_relres(struct irq_data *d)
>> > > +{
>> > > +       gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
>> > > +}
>> >
>> > FYI Hans Verkuil is working on a patch set that moves the
>> > lock/unlock as IRQ call to the irqchip request() and release()
>> > functions so we can switch a GPIO irqchip line from IRQ
>> > mode to say output at runtime without too much trouble.
>> > (CEC needs this.)
>> >
>> Thanks, I will look into Hans's RFCv2. But what would help me would be
>> to avoid creating the IRQ for the GPIO itself (I have the latent IRQ),
>> if I could just return that instead in gpio_to_irq(), it might be
>> easier. I understand ->to_irq() is supposed to be a translate function
>> only, I can avoid the dance of enabling and diabling the PDC IRQ on
>> suspend and resume.
>>
>
>I did implement gpio_to_irq() like this in the PMIC gpio/mpp drivers and
>we've since concluded that we need to move this to some hierarchical
>interrupt controller, because people like Linus expect to be able to say
>
>  interrupts = <&gpio_controller 1 IRQ_TYPE_EDGE_RISING>
>
>which is something used all over the place with the TLMM driver today.

Does it have to be &gpio_controller, can it be another interrupt controller?

Say,
	interrupts-extended = <&pdc 1 IRQ_TYPE_EDGE_RISING>;

-- Lina

