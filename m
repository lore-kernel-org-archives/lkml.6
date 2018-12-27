Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0276FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C021521741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Ly2y4lHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeL0DiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:38:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36824 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0DiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:38:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so17087250wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDUoqQRTnNv8ybCgbXaTIde6zC06OstmyEq9KrXom/k=;
        b=Ly2y4lHYRBeMWyOe9V9k8iaEAyxLZqNsfB4Jg52//kPQXPyUAlg1/tsen+EoUFFvml
         cfPQlKuvk7gcXDuS/qqZuHz0Gwe10JPDGzEirWL39CKHjwcpj4dREsqLLURd74KVgOsc
         FVO7XuH74eM41LdpIptn64A8eEqi1/X6O2Npf+Wl4H8hA3rrkXD2ghyKxl0tMJXtph3U
         lbNLdncFB0qzfwBdFXA3VLz9vmwoCtZReVtd6yOocVyJjCylk5C40M7rPK21/+Kvtw+M
         ioiMlZzqaORmLYIxGYaEwvLNorVsj9rdD0TD6XPbwxS0IQYvB0OrdKr7C6hmRZ2aSAXU
         3cDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDUoqQRTnNv8ybCgbXaTIde6zC06OstmyEq9KrXom/k=;
        b=CmEJJeLeuiqoIUAO+0XuG1uAsgO8MCgLflEHTFblypVFRiov/WINMErJce0TTmWOAB
         voo6qXsRTGSYSOVLBik37kZTRRw9zeA4iAlbThI5DgM530HA+mKfIwIGlMWfG9Q2vG8d
         qVuuHFr1i+XcDtmhBRg7fXBMGNcsaJ0BMmsrsH0HuGkEC7liwgILQc1RcwuP7y77M/Zs
         uKEu/yNc3YvNr6sjmTpvZpFNpSgISiMfqtcNx3xwe5WolgL/IRP3d6g8VwaqzuA9kQ6/
         WJfcJtPzf/IM2+PV7qOtWQ+Dn4vsw1l1yzmqfWsACP5vbqf13XfrC2UQmfhyZXJ6Wlkd
         csQQ==
X-Gm-Message-State: AJcUukcWAijn9Brp8E9HS8WjVtoBW+nmOUuDFfE0Hds4h5iTogK8QU9X
        D5ewghuSj/8mGkHxDOz6bj1CBRsTn6CnuA1VAIPxFw==
X-Google-Smtp-Source: ALg8bN6HyLNDs99kQtkKUsIs7T8pufHsJZUnYZHs6TVXUJNS0F9oEWIV/jZwaxd5Zp9khGlulxpr5o+jQL5oE0K8z/4=
X-Received: by 2002:adf:8506:: with SMTP id 6mr10635609wrh.128.1545881888326;
 Wed, 26 Dec 2018 19:38:08 -0800 (PST)
MIME-Version: 1.0
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com> <1545865741-22795-3-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1545865741-22795-3-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 27 Dec 2018 09:07:57 +0530
Message-ID: <CAAhSdy12XrVOXcSaoUj1s1DBT-qW5S1nMiVQpCvEVcQM31cRJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: Move cpuid to hartid mapping to SMP.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 4:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, logical CPU id to physical hartid mapping is
> defined for both smp and non-smp configurations. This
> is not required as we need this only for smp configuration.
> The mapping function can define directly boot_cpu_hartid
> for non-smp usecase.
>
> The reverse mapping function i.e. hartid to cpuid can be called
> for any valid but not booted harts. So it should return default
> cpu 0 only if it is a boot hartid
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/smp.h | 13 +++++++++++--
>  arch/riscv/kernel/setup.c    |  2 ++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 41aa73b4..8f30300f 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -22,12 +22,13 @@
>  /*
>   * Mapping between linux logical cpu index and hartid.
>   */
> -extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
> -#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>
> +extern unsigned long boot_cpu_hartid;
>  struct seq_file;
>
>  #ifdef CONFIG_SMP
> +extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
> +#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>
>  /* print IPI stats */
>  void show_ipi_stats(struct seq_file *p, int prec);
> @@ -58,7 +59,15 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
>
>  static inline int riscv_hartid_to_cpuid(int hartid)
>  {
> +       if (hartid == boot_cpu_hartid)
>                 return 0;
> +       else
> +               return -1;
> +}
> +static inline unsigned long cpuid_to_hartid_map(int cpu)
> +{
> +
> +       return boot_cpu_hartid;
>  }
>
>  static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c290e6a..bd4d7b85 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -83,6 +83,7 @@ EXPORT_SYMBOL(empty_zero_page);
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
>
> +#ifdef CONFIG_SMP
>  unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
>         [0 ... NR_CPUS-1] = INVALID_HARTID
>  };
> @@ -91,6 +92,7 @@ void __init smp_setup_processor_id(void)
>  {
>         cpuid_to_hartid_map(0) = boot_cpu_hartid;
>  }
> +#endif

Please move __cpuid_to_hartid_map[] and smp_setup_processor_id()
to arch/riscv/kernel/smp.c

Otherwise, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>
