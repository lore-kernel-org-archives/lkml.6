Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1383206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="SUvjF5QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfAHLsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:48:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33559 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:48:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so8265704wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fihLDeBdBCv7UmpGapUichtBalNpltWbM/T1LuHnn1E=;
        b=SUvjF5QTE/q99kJO/QO9AadOOOqQJy0OsaAQvr0dXzDYTrM/rDxyxXc/D1pzpLDiss
         RPiTeQKe8HNfCPbasdq3muPc+uJJz1i4HSbJY/EtIUMyh9sWPpwXPp6vuI4pJMbnZQKt
         A1sN75oTC4HgufmnLk0LedxaFnjIMebh1PUmq8LIx6Dem5qMeVsj8ZaNx2v22fu6Kk92
         8WIym4S1nSQ6OoyCWRgK8HhdWKPt+McV+PkLz6ONEZZCzpQH44lYSDZxFErXa245h4yv
         zAODo284aAsJwLhVDdZpezsZulyiAw/U7Dhm2ecWp8dQz5K8v400aoYdvMXXMT3B2BRr
         Gv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fihLDeBdBCv7UmpGapUichtBalNpltWbM/T1LuHnn1E=;
        b=J1IVYNKEZy3PM2YGMWSOg5068CQqyKYHoDN/eyT+nJUzOUqAwDtVy1BfHYSP9WACi8
         r8poAaz6pZfp7ND4wo4RjjlJaQqj5SzxrJpw/LMvo50jACDkcH+ylyGR1jWYg/kcymnh
         XmwPR25/gPjDvAWihxE2x/YTTmHGsxVNkLTcwGfjCyt3yCRPr9uWneOZ+LjdGsQo8E1I
         lYrRFSCVEdsGuJdh8I3RfZZs2XMviNCBR4d7n8DbWyxqWjtG2V+nmoDtYjiwj8paBvQs
         994Csp7dlNTVSuJ4kIlfjDBAsVSp2zIgtW5zPfr90ea2SIZYY4584NJAyZgsjYmvosFE
         9N0A==
X-Gm-Message-State: AJcUukdKdmiKpmGA/+kUBuYWleay19pMuy5XjtSCaHqQVETx97AIRBBb
        6+1pqkebekVR8seB8Zh85f2tQUSUNg3mT2JfGtgUbg==
X-Google-Smtp-Source: ALg8bN5cD2iJ0kVxGqwVi1PVwrKMkhUsaq8p5Clty6fiADVv2zC8MmX6NanYBcrH0TBkbAmccauLUMvnOgOJ/U1koFA=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr1543468wme.16.1546948114765;
 Tue, 08 Jan 2019 03:48:34 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-4-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-4-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:18:23 +0530
Message-ID: <CAAhSdy38LyH35ABqexHoG-fy=FXp9B79cruSHBuD+jzY_EFVgw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] RISC-V: Remove NR_CPUs check during hartid search
 from DT
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
> In non-smp configuration, hartid can be higher that NR_CPUS.
> riscv_of_processor_hartid should not be compared to hartid to
> NR_CPUS in that case. Moreover, this function checks all the
> DT properties of a hart node. NR_CPUS comparison seems out of
> place.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpu.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f8fa2c63..19edaeae 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
>                 pr_warn("Found CPU without hart ID\n");
>                 return -(ENODEV);
>         }
> -       if (hart >= NR_CPUS) {
> -               pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
> -               return -(ENODEV);
> -       }
>
>         if (of_property_read_string(node, "status", &status)) {
>                 pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
