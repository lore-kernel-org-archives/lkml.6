Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9DD37C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC3F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bMIvT8wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC3F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934858AbeFLAqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:46:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40678 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934446AbeFLAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:46:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so11135533pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SW/0hFasrCYKNRGHyDR1MhXB96TLPQ8coLgT8ffY3yo=;
        b=bMIvT8wudNgwohK8PcysUqxmUDfKNpFOlSslzhzZgXsDI07MEDNr6V1On5qKJOtf4k
         WfJ5tDaUJoIVTFozPwpfhDWuCHbKSHtjIs9wqm0tlbVn4nTe9QNMixyhLq1IuruHw/Vy
         waTRmLjkdW+PQ4q1RIgcbEyEISGZqcMCrNg0LkS1pCUwBYYCf2Ce7HJ6fBX+NJiCX/xA
         smHFLHiIrb8FfiiX9ajhCJeg0Epl4Sj6smV1iYMGAmOCPhk4WZPQewlL8fU8mJq3HxXp
         s+73BFS+fd9icuV4TPpHg0W4xfkbJhZPVF9weCMEQF1fRnfXf0v+WvC1RBXOqwi0rj65
         m0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SW/0hFasrCYKNRGHyDR1MhXB96TLPQ8coLgT8ffY3yo=;
        b=ZBq/dGOeferG/OjEMG2+4FWDteGZAW2/hJxXLuAEgsljPp8jXjdpuweJGO4mpu1aY3
         HRPSC3gPQ1tFpYKbLOkGBIcLgtzjYIDChTarIslLs10oBcYOqe2kkH3nFe/O8JysFO98
         t7/ox+4S9rtuuHmHGw+/vhJTaieq0ctTbLRsufj//prBfr1PAXhA+WxmvH4ZZDHnEtpG
         4/bSetpRZmUGcTP5xSFjXlsanGpeWO6rwrJZvQrB91Qxrg7qej2PE0mFlEr+hptbGklg
         q3Z1SuVOI9zs0g3/Fv/tB7BznNz3T4tPysfHhfayFt5ce+TMHa51G+x2kaz/Oc8q0YwR
         MTFQ==
X-Gm-Message-State: APt69E16YRXmkNaUQ3+u9+/0tY6N4mXXjHzaQ2YS9zEnk5ObvKrVjf7Z
        EaTAbooeIrDplUB8f67ECWXnOg==
X-Google-Smtp-Source: ADUXVKIyJXZYtKgj01NHrpF2i98RdHEwnPW9CVlQZhRemwX7tRrI+5kw7+9odz0wlLZS3ojlL+90cg==
X-Received: by 2002:a63:9543:: with SMTP id t3-v6mr1158399pgn.77.1528764389404;
        Mon, 11 Jun 2018 17:46:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b3-v6sm112540336pff.132.2018.06.11.17.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:46:28 -0700 (PDT)
Date:   Mon, 11 Jun 2018 17:46:28 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Jun 2018 17:38:26 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Fix PTRACE_SETREGSET bug.
In-Reply-To: <20180611214822.8539-1-jimw@sifive.com>
CC:     linux-riscv@lists.infradead.org, Jim Wilson <jimw@sifive.com>,
        oleg@redhat.com, albert@sifive.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Jim Wilson <jimw@sifive.com>
Message-ID: <mhng-7a581ed4-d7ab-4188-92e6-3a8002f3c8d1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 14:48:22 PDT (-0700), Jim Wilson wrote:
> In riscv_gpr_set, pass regs instead of &regs to user_regset_copyin to fix
> gdb segfault.
>
> Signed-off-by: Jim Wilson <jimw@sifive.com>
> ---
>  arch/riscv/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ba3e80712797..9f82a7e34c64 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -50,7 +50,7 @@ static int riscv_gpr_set(struct task_struct *target,
>  	struct pt_regs *regs;
>
>  	regs = task_pt_regs(target);
> -	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0, -1);
> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
>  	return ret;
>  }

Whoops, that's embarassing :).  I poked around and didn't see this anywhere 
else, so I'm not sure where we managed to obtain this particular pathology.

Thanks for the patch!
