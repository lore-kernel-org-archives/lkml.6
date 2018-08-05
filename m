Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6973C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88418219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hgPXEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88418219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeHEXo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:44:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33650 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeHEXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:44:26 -0400
Received: by mail-pl0-f65.google.com with SMTP id b90-v6so3981541plb.0;
        Sun, 05 Aug 2018 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68aRvae1AQj3hr0QIjBQlhYfOaOxmGZEU/YrS8HNH8g=;
        b=W6hgPXEm55s3uieMOylCaCRshFsbduAWOXtMxWMdtff8hmMAxCFOKwQ1EcRGuiCLPk
         o39SHc/zxe/yWoWcJeidvtfvMFqjQjut3Yo3WFzClFRBhygujaVTihujr9qAfEMsR3yy
         v6qnllAf6xpMFLuEvmV2Y2KQsXGpMo08S+RI+6z5MwkFXbjWqblKYpeBkch59JGvhDOb
         V83NCHKCETJGezYl71jMEF04K3Q5B51uPrUpGyO1LChhdBqfvNJvNftaKWOuU3d4GWml
         q3CbJi+n46JZVb9b7W20+rYpOQCxyr7EQOXblHJNp6YV+exfG4WYB0JIsF7GyKAB2kqw
         OO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68aRvae1AQj3hr0QIjBQlhYfOaOxmGZEU/YrS8HNH8g=;
        b=iM7KaaSGblQ/BozpfQ3t90Py+bQfJFfaSRbkHqdqFiA4Se1M6VMPOIhdWID3z+oSzB
         ndT1IfiXggJuNG/UIHD3bH585/McKEx5AUEex692Ray8Ygx3yR086JKu6Lk0N0dgmBJ+
         bvAbxjf6tLBJ7A3vRPvfKv9r+9c33qb3Ecqt0DMick4hACFH8uGpHk3gnEuOKnD8L6EM
         WyVFCOUelPqWUP1ub6MF9Bsjdg807GOaOOqW1mRty5PKpl4BYApvBqzmHypPAqhNor0E
         ohxNBGyv4zXUIPYUKMONJG1XbcB2KXrv0T8CNBiicAzukF4hPHhONjRzZDjOeUWFSyxm
         wJgA==
X-Gm-Message-State: AOUpUlFSvOCO00V925r6hp6UnfgqO+Ngzo0snAjN3NIFt2Wy6FTs/P+6
        oLqn5F4PZSKCeSt936m9yMw=
X-Google-Smtp-Source: AAOMgpfNgB63kZdUy1UXJa3Le3iXfJPP18/fYy8IAHb4uRUaHDozjW2r9jIY6lrXxkQMN9oyjXlZEQ==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr11574657pld.134.1533505104588;
        Sun, 05 Aug 2018 14:38:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s14-v6sm25449195pfj.105.2018.08.05.14.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 14:38:23 -0700 (PDT)
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <Pine.LNX.4.44L0.1808051424440.29532-100000@netrider.rowland.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <55fffb30-1388-af6a-70a6-cb738dab062f@roeck-us.net>
Date:   Sun, 5 Aug 2018 14:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1808051424440.29532-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 11:31 AM, Alan Stern wrote:
> On Sat, 4 Aug 2018, Guenter Roeck wrote:
> 
>> On Sat, Aug 04, 2018 at 10:50:15AM -0400, Alan Stern wrote:
>>> On Fri, 3 Aug 2018, Guenter Roeck wrote:
>>>
>>>> Testing an USB drive connected to ohci-sm501 results in a large number
>>>> of runtime warnings.
>>>>
>>>> WARNING: CPU: 0 PID: 0 at ./include/linux/dma-mapping.h:541
>>>> hcd_buffer_free+0x148/0x178
>>>> Modules linked in:
>>>>
>>>> CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc7-00014-g7ec386e4c991-dirty
>>>> PC is at hcd_buffer_free+0x148/0x178
>>>> PR is at hcd_buffer_free+0x66/0x178
>>>> PC  : 8c26cbb0 SP  : 8c481da8 SR  : 400080f1
>>>> TEA : c00c8fe0
>>>> R0  : 000000f0 R1  : 000000f0 R2  : 8f9bb890 R3  : 00000000
>>>> R4  : 8f9c8800 R5  : 00001004 R6  : b07c6000 R7  : 007c6000
>>>> R8  : 00001004 R9  : 8f9bb814 R10 : 8c388104 R11 : 007c6000
>>>> R12 : b07c6000 R13 : 8f875680 R14 : 00000000
>>>> MACH: 000002fe MACL: 0000017c GBR : 00000000 PR  : 8c26cace
>>>>
>>>> Call trace:
>>>>   [<(ptrval)>] usb_hcd_unmap_urb_for_dma+0xf4/0x13c
>>>>   [<(ptrval)>] arch_local_save_flags+0x0/0x8
>>>>   [<(ptrval)>] __usb_hcd_giveback_urb+0x2e/0xdc
>>>>   [<(ptrval)>] arch_local_save_flags+0x0/0x8
>>>>   [<(ptrval)>] finish_urb+0x8a/0x164
>>>>   [<(ptrval)>] arch_local_save_flags+0x0/0x8
>>>>   [<(ptrval)>] printk+0x0/0x48
>>>>   [<(ptrval)>] ohci_work.part.11+0x150/0x41c
>>>>   [<(ptrval)>] td_done.isra.4+0x0/0x11c
>>>>   [<(ptrval)>] vprintk_default+0x14/0x20
>>>>   [<(ptrval)>] arch_local_save_flags+0x0/0x8
>>>>   [<(ptrval)>] ohci_irq+0x20c/0x314
>>>>   [<(ptrval)>] usb_hcd_irq+0x16/0x28
>>>>
>>>> Code analysis shows that interrupts are indeed disabled in ohci_irq().
>>>> Handle the situation by setting the HCD_BH flag in the ohci-sm501 driver.
>>>> With this flag set, urbs are released in a tasklet and not by the
>>>> interrupt handler.
>>>>
>>>> Fixes: f54aab6ebcecd ("usb: ohci-sm501 driver")
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Unfortunately, one must not simply turn on this flag.  Doing so will
>>> violate some of the documented requirements for scheduling of periodic
>>> transfers.  Significantly deeper changes to the OHCI driver are
>>> necessary before the flag is set.
>>>
>>
>> Well, it was worth a try. Note that I did try to figure out if there are
>> any pitfalls when setting HCD_BH, but I didn't find anything. Reminds me
>> of Hitchhiker through the Galaxy for some reason.
> 
> The interactions are pretty subtle, and the descriptions are hidden in
> the kerneldoc for usb_submit_urb and usb_unlink_urb.  ehci-hcd, for
> example, required a number of non-obvious changes when it was converted
> to use HCD_BH.  If anyone wants to write something similar for
> ohci-hcd I'll be happy to review it, but I don't want to write it
> myself.  (Besides, speeding up the time spent in interrupt handling

Not me. I stumbled over the problem while enhancing my qemu boot tests,
after attaching a USB drive to the sm501-ohci controller on a virtual sh4
system. Who knows if that system is still used in the real world and,
if it does, if it runs a recent kernel. Worth a quick fix, but not a major
code overhaul - even more so without access to real hardware.

> seems less urgent for OHCI, which runs much slower than EHCI and is
> not getting used very much in new hardware.)
> 
> Another way to attack this problem would be to allow DMA unmapping in
> interrupt context.  I have never understood why DMA mapping is okay
> with this but unmapping isn't.
> 

AFAICS it used to be interrupt tolerant for all but x86 up to commit
6894258eda ("dma-mapping: consolidate dma_{alloc,free}_{attrs,coherent}").
A quick test shows that the warning is indeed not seen if I run my test
on v3.18.y.

You would have to ask Christoph why it is now interrupt-intolerant for all
architectures.

Guenter
