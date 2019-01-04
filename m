Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C06C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D92218A4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mRrwnXbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfADFDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:03:50 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37271 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfADFDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:03:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so24640989lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 21:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ME8F7/tqwkC++IqaY030+2nSR1n7tVYolNeJJkHOFS0=;
        b=mRrwnXbY8e7eSM48aQWr+T73VJGKd+TdYS5JiGUbyljYGwQx6REQYm+mXQy60vckpZ
         5t2WVruQEvBhf9IOlH0LNd2eMIYkOXmpUs1cjTNP5fVECYxEQSaJCxNSN2lskHqfXqaC
         LFy5ve9P7xibp3ZlCD/bzZpzO7CXOI40z93vZE0qrkuYHlPqH8/5rvtTeyjdbttdWF83
         zCxlfCQeRoo94cvz1R5L/GXseYFex7OjB5+9bqzz0HJjVB+CqD2pYW3MxzyiHL1Qw5cr
         lqZDH5k8vTcAdObpRkby8ma6eubhui4DKbkkq5UJkSxGpGJuBdcAdyqWquE/P/IlKvPw
         H3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ME8F7/tqwkC++IqaY030+2nSR1n7tVYolNeJJkHOFS0=;
        b=MOP7FITe1q/WL9ag0xqKsiIK4dQHtUxVrvzu3TeWPzv2v3If/TiY6pctRPXvKgz9+8
         uKDQrjCK+qe8nT0E7xGJUHYMCixu9HLhgEDw3D1ktbnvUHBvOmWtz6ZTR2Stqi+n30mB
         qBBWCXg+pnGRvTXfUKhCJg5pJ25TNUt4uq7sN0r6ew0lWQ9rd0n4j2km5CJ95tUIuSWh
         i/xwr9JbZDdEdlqxTfArmP5aJdISvg9aVt/L4iOeJGgUSNlX75hfVQrByCY5AO918V0D
         4F0pOimrY5SDf0w8bJJboGIFqarjUsinlONmc3/QVk/OpxJpB/MfpuZHmZj6vcakap7y
         o9RA==
X-Gm-Message-State: AA+aEWbtyALC5zIEUzIII32AeAemnqATw9uxCdHz+AaqkhmFjU8HWqdp
        wFGm7DfM12iz0WJfkiA9UPhRjMWNO8DqI4HdlLngwA==
X-Google-Smtp-Source: AFSGD/XVc8l1UaVv+9WkdEg9eh4e2kv068Vx1cZdYWGGzuMQnEOGTUw/GsYnrwe6hI/K5HicSehK75FS2hrAzqTMyjI=
X-Received: by 2002:a19:739d:: with SMTP id h29mr26642446lfk.85.1546578227465;
 Thu, 03 Jan 2019 21:03:47 -0800 (PST)
MIME-Version: 1.0
References: <1544768442-12530-1-git-send-email-yash.shah@sifive.com>
 <1544768442-12530-2-git-send-email-yash.shah@sifive.com> <20181218172031.GA7272@bogus>
In-Reply-To: <20181218172031.GA7272@bogus>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 4 Jan 2019 10:33:36 +0530
Message-ID: <CAJ2_jOEy-0DmkzoOwezUf3+gHV3CTu04CqG1tiw5=iX-AO8xZg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] pwm: sifive: Add DT documentation for SiFive PWM Controller
To:     Rob Herring <robh@kernel.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Dec 14, 2018 at 11:50:41AM +0530, Yash Shah wrote:
> > DT documentation for PWM controller added with updated compatible
> > string.
> >
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Compatible string update]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sifive.txt         | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > new file mode 100644
> > index 0000000..250d8ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> > @@ -0,0 +1,44 @@
> > +SiFive PWM controller
> > +
> > +Unlike most other PWM controllers, the SiFive PWM controller currently only
> > +supports one period for all channels in the PWM. This is set globally in DTS.
> > +The period also has significant restrictions on the values it can achieve,
> > +which the driver rounds to the nearest achievable frequency.
> > +
> > +Required properties:
> > +- compatible: should be something similar to "sifive,<chip>-pwm" for
> > +           the PWM as integrated on a particular chip, and
> > +           "sifive,pwm<version>" for the general PWM IP block
> > +           programming model. Supported compatible strings are:
> > +           "sifive,fu540-c000-pwm" for the SiFive PWM v0 as
> > +           integrated onto the SiFive FU540 chip, and "sifive,pwm0"
> > +           for the SiFive PWM v0 IP block with no chip integration
> > +           tweaks.
>
> This should reference the common doc Paul has written and not re-explain
> the versioning scheme again.

Ok sure.

>
> > +- reg: physical base address and length of the controller's registers
> > +- clocks: The frequency the controller runs at
> > +- #pwm-cells: Should be 2.
> > +  The first cell is the PWM channel number
> > +  The second cell is the PWM polarity
> > +- sifive,approx-period: the driver will get as close to this period as it can
>
> Needs a unit suffix as defined in property-units.txt

Will be done.

>
> > +- interrupts: one interrupt per PWM channel
> > +
> > +PWM RTL that corresponds to the IP block version numbers can be found
> > +here:
> > +
> > +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> > +
> > +Further information on the format of the IP
> > +block-specific version numbers can be found in
> > +Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > +
> > +Examples:
> > +
> > +pwm:  pwm@10020000 {
> > +     compatible = "sifive,fu540-c000-pwm","sifive,pwm0";
> > +     reg = <0x0 0x10020000 0x0 0x1000>;
> > +     clocks = <&tlclk>;
> > +     interrupt-parent = <&plic>;
> > +     interrupts = <42 43 44 45>;
> > +     #pwm-cells = <2>;
> > +     sifive,approx-period = <1000000>;
> > +};
> > --
> > 1.9.1
> >

Thanks for the comments!
