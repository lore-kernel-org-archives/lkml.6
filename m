Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D763DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6788E26C3E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pow76olF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6788E26C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeFZU0R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:26:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45855 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeFZU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:26:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so8104888pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5oCijZqRRLjU1tU+JY9MJdRGy5LcryJVuAj8txFMAXg=;
        b=Pow76olFQal3Sm6kSwUWYPXY1bMGQs7CIKbHnaFc1X9s8iOpCzIG8n2Onqpd0aFSsh
         qLvYJog2bKpsweDf00Irq/gu3rhRzW2X9a0O8xq0VE8sq2PurLWUwR1hdAah1N/Nlc0Y
         /jrompTuNV5MDcZDod2xYjNqnirIUNUIsXkkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5oCijZqRRLjU1tU+JY9MJdRGy5LcryJVuAj8txFMAXg=;
        b=JdEeeIcWuVNcRZ2oVInQeiLCA39WkJA3mNPenJqszmo6TuknoeTJXkzOLjE95f45jP
         bVEUkep1LSzp6CQE4wpaXThd2YCTmeGhByFQxnwtgXuFYovkQODU/u6eCVX9JBQp7VQn
         MOyCLuXPZ4ul3b+pynFx35BLY5zH6eJJz5QPiJUAv2U0aVbVkZcjKei4pnwwj1ZsL9Xn
         K9BCq3NXA+o2UuRANcnZ6UidSfCidmvFSFvU0vmhyxpGOJ+9RVWfHA59CNUSEsAOUef1
         acyXaNj44x318zi0pkHj1r3n7n9B5Ti77OqbASnFAuyPSiYJd7GvR72k9mBhat4uQCZS
         dEcw==
X-Gm-Message-State: APt69E2ScQJaN37jVtzio0oU+42a6IBFhShbBKGGg8GhTPzSxirFTZNY
        XqExCn5ulfNL+UXI8/aI2Yjo7A==
X-Google-Smtp-Source: AAOMgpexJcIbce9UVxx5cGtfpwpProEeMzPWKQsWcYM/7uQVVdWaVOw6O6nwtlFlpa2wP5uUeam3Yw==
X-Received: by 2002:a62:5bc4:: with SMTP id p187-v6mr2935684pfb.226.1530044775234;
        Tue, 26 Jun 2018 13:26:15 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a81-v6sm6038150pfl.167.2018.06.26.13.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:26:14 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:28:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        jason@lakedaemon.net, sudeep.holla@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, nicolas.dechesne@linaro.org
Subject: Re: [RFC PATCH] irqchip/gic-v3: Add quirk for msm8996 secured
 registers
Message-ID: <20180626202839.GI1860@tuxbook-pro>
References: <20180613114340.32550-1-srinivas.kandagatla@linaro.org>
 <2d866cd1-59a4-befb-b2de-b91f9e56804a@arm.com>
 <98209e4e-96b3-3baf-3f21-a57dc8447850@linaro.org>
 <152900843159.16708.3190914824253841690@swboyd.mtv.corp.google.com>
 <61229c8f-7de0-a798-5af4-ba5e0ea78001@arm.com>
 <152908522534.16708.13094007571453293776@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152908522534.16708.13094007571453293776@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Jun 10:53 PDT 2018, Stephen Boyd wrote:

> Quoting Marc Zyngier (2018-06-15 01:16:02)
> > On 14/06/18 21:33, Stephen Boyd wrote:
> > > Quoting Srinivas Kandagatla (2018-06-14 10:54:43)
> > >>>
> > >>>> +{
> > >>>> +    struct gic_chip_data *d = data;
> > >>>> +
> > >>>> +    d->flags |= GICV3_FLAGS_WORKAROUND_IW_GICR_WAKER;
> > >>>> +
> > >>>> +    return true;
> > >>>> +}
> > >>>> +
> > >>>> +static const struct gic_quirk gicv3_quirks[] = {
> > >>>> +    {
> > >>>> +            .desc   = "GICV3: Qualcomm MSM8996 WAKER IW",
> > >>>
> > >>> Please the erratum number in the message. It should read something like:
> > >>>
> > >>>               "GICv3: Qualcomm erratum BIGNUMBERHERE"
> > >>>
> > >>>> +            .iidr   = 0x00001070,   /* MSM8996 */
> > >>>> +            .mask   = 0x0000ffff,
> > >>>
> > >>> Please match the full GICD_IIDR register, not just the implementer and
> > >>> the revision. Unless you expect all the QC systems to have the same
> > >>> behaviour?
> > >> There seems to be more than one SoC that has this issue,  I will dig up 
> > >> more info before sending next version.
> > >>
> > > 
> > > It depends on the firmware and if that firmware decides to block or
> > > allow access to this register space. I don't see how it can be quirked
> > > based on the IIDR at all because there could be different firmware on
> > > the board that doesn't block access to the register. Can a DT property
> > > work?
> > 
> > Are you saying that the IIDR doesn't isn't unique per implementation of
> > the firmware (which, as far as the kernel is concerned in this case,
> > implements the GIC)? That would be another erratum. If we did change the
> > behaviour of the vGIC in KVM, we'd certainly change the IIDR value! This
> > is the exact same case.
> 
> I don't know for certain. All I know is that we can't assume all QC
> systems have a firmware that brings the whole system down when you read
> the WAKER register. Hopefully Srini can find out if reads to IIDR are
> being trapped by the hypervisor and emulated as something different.
> 

I took another look at the internal documentation related to this change
and concluded that it was introduced for the "lead device" on the 8996
platform. As such I expect that all publicly available 8996 devices have
this implementation.

Looking through some relevant platforms it seems like it's only 8996
that that sports a GICv3 with an IIDR of 0x1070 (e.g. 8994 has a QGICv2
with the same IIDR...), so the quirk seems reasonable in scope.

Regards,
Bjorn
