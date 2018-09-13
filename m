Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4383C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2AD20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VDSJajtj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPiKBIXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2AD20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeIMR3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:29:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33829 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbeIMR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:29:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 22C9421F23;
        Thu, 13 Sep 2018 08:19:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Sep 2018 08:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=N1vRXIfx5xBcMNQSxmKp7q3aIrXLEe95WD5P7vEuMGc=; b=VDSJajtj
        RNsxJ+HZD8PzEOhlqHwGTe3K9pvlNq/A0QfhVz2rkkGjGPVUnfxMPcSAc6/+s3mZ
        xQu5BO4g7mSz8Smm95NPxA/Pkf0SHjS1nd8MEDPyP7U7H0RUeCVRfbihFovNS/jg
        ZXS+/W0Yd8HLmf8EdEUv+KC8XGPJY730NjwBx079698G3l8J8lfcYOA3pE37Q5Kj
        ziyCjWvEEQIlSFpsFsVzHRuadMkG4nK73JswUUzZJ48mUXH8h5ktVlssRLA6Kg81
        UxDsWBjyFxbCAuKaJvzhAISRJA3nCVaQ7uxOOHwyUoxMxnXsb3vQrVsjA5bdoi/F
        II3qjcj8sgYfqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=N1vRXIfx5xBcMNQSxmKp7q3aIrXLE
        e95WD5P7vEuMGc=; b=fPiKBIXEk/796/k5ppB9k33TeAGv4CgXybJEy1B52rTwK
        OfvrHg3iP6RFo46kTJuBXTodh6Buaq1+dCIFvd2XimL8hG4dUJEJId2P4BF8IT27
        Goz0ktjECA3zfR2l/d1lpnFwRHbZ1opHeIjJZLcnJp36kpF4xPQM4i5N2oGRa8ic
        4PWE34sR9lBcfJ/FdZjqPXbBfLvQ/LAh+mBR0b0LO5wIBqTodZZW8yWlXspDGoFg
        iPd646eooKE/eQhJ9sp9lL36ddjwfVqExy6sXgu5kFWW/I1cpJ0OUo4l4dU4DUDn
        fxdcyesA5m9myZLgSvaZesYZrklckajuxXFGLU+bw==
X-ME-Proxy: <xmx:6FWaW6Btr3F-UiyYs7asNqk8_8UkN5tR85P-mFT3i0j9cWH4My9g0g>
    <xmx:6FWaW_X-56JcjaMAsMvZ3IsGYt_gIGUVxLfpYLnMRIbG9FY5L5gzCA>
    <xmx:6FWaW7142x3dHPATkREnsEampy-2_z_PzDM4Z2z350acv_-JigmkCQ>
    <xmx:6FWaW4XuDyOxtJafkRR_wVwOS2AcjUDthsashHRsUUkSX7_ytx_0Jw>
    <xmx:6FWaW5CNP1r5hCHrX6xDCrsEGwI0A8PC2C4hdq2jBm_wZd6SEuYJnw>
    <xmx:6VWaW6tA8VRPst1KwJRUWTeQRMe9toLiYXi1gega8BFb-OUnMKaLPA>
X-ME-Sender: <xms:6FWaW7IJSXkZgjp5P6xQOFIBzpVIbZI1COdRGAa9MepRjbStca2C-w>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 401C0102D6;
        Thu, 13 Sep 2018 08:19:52 -0400 (EDT)
Date:   Thu, 13 Sep 2018 14:19:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     stable@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [stable PATCH 1/2] arm64: Fix mismatched cache line size
 detection
Message-ID: <20180913121951.GE2268@kroah.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <20180912193816.GF21563@kroah.com>
 <4b8db4d5-20d7-5597-7977-b8df1072ecc7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8db4d5-20d7-5597-7977-b8df1072ecc7@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:54:06AM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> On 12/09/18 20:38, Greg KH wrote:
> > On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
> > > commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
> > > 
> > > If there is a mismatch in the I/D min line size, we must
> > > always use the system wide safe value both in applications
> > > and in the kernel, while performing cache operations. However,
> > > we have been checking more bits than just the min line sizes,
> > > which triggers false negatives. We may need to trap the user
> > > accesses in such cases, but not necessarily patch the kernel.
> > > 
> > > This patch fixes the check to do the right thing as advertised.
> > > A new capability will be added to check mismatches in other
> > > fields and ensure we trap the CTR accesses.
> > > 
> > > Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> > > Cc: <stable@vger.kernel.org> # v4.9
> > 
> > Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
> > 4.14-stable.  Not to 4.9-stable from what I can tell.
> 
> Now when you asked this, I realise that the Fixes tags were not sufficient.
> 
> Actually this series fixes a bit more than the commit: be68a8aaf925 ("arm64: cpufeature:
> Fix CTR_EL0 field definitions"). I think these patches should have :
> 
> Fixes: commit 116c81f427ff6c5 ("arm64: Work around systems with mismatched cache line sizes")
> 
> and
> 
> Enable trapping on mismatched bits in CTR for IDC/DIC, which were
> added to v8.3 onwards.
> 
> Essentially these patches makes sure that we trap accesses to
> CTR_EL0 when some of the fields are mismatched across CPUs, so
> that the CPUs get a consistent view of the cache properties
> throughout the system. It also makes sure that we put out
> correct information about why we trap accesses to the CTR_EL0
> accesses from the userspace.
> 
> Hope this helps. The same applies for the next patch.

Yes, it does help.  But these patches do not apply to the 4.14.y series,
which I also need to apply them to (you don't want to move from 4.9.y to
4.14.y and get a regression.)

So can you provide backports for both of these patches for 4.14.y?  Then
I would be glad to queue these all up.

thanks,

greg k-h
