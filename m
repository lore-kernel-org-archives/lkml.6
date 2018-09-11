Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0014320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="hXVMnFBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0014320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIKIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:34:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:34:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so24008775wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 20:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Jnpooms19DYfZDOgfxp7DgeD/sjaxBF8WszHUEKvj8=;
        b=hXVMnFBWjnw3HZiMwkbzv5gte7QG1kjKaDtpEATqq8EmxemyxJvwoIHSRR3H7RiWhC
         SaQ/Sox2/27OA3Q08giq5Cog2AItCFOE2yOT9Z9X1SIGCEROm+rXHg2fYRMW7dsz7sEh
         R7RmVW6DzvgNXlnDQIVBS4F+25aVvWH8vkKNNwOGC2jWAA11ifhvUzNRhYJc40BzVu2n
         bZJcthzV3BwzI1zFLD8Vm55eWTk61QnVDS2J377VtaxlUPIHBrFy4D835PO3BqCqjnwa
         nJdcWqlmB2Ud/dw2lzqJs9mzh/ARBQTMFm7U1V9Hf5i2wu2oS0bnxDELLlTsgL/T3PU/
         mPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Jnpooms19DYfZDOgfxp7DgeD/sjaxBF8WszHUEKvj8=;
        b=OmOb5bgdbrRAcarRxdk7mfeM3qkkotDno9NzpiM/9N0bYciXksEzQlS/dDREbgglDY
         Wf7yvFrEVZqxbRqbVgV2ILjczjHuX3uWG5Ba6h3YGQi1OsmJOTPPMahMQY+OeLE8fZpm
         7ZaRNotLunzgHzHbFXIYt3DRwoc/mmmhtfNFyx8kDVnKKpYMX0Sn5m1HX2B+5XwjjGH0
         brST5VLtz2CkYSKIrDw0V3DgH/C2Eq6+JvXyiNk70GFQZZ/mgsyyfCOR22SXs++bPrXz
         KD2ynrVTjQ3ODA5SngqgTI4eX94gYkLs70uSj7/HskE2dDhF53KBrOXv6/QwgwlabSED
         3X1w==
X-Gm-Message-State: APzg51Abw2Mi+ZvJOTAJpJIn7ilOIe7wocBnMchuKomMeLwG1gSrrcyQ
        DlU3YX9Hb2lLiOGPakgF8ICMPIJRAtvZtxYRKNxWsg==
X-Google-Smtp-Source: ANB0VdaAEtLGvKP7h3YNjktVwJYMHPZCS0Y/KbRkzABSp3JhnvTFQ/2+P/bNKekAVS7uob5Z9o/7SuXANiO90UPMXHM=
X-Received: by 2002:adf:8167:: with SMTP id 94-v6mr17842031wrm.127.1536637033089;
 Mon, 10 Sep 2018 20:37:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 20:37:12
 -0700 (PDT)
In-Reply-To: <20180910133418.GA12330@infradead.org>
References: <20180904185001.GA25119@infradead.org> <mhng-ba039ed5-dcff-41d3-b237-0708b5e117b2@palmer-si-x1c4>
 <CAAhSdy3mOdxR9JpZyC9fCx5rphUBDxn2kbRpgtZp4h0_jYCxMA@mail.gmail.com> <20180910133418.GA12330@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 11 Sep 2018 09:07:12 +0530
Message-ID: <CAAhSdy0zums9m4ZgSAv9GZuGE1iLfCfMbpjduZnNXQZu8uJZ5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] RISC-V: Make IPI triggering flexible
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:04 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Sep 06, 2018 at 04:15:14PM +0530, Anup Patel wrote:
>> This patch is doing two things:
>> 1. Allow IRQCHIP driver to provide IPI trigger mechanism
>
> And the big questions is why do we want that?  The last thing we
> want is for people to "innovate" on how they deliver IPIs.  RISC-V
> has defined an SBI interface for it to hide all the details, and
> we should not try to handle systems that are not SBI compliant.
>
> Eventuall we might want to revisit the SBI to improve on shortcomings
> if there are any, but we should not allow random irqchip drivers to
> override this.

I have already dropped this part from the PATCH v2.

>
>> 2. Have more generic IPI handler in arch/riscv so that IRQCHIP driver
>> can call it
>
> And that is rather irrelevant without 1) above.

Nopes, this is required for the RISC-V INTC driver.

Regards,
Anup
