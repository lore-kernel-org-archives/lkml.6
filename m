Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3032EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B60216FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="L2qlxMeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B60216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeHDDrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:47:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38711 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:47:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so3290932plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 18:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iOk1r5vucdU/cKac98peLYAidXfl2VG9QlZC6vINy6I=;
        b=L2qlxMeSu7Oz43EGkriBFTIwqICElYa5I0tEc0hkR0biwffOATjqbZyF8jNO4YLPrL
         mUQE1hiJioHjSyLblkiP+/0m/Izoinm8khqwWFOtOYLSUgE9PA5i2Wn5Qr9Kl1BfwD4m
         USb9gDyZJXpZJauneU6VPUWI22+z25H14b5Awa5oZTaGbikowNEZIfpqAlkEeioOzN+v
         XCzXubjjqCW657yghcxz6ibDkApkKgHQywSO6aHRGDZOVWVxC4lUsCVXkAJJei6YT3F8
         eGHkHa9WMMtL81nPJ1tK9rvzYdxUHgAEB9x7dzwVZl9p93shvuZAzuMrEADpgjsEjGEP
         RXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iOk1r5vucdU/cKac98peLYAidXfl2VG9QlZC6vINy6I=;
        b=Lxxppni/JU5nyU2vMKvaI6JQeHRZZpq2Cr8nYmyRzYW/gbGvhIBxgIT8B1IFFRWmlY
         T3DVczkX+sSsAxtrgQCjJ7x5WjVeDe7Ic3dgRYsxU3fvDxcWUJORjsRnwCyAecNgRpl1
         fYRMRfh/3p/6hS+K2NCh69uyT3pHSX6vx5aNorFdTIhub8ykcnMEqs/hjCJHznDlMnDo
         o4h7oNo5dqES18PjVL8keTjbX6MNDpUKw2RzrW0O1FANWRFNjDqamXUUVHo/i9NRx3Ls
         le5VbmmOqG1wI7hnuh4TMdydJObRFtA5GXL/oWQIigmhbm+T9X8esKikPbIdF9Aii/6b
         zhyQ==
X-Gm-Message-State: AOUpUlE5X88LuLUj1xE4kTaMOZZSqpOaViea7lEmWqvE6Pt4yjV4BV1X
        H6XWZ6jZumkhfKSmbctvrUJfuvHzhmg=
X-Google-Smtp-Source: AAOMgpdHJq4XRJb790ffNF+GPKD2BJNsyqfykJudOcGOI7i0w53U12wen7dBQjHYeB2vK2LWN40THw==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr5627598plb.322.1533347324548;
        Fri, 03 Aug 2018 18:48:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm8813536pfk.149.2018.08.03.18.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 18:48:43 -0700 (PDT)
Date:   Fri, 03 Aug 2018 18:48:43 -0700 (PDT)
X-Google-Original-Date: Fri, 03 Aug 2018 18:01:03 PDT (-0700)
Subject:     Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_JsqJWOXX7-_sb4W63wPRqFjHuU-DM-LNYgczieWjAE5ABfQ@mail.gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh@kernel.org
Message-ID: <mhng-6ecc7259-6cd2-4649-a0b5-be7c79176657@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Aug 2018 11:26:31 PDT (-0700), robh@kernel.org wrote:
> On Wed, Aug 1, 2018 at 1:12 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Jul 31, 2018 at 04:46:30PM -0600, Rob Herring wrote:
>> > Perhaps this should be 'sifive,plic0'
>>
>> Excepet for the fact this the old name has already been in shipping
>> hardware and release of qemu and other emulators it should.
>
> Not really my problem that they didn't follow the process and upstream
> their binding first. But this alone is just a string identifier, so I
> don't really care that much. If things are really a mess, then the
> next implementations will have to have better compatible strings. More
> likely, I'll just see folks trying to add various properties to deal
> with all the differences.
>
> You could always define a better compatible and leave 'riscv,plic0' as
> a fallback to avoid breaking things.

Ya, sorry about that.  FWIW, we don't consider any of the bindings stable until 
they're actually accepted upstream, so it's on us to fix our bootloaders to 
match what actually lands upstream.  Luckily there's not that much hardware out 
there and none of it is in production, so I'm OK forcing people to upgrade 
bootloaders to make this all work.

I think it's probably best to leave the extra compat string out of the kernel 
proper, as then it'll never be enshrined as a RISC-V standard.

>> > Normally this would have an SoC specific compatible too. Sometimes we
>> > can get away without, but it doesn't seem like the PLIC is very tightly
>> > specified nor has common implementations.
>>
>> It is a giant f***cking mess to be honest.  Adding a highlevel spec
>> to the ISA but not a register layout is completely idotic, but if you
>> look at the current riscv-sw list this decision is still defended by
>> SiFive / the RISC-V foundation.  The whole stale of the RISC-V platform
>> Ecosystem is rather pathetic unfortunately, and people don't seem to
>> be willing to learn from past good practice nor mistakes in ARM land.
>
> Interrupt controllers are where the differentiation is. ;)

Again, sorry about that :).  The RISC-V platform specification really should 
have started a year ago, but I'm afraid there's just a bit too much going on on 
my end.

If it helps any, we just submitted a plumbers dev room with one topic being the 
RISC-V platform spec, so I guess I'm in official trouble now it there isn't at 
least something to talk about by November...
