Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC08208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5BZ2gaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC08208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeGKKQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:16:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:16:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id m1-v6so4845258wrg.5;
        Wed, 11 Jul 2018 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oY4nNvXwf2yf48SIhMl+03vqsgHzBxvOTHrNtTHBekQ=;
        b=B5BZ2gaWZYViVB1qgMPFG4tss0d+bnGjwwNYz2luObDUyFqiLIo46wEkB524yZtYUx
         C51Kb8eL2yA8Uim1c3wXGRrxq/h+6+AlhyA5UYMCFhZtFO6IUAmbAW7mRafMvzyTMXif
         afXklImmsXiZHjS45T7V5hC63cl5q9pe4srFisoFRB8AQGuYAl/DSb3aPqscnTtJCZhC
         b6LYxzmUwopI1Op179W2zwNXWAeS8hxLsvkQX8ZDBYn+NVy2Wam/MgwU7B6JuXfyg46E
         /cHiPpKCmZl28aD9p+ci7lDKIt8D/GZ9aUVmKEwHSpdd6N63bSY//2PcDJHGNmQAgqsO
         Kf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oY4nNvXwf2yf48SIhMl+03vqsgHzBxvOTHrNtTHBekQ=;
        b=rvbYKip7/WbB9ILYfK1GDcG7X4+aDWrQBLFOBYUhpRpREEmRLY8C3tzoFChtZ5lCLH
         Y8NUj3uMiec6C5SldW/U7TDPFytd8euabJXfSQFXn4MHmrdLYEE4siyd6VjE5MuRHLx8
         a3VSxPxsiDUMTuLMSTc4lc3Lml51p84WNUB+jJHynNOQBsU+FtqRMAR7zFnb48h4138R
         iHbJpxMZzIQk0zrPQzFOJgpH4h+cpxR+2cf7t7ex03sJl2xLD+5sfzU0tx+plnpz/UTX
         OL5gESEkULFy2f/qpLQSjk96hp6qQmA5yBGwS32nmWjWZ5g8/Br0N5Bj3fG2M1kWejWn
         6s7A==
X-Gm-Message-State: APt69E1pRWuRRsnhTBycI1Bl518562JZR/mBUPutLIUKImku422zjPqw
        0GSITYpttEDvlwTFLM4OhtE=
X-Google-Smtp-Source: AAOMgpfmq8f3FrCjhS7kNqpfA2QBdQOe+fCUUwgM2+FMRgSJhRb9ZgfAePDC0/EtsUOYnp1RQ8kENQ==
X-Received: by 2002:adf:c74e:: with SMTP id b14-v6mr19063559wrh.16.1531303986762;
        Wed, 11 Jul 2018 03:13:06 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c18-v6sm24291605wrq.17.2018.07.11.03.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 03:13:06 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:13:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Wilfried Klaebe <linux-kernel@lebenslange-mailadresse.de>
Subject: Re: [GIT PULL 0/1] EFI mixed mode fix for v4.18
Message-ID: <20180711101303.GA8574@gmail.com>
References: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711090235.9327-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:
> 
>   Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent
> 
> for you to fetch changes up to d7f2e972e702d329fe11d6956df99dfc31211c25:
> 
>   efi/x86: remove pointless call to PciIo->Attributes() (2018-07-11 10:52:46 +0200)
> 
> ----------------------------------------------------------------
> A single fix for the x86 PCI I/O protocol handling code that got
> broken for mixed mode (64-bit Linux/x86 on 32-bit UEFI) after a
> fix was applied in -rc2 to fix it for ordinary 64-bit Linux/x86.

Just curious, because it's unclear from the changelog, what was the symptom, a 
boot hang, instant reboot, or some other misbehavior? Also, what's the scope of 
the fix: were all 64-bit on 32-bit UEFI mixed-mode bootups affected, or only a 
certain subset?

Thanks,

	Ingo
