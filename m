Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AA7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD198208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD198208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHXRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:46:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeHXRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:46:14 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 373C9C9E;
        Fri, 24 Aug 2018 14:11:23 +0000 (UTC)
Date:   Fri, 24 Aug 2018 16:11:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Matthias B." <matthias@winterdrache.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824141120.GA31555@kroah.com>
References: <20180824142408.6340d052@ninja>
 <20180824125950.GA29673@kroah.com>
 <20180824160947.49387d7b@ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824160947.49387d7b@ninja>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:09:47PM +0200, Matthias B. wrote:
> The following is the dmesg output from my working 4.4.147 around the
> time when the newer kernel panics.
> 
> 
>     0.425380] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    0.425932] Bluetooth: HIDP socket layer initialized
> [    0.426617] microcode: CPU0 sig=0x306c3, pf=0x2, revision=0x19
> [    0.427203] microcode: CPU1 sig=0x306c3, pf=0x2, revision=0x19
> [    0.427772] microcode: CPU2 sig=0x306c3, pf=0x2, revision=0x19
> [    0.428688] microcode: CPU3 sig=0x306c3, pf=0x2, revision=0x19
> [    0.429221] microcode: CPU4 sig=0x306c3, pf=0x2, revision=0x19
> [    0.429744] microcode: CPU5 sig=0x306c3, pf=0x2, revision=0x19
> [    0.430255] microcode: CPU6 sig=0x306c3, pf=0x2, revision=0x19
> [    0.430761] microcode: CPU7 sig=0x306c3, pf=0x2, revision=0x19
> [    0.431271] microcode: Microcode Update Driver: v2.01
>     <tigran@aivazian.fsnet.co.uk>, Peter Oruba [    0.431815] AVX2
>     version of gcm_enc/dec engaged. [    0.432347] AES CTR mode by8
>     optimization enabled [    0.433358] registered taskstats version 1
> [    0.434086] Btrfs loaded
> [    0.434991] rtc_cmos 00:02: setting system clock to 2018-08-24
>     13:35:45 UTC (1535117745) [    0.435586] ALSA device list:
> [    0.436074]   No soundcards found.
> 
> 
> 
> All of the times visible on screen for the panicking kernel are in this
> gap.
> 
> 
> 
> [    0.595677] snd_hda_intel 0000:01:00.1: Too many HDMI devices
> [    0.596251] snd_hda_intel 0000:01:00.1: Consider building the kernel
>     with CONFIG_SND_DYNAMIC_MINORS=y [    0.596839] snd_hda_intel
>     0000:01:00.1: Too many HDMI devices [    0.597412] snd_hda_intel
>     0000:01:00.1: Consider building the kernel with
>     CONFIG_SND_DYNAMIC_MINORS=y [    0.612466] snd_hda_intel
>     0000:01:00.1: control 3:0:0:ELD:0 is already present [    0.613100]
>     snd_hda_codec_hdmi: probe of hdaudioC0D0 failed with error -16

Have you tried enabling CONFIG_SND_DYNAMIC_MINORS like the kernel is
asking you to here?  Does that help?

thanks,

greg k-h
