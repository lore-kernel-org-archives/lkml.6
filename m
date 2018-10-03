Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7430DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E369213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPYts9b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E369213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJDGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:43:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34687 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbeJDGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:43:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 09D7921CF1;
        Wed,  3 Oct 2018 19:52:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Oct 2018 19:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Y2bj3x
        YGwNU3eRtnuookW/lZofNIPUOfGlaMlDVDyQs=; b=HPYts9b9B1yhKS7UHtFOAU
        aHI+/cKgbSErf9Razo1Ec7LTtMd3q03McchJMlpLntmfRYf8tKVgVPi0QUGnp2az
        rq8qgHKAF6pAYFHRhJ5OEG2ae6ovJJFx/uWRAEcNckdsP78g5LTZAviCJkIl0Lvp
        sYfTsmGHUlOYUK2AqeVI5YSPxG/rML1l0dNvsyaSPZYAE+/GW+FMWxjjVhoWcacG
        izMU11hcMf3Sp29I+rjEzhzXUQFDa+yRMQrT3gJNh3gxJVDwAtO4c38x5J9VoFFF
        WyUMJRqV2x3ddeAdA68npovSAkObK6Rf9+32LlnR1/VYWpFkOBfE027RIpOVvBCw
        ==
X-ME-Sender: <xms:QFa1W9X3X3UAcDNCAXvkxkcfpBiDPpi45U1BDOoE-czsQnhVvHlaow>
X-ME-Proxy: <xmx:QFa1WxRqtGn0uxbkZevoamLwullfceKThT5Qyl1CVOLHL9T2ytBybA>
    <xmx:QFa1W7GC2x335Bl6YN8oDMbbwIFXKopgFdO-JIC7dcXUsECxu8ruyw>
    <xmx:QFa1WyTM2dARwXpYPUgfyFCFTwutE0UIEYpjxWX5mmzaQmGPUxzGng>
    <xmx:QFa1Wzdtf-EBHT4oH4oxMfDexMniIITajCSiJvI3ZOqVKD37U0SUAg>
    <xmx:QFa1W_mAN572CBuOcMOhwaVN1mk-zrP8FPnsybUN46Qcm1EJAoaBcQ>
    <xmx:QVa1W4YMlQyoqWwUUta5em6NYJ88gh99s9udOptyVgUv3kkVWvwuDg>
Received: from localhost (unknown [64.124.202.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC9FB102D7;
        Wed,  3 Oct 2018 19:52:31 -0400 (EDT)
Date:   Wed, 3 Oct 2018 16:52:30 -0700
From:   Greg KH <gregkh@linux-foundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20181003235230.GA7858@kroah.com>
References: <20181003.145756.2159165162231604122.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003.145756.2159165162231604122.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 02:57:56PM -0700, David Miller wrote:
> 
> Sorry, a bunch of stuff got queued up while I was moving last week, so
> this is larger than I would like this late in the game.
> 
> Nothing super dangerous or scary though, just lots of simpler fixes:
> 
> 1) Prefix length validation in xfrm layer, from Steffen Klassert.
> 
> 2) TX status reporting fix in mac80211, from Andrei Otcheretianski.
> 
> 3) Fix hangs due to TX_DROP in mac80211, from Bob Copeland.
> 
> 4) Fix DMA error regression in b43, from Larry Finger.
> 
> 5) Add input validation to xenvif_set_hash_mapping(), from Jan Beulich.
> 
> 6) SMMU unmapping fix in hns driver, from Yunsheng Lin.
> 
> 7) Bluetooh crash in unpairing on SMP, from Matias Karhumaa.
> 
> 8) WoL handling fixes in the phy layer, from Heiner Kallweit.
> 
> 9) Fix deadlock in bonding, from Mahesh Bandewar.
> 
> 10) Fill ttl inherit infor in vxlan driver, from Hangbin Liu.
> 
> 11) Fix TX timeouts during netpoll, from Michael Chan.
> 
> 12) RXRPC layer fixes from David Howells.
> 
> 13) Another batch of ndo_poll_controller() removals to deal with
>     excessive resource consumption during load.  From Eric Dumazet.
> 
> 14) Fix a specific TIPC failure secnario, from LUU Duc Canh.
> 
> 15) Really disable clocks in r8169 during suspend so that low
>     power states can actually be reached.
> 
> 16) Fix SYN backlog lockdep issue in tcp and dccp, from Eric Dumazet.
> 
> 17) Fix RCU locking in netpoll SKB send, which shows up in bonding,
>     from Dave Jones.
> 
> 18) Fix TX stalls in r8169, from Heiner Kallweit.
> 
> 19) Fix locksup in nfp due to control message storms, from Jakub
>     Kicinski.
> 
> 20) Various rmnet bug fixes from Subash Abhinov Kasiviswanathan and
>     Sean Tranchetti.
> 
> 21) Fix use after free in ip_cmsg_recv_dstaddr(), from Eric Dumazet.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 846e8dd47c264e0b359afed28ea88e0acdee6818:
> 
>   Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-09-25 18:14:14 +0200)
> 
> are available in the Git repository at:
> 
>   gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

Now merged, thanks.

greg k-h
