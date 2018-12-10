Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB3D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfrxoLjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB3D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLJG1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:27:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51463 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLJG1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:27:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so9675445wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2PELzzroORYeHOg/chz31p17911EI6xKHpBZH2713G0=;
        b=IfrxoLjp+TWvaGp+JCyqyc6meCpHbs0nhnIaPFGs0BucQ0w38ivBUwSfZJ8GBeK0q/
         ubsI/2fxyH2aOgpI89/7Hzx4KtHjq9kf0QAywxZtPtyF6H6a2t1xxabOXRSC8Jtk8nNO
         uWny2z/QLv+KuK7oWlWc3w8RzvdQFTsFgMtbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2PELzzroORYeHOg/chz31p17911EI6xKHpBZH2713G0=;
        b=m4pZiBi6YQZ49Y0yZwbvEpIvn5ELACyGMgRQurpoJ2SpboG9lOCQ5T2YLJXh9PbDb9
         ABBaEYTzIrbXmZX8H0cV1OecnXnZytnUaxrGBaiKLHtYs58A+HlS/8aWYEwx4yWa8xGi
         JZgXGx+nnnDkU/tP3yYy1iO2/N0w2GPvfx/IA64x8nv+s5EuBpbJsiMD+09Io+cMU7R/
         iynPVQyu3jyGXSHZDuo1B6t/pnUvxvF6gY5TPdWkufe6olx0I2iHQ9ls5heOKEOWcm9h
         x+MedH+J1vJDs2cBEiBDfPDnN5s/bd31/phR3q+Huc1oGGAUV4BsWEYrchfv2qVRgSfD
         pftQ==
X-Gm-Message-State: AA+aEWYPPUpoCgMQEAn1a7essJa+DTiCFnXVEFUrXlUseBPWSx9J2kjt
        e/CN1GUsgw+i300GD4qQeP+9OW4cAQU=
X-Google-Smtp-Source: AFSGD/UEZqFHqxnczTuX1+GOSXHNWxT1E2vtYTnL7Upj1jE4ZHRTUEL+++W8+wjv/iczAXHIKeRUmA==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr8876909wma.123.1544423237463;
        Sun, 09 Dec 2018 22:27:17 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id a18sm12075050wrp.13.2018.12.09.22.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:27:16 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:27:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210062718.GO26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
 <20181208150526.uceviwfwqskfwovm@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208150526.uceviwfwqskfwovm@qschulz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Quentin Schulz wrote:

> Hi Lee,
> 
> On Fri, Dec 07, 2018 at 07:22:37PM +0000, Lee Jones wrote:
> > On Fri, 07 Dec 2018, Vasily Khoruzhick wrote:
> > 
> > > On Fri, Dec 7, 2018 at 8:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > 
> > > > My OCD-dar is going crazy.
> > > >
> > > > Why haven't you used the same alignment as is already there?
> > > >
> > > > If it starts to run over 80-chars then bring the others back.
> > > >
> > > > Also why is there a single liner shoved in the middle of the
> > > > multi-line entries?  Please move the singles to the top or the
> > > > bottom.
> > > 
> > > Hi Lee,
> > > 
> > > Could you please reformat it in the way that makes your OCD-dar happy?
> > > It would be really nice to get
> > 
> > I'm afraid not, for a multitude of reasons.
> > 
> > The most important of which surround testing.
> > 
> > > AC and battery support for APX8x3 merged -- it'll make Pinebook and
> > > Teres-I pretty well supported by mainline kernel.
> > 
> > That's great.  A worthy cause indeed.  So I'm sure you guys will want
> > to turn the patch around in short order so that it's applied in time
> > for the next merge window.
> > 
> 
> Aren't the MFD cells probed in order?
> 
> In that case, it makes little sense to short order them for this
> particular device (X-Powers PMICs in general). It will just make the
> system boot slower because of probe deferring.
> 
> Why? As explained by Chen-Yu in v3[1], axp-gpios can be muxed as
> regulators, thus should be probed before axp-regulators. axp-adc is
> often used by axp-battery, axp-usb-power, axp-ac-power, thus should be
> probed beforehand as well.

If there are inter-dependencies between the devices, it makes sense to
keep them in the most efficient order.

> For the alignment that also triggered your OCD, I can send you a patch
> the day you merge this one if it can help. I sent a few patches for this
> driver that didn't respect the alignment so I'm fine fixing the mfd
> cells (and eventually re-order them as I saw a few axp-gpio cells being
> declared after axp-regulators).

That's fine.  Please send the patch (based on this set) right away.

> Does that make this patch OK for you, Lee?

Yes, thank you.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
