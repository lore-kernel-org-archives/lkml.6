Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F0FBC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3AA20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 23:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3AA20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbeFKXqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 19:46:48 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53202 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeFKXqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 19:46:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B588228FD5;
        Mon, 11 Jun 2018 19:46:39 -0400 (EDT)
Date:   Tue, 12 Jun 2018 09:47:06 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
In-Reply-To: <3490f7d6f45ec2586858e4547e97474d93bd2d4d.camel@kernel.crashing.org>
Message-ID: <alpine.LNX.2.21.1806120911370.34@nippy.intranet>
References: <cover.1528423341.git.fthain@telegraphics.com.au>         <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>         <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>         <m2h8mc4ejw.fsf@linux-m68k.org>     
    <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>         <alpine.LNX.2.21.1806092140410.26@nippy.intranet> <3490f7d6f45ec2586858e4547e97474d93bd2d4d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2018, Benjamin Herrenschmidt wrote:

> Pre-PCI is basically "NUBUS" based even in absence of an actual NuBus 
> slot :-) It has to do with the internal HW architecture. The only ones 
> that aren't are the even older designs (the 68000 based ones).
> 

There is already some disagreement in the comments in the nubus-pmac code 
about the suitability of "PMU_NUBUS_BASED" as opposed to e.g. 
"PMU_WHITNEY_BASED".

Point is, the PMU driver doesn't care about the expansion slots or 
architecture (Whitney-based PMU appears on m68k and powerpc). So NuBus vs. 
PCI is a red herring here. The pmu_kind relates to backlight, buttons and 
battery.

(Leaving aside the PMU driver, if a pre-OpenFirmware Mac has a "slot zero" 
ROM, one can argue that it is actually a NuBus machine, regardless of any 
actual expansion slots.)

> What's the situation with those NuBus things ? What do they use as a 
> bootloader ? The old Apple one or BootX ? We should merge that port of 
> it's maintained.
> 

I agree that this code should not languish out-of-tree. But it would need 
more work before it could reasonably be submitted to reviewers.

I do have some nubus-pmac hardware but I also have more mac/68k driver 
work to do before I can tackle another architecture.

I don't know what the bootloader situation is, but it looks messy...
http://nubus-pmac.sourceforge.net/#booters

Laurent, does Emile work on these machines?

-- 

> Cheers,
> Ben.
>  
