Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAB0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5320849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD5320849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeGUIfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:35:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeGUIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:35:09 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F16EBAE7;
        Sat, 21 Jul 2018 07:43:21 +0000 (UTC)
Date:   Sat, 21 Jul 2018 09:43:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color
 improvements
Message-ID: <20180721074319.GA30454@kroah.com>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 05:01:52AM +0200, Adam Borowski wrote:
> Hi!
> Here's a patchset with two entangled improvements:
> 
> * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
>   allows disabling it, rendering such characters with a bright background
>   instead.
> * due to my error, 256-color mode uses a much darker palette for conversion,
>   resulting in behaving inconsistently with 24-bit mode.
> 
> The new code uses bright backgrounds when possible, enabled with \e[100m or
> \e[48;m.
> 
> Despite the whole idea following a VGA capability, this patchset doesn't
> change vgacon yet, just fbcon.  The reason being: ~80% of x86 users have an
> nVidia chip, which means nouveau or nvidia-proprietary.  Nouveau implies
> fbcon, nvidia-proprietary fails to properly restore text flags (as evidenced
> by 512 glyph mode turning to 256 on switch from graphics).  You don't care
> about the proprietary driver, but let's not break it pointlessly, and as
> both nVidia cards I own work only with nouveau, I don't want to touch what I
> can't test.
> 
> Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
> register 0x10) later.
> 
> This fixes the display of catimg and similar tools.

I've applied the first patch, as it was obvious :)

For the rest, can you make it a config option as Alan said?  And I
agree, we don't care about breaking nvidia systems, go ahead :)

thanks,

greg k-h
