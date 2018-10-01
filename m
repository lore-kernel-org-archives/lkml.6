Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72851C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBCD208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hes4+ByO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CrNmX1Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBCD208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeJBEGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:06:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:06:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 234A960275; Mon,  1 Oct 2018 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538429174;
        bh=4mAE5fZXz/5SW/SmgR75NJmHTXyt9YGlzMKREowUT3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hes4+ByOXBAVeUOVQ0XfaSuueevGec809BQ3Vrw0ICu9e8C1Q4FUDsZE43Sk8juB+
         YOH1o2atfYXrcFfeLSEwTRCmgZvCGEE70Dq7x0WI9ipbick6c8Zx0h04MR41ipQs7u
         84xPrrrUWVL7oRP59U008UezLj6KvD70O9YkTKOQ=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E881C60275;
        Mon,  1 Oct 2018 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538429172;
        bh=4mAE5fZXz/5SW/SmgR75NJmHTXyt9YGlzMKREowUT3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrNmX1Vmj0WIQIPzM4wUPVEVuBdER8bIH1Tw2d2ad6/O+Pi3uk8GNWlBkNPyPDaBs
         j7PtRyBGMHl74KYz2S18jch0I9/5kMUEjS66f2cInRPARCAslCCeT5EpeMWQIPCoZC
         y+f72Ik9KPt829pIsIsnQGmC6CjzJVF9KqWpRANw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E881C60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 1 Oct 2018 15:26:08 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20181001212608.GF31641@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Saravana Kannan <skannan@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        robdclark@gmail.com
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
 <1ae0a36a-1178-4db5-1ae9-8f19e561a18b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ae0a36a-1178-4db5-1ae9-8f19e561a18b@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:56:32PM -0700, Saravana Kannan wrote:
> 
> 
> On 09/26/2018 07:34 AM, Jordan Crouse wrote:
> >On Tue, Sep 25, 2018 at 01:02:15PM -0500, Rob Herring wrote:
> >>On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> >>>This binding is intended to represent the relations between the interconnect
> >>>controllers (providers) and consumer device nodes. It will allow creating links
> >>>between consumers and interconnect paths (exposed by interconnect providers).
> >>As I mentioned in person, I want to see other SoC families using this
> >>before accepting. They don't have to be ready for upstream, but WIP
> >>patches or even just a "yes, this works for us and we're going to use
> >>this binding on X".
> >>
> >>Also, I think the QCom GPU use of this should be fully sorted out. Or
> >>more generically how this fits into OPP binding which seems to be never
> >>ending extended...
> >This is a discussion I wouldn't mind having now.  To jog memories, this is what
> >I posted a few weeks ago:
> >
> >https://patchwork.freedesktop.org/patch/246117/
> >
> >This seems like the easiest way to me to tie the frequency and the bandwidth
> >quota together for GPU devfreq scaling but I'm not married to the format and
> >I'll happily go a few rounds on the bikeshed if we can get something we can
> >be happy with.
> >
> >Jordan
> 
> Been meaning to send this out for a while, but caught up with other stuff.
> 
> That GPU BW patch is very specific to device to device mapping and
> doesn't work well for different use cases (Eg: those that  can
> calculate based on use case, etc).
> 
> Interconnect paths have different BW (bandwidth) operating points
> that they can support. For example: 1 GB/s, 1.7 GB/s, 5GB/s, etc.
> Having a mapping from GPU or CPU to those are fine/necessary, but we
> still need a separate BW OPP table for interconnect paths to list
> what they can actually support.
> 
> Two different ways we could represent BW OPP tables for interconnect paths:
> 1.  Represent interconnect paths (CPU to DDR, GPU to DDR, etc) as
> devices and have OPPs for those devices.
> 
> 2. We can have a "interconnect-opp-tables" DT binding similar to
> "interconnects" and "interconnect-names". So if a device GPU or
> Video decoder or I2C device needs to vote on an interconnect path,
> they can also list the OPP tables that those paths can support.
> 
> I know Rob doesn't like (1). But I'm hoping at least (2) is
> acceptable. I'm open to other suggestions too.
> 
> Both (1) and (2) need BW OPP tables similar to frequency OPP tables.
> That should be easy to add and Viresh is open to that. I'm open to
> other options too, but the fundamental missing part is how to tie a
> list of BW OPPs to interconnect paths in DT.
> 
> Once we have one of the above two options, we can use the
> required-opps field (already present in kernel) for the mapping
> between GPU to a particular BW need (suggested by Viresh during an
> in person conversation).

Assuming we are willing to maintain the bandwidth OPP tables and the
names / phandles needed to describe a 1:1 GPU -> bandwidth mapping
I'm okay with required-opps but for the sake of argument how would
required-opps work for a device that needs to vote multiple paths
for a given OPP?

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
