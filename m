Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E19C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3265206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="RJVNzMAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfAHLtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:49:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfAHLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:49:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so4086384wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+V0n8Xtcjz4tHs8ZXrRMUNU6iatKnY0VEqk+wmS3fU=;
        b=RJVNzMAIesjPC3AE2E+TOmmX5R6vuJzXu/efycylgwXhE1CxBo434WiRvT0LIlPnqH
         Xbs7Rz8UXSpXOq4XvCfjiajPfiN0SpQDl9EuxEW++yFRJ08jY79tWwbNpMH+RyDp9nsW
         l1Zk3ZRzGq2KusdLTTZpDyOuFnw32FfI3ut5Fy/PGBeqyHAtH706e+dS9kvvBRp5+Hex
         mgXXSpXi6nUEfY5HRxgqTsZfXzX7S13J3jG7VQqV8Twpsxsdb/5i9of1VVAu+gYA7iSC
         71Y6m0RinP6SMCR19Ywy2bMXErQukqsPEvmYvaeRu2iZ6unrQHF18h62pBdqFTwRr3yo
         rvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+V0n8Xtcjz4tHs8ZXrRMUNU6iatKnY0VEqk+wmS3fU=;
        b=Oz/ycpEsR8n9WhzAVcYmx+k+5OpYtd4uyY0SevQ10kRire3Qj3HnuGmTZCPHXW77dW
         QorUZG7jX8f51alCS7WNAz9aUqurLDuPAsnqV6w/f5JKf8sySbKDrlIpn1g66m5dxAKO
         hdhkmhm8+U9LRMETH8G2dOdjLlHBV1LNqyDS4E8uFqdJ/NOvZ6av1Hnzhu0Dkkmzf8T5
         vGZI8a/LSReugtrAyii8YRM7SkPpTJhj58g+2AFrEToQOStQZsLgD9E9tLjo1j1TYrI1
         +aSpcYXZqoPlQ+xwsAjRemN+/l2fchkG8PlTdIcK+T02EQ4CpTGUc5G/qOIEEnjqmUqN
         vcmw==
X-Gm-Message-State: AJcUukeFr/yDUIt48nuv4OMk/vq9LCgy5j5vtsbAty2waXdBrZ8nGqUp
        px/NmyVpyotdV3crUEMZ/jAbBGQ8+ES+DA7U9kat2Q==
X-Google-Smtp-Source: ALg8bN5Ji4/z3cNLskNRfsCfIPWBHYz878MlwhN7JxfA8KyX57565/Xs6NV9LUpnH6eNYuN4MMatcqZUvKknxJE19mw=
X-Received: by 2002:a1c:f509:: with SMTP id t9mr1641639wmh.76.1546948151708;
 Tue, 08 Jan 2019 03:49:11 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-5-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-5-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:19:00 +0530
Message-ID: <CAAhSdy05324s1RtBM73v5irR9-c5gU0T6W=UA4chVCgEwvR-yA@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Allow hartid-to-cpuid function to fail.
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
> It is perfectly okay to call riscv_hartid_to_cpuid for a
> hartid that is not mapped with an CPU id. It can happen
> if the calling functions retrieves the hartid from DT.
> However, that hartid was never brought online by the firmware
> or kernel for any reasons.
>
> No need to BUG() in the above case. A negative error return
> is sufficient and the calling function should check for the
> return value always.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index e407bd4f..ce9a2e73 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -58,7 +58,6 @@ int riscv_hartid_to_cpuid(int hartid)
>                         return i;
>
>         pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> -       BUG();
>         return i;
>  }
>
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
