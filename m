Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C04CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1C425A4F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1C425A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeFYNUw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:20:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbeFYNUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:20:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DE9EAC95;
        Mon, 25 Jun 2018 13:20:48 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:20:48 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     vereecke.jan@skynet.be
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH] Patch enabling Fn function keys for Laptop Asus G730
 (keyboard 0x1869)
In-Reply-To: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
Message-ID: <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm>
References: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, vereecke.jan@skynet.be wrote:

> Attached is a patch enabling (most of) the Fn function keys for the Asus ROG
> Strix GL730 Laptop. The keyboard identifies as a USB device 0x1869.
> 
> This patch enables:
>     volume/mute keys, ROG key, rew/play/ff,
>     monitor and keyboard brightness keys,
>     Touchpad toggle key,
>     Calculator key
> 
> 'Touchpad on/off' Key returns keycode 33, which is mapped to the 'p' key.
> 'Display on/off' returns keycode 253, which is mapped in X11 to NoSymbol
> 'Airplane Key' returns keycode 255, which is mapped in X11 to NoSymbol
> 
> The following keys are not activated yet:
>        Microphone Mute key, Fan key, Display Switch key

Thanks a lot for the patch.

> This patch is against the 4.17-rc7 kernel, for the x86 architecture

This usually doesn't go to the changelog, it'd be unnecessary polution of 
the set-in-stone git changelog.

> diffstat for this patch is:
>  hid-asus.c   |    2 ++
>  hid-ids.h    |    1 +
>  hid-quirks.c |    1 +
>  3 files changed, 4 insertions(+)
> 
> To apply the patch, in the root of the kernel tree use:
> patch -p1 < AsusGL703-Keyboard-Fn-keys.patch

Neither does any of this.

What is OTOH missing is your signoff.

Could you please fix these up and resubmit (ideally with Subject: line 
also tailored to fit the subsystem customs, IOW something like "HID: asus: 
add support for ....").

Thanks,

-- 
Jiri Kosina
SUSE Labs

