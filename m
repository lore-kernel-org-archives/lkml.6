Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87B20779
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7yqMzLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87B20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeGLJmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:42:15 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38583 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeGLJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:42:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so54599883oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvezg0H1R5cj86TL6CQFpifq3Ylpvdob6co5WNClqus=;
        b=P7yqMzLPjCwrwoy1XZClDeczI/5YBjdUhKytIJcgjMq2a/hBcmp9/aKZUexDm/u5X2
         mgo7myItMigOzaKIi7ewUZjhqyY/C79vd0GbVm/0nyviyWR2NQTWMiIXzMhZlpPmqC8l
         ALpcCkthKbQScEdfLB0I0ArvWAYgUCGimpK/GmBzyamCPGgCp341zbYlE6b0V7gvI5t8
         K/VGjJxEJ6MqI6JqpvSrNuakna49H8f7N3fy9Fp011H4ou+xokGy51B74FiAe5WVbis6
         oDmMOSmp4Kf6nATk0dTHEz/ABnLQ0AgxvXQMX56Vvc51vaSsUlUXV6ej5DIOxlieps8d
         ixDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvezg0H1R5cj86TL6CQFpifq3Ylpvdob6co5WNClqus=;
        b=ZCfF6McLQRHZmWzFjQeWwGI/lZCI6Z9DY5PzkZ0RSOLMoCSnBIVJjqAlSrmbIRu1Wy
         Foytq8eZR8+pcSF2DzLxtwoRwe95hyEweqpYhK3Gi+IQfoc+BmhAiT3bOYtqiXIsP5wi
         wiuj42Dp3iXOsC+1osrj35ztmjUFzBK8i8ftALGFkuMiZtJWWB1sP04z0Upch2jchmYM
         Cre4KDti4FcWjx5jqb/+W00XIthgU+DFSfNwKH7j/YT6N+G3xbbq/vABHn7sLckM4auW
         Y7hvtFe2X8RXUsL3MofL36+p33Fxv7TZLxLd4bjCAhG4JYitluHIQQ9tiU1UkcRYw5sO
         ss9Q==
X-Gm-Message-State: AOUpUlGCIob9oSPUBfLEKk+CfGGIZuoZlPmitadhWXQYBiJlBOoL2gV5
        S69EDKELZWdnN/gO4hTZTFXWRCfpWPfrrUdLEr2HkA==
X-Google-Smtp-Source: AAOMgpcotcmIpiQ2dFLgny2Xj0gnyJpT/VDhhKxfW6YCTyH7FUNNo/vBnnybXus9oCY9j95XOoHSznN9C2GLEtKOhqU=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr1597772oii.216.1531388008292;
 Thu, 12 Jul 2018 02:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g45z--ucXf-So517tgrayZT6x2TGvaUvaDF7zeRNn7CPXw@mail.gmail.com> <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
In-Reply-To: <e51471e6-0f8a-bffc-34c8-1e74239fdbcf@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Jul 2018 02:33:16 -0700
Message-ID: <CAFd5g47j_h4ZrT8Eg1FZ8sAj5ekCUH20jUVub75ozdkg8_YW7Q@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        james.feist@linux.intel.com, vernon.mauery@linux.intel.com,
        Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:55 AM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
<snip>
> >> +/* Timeout for bus busy checking */
> >> +#define BUS_BUSY_CHECK_TIMEOUT                         250000 /* 250ms */
> >> +#define BUS_BUSY_CHECK_INTERVAL                                10000  /* 10ms */
> >
> > Could you add a comment on where you got these values from?
> >
>
> These are coming from ASPEED SDK code. Actually, they use 100ms for
> timeout and 10ms for interval but I increased the timeout value to
> 250ms so that it covers a various range of bus speed. I think, it
> should be computed at run time based on the current bus speed, or
> we could add these as device tree settings. How do you think about it?
>

This should definitely be a device tree setting. If one of the busses is being
used as a regular I2C bus, it could hold the bus for an unlimited amount of
time before sending a STOP. As for a default, 100ms is probably fine given
that, a) the limit will only apply to multi-master mode, and b) multi-master
mode will probably almost always be used with IPMB, or MCTP (MCTP actually
recommends a 100ms timeout for this purpose, see
https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.1.0.pdf,
symbol PT2a). That being said, if you actually want to implement IPMB, or MCTP
arbitration logic, it is much more complicated.

>  >
<snip>
> >>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >> -       if (aspeed_i2c_slave_irq(bus)) {
> >> -               dev_dbg(bus->dev, "irq handled by slave.\n");
> >> -               return IRQ_HANDLED;
> >> +       if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
> >> +               if (!aspeed_i2c_master_irq(bus))
> >
> > Why do you check the slave if master fails (or vice versa)? I
> > understand that there are some status bits that have not been handled,
> > but it doesn't seem reasonable to assume that there is state that the
> > other should do something with; the only way this would happen is if
> > the state that you think you are in does not match the status bits you
> > have been given, but if this is the case, you are already hosed; I
> > don't think trying the other handler is likely to make things better,
> > unless there is something that I am missing.
> >
>
> In most of cases, interrupt bits are set one by one but there are also a
> lot of other cases that ASPEED I2C H/W sends multiple interrupt bits
> with combining master and slave events using a single interrupt call. It
> happens much in multi-master environment than single-master. For
> example, when master is waiting for a NORMAL_STOP interrupt in its
> MASTER_STOP state, SLAVE_MATCH and RX_DONE interrupts could come along
> with the NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus - it happens a lot in BMC-ME connection
> practically. In this case, the NORMAL_STOP interrupt should be handled
> by master_irq and the SLAVE_MATCH and RX_DONE interrupts should be
> handled by slave_irq so it's the reason why this code is added.

That sucks. Well, it sounds like there are only a handful of cases in which
this can happen. Maybe enumerate these cases and error out or at least warn if
it is not one of them?

>
<snip>
> >> +       for (;;) {
> >> +               if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> >> +                     (ASPEED_I2CD_BUS_BUSY_STS |
> >> +                      ASPEED_I2CD_XFER_MODE_STS_MASK)))
> >
> > Is using the Transfer Mode State Machine bits necessary? The
> > documentation marks it as "for debugging purpose only," so relying on
> > it makes me nervous.
> >
>
> As you said, the documentation marks it as "for debugging purpose only."
> but ASPEED also uses this way in their SDK code because it's the best
> way for checking bus busy status which can cover both single and
> multi-master use cases.
>

Well, it would also be really nice to have access to this bit if someone wants
to implement MCTP. Could we maybe check with Aspeed what them meant by "for
debugging purposes only" and document it here? It makes me nervous to rely on
debugging functionality for normal usage.

> >> +                       return 0;
> >> +               if (ktime_compare(ktime_get(), timeout) > 0)
> >> +                       break;
> >> +               usleep_range((BUS_BUSY_CHECK_INTERVAL >> 2) + 1,
> >
> > Where did you get this minimum value?
> >
>
> No source for the minimum value. ASPEED uses mdelay(10) in their SDK
> but I changed that code using usleep_range and the range value was set
> with considering time stretching of usleep_range.
> regmap_read_poll_timeout was a reference for this code.

What protocol are you trying to implement on top of this? You mentioned BMC-ME
above; that's IPMB, right? For most use cases, this should work, but if you
need arbitration, you will need to do quite a bit more work.

>
> Thanks,
>
> Jae
<snip>

Cheers
