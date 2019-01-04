Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B12D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NI7PTZcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfADAMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:12:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45278 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfADAMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:12:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so16665631pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFEALEkFaJT2VFIFMtAEkSI4WOO8QL7W9p2XHbjCmuQ=;
        b=NI7PTZcMXwzMkEcAF1zLg+6mE/bburtxAEDyJeC+/uzMeqfcwlGF+2WH3w+e46J5KX
         4hmO6uyFIv0C9sfSmVkIF5I95YfCzr4XoYzDp8Mbet1GdvhRZzmGj9zeoQzKkpx/VVai
         BVUPdCnFg+17uRKBgSRWNBIBSlCIRL/bXfXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFEALEkFaJT2VFIFMtAEkSI4WOO8QL7W9p2XHbjCmuQ=;
        b=O1JXCnT1yYQnorxiOm8jMvlHanQeGQGc1IXSBhCbnJ+64vu1WyRGKSkSA9gyy4rsiw
         qNREWpdMZFAFFFjnqlU2CRPL/14WmRNz/nhfwzzolzOH0lmcBxeI0Lxrc80xIZ3tP7AQ
         zpIVE/YfWdjxfGGn/sXmLGgx5KyEtDTTq7LOL+VwppI3wwPy4MYUOtcZ7SVSR1J3zhOC
         gFxlFoBn43P7EWz9zGBm1iaHwefj6XUQ/kuk7uF7DuFdVMKYhXzeWm8DVdileiHtRVRa
         TMwzooXmWGxgUs7tz2u334/Nzh1PnjtqS3zVS78f1AEcH+uIzhrkwtV1kNqheoskvAhO
         sSkg==
X-Gm-Message-State: AJcUukcRnraZuKwDCXltGRV2CX9cMAJ+WVT3QDR9wOBKp69btYwKsysA
        oulpfrNkCbglWTjIcVp0fARXrQ==
X-Google-Smtp-Source: AFSGD/XxI3zLeezVwUdpOt85OX3gqWZOFSQxEHyAGuV4Fv9CrlRFTY/huCQT6Cul8Wq8fj/pome14A==
X-Received: by 2002:a62:c302:: with SMTP id v2mr50675456pfg.155.1546560722395;
        Thu, 03 Jan 2019 16:12:02 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 78sm105336656pft.184.2019.01.03.16.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 16:12:01 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:11:59 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190104001158.GA200069@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com>
 <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104000145.GJ31596@builder>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Jan 03, 2019 at 04:01:45PM -0800, Bjorn Andersson wrote:
> On Thu 03 Jan 15:50 PST 2019, Brian Norris wrote:
> 
> > On Thu, Jan 03, 2019 at 03:30:14PM -0800, Brian Norris wrote:
> > > On Fri, Dec 28, 2018 at 10:18:18AM +0530, Sibi Sankar wrote:
> > > > +- firmware-name:
> > > > +	Usage: optional
> > > > +	Value type: <string>
> > > > +	Definition: must list the relative firmware image path for the
> > > > +		    Hexagon Core.
> > > 
> > > Relative to what? I still think it's a terrible idea that your driver
> > > looks for files at the top-level /lib/firmware/ directory, but now
> > > you're leaking this into the device tree. This should at a bare minimum
> > > be namespaced to something like the qcom/ sub-directory. But ideally,
> > > the driver would automatically be deriving a further sub-directory of
> > > qcom/ based on the chipset or something, and then the only thing you'd
> > > describe here is some kind of variant string -- something akin to
> > > ath10k's qcom,ath10k-calibration-variant (see
> > > Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt), which
> > > doesn't require a full path-name or any hierarchy.
> > 
> > Oh, I see Rob actually recommended this binding in v1, and it's (sort
> > of) in use by a few other drivers. Is it really expected that we put
> > arbitrary pathnames in device tree? None of the binding documentation
> > seems very specific to me, and their implementations *do* allow
> > arbitrary text. As it stands today, this is a great recipe for name
> > collision -- e.g., how the driver today suggests "modem.XYZ" names; is
> > Qualcomm really the only one out there making modems? :D
> > 
> > So my natural instinct is to avoid this. But if that's what everybody
> > wants...
> > 
> 
> I share your concern about this, but I came to suggest this as the
> driver cares about platforms but the firmware is (often?)
> device/product-specific.
> 
> E.g. we will serve the MTP and Pixel 3 with the qcom,sdm845-adsp-pas
> compatible, but they are unlikely to run the same adsp firmware. This
> allows the individual dtb to specify which firmware the driver should
> use.

I understand this, but that still doesn't mean we should be suggesting
each DTB to clutter the top-level firmware search path, especially since
lazy people will probably just use "modem.mdt" and similar. That means
you no longer can ship the same rootfs that supports both QCOM and
<other> modems, if <other> modem also uses the same lazy format.

It seems like a much better practice to at least enforce a particular
prefix to things. e.g., the driver could assume:

  qcom/sdm845-adsp-pas/ (or if you must, just qcom/)

and your DTB only gets to add .../<your-string-here> to that path.

In case it isn't clear: I think it's also severely misguided that the
existing driver gets away with lines like

	request_firmware(&fw, "modem.mdt", ...);

today ;)

Brian
