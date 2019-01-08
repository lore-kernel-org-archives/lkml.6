Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80744C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B55C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Sjr30I2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfAHLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:49:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:49:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so3735578wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YU8sH6viOntqgZUUKSU5EN2OBCWmmABCsIsJ/nFFgT8=;
        b=Sjr30I2eXvkoganrTMZz1QEUTpkPkShpdPHN6iyZPeBFV/ENz4RKNh7HZtgIqE1zir
         STNU1kmJAU7+QjvqTGx8tAxPQtzxIYx4LoTCO7+V74ox+HJRDHtlI0gicNguMnuIm5RF
         3yb1We9woWYmnqT0flzKjyBTpCQm6IuxNusK037N+jJbwKiJYYjwUz1DJ8TedvsS9Z7K
         4I/AWYpfkIq3qEBKRhKJELhrL2ew0DhCT4oUKXhzZSQMqgEwmhws2i7WCa6UlkRQaKqh
         KZJibTWr5C1a6ZEFImm4j+zmYti3SHgJXhALEdIvP8VLoROTpIbm+KpRu5G9Pw2YebjH
         fd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YU8sH6viOntqgZUUKSU5EN2OBCWmmABCsIsJ/nFFgT8=;
        b=bY/NnSKMm1/MwFuJnZxQSyWYm6/anXxvnPxvY0v4Jf/+Y7Oe+/h6ihOig5yvVkh3rT
         J4MjrAvQIFuqj/ynPkn/wKR04QjtnhFCLugUiZaSOYkyQIooGOCvdyoOf/RX2N4JAqBg
         QoLKZs7JstZpo7DZaFQQnHS1KcwEH4dzBl0aO5VqCoK16L98ZQVBBJ1eB6qay9JxHZpI
         1PZ7JTEpBf+XeDZ2oEv+9BLRpWn4/QRULhHiPpJjhYDZ+oz12BL+kGiu/NI4CBkmx7gI
         0KCd7inw182zQUMfyP/XyzQN6dcCJ/57CPLgHVB1TLoU4q7waMt4K7CFsbHeZFMDM35I
         a0Aw==
X-Gm-Message-State: AJcUukdAPZ1ca8CMhY522wqPHzM6Vtd5tVe/PLm7+QzD7Z7cdDdeAlVf
        zQUzXTNiI5prL6GPE9OGECR4TwrkBwyF6GgdEf2M5g==
X-Google-Smtp-Source: ALg8bN7lVCwuJVluZT27lSHsmMrkdDNnoaj2qJP0aC52MKFDFcbD/tENFyulDm+tPSx4ePn6GzXMegKGRiUQO8OZD/4=
X-Received: by 2002:adf:8506:: with SMTP id 6mr1282487wrh.128.1546948180695;
 Tue, 08 Jan 2019 03:49:40 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-6-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-6-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:19:29 +0530
Message-ID: <CAAhSdy2XfTvyg+OxNYWzcwtPLB=0VJMGovzYcFTQyS36H-ZDYg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] RISC-V: Compare cpuid with NR_CPUS before mapping.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> We should never have a cpuid greater that NR_CPUS. Compare
> with NR_CPUS before creating the mapping between logical
> and physical CPU ids. This is also mandatory as NR_CPUS
> check is removed from riscv_of_processor_hartid.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smpboot.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 32e14572..7954470b 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -69,6 +69,11 @@ void __init setup_smp(void)
>                         of_node_put(dn);
>                         continue;
>                 }
> +               if (cpuid >= NR_CPUS) {
> +                       pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> +                               cpuid, hart);
> +                       break;
> +               }
>
>                 cpuid_to_hartid_map(cpuid) = hart;
>                 set_cpu_possible(cpuid, true);
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
