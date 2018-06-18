Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2808EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D342075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7RMmIZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D342075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936079AbeFRTJb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:09:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50935 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935857AbeFRTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:09:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F36FE22210;
        Mon, 18 Jun 2018 15:09:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Jun 2018 15:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=9jQnvGP9VcV5Oldn/S4vrIfSeNKef
        l3WLz7yGDYXzhA=; b=o7RMmIZMJhRMJWPW4LeelyNGunTTEbidkU7cp4MFLXfJE
        ln9smFGugFp5r6iqUo2kRrnIsFBJRkodkfoHBmVfSn+DST7k1DD/4CRsmfKOwj71
        ik5aVpbzD8NSG/zTYMwJskIYhN1Jt/3XvT2P4VJQ4lacmfWJpAs/OYqfOhXcw2HM
        qKrva4BlwjHHnnbgx9GIiqkNg5sZ1CDIOZX6Z4CYssLvnSj2IyF29UK4pRa6gZ2O
        pNwCTX/GDAomzxqSV/kD5iMTtWrYw1jCf6Ak4irLcIqKO8n/tWdzLmpoJM/JRoXv
        b+IUwLsHp9C735oR6fmNqYCJ14eSpZRfGqRW8fYPg==
X-ME-Proxy: <xmx:aAMoWz4rj93coClEZFw8A_MaLI-ax7pMQz7zlSV8U-pcKZKQV2fLww>
    <xmx:aAMoWykrSY5K0YIIvVR0LBTOTUvGf2js_OryC5KwDeblcco7lI7ljg>
    <xmx:aAMoWxYWM2VWO-GkKYzm5AgrhN36ceW6vLCpfAj_CUvobGf9BEy0_g>
    <xmx:aAMoW4NIGBEKpH-ZbmvqhvL3-_AEt8DoIJ7ls75_VZX-DyGBEdffAw>
    <xmx:aAMoW2gZcxjERoqEG1SksglWyYR5QKpBSqV_RnhUWKBH20lQD9swkQ>
    <xmx:aAMoW-qA8GHR8BjcuwyoY9tiynonHC8UiSMvWxW18k4pJ7lb5tTHZQ>
X-ME-Sender: <xms:aAMoW98ct_j-F3FaEMmkt4WmekyecLMvDhymH08ClrL3Y1U4yEo7qw>
Received: from localhost (unknown [5.29.216.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37B6D10262;
        Mon, 18 Jun 2018 15:09:28 -0400 (EDT)
Date:   Mon, 18 Jun 2018 22:09:26 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     valdis.kletnieks@vt.edu
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 4.14.(44->48) IPv6 RA issue?
Message-ID: <20180618190926.GA18065@splinter>
References: <35958.1529334166@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35958.1529334166@turing-police.cc.vt.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:02:46AM -0400, valdis.kletnieks@vt.edu wrote:
> So I'm trying to troubleshoot an issue on an OpenWRT/Lede based
> router, where IPv6 connectivity totally fails. I've bisected it down to:
> 
> git log --oneline 187da94808a634477b5e5a69109ea0c566dfa64b..73d8a6ab7668173d70adbed45b61be5256c505e
> 73d8a6ab7668 (refs/bisect/bad) base-files: fix UCI config parsing and callback handling
> e52f3e9b1376 kernel: bump 4.14 to 4.14.48
> 7590c3c58f5e (HEAD) scripts: Replace obsolete POSIX tmpnam in slugimage.pl with File::Temp function
> 987900f2de76 hostapd: properly build hostapd-only SSL variants
> 
> and am pretty sure that it's the kernel bump (works with a 4.14.44 kernel,
> breaks with 4.14.48) as the other 3 commits don't go anywhere near IPv6 handling.

...

> Note that eth1 is the uplink towards my ISP.  I've pointed a 'tcpdump -n -i eth1 ip6'
> at it, and see plenty of RA packets come in, but neighbor discovery never completes.
> Looking at the Changelogs for .45->.50 don't show any smoking-gun patches.
> 
> This ring any bells, before I delve deeper into it?

If this is a router and forwarding is enabled, then you need to set
'accept_ra' to '2' [1]. Is this what you have configured? Seems that
OpenWRT recently started to explicitly set 'accept_ra' to '0' [2].

1. https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
2. https://github.com/openwrt/openwrt/commit/bb46520159c0119e829900e29681feea6f297fe0
