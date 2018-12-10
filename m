Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0678C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1F320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544435527;
	bh=6pBcMX94F7DEiT7Nu7dUI7RLainh+R22Tc2iQul6f98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0QS/GZeVpnxjrsedxaX51jS4hCYCeCbBbrjIkSSVgVcsDwbb7Y5tc/8Zef+885Iep
	 N27xzJHlEMdNFwWFWDICp821zraRvMww/jmrcvAdaQowdKiYloFdJZl1o0gn/cqpd5
	 cqofvy3YgTAUgXsSRladl3LJtJBpxpHYdTfBtQEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1F320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLJJwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJJwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:52:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAE92082D;
        Mon, 10 Dec 2018 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544435525;
        bh=6pBcMX94F7DEiT7Nu7dUI7RLainh+R22Tc2iQul6f98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djMIQiKpPrZce09rW0OpDNlzW/ZR830e3T/bfh/WGUdsQwpfoYbd8q5d/8McANrwg
         fxgw0ptb7Sloqm+7NTFCmrxh3qT00khTUU7O84BRj3h3ZtWisPWD30GIjn6lXFhgjC
         HbCaaW8/ZnkBDLld2SH2la1HV+xe4HZme/Oka5gI=
Date:   Mon, 10 Dec 2018 10:52:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     stable@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ARC: [zebu] Remove CONFIG_INITRAMFS_SOURCE from
 defconfigs
Message-ID: <20181210095202.GC27385@kroah.com>
References: <20181210083349.35728-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210083349.35728-1-abrodkin@synopsys.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:33:49AM +0300, Alexey Brodkin wrote:
> Zebu boards were added in v4.9 and then renamed to "haps" in v4.10.
> 
> Thus backporting
> commit 64234961c145 (ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs)
> we missed "zebu" defconfigs in v4.9.
> 
> Note this is only applicable to "linux-4.9.y"!
> 
> Spotted by KerneCI, see [1].
> 
> [1] https://storage.kernelci.org/stable/linux-4.9.y/v4.9.144/arc/zebu_hs_smp_defconfig/build.log
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arc/configs/zebu_hs_defconfig     | 1 -
>  arch/arc/configs/zebu_hs_smp_defconfig | 1 -
>  2 files changed, 2 deletions(-)

Now queued up, thanks.

greg k-h
