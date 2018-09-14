Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC011FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945D520833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppTiWdkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeINV6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:58:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37803 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbeINV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:58:53 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so9313202qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 09:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bBDwXoUqF7xWeLzSUEbwVm+elkBhR58J0N2fe+wEUB4=;
        b=ppTiWdkh9MF6785pE5y+PV0MNsq6vR/aa5E30i9wz7/lbf5upW57TDSVCLwHpDYNvw
         nFTahiVh3yytBu7pCbt4soOT0XQ9VUNrfGRWGcTGnn+bwKXUJCClaJDwfevcZ8zmOQ3k
         a4Qc9Qn6fQW85E9b+UsWJsvRT/Bf7S0PkM+DmZU+4TIE7XF1Un+3us0YndRzGdos4bMv
         jSFYT99QlNcbrNpoV0PPcynkdxaqtKiWkcTcPTJk2uxge5btyfIKqBGsOoECfq+GXIx2
         kyDuMWBg+RPsMZx2VbuiuUcqOL0WdotY/Fk2lTHs1Z9tT7+6f7NRJ5NVrCAsdmE4n1Pm
         2qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bBDwXoUqF7xWeLzSUEbwVm+elkBhR58J0N2fe+wEUB4=;
        b=HMAjXZgKQtzi+gnZpdcXnm5vO2KxzpG3NaCfdW+65g36Yf/bCqGDb0E+m7yeIIm6eD
         la2SfLN9DPnfSN8KGget2N85JyWQkp795QzKQ8LUfP6AKtlPuEKck7L5QpurzebqFIJE
         f8AdXLRaBqZXHM/JCdwa+lWC0K2YL4Y6y3WgTZRgmdz7pOpS+im3/EfFpKmqG8bh/kdP
         exCdFVb2mANJmHqScoTQqasWNUKrpLcURmTNLR5qVQnAjnSPTliBtZ1E0Y0FW1tsHDNw
         nIuXzg+8HBf/XXtniCjSo1YlwSTrOkBG1gKpkKxnaVlYtHjGl1h46IHUVxjvcNU6xx0o
         xffg==
X-Gm-Message-State: APzg51BYpsE2Yj12OCTr1cnyPIMOBfV3ODULP5whsAtZUaRDvdj/mpdQ
        uuDBl4cBiTeqoamIzla5jRgGvXNWRqNvX1sVl9mll0RQksg=
X-Google-Smtp-Source: ANB0VdY0tV1k99hDrXGSggrvRALLfzgY5lAiuKtlEKj0yFvxBGThNs++CZxQQsMp1SKaxGA77MU4kwhqiweo3OekrME=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr9764402qvb.78.1536943415859;
 Fri, 14 Sep 2018 09:43:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 09:43:15
 -0700 (PDT)
In-Reply-To: <1536936549-30631-1-git-send-email-zhongjiang@huawei.com>
References: <1536936549-30631-1-git-send-email-zhongjiang@huawei.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Sep 2018 18:43:15 +0200
Message-ID: <CANiq72ndUkKyZ1gxgv9kv_Niq0sb7RwLj4QGrKNa2bg_jmd45A@mail.gmail.com>
Subject: Re: [PATCH] sched: Fix a GCC compiled warning.
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhong,

On Fri, Sep 14, 2018 at 4:49 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> Fix the following compile warning:
>
> kernel/sched/core.c: In function =E2=80=98update_rq_clock_task=E2=80=99:
> kernel/sched/core.c:139:6: warning: unused variable =E2=80=98steal=E2=80=
=99 [-Wunused-variable]
>   s64 steal =3D 0, irq_delta =3D 0;
>

Dou (and I, without having noticed Dou's) also sent another patch for this,=
 see:

  https://lore.kernel.org/patchwork/patch/973402/
  https://lore.kernel.org/patchwork/patch/983794/

Cheers,
Miguel

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7577ce4..1003c1d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -136,7 +136,7 @@ static void update_rq_clock_task(struct rq *rq, s64 d=
elta)
>   * to sched_rt_avg_update. But I don't trust it...
>   */
>  #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_=
ACCOUNTING)
> -       s64 steal =3D 0, irq_delta =3D 0;
> +       s64 __maybe_unused steal =3D 0, irq_delta =3D 0;
>  #endif
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>         irq_delta =3D irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
> --
> 1.7.12.4
>
