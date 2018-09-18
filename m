Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C8ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4AF20858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4AF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeIRNHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:07:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbeIRNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:07:38 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1604CAE;
        Tue, 18 Sep 2018 07:36:16 +0000 (UTC)
Date:   Tue, 18 Sep 2018 09:31:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20180918073135.GC4067@kroah.com>
References: <20180917.200040.1595079540584326114.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917.200040.1595079540584326114.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:00:40PM -0700, David Miller wrote:
> 
> Various fixes, all over the place:
> 
> 1) OOB data generation fix in bluetooth, from Matias Karhumaa.
> 
> 2) BPF BTF boundary calculation fix, from Martin KaFai Lau.
> 
> 3) Don't bug on excessive frags, to be compatible in situations mixing
>    older and newer kernels on each end.  From Juergen Gross.
> 
> 4) Scheduling in RCU fix in hv_netvsc, from Stephen Hemminger.
> 
> 5) Zero keying information in TLS layer before freeing copies
>    of them, from Sabrina Dubroca.
> 
> 6) Fix NULL deref in act_sample, from Davide Caratti.
> 
> 7) Orphan SKB before GRO in veth to prevent crashes with XDP,
>    from Toshiaki Makita.
> 
> 8) Fix use after free in ip6_xmit, from Eric Dumazet.
> 
> 9) Fix VF mac address regression in bnxt_en, from Micahel Chan.
> 
> 10) Fix MSG_PEEK behavior in TLS layer, from Daniel Borkmann.
> 
> 11) Programming adjustments to r8169 which fix not being to enter deep
>     sleep states on some machines, from Kai-Heng Feng and Hans de
>     Goede.
> 
> 12) Fix DST_NOCOUNT flag handling for ipv6 routes, from Peter
>     Oskolkov.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit 7428b2e5d0b195f2a5e40f91d2b41a8503fcfe68:
> 
>   Merge tag 'drm-fixes-2018-09-12' of git://anongit.freedesktop.org/drm/drm (2018-09-12 17:36:47 -1000)
> 
> are available in the Git repository at:
> 
>   gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

Process question, any reason why you don't use signed tags?  I noticed
that you didn't use them in the past, just curious.

thanks,

greg k-h
