Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F62C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3D22086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="zqccA4rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3D22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeIEJEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:04:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39569 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeIEJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:04:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so6074905wrf.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 21:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3NKK3uaxrLH0EUYUjBrdOrHpShPZ503Tz6VHQ8m7r58=;
        b=zqccA4rMFij04h9u69wrvVSB7xIAIzcY5xjyl2tCcuNpZsPkE+n2etK/xX1tsAbSAv
         P8ZFAuA2jVwubBfZboMm2vukEx1p+NIVT+n8MuchoWbFPJbvDI5Ln3tfG1BZU7RcXGAY
         kIvkEEFFOM2lO65g0pz5XllkKyzkiIcF6Nr5y7GCFjR5zdxtlijCtj/wE50N8V0YWt26
         4s4yfnWwkTxQlmldRNOI4GM7mHNEAw7K3b12vCZbmEyurhUnuxBw7RIXPR1mp1wrFMPf
         uOtDlQNeJyiAq4ZgDZ4qkAQcqFThf7gmYwqfLOK3vuFpE6cIQag9ZCANCRX0nxkTHaSL
         mxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3NKK3uaxrLH0EUYUjBrdOrHpShPZ503Tz6VHQ8m7r58=;
        b=lm2AJ0C5xMuU6FrwYw/Hjq7egpxfI9ZpiRzdCZ5yzb4XaMTSVex1Tx/yDqZkUx1XUy
         V9n3V41FHxEq8vKmCMK0Iba/cjydc4JsvrW4BxkOAiFoB7qDXP7u2ALWvqM9wG982EoY
         UohudTrSyOLL2hyy+ywdYwVlYq5iUyJv9R96DIl30pkyrFXTlsVEIusvKEknZMN8NtIz
         gbG/0ehuacwvV56N/ByLihzfndBUHztpgBoBsC+JpvwVIZ+39O61UB+8ar/gXALCIODS
         cH4Qh8z2d+mUgSTzikWeqkZOJHLV9b9OX2qELOEuQnB1nxVzZLm7K439Ky7QC1VdRAn1
         nwEQ==
X-Gm-Message-State: APzg51CwunCJLelQ9ITehNPDFKS9JJ76kt9M7KU8BpJJLjrxXkkYu5gk
        O9OlmglvOIgnBoCSXab3VWwVnrxCkpKd3i1mssJkBw==
X-Google-Smtp-Source: ANB0VdaxE1qgeCVhnY7xjrNBlUuJSbMmUzM8huhQrfqn0xmYI5w0cQpruc+QsuGaS5UBucY9rOA6LKBvN+s5qNyNALs=
X-Received: by 2002:adf:facf:: with SMTP id a15-v6mr14151253wrs.74.1536122184503;
 Tue, 04 Sep 2018 21:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 21:36:24 -0700 (PDT)
In-Reply-To: <20180904185001.GA25119@infradead.org>
References: <20180904124514.6290-1-anup@brainfault.org> <20180904124514.6290-2-anup@brainfault.org>
 <20180904185001.GA25119@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 5 Sep 2018 10:06:24 +0530
Message-ID: <CAAhSdy1iPZ_Y4opsXBE0o09uzgSxV8A9YKHawFB+knXH7FFLsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:20 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Sep 04, 2018 at 06:15:10PM +0530, Anup Patel wrote:
>> The mechanism to trigger IPI is generally part of interrupt-controller
>> driver for various architectures. On RISC-V, we have an option to trigger
>> IPI using SBI or SOC vendor can implement RISC-V CPU where IPI will be
>> triggered using SOC interrupt-controller (e.g. custom PLIC).
>
> Which is exactly what we want to avoid, and should not make it easy.
>
> The last thing we need is non-standard whacky IPI mechanisms, and
> that is why we habe SBI calls for it.  I think we should simply
> stat that if an RISC-V cpu design bypasse the SBI for no good reason
> we'll simply not support it.

It's outrageous to call IPI mechanisms using interrupt-controller as "wacky".

Lot of architectures have well thought-out interrupt-controller designs with
IPI support.

In fact having IPIs through interrupt-controller drivers is much faster because
SBI call will have it's own overhead and M-mode code with eventually write
to some platform-specific/interrupt-controller register. The SBI call only makes
sense for very simple interrupt-controller (such as PLIC) which do not provide
IPI mechanism. It totally seems like SBI call for triggering IPIs was added as
workaround to address limitations of current PLIC.

RISC-V systems require a more mature and feature complete interrupt-controllers
which supports IPIs, PCI MSI, and Virtualization Extensions.

I am sure will see a much better interrupt controller (PLIC++ or something else)
soon.

>
> So NAK for this patch.

I think you jumped the gun to quickly here.

This patch does two things:
1. Adds a pluggable IPI triggering mechanism
2. Make IPI handling mechanism more generic so that we can
call IPI handler from interrupt-controller driver.

Your primary objection seems to be for point1 above. I will drop that
part only keep changes related to point2 above.

Regards,
Anup
