Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A802C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FB02083B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FB02083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winterdrache.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHXRoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:44:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeHXRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:44:39 -0400
Received: from ninja ([83.135.210.22]) by mrelayeu.kundenserver.de (mreue105
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MKZOx-1fv8SR1VyB-001vNC; Fri, 24
 Aug 2018 16:09:48 +0200
Date:   Fri, 24 Aug 2018 16:09:47 +0200
From:   "Matthias B." <matthias@winterdrache.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824160947.49387d7b@ninja>
In-Reply-To: <20180824125950.GA29673@kroah.com>
References: <20180824142408.6340d052@ninja>
        <20180824125950.GA29673@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xb8HheezUbCR5GuaSn9cL0Alw2/ygMMO7eJmKUP/fsu3Knve8ca
 AsVdIemjQII0EEay79QG68e9JzK3H2utdqrfztnLrH0QztQPYlqGnromuW+SQ2PnwYEsHgE
 zgnJBwMqIzktFY/k6LkQtr4dqrhNHUixx4DdspdEz5Z/T3TUuftlTOqHfVgmLLbzoc2wUCz
 tudZ7HpP7YYphpUaaP+lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KgwKqquz+ZU=:dEQYaGxS20jzj07MJUxv3m
 7hGsSVzb7a47FFtq0OD+kbTANRFb6tDItQbGRavpwFUhSoKSOVrCdNsvVATXFhdb5iZUZLw1d
 49HYiGLkPutKn0u9yTIQYsBvVIeCPhVZbWv7uff3iHmJIJ7KosDPxoBO/tWocfZFqlQAiQZWA
 EbRUmDA1qX4zSXGtDzEmbDfR+5pRC6hzoqG9HtWkqy8hY1OmLv1pOjZJMSnpbjUxMReqtt81n
 O8Ebd/dQCB9x+k0boLDwJEjCI1Adbx6PrFhryzloybIKqay0mumBoGS8Tg+qVy5aTf7wIgJWx
 GZD2+4u6QQ0a5FWlHGdhDBpAABVTEV6UuzDRH4Uwv/VzD1zp+hDqWZmw7cmBaEv6BgiBwytaU
 yeWs64bfqQquFWrR09jVMkXIkvshkdtNj4c/YkDTCumUcYb1I/XHBsVe3w0lWXv5L7SvUaDzR
 CbHEKe3lwkmCfuSTfwWTZZqDElegX+B6l7sWdkZceW1tEl1VZ0bCPCmNYs+7IWinHV4fx5Mwz
 dcoPr/il6N3oEODNPgBrc1hAsYLjyBJPc7hA7D/dKzoZFp13UZZZ1VfwTHfyvd3AA3qYNRN30
 gg8e8oBHQ/A5NeZ3YerhiAfG2nMozgr/KVrNMjn4QDhBrcHzG7IAMmANlBh0llpnj6y4gaYvY
 9ZkV+NndOTxcgVez9/IFVWbfswxBIe5b2myDkFxJapdJQhT02djpmzNrtR1iJc4yjyaDQQZN+
 YwYp5HGnEZqvsXH6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the dmesg output from my working 4.4.147 around the
time when the newer kernel panics.


    0.425380] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.425932] Bluetooth: HIDP socket layer initialized
[    0.426617] microcode: CPU0 sig=0x306c3, pf=0x2, revision=0x19
[    0.427203] microcode: CPU1 sig=0x306c3, pf=0x2, revision=0x19
[    0.427772] microcode: CPU2 sig=0x306c3, pf=0x2, revision=0x19
[    0.428688] microcode: CPU3 sig=0x306c3, pf=0x2, revision=0x19
[    0.429221] microcode: CPU4 sig=0x306c3, pf=0x2, revision=0x19
[    0.429744] microcode: CPU5 sig=0x306c3, pf=0x2, revision=0x19
[    0.430255] microcode: CPU6 sig=0x306c3, pf=0x2, revision=0x19
[    0.430761] microcode: CPU7 sig=0x306c3, pf=0x2, revision=0x19
[    0.431271] microcode: Microcode Update Driver: v2.01
    <tigran@aivazian.fsnet.co.uk>, Peter Oruba [    0.431815] AVX2
    version of gcm_enc/dec engaged. [    0.432347] AES CTR mode by8
    optimization enabled [    0.433358] registered taskstats version 1
[    0.434086] Btrfs loaded
[    0.434991] rtc_cmos 00:02: setting system clock to 2018-08-24
    13:35:45 UTC (1535117745) [    0.435586] ALSA device list:
[    0.436074]   No soundcards found.



All of the times visible on screen for the panicking kernel are in this
gap.



[    0.595677] snd_hda_intel 0000:01:00.1: Too many HDMI devices
[    0.596251] snd_hda_intel 0000:01:00.1: Consider building the kernel
    with CONFIG_SND_DYNAMIC_MINORS=y [    0.596839] snd_hda_intel
    0000:01:00.1: Too many HDMI devices [    0.597412] snd_hda_intel
    0000:01:00.1: Consider building the kernel with
    CONFIG_SND_DYNAMIC_MINORS=y [    0.612466] snd_hda_intel
    0000:01:00.1: control 3:0:0:ELD:0 is already present [    0.613100]
    snd_hda_codec_hdmi: probe of hdaudioC0D0 failed with error -16


-- 
If God hadn't wanted me to be paranoid,
He wouldn't have given me such a vivid imagination.

