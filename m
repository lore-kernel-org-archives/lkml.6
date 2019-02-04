Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66897C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E7F2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1ItIJhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfBDTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:25:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35254 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfBDTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:25:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so390739plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLB+B3AT+x832TXyMloDVxso/Exwsg5043nY90d/CZ0=;
        b=S1ItIJhQvDnvaUoLKkwqG5b8CUfC03Y6qdx0l9HlLt7se3NH3aV8TwJpUpYJepNOO4
         7cc21d59MYr87lEwMao6eGXHVqh2vegCBrtX+3eWlGy5YzYLLPNvSx/6dxK9i/MCXMVn
         gujFNnMBjquBi3tVgBWhO7nIqO1iu8HOxMppU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLB+B3AT+x832TXyMloDVxso/Exwsg5043nY90d/CZ0=;
        b=snQuyvFn5Z9bt0w5NSoO0idwFGXq6v1x0nA0GVUST3QxLq4ZsQm0ndTYxkqim1lAPD
         MW4xnVTCb+3go8pXvsxKCLkHTjjci3qdvW3lTRO/eqvT0lXk4EARDT44yh3S6EwK612O
         EZeHopw2yr8Fu4VBFmPZG0UYY5BplqAZYtauLwQJah2UpvMs4y5MzPIKAeWGW5M+aA08
         sUm74wijpC/haWDrgal9l3NQPHakm0W1+ega+mjMED4KxBtxzp4RBXqGQQ5M93nHC+WH
         S6ge3S4q5cz6ZwqJjLGk1BH/+JK+8BgKm5sXzAnk9BsoBStZ00jDz+tmh9yfU6AUnJe+
         azjA==
X-Gm-Message-State: AHQUAuZ/TinFjSlbixZQPhe3GQQbE0Sh/Zs3cVvGO+t5aJgJYRhHoPTN
        E9kRkK8UwNzyzLyk1G+MIkB/fg==
X-Google-Smtp-Source: AHgI3IYDztpvUA9hBM48w5nvqTXAWkqGUmP5alcsfqG7Ia6SRC2f0KvTLSklHIdxsoqlSceoVeHYfg==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr920694pld.327.1549308313821;
        Mon, 04 Feb 2019 11:25:13 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s2sm890780pfa.167.2019.02.04.11.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 11:25:12 -0800 (PST)
Date:   Mon, 4 Feb 2019 11:25:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190204192510.GZ31919@minitux>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
 <20190129224652.GB11349@centauri.lan>
 <20190204104347.GD23441@sirena.org.uk>
 <20190204160337.GG2387@tuxbook-pro>
 <20190204182321.GH23441@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204182321.GH23441@sirena.org.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Feb 10:23 PST 2019, Mark Brown wrote:

> On Mon, Feb 04, 2019 at 08:03:37AM -0800, Bjorn Andersson wrote:
> 
> > We have a regulator that is described as 1.05V in the schematics for the
> > board we're working on and we have the USB block wanting 1.05V on one of
> > its pins.  But the particular regulator works in steps of 8mV, and the
> > adjacent steps are 1.048V and 1.056V.
> 
> > A) If we describe the min-microvolt = max-microvolt = 1.05V then the
> > regulator frameworks adjusts the min value to 1.056V, per the steps, and
> > fail as min > max.
> 
> Right, because that constraint isn't satisifiable on the board, an exact
> value has been asked for which can't be delivered.  We *could* try to
> allow some fudge factor for tolerance but that feels risky, it'd be
> better if the constraints were written to be satisfiable.
> 

Okay, I don't see a big problem with expecting the DT to only contain
values that the hardware can actually do. I do however see that
machine_constraints_voltage() has been changes to expect the driver to
return -ENOTRECOVERABLE when we don't have a way to query the voltage
during probe.

Updating the qcom_smd-regulator driver to do this causes this regulator
to not be probed as we now have:
[    0.199911] l3: Setting 1050000-1050000uV^M
[    0.199927] l3: unsupportable voltage constraints 1056000-1048000uV^M

So there's a risk of this breaking compatibility with older dtb files on
other boards. We will have to do some more verification on this.

But we can start by making sure we're specifying valid constraints for
the hardware.

> > B) The USB driver that we inherited was written to request min/max of
> > 1.05V/1.05V, so pointing this to a regulator with min/max of e.g.
> > 1.05V/1.06V we're outside the adjusted range of 1.056V/1.06V.
> 
> This is just very bad practice on the part of the USB driver, if it is
> not varying the voltage it should not be setting the voltage and let the
> machine figure things out.  It is completely pointless for the driver to
> be setting an exact value that it never varies, this is the sort of
> thing machine constraints are for as it leads to trouble like this.
> This is one of the many unfortunate practices in the Qualcomm BSP code
> sadly.
> 

We're taking care of this, but I spotted the min = max =
non-supported-value issue on SDM845 recently as well and wanted to know
which path to take.

> > So the question is, should the board dts be written with
> > min/max-microvolt adjusted to match the hardware steps? Or could the
> 
> Well, it is definitely unwise of the board to request a specific
> voltage if the board can't physically set it, that's asking for trouble,
> so I'd have expected the board should pick the value it wants.
> 

Agreed, and if we can make the initial get_voltage fail with
-ENOTRECOVERABLE then we get a proper failure on an invalid DT, so I'll
review the other platforms using this driver to see if we can introduce
this.

> > regulator framework be made to round down to the previous valid step
> > instead of up?
> 
> We definitely don't want to round voltages down, it is vastly more
> common for devices to experience problems like brownouts if they go
> under voltage so it'd be more likely to cause harm than good.

We're 2mV off in this case, but it could have been way off. So I'm good
with this position.

Thanks Mark

Regards,
Bjorn
