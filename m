Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4212145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 05:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549342887;
	bh=2q/nWreDmf4PHQGRP8s50OMKY7xs6uZYZGwOVEnWQMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=po14RvghinX5ieWdMGeN44bHzn4ln8R9gnour5G7CtwAm9Hx35nG+U0lRvjwxrxWw
	 q9GbbZOQcLD7VnuniURSkMqyd20UwOgjN8TXuW3d3X+lJnszTwhe8GN4zZ3m2ECpe0
	 nnAVuVy7Ol15PqKDEqe3vORnXss2K5Qg21kH7l7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfBEFB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 00:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfBEFBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 00:01:25 -0500
Received: from localhost (unknown [171.61.84.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120E72081B;
        Tue,  5 Feb 2019 05:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549342884;
        bh=2q/nWreDmf4PHQGRP8s50OMKY7xs6uZYZGwOVEnWQMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ay1JqYOB7/m2yMyXXi9AOLbK7QPHvmY6NHOFbzfnYxTVpRNJq/o++liD8gs3o9Diu
         EAFBc6VtUmJIxQZsL4xCx0lLhCEjqAWZCVicMx1RbAkwzaMWTzejNDAMYRNot3obTU
         Cc4xOjZAKHQY+MjWt00CbbsSbW1NtRpp/j8+35u8=
Date:   Tue, 5 Feb 2019 10:31:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/8 v5] k3dma patches to add support for hi3660/HiKey960
Message-ID: <20190205050116.GV4296@vkoul-mobl>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
 <20190204090154.GM4296@vkoul-mobl>
 <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVo8aukbc61YX0r3ABDWYJ_cisSb2NxN1qNyWJ_tfYCyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-19, 11:15, John Stultz wrote:
> On Mon, Feb 4, 2019 at 1:03 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 24-01-19, 12:24, John Stultz wrote:
> > > This patch series is based on recent work by Tanglei Han, and
> > > adds support for hi3660 SoCs as found on the HiKey960 board,
> > > along with a few patches I've been carrying.
> >
> > Applied and fixed the minor style issues in patch 5, and retagged 3 thru
> > 5 to dmaengine: xxx, thanks
> 
> My apologies for the style mistake. Your help is very much appreciated
> here! Thanks so much again!

No issues it was a minor one so didnt warrant a respin!
> 
> Just to clarify, are you planning on taking the reviewed binding
> documents (patches 1&2) via your tree?

yes sorry I should have clarified since this is multi-subsystem series.
I have applied 1 thru 5 that includes DT binding. I do that typically
for dmaengine driver patches with Rob's ack.

Thanks
-- 
~Vinod
