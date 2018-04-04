Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3786631-1522829947-2-5756846003986675491
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522829946; b=UtpP0T6od1Pn0ab/BErMNMRGE7gdBKwoXjkoVzHsZBmM9BQ8AG
    R63Nhj9Ef4Hvjxta/7wA8oZ/Nxq8qPyjv/Tgt/goVVhCODwukSPxiOey9SIeCJZY
    DfQU9DEiqWJnmJ8zAO3ZD9rrOo4lrpfGcKi74usULdwPCfnZ0kvAjI6eVXuPFX6I
    bibw+GU5pNB0mafoYwDqfdVlW2knA72xpWkRUzvVGvIn8hSXivggkBq0viA9tRRi
    0w/SBKfTFQxFd2KITPecJNw3/Dl8yAp2ORCGG39l57wYi53DURH4FpVGrGMdozdx
    Z8NvhABuxQvrjOf1vpMRu5Et0vs0bOEebtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522829946;
    bh=cuIzUiSZryWyohg3Bvk+Dz1hGMyk0YbHWOsPFlpPHbU=; b=C3SKZG+lUXTO
    kztHpHXGe+KtshxlwRY3GKld3dJNBwWCfN0HR1urPMfR/rnSuVJwlU1voSXUpBZ1
    nz0dvFm/jQ9DAlliuag2WdrQ3t2eRAYMZgZfyPR7acStmGihevBVJZFdkgZW8Tuo
    yit7kkJL+iUmsZ+aDMonNMbe4py6YHUcBztFKAp6N3ivoDcCwYdko+c5vUY1iNTV
    byu3V+sV3GvIKYb/GAd6YODYXFWSL+mvkJEjrOCH3of1K8Qpqsl/bV29pVxCr4Cq
    ddkiebDP9lJ5vhLVIoxaEQ1fYibargWBVgMawKaIreN1yi2/9JCxt+6XcLDZfaii
    Fe18eE/s9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMBiZsHoXXKwe8WQ9jJabMwNY63nygJ35vRplmTXab08zEFRhlRiBnggjEdPm65uGJ7QqdvNFSdb1b9+6SEuvEQziFBhuNuFw5uVFya3e0E9SbQ+9m7x
    ZRWDI/VAsInHXDOwrE6eFUIOQ0VYQIML7K4xbPxKnut5fOy9X/Z7BpJIx8qi7BaR3qCKH9OU0TrZ0qDjzxUwML+Osd8/0vuzcYZhASrpBjJMiQePBJYG6ct7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=LpQP-O61AAAA:8 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8
    a=eOIGH_h2VAteLHul0xEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbeDDITA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 04:19:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40319 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeDDISe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 04:18:34 -0400
Message-ID: <1522829907.5562.1.camel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset
 control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 04 Apr 2018 10:18:27 +0200
In-Reply-To: <CAK7LNASifFt+5UPMPz=UxOkNbNgkgjP64+kPe=1SkqEx2RKb0g@mail.gmail.com>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
         <1522742421.5089.1.camel@pengutronix.de>
         <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
         <1522745178.5089.10.camel@pengutronix.de>
         <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
         <adf0ab8f-2808-8772-76c5-b4a3075557c4@codeaurora.org>
         <CAK7LNASifFt+5UPMPz=UxOkNbNgkgjP64+kPe=1SkqEx2RKb0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-04 at 10:25 +0900, Masahiro Yamada wrote:
> 2018-04-03 19:35 GMT+09:00 Vivek Gautam <vivek.gautam@codeaurora.org>:
> > 
> > 
> > On 4/3/2018 3:49 PM, Masahiro Yamada wrote:
> > > 
> > > 2018-04-03 17:46 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > > > 
> > > > On Tue, 2018-04-03 at 17:30 +0900, Masahiro Yamada wrote:
> > > > > 
> > > > > 2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> > > > > > 
> > > > > > On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
> > > > > > > 
> > > > > > > This driver handles the reset control in a common manner; deassert
> > > > > > > resets before use, assert them after use.  There is no good reason
> > > > > > > why it should be exclusive.
> > > > > > 
> > > > > > Is this preemptive cleanup, or do you have hardware on the horizon that
> > > > > > shares these reset lines with other peripherals?
> > > > > 
> > > > > This patch is necessary for Socionext SoCs.
> > > > > 
> > > > > The same reset lines are shared between
> > > > > this dwc3-of_simple and other glue circuits.
> > > > 
> > > > Thanks, this is helpful information.
> > > > 
> > > > > > > Also, use devm_ for clean-up.
> > > > > > > 
> > > > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > CCing Philipp Zabel.
> > > > > > > I see his sob in commit 06c47e6286d5.
> > > > > > 
> > > > > > At the time I was concerned with the reset_control_array addition and
> > > > > > didn't look closely at the exclusive vs shared issue.
> > > > > > > 
> > > > > > >   drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
> > > > > > >   1 file changed, 2 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/usb/dwc3/dwc3-of-simple.c
> > > > > > > b/drivers/usb/dwc3/dwc3-of-simple.c
> > > > > > > index e54c362..bd6ab65 100644
> > > > > > > --- a/drivers/usb/dwc3/dwc3-of-simple.c
> > > > > > > +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> > > > > > > @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > >        platform_set_drvdata(pdev, simple);
> > > > > > >        simple->dev = dev;
> > > > > > > 
> > > > > > > -     simple->resets =
> > > > > > > of_reset_control_array_get_optional_exclusive(np);
> > > > > > > +     simple->resets =
> > > > > > > devm_reset_control_array_get_optional_shared(dev);
> > > > > > 
> > > > > >  From the usage in the driver, it does indeed look like _shared reset
> > > > > > usage is appropriate. I assume that the hardware has no need for the
> > > > > > reset to be asserted right before probe or after remove, it just
> > > > > > requires that the reset line is kept deasserted while the driver is
> > > > > > probed.
> > > > > > 
> > > > > > >        if (IS_ERR(simple->resets)) {
> > > > > > >                ret = PTR_ERR(simple->resets);
> > > > > > >                dev_err(dev, "failed to get device resets, err=%d\n",
> > > > > > > ret);
> > > > > > > @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > > 
> > > > > > >        ret = reset_control_deassert(simple->resets);
> > > > > > >        if (ret)
> > > > > > > -             goto err_resetc_put;
> > > > > > > +             return ret;
> > > > > > > 
> > > > > > >        ret = dwc3_of_simple_clk_init(simple,
> > > > > > > of_count_phandle_with_args(np,
> > > > > > >                                                "clocks",
> > > > > > > "#clock-cells"));
> > > > > > > @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > >   err_resetc_assert:
> > > > > > >        reset_control_assert(simple->resets);
> > > > > > > 
> > > > > > > -err_resetc_put:
> > > > > > > -     reset_control_put(simple->resets);
> > > > > > >        return ret;
> > > > > > >   }
> > > > > > > 
> > > > > > > @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct
> > > > > > > platform_device *pdev)
> > > > > > >        simple->num_clocks = 0;
> > > > > > > 
> > > > > > >        reset_control_assert(simple->resets);
> > > > > > > -     reset_control_put(simple->resets);
> > > > > > > 
> > > > > > >        pm_runtime_put_sync(dev);
> > > > > > >        pm_runtime_disable(dev);
> > > > > > 
> > > > > > Changing to devm_ changes the order here. Whether or not it could be a
> > > > > > problem to assert the reset only after pm_runtime_put (or potentially
> > > > > > never), I can't say. I assume this is a non-issue, but somebody who
> > > > > > knows the hardware better would have to decide.
> > > > > 
> > > > > 
> > > > > 
> > > > > I do not understand what you mean.
> > > > 
> > > > Sorry for the confusion, I have mixed up things here.
> > > > 
> > > > > Can you describe your concern in more details?
> > > > > 
> > > > > I am not touching reset_control_assert() here.
> > > > 
> > > > With the change to shared reset control, reset_control_assert
> > > > potentially does nothing, so it could be possible that
> > > > pm_runtime_put_sync cuts the power before the reset es asserted again.
> > > > 
> > > > > I am delaying the call for reset_control_put().
> > > > 
> > > > Yes, please disregard my comment about the devm_ change, that should
> > > > have no effect whatsoever and looks fine to me.
> > > > 
> > > > > If I understand reset_control_put() correctly,
> > > > > the effects of this change are:
> > > > >    - The ref_count and module ownership for the reset controller
> > > > >      driver will be held a little longer
> > > > >    - The call for kfree() will be a little bit delayed.
> > > > 
> > > > Correct.
> > > > 
> > > > > Why do you need knowledge about this hardware?
> > > > 
> > > > Is it ok to keep the reset deasserted while the power is cut?
> > > > Or do you
> > > > have to guarantee that drivers sharing the same reset also keep the same
> > > > power domains active?
> > > > 
> > > 
> > > If this were really a problem, the driver would have to check
> > > the error code from reset_control_assert().
> > 
> > 
> > Just to understand this - If the power domain isn't active for the said
> > device,
> > does it matter if it is in reset state or not?

If the dwc3 driver is unbound, but the reset is not asserted because
another driver holds it deasserted, could the power domain be disabled?
And could this cause a problem? A disabled power domain might cause
resets not to propagate in some modules, but I have no idea whether this
might be the case here.

> > > 
> > > 
> > >   ret = reset_control_assert(simple->resets);
> > >   if (ret)
> > >             return ret; /* if we cannot assert reset, do not allow
> > > driver detach */
> > 
> > 
> > What's the point of this. The power domain and reset should be independent
> > of each other, and when we are doing a driver detach, the state of hardware
> > should be of less concern.
> > The device should anyways not leak power when the power domain isn't active.
> > 
> 
> I do not see any point in worrying about this.
> 
> 
> Philipp,
> Do you agree this patch is no problem?

For all I know, that might depend on the hardware.

I agree this patch is no problem for current users, as there is no board
sharing those resets.
And I assume it is no problem for your hardware either, if unbinding and
rebinding the dwc3 driver works while another driver holds the reset
deasserted.

regards
Philipp
