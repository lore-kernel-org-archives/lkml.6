Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B8C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCA020861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MgF85QVS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxkPM8Il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCA020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIMRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:50:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52579 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727152AbeIMRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:50:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3770421C24;
        Thu, 13 Sep 2018 08:40:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 13 Sep 2018 08:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bctkEN6WQEQdmswgZ5q9UdKcdLtoxHG/h7fFVQUn198=; b=MgF85QVS
        9K/Y0swnmwTXZ6PBmaefPl6bvz9nR3VVpfwxXZinSbHhyKZS2NDPZvuiBN8XJ6IG
        bucrAMQ83S38K/RL/alfXqprKpuVgNR9X7J5WrwL0NWjBOQEvNC2uwGfExY4A1T5
        O1GOw4U/pX2Qvs8M4rTF2RerpH7NIHVE658VddFLoLALkzuC4hP5/PN7teSnQnm6
        hMjuu/b1jhv5i5AG8zIDodkOaJwoaN3iTzxiCAAt2e8OfuV4dPdYtSfMOLQIS1oN
        cV8NUY8GqkfWXnWXjRJ/0B5QHbxpRbkXp6/gMBHxRh4ThwZN7rSu2PHuYYnNT4J2
        mguJtj8x/l7HUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=bctkEN6WQEQdmswgZ5q9UdKcdLtox
        HG/h7fFVQUn198=; b=NxkPM8Illl6sqvNjvXXvH20BSyQ30m4veaYFjtz6KVz8Q
        RvTtTOTHvJHcL/UuzTrqmzK6twEPGtNujGtM2xK86fOzJZcar9V9FvHHw1IqLyvs
        Ul/7uRLj7lz08Gx31Go80P0TjcGgzMHwWc9fpCb3bh39FOLu1T5vzEsnZSpZPDdt
        NXscdr+1/VjJQho1ZOKguDqQPrj8WoNtuOUORQAe3f4FE4uvptochDD5MMxXbS8j
        UvawN/cVj/N31qGsfTgsFWhZBx4sBg++epfuHCyLl6CfgdYTKXiL6+58phMhzRg3
        zk0a/fUO7o1/rV1jVxjDzRTwg5hkH5UfRXpeTsqng==
X-ME-Proxy: <xmx:z1qaW2wEU7OpEgyGaoE1keJQihRIyUL6tNBFEkeBWWN3uYcEhmg1Pg>
    <xmx:z1qaW5Dds0HslkgC9ZVJWjNk-tN3GWlCKrOLHkHB2St29g2uVgx6Cw>
    <xmx:z1qaW2OzlM1IspUuzZFPW_AuU2-G4ypilSjbUUepiCNP-GyXrjC1cA>
    <xmx:z1qaW3hoxanQOYp4Unz2MjZr_2ZqlkESHuN3NG2LXO-fdGSHHBIE9g>
    <xmx:z1qaW0YS6E331dDYrx_v1kYwhHs6g_2zfJk80Z1kgA3U_HArKEPAiA>
    <xmx:0VqaW7Pcod-2C2CQRMRdzZpZzFPvUb2O12s4cexwqjS_3XCgwiCbZQ>
X-ME-Sender: <xms:z1qaW0el8hP5rbao1tQe0tx2qEct2Sco7uYNOjj8fhW0EnjwyU8Muw>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41D38102A0;
        Thu, 13 Sep 2018 08:40:47 -0400 (EDT)
Date:   Thu, 13 Sep 2018 14:40:46 +0200
From:   Greg KH <greg@kroah.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     stable@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Subject: Re: [stable PATCH 1/2] arm64: Fix mismatched cache line size
 detection
Message-ID: <20180913124046.GA21180@kroah.com>
References: <1536052210-11625-1-git-send-email-suzuki.poulose@arm.com>
 <20180912193816.GF21563@kroah.com>
 <4b8db4d5-20d7-5597-7977-b8df1072ecc7@arm.com>
 <20180913121951.GE2268@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913121951.GE2268@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 02:19:51PM +0200, Greg KH wrote:
> On Thu, Sep 13, 2018 at 10:54:06AM +0100, Suzuki K Poulose wrote:
> > Hi Greg,
> > 
> > On 12/09/18 20:38, Greg KH wrote:
> > > On Tue, Sep 04, 2018 at 10:10:09AM +0100, Suzuki K Poulose wrote:
> > > > commit 4c4a39dd5fe2d13e2d2fa5fceb8ef95d19fc389a upstream
> > > > 
> > > > If there is a mismatch in the I/D min line size, we must
> > > > always use the system wide safe value both in applications
> > > > and in the kernel, while performing cache operations. However,
> > > > we have been checking more bits than just the min line sizes,
> > > > which triggers false negatives. We may need to trap the user
> > > > accesses in such cases, but not necessarily patch the kernel.
> > > > 
> > > > This patch fixes the check to do the right thing as advertised.
> > > > A new capability will be added to check mismatches in other
> > > > fields and ensure we trap the CTR accesses.
> > > > 
> > > > Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
> > > > Cc: <stable@vger.kernel.org> # v4.9
> > > 
> > > Why 4.9?  be68a8aaf925 only showed up in 4.16 and was backported only to
> > > 4.14-stable.  Not to 4.9-stable from what I can tell.
> > 
> > Now when you asked this, I realise that the Fixes tags were not sufficient.
> > 
> > Actually this series fixes a bit more than the commit: be68a8aaf925 ("arm64: cpufeature:
> > Fix CTR_EL0 field definitions"). I think these patches should have :
> > 
> > Fixes: commit 116c81f427ff6c5 ("arm64: Work around systems with mismatched cache line sizes")
> > 
> > and
> > 
> > Enable trapping on mismatched bits in CTR for IDC/DIC, which were
> > added to v8.3 onwards.
> > 
> > Essentially these patches makes sure that we trap accesses to
> > CTR_EL0 when some of the fields are mismatched across CPUs, so
> > that the CPUs get a consistent view of the cache properties
> > throughout the system. It also makes sure that we put out
> > correct information about why we trap accesses to the CTR_EL0
> > accesses from the userspace.
> > 
> > Hope this helps. The same applies for the next patch.
> 
> Yes, it does help.  But these patches do not apply to the 4.14.y series,
> which I also need to apply them to (you don't want to move from 4.9.y to
> 4.14.y and get a regression.)
> 
> So can you provide backports for both of these patches for 4.14.y?  Then
> I would be glad to queue these all up.

Oh nevermind, I found those patches in my queue, you already sent them!

sorry for the noise.

greg k-h
