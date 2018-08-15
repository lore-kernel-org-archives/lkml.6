Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F37C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ACD214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGKKzpWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ACD214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeHPCts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:49:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHPCtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:49:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so2493256wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rdTo/A2FoV4oBy77mz3s9hCLwueCb3Br+QLhyRz+ql0=;
        b=XGKKzpWPWAa/SnjqbpNHptcYD41oY5aerzt8poiz2tXSU/7Yztjo5JfDr8OMi6wDmm
         rjdZxSYpTMU4lA8Skj5UOVS8oqU4HSgS0qHksL8cDiUeplYFJ8kjj0vKJGeAmeTRfrGC
         5ADLtBDmzCmCQvEsLDNVtlsimk2ZeWtuZCkkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rdTo/A2FoV4oBy77mz3s9hCLwueCb3Br+QLhyRz+ql0=;
        b=YBJcYtY+LMRiW1L92RKmH3v6ppmiJMVLbTPfk42H3y8C1CiNKdmz6khna7bXaLh0Vz
         Dlt4ul61ry90vPrQdSeCbkfv6DGKjjQz+1ycX+SNE3O8mYqgKEY8lFU4wiXTiZE95E+5
         Nem8pktxspxFjaXiANCNH+Y2ubw+P3iw2E4B/DoLb8NhjO73LtpnUu0R71fudUD5FrPR
         dmzO7WJL5sZ6o0x2YeXweyK9Y0/knvKYz+JvhEnATk/g5lgnTv92OOasK++lc9Jwg8I7
         Xeqa7XroBJN2zyRxPR2g2EnebBA8fvgfwURALtb84Q6JaULClQzuCLxk/Cch3jaoleFw
         meQA==
X-Gm-Message-State: AOUpUlHrw4no7ikFv0eCUOyXJ72Rbj7hNsWeGtVS1cik3KhxP1a+bUqx
        8SaY7Gg3ZdGbCMU6a8L7Pb9VDQ1KuzV2UDqldwHIxQ==
X-Google-Smtp-Source: AA+uWPwoXe59mdwaFgMhEBvdzkUXJ8WRkfdtwfYXT1HdjulLrCIhtu1fvDpqn+xvKIQCeBLjxlDwHe8czSG7Hpg2FEc=
X-Received: by 2002:adf:db41:: with SMTP id f1-v6mr16958635wrj.212.1534377316035;
 Wed, 15 Aug 2018 16:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 16:55:15
 -0700 (PDT)
In-Reply-To: <20180814113633.GE28664@arm.com>
References: <20180814113633.GE28664@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Aug 2018 16:55:15 -0700
Message-ID: <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: updates for 4.19
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vishal Bhoj <vishal.bhoj@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> Please pull these arm64 updates for 4.19. Details in the tag, but please be
> aware that we've pulled in the x86/mm branch from -tip so that we can make
> use of the core ioremap changes which allow us to put down huge mappings
> in the vmalloc area without screwing up the TLB. Much of the positive
> diffstat is because of the rseq selftest for arm64.
>
> There is a trivial conflict in arch/arm64/Makefile with your tree, since
> we effectively rewrote a fix that was merged in -rc5 [96f95a17c1cf]. The
> correct resolution is therefore to prefer the code using ld-option, which
> is what we have here. We also ran into a couple of trivial conflicts that
> were resolved in -next with the KVM and EFI trees.
>

Hey Will,
  So I noticed issues booting Linus' master on the HiKey960 board I
have today (something hangs early in boot before I get any serial
output), and isolated the issue down to your branch here.

It seems to be coming from 693350a79980 ("arm64: insn: Don't fallback
on nosync path for general insn patching"), and reverting that change
resolves the issue for me.

If you have any suggestions for alternative fixes or things to try,
please let me know.

thanks
-john
