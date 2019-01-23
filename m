Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D0B2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h5IRtFuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfAWS5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:57:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38199 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:57:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1474731pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uzkyORv9WHDjxXAzIFaE9ySsH2mGC9U4XGK9nC78CHA=;
        b=h5IRtFuIVJH/cG3FVACxeIC4AI/AcK3/3xbMyrcYh3sq2L98YlyPIylJWOA+NPneVq
         vfpL9vMlD+w1B0AJ8UnE8lS+zZ2cUt/ASW7a8Ut/w1V6JHuaQ3pA3TqkfcYef94rwMIj
         YsYUEO5Y+cQ5NV6MDHoA3LdJQAjuzS76/EdhuzrXSoXS12Yr7610MpwxonbjZ+Q9/anS
         vM8Ll+P7kPlMJ/T91z9FsBr9j7t/PgurOX3ZPhhiPv38ARc+7RyWtiEJ7oT8LyhaRl0k
         aFd9kP+sZYJsXMJHB5bn3d2vZ0JtpGRUw9U1KoCc8twFRm8aA+aIZiICADoDeBE5mTpu
         7eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uzkyORv9WHDjxXAzIFaE9ySsH2mGC9U4XGK9nC78CHA=;
        b=i522Jx+t+UrZDQlwic//8mvexFcZTuKwh9N158FT9pNxXydW5ZdFa1SLtO/+llPk0T
         7UZ9UTmcR91BIDFItWl3oDxpa5zgHTTeP0PzlU34WaBkZ9cAiF/SFVoJ+/9IB3yjUI+B
         1rh64wRsy0cN2uMJUvh0V7UuVsLHi0nAqoQUunwjP5e1VHFAQOL42WuqdsXWvgiGOlmE
         jLGKP/IzdQGH1cmAZuMXZYNMW9R7jHbIY5/+/ll4ANMhkq3SrEisoMEGxCii8kstt/PQ
         3gY2ZOcS1iSDSzB6jQmwhTJthlKLdR32oqdHCsVmPkf/FmN8BXvm0qC3G2hMXq1PY/BV
         TbHQ==
X-Gm-Message-State: AJcUukeA/Sz53lYdLs0l6NU0K8ff4KVTUFVp6/QMNVeKOK3utBRGLhr+
        Azq/UZ8aeOtWxm/K60vcaTLWEQ==
X-Google-Smtp-Source: ALg8bN5mwouh5JuNw9Q+C5Y6nK005HnUqC2PlgGXjXxercm2orfgwKaSxnp0K6Ef32dTNhpSeMxLZQ==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr3068841pgp.443.1548269838008;
        Wed, 23 Jan 2019 10:57:18 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z62sm28719238pfi.4.2019.01.23.10.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 10:57:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:57:16 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 10:51:09 PST (-0800)
Subject:     Re: [PATCH v4 0/5] IRQ affinity support in PLIC driver
In-Reply-To: <CAAhSdy0NYKgX0whXLF8h9Pjeg05D=pL8FcH674jTrTwUX3YX3Q@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-228e5168-7ccc-49e6-91a3-a883a2aa8e58@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2019 04:14:05 PST (-0800), anup@brainfault.org wrote:
> On Thu, Dec 27, 2018 at 4:48 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> This patchset primarily adds IRQ affinity support in PLIC driver and
>> other improvements.
>>
>> It gives mechanism for explicitly route external interrupts to particular
>> CPUs using smp_affinity attribute of each Linux IRQs. Also, we can now
>> use IRQ balancer from kernel-space or user-space.
>>
>> The patchset is tested on QEMU virt machine. It is based on Linux-4.20
>> and can be found at riscv_plic_irq_affinity_v4 branch of:
>> https://github.com/avpatel/linux.git
>>
>> Changes since v3:
>>  - Dropped PATCH2
>>  - Added PATCH to not inline plic_toggle() and plic_irq_toggle()
>>  - Moved PATCH3 changes to PATCH6
>>  - Used WARN_ON_ONCE() instead of WARN_ON() in PATCH5
>>
>> Changes since v2:
>>  - Fixed incorrect address of enable registers using sizeof(u32) in PATCH1
>>  - Retained comment about need for locking in PATCH1
>>  - Split PATCH2 into two patches
>>  - Split PATCH3 into two patches
>>  - Minor fix in commit description of PATCH4
>>
>> Changes since v1:
>>  - Removed few whitspace changes from PATCH1
>>  - Keep use of DEFINE_PER_CPU() as it is
>>
>> Anup Patel (5):
>>   irqchip: sifive-plic: Pre-compute context hart base and enable base
>>   irqchip: sifive-plic: Don't inline plic_toggle() and plic_irq_toggle()
>>   irqchip: sifive-plic: Add warning in plic_init() if handler already
>>     present
>>   irqchip: sifive-plic: Differentiate between PLIC handler and context
>>   irqchip: sifive-plic: Implement irq_set_affinity() for SMP host
>>
>>  drivers/irqchip/irq-sifive-plic.c | 110 +++++++++++++++++++-----------
>>  1 file changed, 71 insertions(+), 39 deletions(-)
>>
>> --
>> 2.17.1
>>
>
> Any comments on this series??

Sorry, I haven't had a chance to take a look -- I've still a bit too behind on 
getting my act together on our fixes and haven't had time to take a look at 
things for the next merge window.
