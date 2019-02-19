Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87392C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566D42147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OpcATbZk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I6DMudqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfBSQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:12:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:12:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 249CF607EF; Tue, 19 Feb 2019 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550592743;
        bh=av/QoHAeg/ovIr0Embg2teNlj9SB937zBg4K/g3+yOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpcATbZkHtNzjG/LdhFCqNjBnR2jC1n1EivK29fyf2x7TzX8VCL+voMfj62/lI+Zf
         BEphFfB+DWPtJT05tEHT+L3t2jahXQ3QmOBIbBN3OwY4ZsLhiCuqVq8hsbkOkpsl/m
         zXxh8YFjqv5wDBxiyE4pa0bc7pOSqpelK9SJLsHY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B48160779;
        Tue, 19 Feb 2019 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550592742;
        bh=av/QoHAeg/ovIr0Embg2teNlj9SB937zBg4K/g3+yOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6DMudqgbwk0Kdgoe/N74aZlsob4zNnJYc7IWcAWF+Sf35Jjj5+MJz/ZHOlUeigAP
         uVorqsRg+MGXMDOF1KIBb3Eyohgk5RA6yMhBYddlNncmJR157LzFbXR09ccQYPnLcf
         QXb0TKoK+1ujdombuRa89wDoKlbB3Q8FxFs5Z8Gs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B48160779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 19 Feb 2019 09:12:19 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 2/6] dt-bindings: drm/msm/a6xx: Add GX power-domain
 for GMU bindings
Message-ID: <20190219161219.GC10863@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
 <1549296944-17285-3-git-send-email-jcrouse@codeaurora.org>
 <CAL_JsqJ0FX=dbQb34bvZcdbWibjKnS2VXGsApT_Vz+UcjUxCSQ@mail.gmail.com>
 <CAF6AEGuXXqfa7OnfnyHLcyHaGXXGKHwpo4gMBH4gU0keExQcFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGuXXqfa7OnfnyHLcyHaGXXGKHwpo4gMBH4gU0keExQcFg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 05:43:16PM -0500, Rob Clark wrote:
> On Sun, Feb 17, 2019 at 4:08 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Feb 4, 2019 at 10:15 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > >
> > > The GMU should have two power domains defined: "cx" and "gx". "cx" is the
> > > actual power domain for the device and "gx" will be attached at runtime
> > > to manage reference counting on the GPU device in case of a GMU crash.
> >
> > power-domains are supposed to be actual regions on a chip die which
> > can be power gated. However, they are often abused by being defined in
> > terms of kernel PM domains which are not always the same thing. This
> > description sounds like the latter case.
> >
> 
> iirc (and Jordan can correct me), this arrangement was needed because
> normally the GMU does the GPU power control (except for if we manage
> to crash it and need to reset the GMU)..
> 
> so maybe not 100% about the actual regions on chip die which can be
> gated.. but it is a reality of how hw + fw + sw fit together..

Ack - forgot to add Stephen who knows about this.

Rob is correct. The GX domain is real but it is normally controlled by an
off-CPU microcontroller. The CPU needs to get involved only when the
microcontroller crashes and we need to get things back to normal.  So the
description of it being an actual region on a chip die is accurate.

It sounds like I need to describe the hardware better in the bindings document.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
