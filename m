Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182135-1522750825-2-10343488215990634882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522750824; b=JA2WryYChE2oA5iQsw0XzkxdCUiDqH3z2+EkJbOw/TF9wKHhMZ
    A2xRD/77MKa3Rc7L/SjsDs7A6cPFCYzgY2yHN8gGePeX/YG8x6Yvay/K/wF0FtmY
    oVRmu9Up/nftjjWDr4ipjCwvAm6sEzZJhg2mzaYgO7Selzk/aOAeKyFNqQdPHr60
    a8pb8a2hQxakCPZXPSYP1HRqCHIgib4OVHfFuJuyKBcyb4kCcHckQ325GQMEIzKp
    zqiYSyHkMEvafXH4UgrZOqYqyd15E/q1zxzICj1RZbwTp7DBwrZH8BRwND2ZI7xv
    hDtIszsfT7KJ8P/1X66hmId6Dmv+PXxed7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522750824; bh=0QnNKkU6QpLWUb3eJSuycJUKCK2842GnhFujifYQUO
    8=; b=krD3zCp7TuZzAHDCl6KK2B2Gejtn1WvzuiEQIyXNc4Nidap39q3HDYF9o+
    7j/TlhcWn1TdxMruZM4/ohLSd3x0850W0P35bihY5unuXIGLbiEnNzOKyjxXQojO
    NGIDiTqdTYWN0ugGrh5pOivy1yOKQA9KLFKt0h6SIPbiImwSlGmYDklyfyQbTRFZ
    nbgT/mI/pYCUcVGYP1q+u/quQlKlyhX5NHYzgmDQhLkNecjnyLNsQgTbe5yVkycb
    xWnphmcB74aXbSb7PzJFI25iYtrsH6FMuKnpQw2hOzbLcxpuA5Nloii7psJKxwjd
    rco5qihXw2V23Os6WVbR99sHf/AQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=miOzreI+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=miOzreI+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHz62U9Qi/57ze86y3cTLbxtikMkKIkgh7ps4vBpr1a1/8ei1RsNpQ3ozOcMMq31N882Pzvt56drbiLnQ3nUc6ni96QKTQVyfQ8OIRuGC6RxxXZ5Qope
    j/uQp16FpM7XxBisN8mGOFqVkhMerpUL4GhV3fz9wPPtcioreY8q/S4WvwcOrvhIzTO/pvd5Sckyq34cww0XSmvgnKiK2H8dFQ/YycoaNV9Vu8I1gs1T3Rqt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=FYIbVJ1ejziHwmbB8noA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbeDCKUL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 06:20:11 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38327 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbeDCKUK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 06:20:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w33AK5Zb024579
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AIpwx49I0l0g0XwtOs+OmFW1JxGUf0mzEEw8f2wSmvAg97nwv5bS0RZZkDBOfBGLfTocVTzax0/GlNxF+EGLUr2V7Fo=
MIME-Version: 1.0
In-Reply-To: <1522745178.5089.10.camel@pengutronix.de>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
 <1522742421.5089.1.camel@pengutronix.de> <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
 <1522745178.5089.10.camel@pengutronix.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Apr 2018 19:19:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
Message-ID: <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset control
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 17:46 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> On Tue, 2018-04-03 at 17:30 +0900, Masahiro Yamada wrote:
>> 2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> > On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
>> > > This driver handles the reset control in a common manner; deassert
>> > > resets before use, assert them after use.  There is no good reason
>> > > why it should be exclusive.
>> >
>> > Is this preemptive cleanup, or do you have hardware on the horizon that
>> > shares these reset lines with other peripherals?
>>
>> This patch is necessary for Socionext SoCs.
>>
>> The same reset lines are shared between
>> this dwc3-of_simple and other glue circuits.
>
> Thanks, this is helpful information.
>
>> > > Also, use devm_ for clean-up.
>> > >
>> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > > ---
>> > >
>> > > CCing Philipp Zabel.
>> > > I see his sob in commit 06c47e6286d5.
>> >
>> > At the time I was concerned with the reset_control_array addition and
>> > didn't look closely at the exclusive vs shared issue.
>> > >  drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
>> > >  1 file changed, 2 insertions(+), 5 deletions(-)
>> > >
>> > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>> > > index e54c362..bd6ab65 100644
>> > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> > > @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>> > >       platform_set_drvdata(pdev, simple);
>> > >       simple->dev = dev;
>> > >
>> > > -     simple->resets = of_reset_control_array_get_optional_exclusive(np);
>> > > +     simple->resets = devm_reset_control_array_get_optional_shared(dev);
>> >
>> > From the usage in the driver, it does indeed look like _shared reset
>> > usage is appropriate. I assume that the hardware has no need for the
>> > reset to be asserted right before probe or after remove, it just
>> > requires that the reset line is kept deasserted while the driver is
>> > probed.
>> >
>> > >       if (IS_ERR(simple->resets)) {
>> > >               ret = PTR_ERR(simple->resets);
>> > >               dev_err(dev, "failed to get device resets, err=%d\n", ret);
>> > > @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>> > >
>> > >       ret = reset_control_deassert(simple->resets);
>> > >       if (ret)
>> > > -             goto err_resetc_put;
>> > > +             return ret;
>> > >
>> > >       ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
>> > >                                               "clocks", "#clock-cells"));
>> > > @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>> > >  err_resetc_assert:
>> > >       reset_control_assert(simple->resets);
>> > >
>> > > -err_resetc_put:
>> > > -     reset_control_put(simple->resets);
>> > >       return ret;
>> > >  }
>> > >
>> > > @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
>> > >       simple->num_clocks = 0;
>> > >
>> > >       reset_control_assert(simple->resets);
>> > > -     reset_control_put(simple->resets);
>> > >
>> > >       pm_runtime_put_sync(dev);
>> > >       pm_runtime_disable(dev);
>> >
>> > Changing to devm_ changes the order here. Whether or not it could be a
>> > problem to assert the reset only after pm_runtime_put (or potentially
>> > never), I can't say. I assume this is a non-issue, but somebody who
>> > knows the hardware better would have to decide.
>>
>>
>>
>> I do not understand what you mean.
>
> Sorry for the confusion, I have mixed up things here.
>
>> Can you describe your concern in more details?
>>
>> I am not touching reset_control_assert() here.
>
> With the change to shared reset control, reset_control_assert
> potentially does nothing, so it could be possible that
> pm_runtime_put_sync cuts the power before the reset es asserted again.
>
>> I am delaying the call for reset_control_put().
>
> Yes, please disregard my comment about the devm_ change, that should
> have no effect whatsoever and looks fine to me.
>
>> If I understand reset_control_put() correctly,
>> the effects of this change are:
>>   - The ref_count and module ownership for the reset controller
>>     driver will be held a little longer
>>   - The call for kfree() will be a little bit delayed.
>
> Correct.
>
>> Why do you need knowledge about this hardware?
>
> Is it ok to keep the reset deasserted while the power is cut?
> Or do you
> have to guarantee that drivers sharing the same reset also keep the same
> power domains active?
>

If this were really a problem, the driver would have to check
the error code from reset_control_assert().


 ret = reset_control_assert(simple->resets);
 if (ret)
           return ret; /* if we cannot assert reset, do not allow
driver detach */

 pm_runtime_put_sync(dev);
 pm_runtime_disable(dev);
 return 0;



What I can tell is, the current situation is
blocking hardware with shared reset lines
from using this driver.



-- 
Best Regards
Masahiro Yamada
