Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC124C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801D32184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVpnOPuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfADACv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:02:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfADACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:02:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so16589283plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZUVvGpz+oQWJvjsufQJKVKWtLJodXiHZQfoEWEhI2K0=;
        b=NVpnOPucLePZ2QugoOleL78npQYnZIfQKvtIUNK9LKL713FBEZeLUznKg+rtWJ56RL
         XqWroIkBvbj2he8T4R+W95g5xKh1hozaiqlH6Ql5REFOyuq8tFrEnueyWP2tIpoJA2UA
         FtjCOY6kNm1ftubUtnfFwWBiivfBcyRwKN/Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZUVvGpz+oQWJvjsufQJKVKWtLJodXiHZQfoEWEhI2K0=;
        b=ca4xKoLVxtn3cxwJIMXRVTgLNBFbKSyJizDNXgYcICguYMFsDpwWSe1i8ttpg55YSR
         heHucKESU5leViOevGG9QfyYR1nl8ijrEn4PXrJaZeC2AjGrKnOoms4htQpZNRBoMv1i
         mGALssOcOeqDy5CLsvkjyZTwS7CJhOS1QLFDTm0Rh7/wKAMUUnWejc/ZNOzbVgCjB2pq
         z/mzv1M8+T/f7DWTv73USNvk5bKebU2aaUJHSVwoQQ/jk1wgMC6JAw+N7hnXllBokDqH
         p+A7By0GjFlbwqmOC/oQqGgn7v5rhFogi8CUEGXfktnv7wjxzFR7B33P16LY6i/RAt7C
         OzmQ==
X-Gm-Message-State: AJcUuke6MT3afGS8WY7H9OY4KXIYlvWmARSqVSiZKko2R+r0/qkLzRdK
        mJabnfbxQDq25LSZUuAPgrCNxw==
X-Google-Smtp-Source: ALg8bN5EOjNt5EF7tMrdC0cVni+3AremMo9GSuFTZ6UwCpUyLd/+yWP/HtDZEo/Yk9OMpQ2k80svcg==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr48262137plb.239.1546560170248;
        Thu, 03 Jan 2019 16:02:50 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h128sm88151312pgc.15.2019.01.03.16.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 16:02:49 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:01:45 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190104000145.GJ31596@builder>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com>
 <20190103235043.GA195759@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103235043.GA195759@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Jan 15:50 PST 2019, Brian Norris wrote:

> On Thu, Jan 03, 2019 at 03:30:14PM -0800, Brian Norris wrote:
> > On Fri, Dec 28, 2018 at 10:18:18AM +0530, Sibi Sankar wrote:
> > > +- firmware-name:
> > > +	Usage: optional
> > > +	Value type: <string>
> > > +	Definition: must list the relative firmware image path for the
> > > +		    Hexagon Core.
> > 
> > Relative to what? I still think it's a terrible idea that your driver
> > looks for files at the top-level /lib/firmware/ directory, but now
> > you're leaking this into the device tree. This should at a bare minimum
> > be namespaced to something like the qcom/ sub-directory. But ideally,
> > the driver would automatically be deriving a further sub-directory of
> > qcom/ based on the chipset or something, and then the only thing you'd
> > describe here is some kind of variant string -- something akin to
> > ath10k's qcom,ath10k-calibration-variant (see
> > Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt), which
> > doesn't require a full path-name or any hierarchy.
> 
> Oh, I see Rob actually recommended this binding in v1, and it's (sort
> of) in use by a few other drivers. Is it really expected that we put
> arbitrary pathnames in device tree? None of the binding documentation
> seems very specific to me, and their implementations *do* allow
> arbitrary text. As it stands today, this is a great recipe for name
> collision -- e.g., how the driver today suggests "modem.XYZ" names; is
> Qualcomm really the only one out there making modems? :D
> 
> So my natural instinct is to avoid this. But if that's what everybody
> wants...
> 

I share your concern about this, but I came to suggest this as the
driver cares about platforms but the firmware is (often?)
device/product-specific.

E.g. we will serve the MTP and Pixel 3 with the qcom,sdm845-adsp-pas
compatible, but they are unlikely to run the same adsp firmware. This
allows the individual dtb to specify which firmware the driver should
use.

Regards,
Bjorn
