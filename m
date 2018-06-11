Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B6E76C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A83A208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QMHCu3fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A83A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934715AbeFKUxc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:53:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41045 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934534AbeFKUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:53:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so10863211pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 13:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5ATqy6FDaazWryUpdp6T2kFdM17mLFZKqGBRW6IyTWc=;
        b=QMHCu3fm9o3F9BKM68UEJuguKbzEZTv39jaabmj4+qKHh8435aeoER3kN5fjKS+1fE
         AdN23TlrUYPPar5iLSRW28pp2KIu5tVjP4yt3hAlxLaAjHZuuSRV5ow73htiRue+P/mg
         Y2PXhFrE9ShS4fgoqly4swD8i7nF4CbXIJVZQcYbZvy5YCDEVkKKLqk5l6i7zcm/1qhV
         FQcXytbP6lfFP+cqCEsfrl2uCiFFja5KRnK1FfqyIn/G2dWHQwJD6o17hZ0/1j2toCyP
         zrnsYDPF0pRPvZsWOMtNNahGgv66p/Nwji4oY3/Jferag+DGhce24Z2wgzfUtENXSP22
         e3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5ATqy6FDaazWryUpdp6T2kFdM17mLFZKqGBRW6IyTWc=;
        b=SWTpmGz/yXatqGmC76/rXmtcppFoRUX1uuZoU9FOHWzTyzHJjMAzR3BFwEAaMXYaXn
         v5zyvWLmeq0WnkWgwfWTQVpvdkuCjS72pzdw65LtR6NZBuvvu8pv1KhlNA0JrnAI81Bv
         oAK8vFQ9wIVxDrJfcj6SN2LoW4k0CQiDCi5Yx2s8QH5X1S3VnyzWgant547hvzbBMYVP
         CuswUdMmbAQ8EY2nSvLtnw9+1VEe8HPoBCO5kXSwEREaOMH/cEeKHpioHoy00eLFf6WM
         RR9ghCOoiBJqntcXiZcH5yXvfHB/qyFAWqZxZBi74/19hiXuzxLMJZHhHKCWy4GnUX/J
         RO+A==
X-Gm-Message-State: APt69E3YuRKRGel+dfw+/mfIrEUjnqd1Bcf4mLUQU5wUlpA9HVXSw1Q1
        nb9N787JCu1D26cnDQLotih8Ow==
X-Google-Smtp-Source: ADUXVKJqmacYrtT1nw42qikx7E1Xk2HWeA/vk7eNG/qyhoYQc2h7i2e8Hgp/XkwOPnE4AbP6b3rNbg==
X-Received: by 2002:a63:a74c:: with SMTP id w12-v6mr634387pgo.374.1528750409833;
        Mon, 11 Jun 2018 13:53:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u1-v6sm42333755pfn.59.2018.06.11.13.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 13:53:29 -0700 (PDT)
Date:   Mon, 11 Jun 2018 13:53:29 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Jun 2018 13:30:24 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Handle R_RISCV_32 in modules
In-Reply-To: <mvm8t7liwrr.fsf@suse.de>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de
Message-ID: <mhng-5cb86075-42ca-4d7a-906b-599072a6484c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 00:54:00 PDT (-0700), schwab@suse.de wrote:
> On Jun 08 2018, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> On Thu, 07 Jun 2018 03:27:27 PDT (-0700), schwab@suse.de wrote:
>>> With CONFIG_MODVERSIONS=y the R_RISCV_32 relocation is used by the
>>> __kcrctab section.
>>>
>>> Signed-off-by: Andreas Schwab <schwab@suse.de>
>>> ---
>>>  arch/riscv/kernel/module.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>>> index 5dddba301d..1d5e9b934b 100644
>>> --- a/arch/riscv/kernel/module.c
>>> +++ b/arch/riscv/kernel/module.c
>>> @@ -17,6 +17,17 @@
>>>  #include <linux/errno.h>
>>>  #include <linux/moduleloader.h>
>>>
>>> +static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
>>> +{
>>> +	if (v != (u32)v) {
>>
>> My worry with this kind of check is that it relies on some sort of
>> undefined behavior in C and that at some point in the future GCC will just
>> go decide the check can never fail.  I checked and GCC doesn't elide these
>> checks now, so I might be wrong.
>>
>> Is this defined to do what it looks like it's doing?
>
> This is unsigned arithmetic, thus fully defined.

Great, thanks!  I guess I'm just a bit paranoid :)
