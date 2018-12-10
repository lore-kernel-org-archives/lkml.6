Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F88C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302BF2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XUsTsbQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302BF2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeLJRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:31:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42227 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:31:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so5714373pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xrhcnDEwAmOP8Rn/HufuDdZnFPgjvZ7KdRhNj1gZ40g=;
        b=XUsTsbQfNGvGi0beiKpPrQvKvHmYmJ/ZRK4C8mcO2ElAVgYX53BYhtDXdBfyyRz9Mp
         /rpXtNOLxnxhx/G+kAeh6UtSERhyuyBM9qgBfgccTFevBEvQOKr9rk0dQO9l7BMZUGxC
         RU09Q+WdV6ZJ8/EgrTSS457Fmg66xcxnbzqu3hAFcd2K22PWa5juAtF2CmwRUfaLZyI8
         2AZS31FOzULIGdGjiM0lRe6XCLUeR8Hxa4dzLgarNQ5uZM2oNla1Cn1D0P28W+zOek1f
         ljTabMzCT3PIWR7LozK4Ko02hywyFx5Gz5gUmStkmxjn1MhSSYOY213ehuoEPy1wwIoh
         Zbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xrhcnDEwAmOP8Rn/HufuDdZnFPgjvZ7KdRhNj1gZ40g=;
        b=Brf629iQ6QQBD8j8+mohfQAsTz4rNJCcyMHJRG/p/0npDJA7XdSDJP2/5b1nKJDP5j
         /2yivEPnsMGoLL+ty+nefYs/JYc0xaNdWlMCE1jRjYKtF1fWkcksAYeGxqDLIovQoHtu
         ZSYpW88LhUrrUXr019OO0HUsCCTohEIdQO0lvwDqTBI4qdQYuh0KmZY/HkrM1cbE6S80
         BokmpYyX472CI+xOItK7w39OzDGQKm7ipdgSJ2nfRsp/FR+d0OKz3OEhOZfbfbnEq11A
         +HvKMJrCZp779mg0VHDOrELvVCV5+0Iqu4y3gd4FTEBw0hF4d9WhTZ+zB0rQVCjtssl+
         9ICg==
X-Gm-Message-State: AA+aEWYQ1odgjqNsOtzK3RDKZ8ooc4buL1Lf5OFVD4tqd/CTZyR4LOD/
        Ql5RiXk2LHh5fGFrHnO01LFeo9IwphQ=
X-Google-Smtp-Source: AFSGD/XgqiG69RKToJcO6K11F9szezaCUUL8dwQhsOJXfUHV9HNmZYkkrZpJEMRjxgNySrPcYo12xg==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr11573552pgk.147.1544463075666;
        Mon, 10 Dec 2018 09:31:15 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j6sm19593579pfg.126.2018.12.10.09.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:31:14 -0800 (PST)
Date:   Mon, 10 Dec 2018 09:31:14 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 09:21:26 PST (-0800)
Subject:     Re: [PATCH v2 0/2] Provide sched_clock for riscv_timer
In-Reply-To: <dd6a7f3f-203a-f71d-314e-9706ca4757bf@linaro.org>
CC:     anup@brainfault.org, tglx@linutronix.de, aou@eecs.berkeley.edu,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     daniel.lezcano@linaro.org
Message-ID: <mhng-5c8b0e7e-4eba-4800-87fd-4ef883fb5ac5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Dec 2018 08:30:34 PST (-0800), daniel.lezcano@linaro.org wrote:
> On 07/12/2018 18:59, Palmer Dabbelt wrote:
>> On Tue, 04 Dec 2018 02:29:50 PST (-0800), anup@brainfault.org wrote:
>>> This patchset extends riscv_timer to provide sched_clock using generic
>>> sched_clock framework.
>>>
>>> The patchset is tested on QEMU virt machine. It is based on
>>> Linux-4.20-rc5
>>> and can be found at riscv_sched_clock_v2 branch of:
>>> https://github.com/avpatel/linux.git
>>>
>>> Changes since v1:
>>>  - Added patch to select GENERIC_SCHED_CLOCK for RISC-V
>>>  - Kconfig RISCV_TIMER depends on GENERIC_SCHED_CLOCK
>>>
>>> Anup Patel (2):
>>>   RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
>>>   clocksource: riscv_timer: Provide sched_clock
>>>
>>>  arch/riscv/Kconfig                | 1 +
>>>  drivers/clocksource/Kconfig       | 2 +-
>>>  drivers/clocksource/riscv_timer.c | 9 +++++++++
>>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> I'm going to add these to my for-next, but let me know if these should
>> go through a clock maintainer's tree instead and I'll drop them.
>
> I'll take the second one through my tree.

OK, I dropped it.
