Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AEEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099A25519
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iJhoiw7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B099A25519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeFYHSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:18:01 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35086 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeFYHR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:17:59 -0400
Received: by mail-it0-f42.google.com with SMTP id a3-v6so10853452itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7PO4BsOv5WLdhWlSB0Fsmt/5PrKsRDAwxuAJAK3nZo=;
        b=iJhoiw7LBTK3gBrhq0ZEGnKGkO1VhHIX4Yi0VFfngQvFigJy84yE0H0D5rj24Yfc1s
         QJUFdCPGhso3PRa6RGWIPHPmkhlypET27SN5zn7cvVSckH4bFfKQVt6FvOGday7HAsIy
         0rpTv61HEDNliFhfcQlIQ+VDdJqMzKPHYxud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7PO4BsOv5WLdhWlSB0Fsmt/5PrKsRDAwxuAJAK3nZo=;
        b=X8ODCcRR8jjOAjpnMHXLSPxK8cVM47d4lV+aBENLdpRRXTgR7eAyJRcqm7Ov8SvSr1
         NOTwlwOWxI99bucg9wyDCtvA2qhMs2NXmL1Qcs++/5jAFTLyOO876NdITCiGVxB/p+fs
         b0iXns/PZOgcKzgFZrKLB6f8KeXRUJ12OpkkxPRlaS1uJ1nitX3l+pe7TB+2HrRHHdry
         NmBmdmx0LTCUEVARaKEBdZloObHAZPgFRCu+nLKcKxRfNC66oyOSJUGm8w6yOL9a6l0m
         DbVP8xAx/bbXjUmkuJp7vv+Xcq2JIxYpgu1nLjFZ7Iy4cLNzKlxWNk9fXcUTktSgCfLq
         TC8w==
X-Gm-Message-State: APt69E33owZtlCQakS+T/KLABZ05oQr9PPSTxGkef1t0UL8I7j+TFgq6
        UXPcHeFOM/vd3xDO2wliKuIKbILwcOztLrBdx/Q1Sg==
X-Google-Smtp-Source: ADUXVKLMX78UtmSRiA86LoOiU2cMonq7AxVi1P44ZVuD9qJCRpotyAjzATVUUftSqSPHUoev4nDWqlkrXMb0LcMRQ8M=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr3863472jas.72.1529911079137;
 Mon, 25 Jun 2018 00:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
In-Reply-To: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jun 2018 15:17:47 +0800
Message-ID: <CA+55aFzhE2PQOM-pykY=GammunCLYhY37eS_UiYnXWXuSvHLZQ@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 134 pass: 113 fail: 21
> Failed builds:
>         i386:allyesconfig
>         i386:allmodconfig

These seem to be due to the trial code to embed user modules in the
netfilter modules to use bpf  to do netfilter (aka bpfilter). Right
now that doesn't cross-compile right.

I'm hoping the networking people get their trial balloon to work
right, but if worst comes to worst, it will just be disabled for 4.18.

In the meantime, I'm hoping it doesn't hold back any *other* testing.
I'm assuming the allyes/modconfig build failures don't actually matter
for the boot testing etc.

The mips problems I have no idea about.

             Linus
