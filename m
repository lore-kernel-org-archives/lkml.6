Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F2FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C82257CF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GcXc2iUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtGlMNk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C82257CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbeFYLGt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:06:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52067 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755242AbeFYLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:06:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2760B1269;
        Mon, 25 Jun 2018 07:06:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Jun 2018 07:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=d+cT8m84h1xttgkHidRtSBavaS661CV/KhDAtsTYOLU=; b=GcXc2iUQ
        ilQDlG1AtFKf8qVhPP77Zyum785RTZz3NEwIkb5cJTb0qs8vq+7PGBnCdcLkUBB9
        lfXiUEjrDGhtxGeInVCNOoV3Z4W1L43BqrLCoKBHQge+h5tl1ED/qJb9eiQldOBA
        eX739GJKc1cldG0K+oXP+uEZ4v8KSZmWuYX8TspZ1+uY+9sL2Dhb/1x8icqgs3A/
        axwW3NFT4+Q+x3FlZU22v/Sp+Nj48zuob2b6d1ri0I7/TK8f6YvSbPdVQcUE3ez+
        xgHw7BdMPrgMkwWYln3ng3BgMEvX/1+GrGdpIt/BSbl0LlL2u5Q/fevPI3hC6KvK
        o07ZHeAsmLb4+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=d+cT8m84h1xttgkHidRtSBavaS661
        CV/KhDAtsTYOLU=; b=YtGlMNk8O/QS4PZOCTREFIXiC4BGLaQT/3bz5WNGVvdds
        mGA+hz/5geN8rdhQL0wjinT8ZmvNIm92l7COxwnzupphcYQx9j6ppY0Tp+qd/jNK
        LoKQIZlMl5Sy3DWW6LZpG8vx5I4bT2kHTdJKPQFdAntX7/DvQS7RmJun+fmCOyAV
        xToM3ivAgkWDgWK+wo/V+27cPmhR0EfYSHcRzbRrWxbS4QcDGHxj6nr1fJR27qMT
        ZcFA2WfcZRaiMnvSsQ7HA0hWqLbklKMNFXyXeeEcJ4kp2ij+nhyFkzWygxW83Gqw
        J2dIYYwh/hGUIMiaDi2Gyas0LQIvCIL4CD3TRXOpQ==
X-ME-Proxy: <xmx:xcwwWzujDbkXakURZrbmDv6o5hGAGQ_5sY7HtpotNnlbM12-oSNhBg>
    <xmx:xcwwW0p4IuRg8-7Ol5C8P-b8vHyvgHI_Kow7H7DKRWvkgn6Bc0CL0g>
    <xmx:xcwwW4n80VLpRrhI7N96p-XDp2VdC83T70daIKwuGzV7y1WuZKtqDQ>
    <xmx:xcwwWwwaXnJpu5_Cn8YJLpIKxfiyEFLq86XC_6O5Qu3JGxfn5ldKKQ>
    <xmx:xcwwW4nKH0aoS9HtLF1qaYwHCdu2mAIsbzv53kp23Y-EMBOQ50Jc4w>
    <xmx:xcwwW35NjwEc7dXo7NkftsmuFzEA47OaxXO_d02fd0fBozx9GvMzAA>
X-ME-Sender: <xms:xcwwW_ZjiuIgymKHon1EdCUW-cJbJt29TzGg7WPHiZMgbZi8_ZeH_w>
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B8AB103CC;
        Mon, 25 Jun 2018 07:06:43 -0400 (EDT)
Date:   Mon, 25 Jun 2018 19:06:40 +0800
From:   Greg KH <greg@kroah.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier.
Message-ID: <20180625110640.GC3058@kroah.com>
References: <20180605092209.22887-1-enric.balletbo@collabora.com>
 <20180605092209.22887-6-enric.balletbo@collabora.com>
 <20180605094626.GC4637@piout.net>
 <39af6363-ce08-a227-f66a-4c7bd4916596@collabora.com>
 <20180605185952.GG4637@piout.net>
 <20180625015832.GB30408@kroah.com>
 <20180625073459.GA15406@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625073459.GA15406@piout.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:34:59AM +0200, Alexandre Belloni wrote:
> On 25/06/2018 09:58:32+0800, Greg KH wrote:
> > On Tue, Jun 05, 2018 at 08:59:52PM +0200, Alexandre Belloni wrote:
> > > On 05/06/2018 20:51:06+0200, Enric Balletbo i Serra wrote:
> > > > Hi Alexandre,
> > > > 
> > > > On 05/06/18 11:46, Alexandre Belloni wrote:
> > > > > On 05/06/2018 11:22:05+0200, Enric Balletbo i Serra wrote:
> > > > >> Adopt the SPDX license identifier headers to ease license compliance
> > > > >> management.
> > > > >>
> > > > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > >> ---
> > > > >>
> > > > >>  drivers/rtc/rtc-cros-ec.c | 21 +++++----------------
> > > > >>  1 file changed, 5 insertions(+), 16 deletions(-)
> > > > >>
> > > > > Applied, thanks.
> > > > > 
> > > > 
> > > > Looks like all the ChromeOS drivers should be licensed as GPL v2 only. There was
> > > > a mismatch between what the header says and the MODULE_LICENSE and I wrongly
> > > > assumed that the MODULE_LICENSE is the one I should follow. So could you not
> > > > apply this patch for now and I'll send another version with the correct license?
> > > > 
> > > 
> > > Hum, ok, this seemed to be the correct way to solve the mismatch to me.
> > 
> > No, the license text trumps the MODULE_LICENSE() string.  Please revert
> > this, or fix it up to be correct.
> > 
> 
> Isn't it correct in Linus' tree?

Looks good to me now, sorry for the noise.

greg k-h
