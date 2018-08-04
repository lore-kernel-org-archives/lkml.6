Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68697C43142
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E595217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SqybN2S7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E595217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeHDGCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:02:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41095 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDGCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:02:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so4226489pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 21:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NUqRxW6C6iCJV6UefdNdwTtdIaXhlvhPSkdGhG22Ig0=;
        b=SqybN2S77tNmy2CTArjRZaUBCN9bPEbmL+TP4l3Rl+a/SgvZlFkZVULbU+ZzlaWZNL
         Rf5JgFm5fnGNlOLYoM06SM5SM2FBnOsg2I2jkTNj/9lpoXJvct9/9uqXDMLJdGamps73
         I9D7AmZzDckdzT8Yd1TM0sjZ0AdytlDQwnQASlBdITh7bR9OTKxTKNcgzzBc5S+KZAYD
         X5VS06Bp/DnvacfNhSH3OkUV3OY+ucGGK7SdzA0q8/T5Jt0QeYNZQA66SFIbBuSCPvwX
         qD0eShBlcLaSNeQ9wXjKR4EQ6p+ayiP4s+X8ZlqK7LJDrPinmJliLsNQXjAPmhZOs2lF
         V5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NUqRxW6C6iCJV6UefdNdwTtdIaXhlvhPSkdGhG22Ig0=;
        b=NExqAr93QuTqz+VYThPIbrPCKX5Ruc8zrr8CFiW5nlHRaVlNhlUCFPjfJGJlqo8Cr7
         zgRnKHtDJhUkqXkIfBRHe7AzqR3mRKZDsWnWyggBX4h6vLEMA/1MKpptNf8DGDAcYy7I
         T+BsDGalWM7mKcncJ+S7F6SiTAKn4EBQWtx9BbRHEwgy+IeEHW4jiz/K7tT/or3eSuPe
         R6nSxwZNU8fS/GjIVpU1gU02phC50uPSfmXwPl3cTUgv9H7p0zL9OL79okgFBmj5blFI
         bLlYXMDtvz3hyFLXAD+s4x3FrRduYrLrPhX5hrl7sJeoZbcKrOejEkGzt0vxmX4/Wg1X
         b54A==
X-Gm-Message-State: AOUpUlHaEyop/jjI5fnsPD51mgIo0Tw31Z5iogZ8UqUEluWAhmT6zEEl
        ttH0rIm7tKBScGgib66cwY74Pw==
X-Google-Smtp-Source: AAOMgpc1HpLjSjCg4mTSGEb+6iIa3Fh1Rn018bApfvJcGq5rjVnu18SFH/CkHRl40ZHyL38IgybWBA==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr6184790pgg.163.1533355381834;
        Fri, 03 Aug 2018 21:03:01 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id f184-v6sm13003927pfc.88.2018.08.03.21.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 21:03:00 -0700 (PDT)
Date:   Fri, 03 Aug 2018 21:03:00 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 20:00:02 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Add support to no-FPU systems
In-Reply-To: <CA++6G0AMXC0ZeTZ+tkLh_5QGoPMR+3YD8Ed=DR8-G=6FL1yDSw@mail.gmail.com>
CC:     alankao@andestech.com, albert@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Darius Rad <darius@bluespec.com>, greentime@andestech.com,
        zong@andestech.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Andrew Waterman <andrew@sifive.com>
Message-ID: <mhng-d4977eb5-94cc-4b3f-b548-e27158814ed7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018 11:23:43 PDT (-0700), Andrew Waterman wrote:
> On Wed, Aug 1, 2018 at 10:55 AM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Tue, 26 Jun 2018 21:22:26 PDT (-0700), alankao@andestech.com wrote:
>>>
>>> This patch adds an option, CONFIG_FPU, to enable/disable floating
>>> procedures.  Also, some style issues are fixed.
>>>
>>> Signed-off-by: Alan Kao <alankao@andestech.com>
>>> Cc: Greentime Hu <greentime@andestech.com>
>>> Cc: Zong Li <zong@andestech.com>
>>> ---
>>>  arch/riscv/Kconfig                 |  9 ++++
>>>  arch/riscv/Makefile                | 19 +++----
>>>  arch/riscv/include/asm/switch_to.h |  6 +++
>>>  arch/riscv/kernel/entry.S          |  3 +-
>>>  arch/riscv/kernel/process.c        |  7 ++-
>>>  arch/riscv/kernel/signal.c         | 82 +++++++++++++++++++++---------
>>>  6 files changed, 90 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 6debcc4afc72..6069597ba73f 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -232,6 +232,15 @@ config RISCV_BASE_PMU
>>>
>>>  endmenu
>>>
>>> +config FPU
>>> +       bool "FPU support"
>>> +       default y
>>> +       help
>>> +         Say N here if you want to disable all floating-point related
>>> procedure
>>> +         in the kernel.
>>> +
>>> +         If you don't know what to do here, say Y.
>>> +
>>>  endmenu
>>
>>
>> Sorry for letting this slide for a bit.  While I'm not opposed to a solution
>> that requires a FPU Kconfig option, it'd be a bit better if we could detect
>> this at boot time.  I think this should be possible because at one point
>> this actually worked and we could boot the same kernel on FPU and no-FPU
>> systems.
>
> I believe it would suffice to have start_thread set sstatus.FS to OFF
> for no-FPU systems (vs. INITIAL for systems with FPU).   The ISA
> string in the devicetree should indicate whether F/D extensions are
> present.
>
> That said, it makes sense to me to additionally provide the Kconfig
> option.  This would elide the sstatus.SD check for no-FPU systems,
> shaving a couple instructions off the context-switch path.  It would
> also enable mimicking the behavior of a no-FPU system even when the
> FPU is present.

That sounds like a good argument.  Do you mind submitting a two-part patch set, 
to:

* Allow FPU kernels to detect and run correctly on non-FPU systems.  You should 
  be able to detect these very early by writing to sstatus, or later by looking 
  at the device tree.
* Add a Kconfig option to disable the FPU entirely (which is pretty much this 
  patch).

Thanks!

>
>>
>> If that's not possible then we'll have to take something like this.  There
>> were some comments on this v2 but I don't see a v3, did I miss one?
