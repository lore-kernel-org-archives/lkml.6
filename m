Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B23C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D2420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="rUd33oBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D2420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeIJWG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:06:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40873 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeIJWG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:06:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so22771882wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vaMQR0dRmZEQ+ju6zEMmH7ubkKV3XafxDe1F0Ae3TdI=;
        b=rUd33oBWWPGiHnMsYGk402Dav0s1oopmGRXNjCAB4jBEhO8FKBABSgQtLb9g0nLwxG
         cahtdx7WVmsFaqPmL3Dm7WI0lSS8gGhs/SpfEtWCI7sQyd50gK69gIBwnCnYaOORusb3
         j0nbeWQKCrSkkpoYqLMkhlDhi48jk6xFBdvyMnpZoD9jpKEexCrsK2aJ5gAYaBmalnZf
         CWWeM23mHE8NpVUn2SNbW3cCA5perEDIZVV3RIkwRYLjAJOK19EBTdSW098VujIzx8J6
         joJQxspap3FUQ4EaXn0uasjhXkvHeuOL50s3SONzgfrHRticDuYLLp6oii7VHYEnueq8
         RHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vaMQR0dRmZEQ+ju6zEMmH7ubkKV3XafxDe1F0Ae3TdI=;
        b=kw+d1XkXCQGfkE1K6lxcUMmd8CWz4fCnCoa3jQjuz9YpGjWWbN9v4lNpp/uau7glyV
         y1mvUSyuOeiGHnLAHVFVYTiua17My90FVWvJdDJ98ZLLG6lOXWSoRuppCKKA0RCjLxnB
         QN3k20mJQEhASMlKgSGWnlSz02hLZa44kcCg/PJDwgZDKcTvMkxzlw2j1fcZNPyzl9WC
         0Ln2jZ+UNxShXJOjECEIpvYKMkKoZpGUgqUtXQICfXosllyIpgozHNQGiwLjw/xMUT9Y
         4Sshq7V6qZ8g7sjyokhkdegfO7yEoj1W7q4HXBDHij3PB/00X0tXoGxPZl9DNxpUznOA
         APqg==
X-Gm-Message-State: APzg51CcjrO5wb/N93c8E2pO165wEEOhSZgM6ii1vpObrHrjZgb5Etls
        YMn7wl3sfTlxhPcjkXisMo3t7r+ASbNlkCBqgvX6yQ==
X-Google-Smtp-Source: ANB0Vdbpdzh/OPS208fKeHaZiAiT3jYiYZMytguz2ChdXKVtdr6cdWb3OkuD8L1z4lSCjY+hDn+P6puvD7SdH9dakY0=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr15151351wrf.46.1536599483636;
 Mon, 10 Sep 2018 10:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 10:11:22
 -0700 (PDT)
In-Reply-To: <20180910163936.GA18699@infradead.org>
References: <20180910132924.GA6987@infradead.org> <alpine.DEB.2.21.1809101533330.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809101536410.1292@nanos.tec.linutronix.de>
 <20180910133902.GB21593@infradead.org> <alpine.DEB.2.21.1809101544560.1292@nanos.tec.linutronix.de>
 <20180910134915.GB30774@infradead.org> <CAAhSdy1be_ibiowifBdgBZjbHuFU=CR4rZXQDwQghVYkex5bMg@mail.gmail.com>
 <alpine.DEB.2.21.1809101805110.1419@nanos.tec.linutronix.de>
 <20180910161143.GA1053@infradead.org> <CAAhSdy0kgsy0QFDQGYeVy6vxu8v7UwRGbdJC9Hhz+36TNYjyGA@mail.gmail.com>
 <20180910163936.GA18699@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 10 Sep 2018 22:41:22 +0530
Message-ID: <CAAhSdy3AN4YTaAJCR50WMB8CgaoZNeT9uOZt2GH2O6i8Y6z6ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:09 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Sep 10, 2018 at 10:05:42PM +0530, Anup Patel wrote:
>> I am quite sure RISC-V spec does not restrict the use of other
>> local interrupts. Different CPU implementations can have their
>> own local interrupts.
>
> Please take a look at sections 3.1.14 and 4.1.1 of the RISC-V privileged
> spec 1.10.

RISC-V priv spec 1.10 defines the 9 bits in MIE and MIP registers and
other bits are reserved.

The unused bits in MIP are WIRI (reserved write ignored and read ignored)
and unused bits in MIE are WPRI (reserved write preserve values and
read ignored).

The RISC-V priv spec 1.10 does not tell that unused reserved bits in
MIE/MIP cannot be used for:
1. CPU implementation specific local interrupts
2. Per-CPU device interrupts.

The RISC-V priv spec 1.10 tries to only describe MIE/MIP bits which
are mandatory on any RISC-V 1.10 compliant CPU but it possible to
used other reserved bits for implementation specific local interrupts.

Regards,
Anup
