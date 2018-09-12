Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E742CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796932088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER+S3oEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796932088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeILQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:51:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34547 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeILQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:51:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id j25-v6so10311399wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7Whiune3XHkIFfqq2d2qOog5M0az0VUGIsg7uy05jLI=;
        b=ER+S3oEFp69zwSIbkgybIDYYrP22KekTEm0ZmX+ERmvRHml1mfoHN/rRKJu896xRAV
         a2/jtFCrnFih+ss6ZVgz4TwyPDWAghvKI0rlb/lGQiTU/r7m4Mkgf13uYAwdy+YroOln
         UeijWxmYIJ7VfL9MZnu0Hux5BLgNcnkImnEbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7Whiune3XHkIFfqq2d2qOog5M0az0VUGIsg7uy05jLI=;
        b=HYLsIJIhiUzgww79hH5lns/gmLll+EmcHdzSDjTKtcSXJN30wb6bFGYwA8go7NiMPH
         TlJhK2R6EN74HMg1Fqs7PVDSRxS0rmvqzSVGTBXdjkQFYTxcdqm+5pf3BRzglxXHpNNi
         aFZaSBMQEVP7MstCa2Ik4jpARIuK6Ihwomntuc6FpMTrhk/RSTxdER6pTJgM9YRgTxeN
         yJTRLnt05C349K1hqzjRgFYtpUjG8LIU/6GVweyDE2dTRrjB7++guwRjhNTzp0XElvnG
         ooBaaFrQQ0cYRzv7YM0ScTpOrzZWxAhY06qnqqSeBu02dE7TpNWFvocesrQa4hmYbHYM
         InYQ==
X-Gm-Message-State: APzg51ApZ9BAw9OGpEJcPvTnYUQYfHBWAF4ArsZ7Hdh9S6DodPHtS6++
        09odZb927RYq1suQ7JzhssPLVQ==
X-Google-Smtp-Source: ANB0VdZ4NvgQ3rDTCZcdTkpPkDgHHkqOc0ieoiWyhs3zsQOgPkZ0YgwLEMA2xfP6VWxty7e+OpCHaw==
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr1328257wmg.78.1536752810490;
        Wed, 12 Sep 2018 04:46:50 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id v21-v6sm1692982wrd.4.2018.09.12.04.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:46:49 -0700 (PDT)
Date:   Wed, 12 Sep 2018 12:46:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180912114633.GU4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
 <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:
> On 12/09/18 11:59, Lee Jones wrote:
> > > On 12/09/18 09:58, Lee Jones wrote:
> > > > > > > +static const struct mfd_cell wcd9335_devices[] = {
> > > > > > > +	{ .name = "wcd9335-codec", },
> > > > > > > +};
> > > > > > Are there more devices to come?
> > > > > > 
> > > > > Yes, that is the plan, we are kind of limited in hardware setup to test few
> > > > > things like soundwire controller. We are exploring other ways to test these.
> > > > I normally don't accept MFDs with just one device enabled.  Since it's
> > > > not really an MFD (M == Multi) until it has more than one function.
> > > > 
> > > WCD9335 Codec hw itself has multiple hw blocks.
> > > 
> > > If the issue is about adding more entries to mfd cells then we should be
> > > able to add below entry:
> > > 
> > > 	{ .name = "wcd9335-soundwire-controller", },
> > > 
> > > Actual driver for soundwire controller is not something We can test with
> > > regular dragon boards, it needs special hw for smart speakers. Once we have
> > > that we can test and post the drivers for that.
> > > 
> > > Otherwise
> > > 
> > > Are you suggesting that I move everything to  sound/soc/codecs and then back
> > > to mfd once soundwire controller driver is added?
> > My preference would be for you to add at least one other (tested)
> > device.  However, in your case I know where you live, so I can throw
> > tomatoes at your house if you don't upstream more device support
> > promptly!;)
> > 
> > When will you be enabling more devices?  If the answer is 'never',
> > then creating an MFD is a waste of time.
> 
> Vinod Koul is exploring this and ATM we are trying to sort out the hw setup.
> Hopefully we should be sorted with Qcom help!

Okay.  Please keep me posted.

> > > > > > > +	ret = wcd9335_bring_up(wcd);
> > > > > > So the device_status call-back brings up the hardware?
> > > > > > 
> > > > > device status reports the device status at runtime. We can not communicate
> > > > > with the device until it is up, enumerated by slimbus and a logical address
> > > > > is assigned to it. So the best place to initialize it is in status callback
> > > > > where all the above are expected to be done.
> > > > Right, I understand what's happening.  I just think the semantics are
> > > > wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
> > > > status and it ends up initiating a start-up sequence.  Just from a
> > > > purist's point of view (I understand that it "works"), it's not good
> > > > practice.
> > > > 
> > > > > Probe is expected to setup the external configurations like regulators/pins
> > > > > and so on which gets the device out of reset and ready to be enumerated by
> > > > > the slimbus controller.
> > > > I suggest fully starting the device in probe() is a better approach.
> > > > 
> > > Its catch-22 situation, without device being powered up and reset correctly
> > > there is no way to enumerate it.
> > Isn't power-up and reset also done in probe()?
> > 
> > What am I missing?
> 
> There are two parts for device to be ready to talk at bus level:
> 1> power up and reset,
> 2> enumerate and assign a logical address by the slimbus controller.
> 
> First part as you said is already done in probe.
> When second part happens when status callback is invoked, that is when the
> slimdevice is ready for any kind of communication at bus level.

I see.  I still think it's hacky to conduct start-up procedures when
all the SS requested was status.  Perhaps it needs a new API call
init()?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
