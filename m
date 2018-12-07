Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30363C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C032082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SG5v/KEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C032082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbeLGR7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:59:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45935 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLGR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:59:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so2147224plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dZIJPc/zDz1bTAg9EEp8yT4SR06aEXY8EPAhihF1+ms=;
        b=SG5v/KEIiaCZJPM0uEg7R4VLe0RAoQ6Az4uCmG5sMLXm/cbWEgQLBNxahWWiJ6ue1f
         /ioV3Z5X+VXUTj+/i1ZDohX9YgTKwANMaii/84z1k7Nvo7N+wQWY6pCGihU9gy9aCVL7
         XXR1Yd1A7s6VRJ+cwT6rO1Hi56aUewNsu9ksDxnVyN7lUD5HCLDaBscA+97QrLE73hC/
         FO2wwwoozlmxNIsIPl/Lor6j3l9lR0oI38houGQD5H0ZwNKDwS4TwGrxq/zM69Wa+k86
         RyJvBzYrdLbKzPkoxI14FUVtAJ6zNfZC03O0/+HZhvhwitrhDpU0cH5JhqpKjqFcRnDj
         QKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dZIJPc/zDz1bTAg9EEp8yT4SR06aEXY8EPAhihF1+ms=;
        b=s0/73eP3m+UHxa2oWKvl5OXti2EZdLhz4oGogSI0EUShxovcdbETEYnJ4tUIAhvLqx
         BVHxW39+N2jsdHvgCAMWVtHs19d0jYRK4Th6mUmYdjq6DCS6RccqmVtEoXg1be7KKj2P
         wUtKxkkEs7iDgpQBwxkYqbI3ZKGliHM+8mOrdpKfO75idfIXmh3Ph8c1PxHC2ZDFFFp9
         tUr0bgdD847WaldG/3D628lHy3XfVKeggQ2oNpldkVJ/NA/1kOWopONDasjqLt+1xdrR
         4NxerFGm7s5HqUKECvMdYYv3EHqzFWuBj8bxv0XekK8EINpq11x19BnsZPCS22arTE1k
         Okag==
X-Gm-Message-State: AA+aEWb1IKAk89In7rNiVxcNMGza0EMT2gkvfZ9Y5GqTpy1Y0quaFAdW
        E3XGXBROBuDQ2UDyNir36BNgpg==
X-Google-Smtp-Source: AFSGD/Xf/B9hJBUbhFDXUt24hm9VBW7iY3nSbGQ6JfMmLtXVBh6M3utXW7Y+U+n5/iKOs65b9f722Q==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr2946391pld.227.1544205573760;
        Fri, 07 Dec 2018 09:59:33 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id p7sm6094445pfa.22.2018.12.07.09.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:59:33 -0800 (PST)
Date:   Fri, 07 Dec 2018 09:59:33 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 09:59:26 PST (-0800)
Subject:     Re: [PATCH v2 0/2] Provide sched_clock for riscv_timer
In-Reply-To: <20181204102952.21297-1-anup@brainfault.org>
CC:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-3c8e382b-518c-4e32-b76e-3eebdd41034a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 02:29:50 PST (-0800), anup@brainfault.org wrote:
> This patchset extends riscv_timer to provide sched_clock using generic
> sched_clock framework.
>
> The patchset is tested on QEMU virt machine. It is based on Linux-4.20-rc5
> and can be found at riscv_sched_clock_v2 branch of:
> https://github.com/avpatel/linux.git
>
> Changes since v1:
>  - Added patch to select GENERIC_SCHED_CLOCK for RISC-V
>  - Kconfig RISCV_TIMER depends on GENERIC_SCHED_CLOCK
>
> Anup Patel (2):
>   RISC-V: Select GENERIC_SCHED_CLOCK for clocksource drivers
>   clocksource: riscv_timer: Provide sched_clock
>
>  arch/riscv/Kconfig                | 1 +
>  drivers/clocksource/Kconfig       | 2 +-
>  drivers/clocksource/riscv_timer.c | 9 +++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)

I'm going to add these to my for-next, but let me know if these should go 
through a clock maintainer's tree instead and I'll drop them.
