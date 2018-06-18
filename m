Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33944208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="W9EY6qqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33944208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juliacomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755219AbeFRPOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:14:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52273 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeFRPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:14:11 -0400
Received: by mail-it0-f68.google.com with SMTP id m194-v6so12533331itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CftzRDh9vXJ+cSm8zI0N/aOokJQ87m0Io5qxvP7s/2o=;
        b=W9EY6qqa7Lyfl9cbMuE+x2tbxPoBQZecVZs5XOBLqQ5U3I9HyGWd3nVB6hu/cve3th
         JsYIAvupzNPAOzIWHXgeS7ZsLwzj/gRWryagrs5AKjzA+rdVhHY+8pvYhBn6f7Mwv5JK
         bMMY8kRZrGh3jXyhG0Tb2SGeNncoOZ7+C8hL//GaoHYA5tKQRnWJnnVm48WrWmIW5lnx
         3bbUP0dTkLThp5uYbq0e/uM7E7VF1BnY7COkBzyCvPjRa4LxU72IU696VyrImTl/l/5B
         odx/GggGRUDWZRzIwbkSsH0EdrpKqcrlrPjxDCGkk+ZrBBSnoj5EWOcYEM5qyGbDSHC9
         eU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CftzRDh9vXJ+cSm8zI0N/aOokJQ87m0Io5qxvP7s/2o=;
        b=X11Uxe7Rp2zOv8BAM6bccwfyVA9uxGSyQeRWblWpSN/eJmODDMIJZu0NwH1Rd+C+fJ
         dvlmZ/t/L7BGKXZ6sLq90mh9nxm30vVOJ9ukQ7WGf+ujve+I9plJ9Nz8jdikH46acMpy
         2ZmQ0Tb9Kis4snrpOcVz+Vz7y4Y2ZTm7IS/RkIWVQGzpo0m8fog4vu0CJK2jnhqUejs8
         VbZcjk61EhxmAiMqfoZ76NGqleLuAPcSrzAOdsEVH5ci92IcaWfCxYUVU6XqRJiae0eA
         O5BsbhKtFxhCtaOtqv4qvn9aT3F7KfKq9sv8XwrDTCmI2UtDulRQ9vjg20hBvMgSomw8
         SZ2A==
X-Gm-Message-State: APt69E1QoHRuSJcAcRPhuxk6/jeyU4DekbFT/RiWXtjwZ/meOiRGs1TB
        Hm/g3hauVOzhSAUpR1ASRKfeqKTUzGQv3UGnjW7uGw==
X-Google-Smtp-Source: ADUXVKKratUtn2vRXP/bGnviWrvVRNTSKz06OovzXahXYfNB1kjgg3CsMeqXDtHSPNX6CzfrTBvGf0RaHKWo30ZzGk4=
X-Received: by 2002:a24:5ccb:: with SMTP id q194-v6mr9200259itb.133.1529334850625;
 Mon, 18 Jun 2018 08:14:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:494a:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:13:29
 -0700 (PDT)
In-Reply-To: <11347d3a-8491-1545-d47d-a1cb2fb9b410@linux.intel.com>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <d8503ac3-b6a4-d6cc-3db7-4e092724b79d@linux.intel.com> <CABV8kRwhrQ75g9y7v4Mq05CfZ9khhVQCwkp052jcNOvKs6-2Fg@mail.gmail.com>
 <11347d3a-8491-1545-d47d-a1cb2fb9b410@linux.intel.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 Jun 2018 11:13:29 -0400
Message-ID: <CABV8kRyWFJN1r8HtNrDGMCEDUEiCS=p0n8xucO9T5B1AvCDZVA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0 per-thread
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <andi@firstfloor.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 4) Catch the fault thrown by xsaves/xrestors in this situation, update
>>     XCR0, redo the xsaves/restores, put XCR0 back and continue
>>     execution after the faulting instruction.
>
> I'm worried about the kernel pieces that go digging in the XSAVE data
> getting confused more than the hardware getting confused.

So you prefer this option? If so, I can try to have a go at implementing it
this way and seeing if I run into any trouble.

>> At least currently, it is my understanding that `xfeatures_mask` only has
>> user features, am I mistaken about that?
>
> We're slowing adding supervisor support.  I think accounting for
> supervisor features is a requirement for any new XSAVE code.

Sure, I don't think this is in any way incompatible with that (though
probably also informs that we want to keep the memory layout the
same if possible).
