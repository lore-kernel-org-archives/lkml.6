Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82436208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHa3YaO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82436208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeGaQvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:51:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43579 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeGaQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:51:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so28562646oib.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sbU84qR9p+ckrPPjiQWNlhCjaT2KFj49dIL/8wYrRLc=;
        b=IHa3YaO2GjuR51O3UmBDnkbXxVpsAx/vxceI1CTXD95eurkzULsRy5Ex3Qc6cgWUhc
         MQ2tfPO1arQOFwfQI1yeFAx+5EfINB2/GDsJkygNmiq37UBjMNuBc8vqBMi6pCAw3qjV
         Htl9vcnMbDi/kcIUartcVnoXBcIavPpWRO+E9EBPloLIUt6cst9DtMI0Endd1Tz6iTes
         ex0JUcNYFW8HxiQbLGGMoDu3kmPItNiDrykGiCCNYXmmT4Kmcq4Gc5kjihFXTqZoXUh5
         r3FSi8ZHcAtbn/e1pmq1I84+oJE7VwCZPihkfOjmFatkjjveb42pTvVkdmS4+INoaJ1b
         Sy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sbU84qR9p+ckrPPjiQWNlhCjaT2KFj49dIL/8wYrRLc=;
        b=oAP5W/aIm2zmFyeMJLoY6Z7mlxgN3zmqGdfDXsIiijQrBKEckJK1TunoMGd2aEpWQm
         IOWHgDL8tZt4KG9ZeuBHXoA8J7JfUy1WCOxEirNbCsL9qgbYYB4/RU/WxyxKKc5b5Uzv
         pE3JrOSozsYb6P8ZGcARrq1Q6RxmZSGe76T8B53EJJGB0X/cmJO2YxD59Z2gv11dVy+Z
         seilgnZWj9OBH2J8pPtb1lDQIYl4Zstvf4Mex5gFxNcsuiTqvmddS4NsYpMje4l+7ZHm
         QirDWgnRXZEI5MdOeNC5J5vVXG91+p1hPmk+A4pVqlR4BxRmtpP2TUm2Vv4qP/YhdwIx
         BSJw==
X-Gm-Message-State: AOUpUlHBDaip4Qr/QjHyjJ9CTqmmTmqocJwHkl0R7gKX5RHFy0AakNbt
        62TKEQ7nyG9gxRJgrMU2tcGAamE141DjoK458/M=
X-Google-Smtp-Source: AAOMgpc4zyYwzt3I+VxiXg2nApua9aq8SBYsF84GxAmXBIMJFx9YpgQc2EmWEkNpo9QVLAB9pEi3I34ovGCh/dTmFYw=
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr20962635oib.254.1533049852353;
 Tue, 31 Jul 2018 08:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7702:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 08:10:51
 -0700 (PDT)
In-Reply-To: <20180731142835.GC4909@kernel.org>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com> <20180731142835.GC4909@kernel.org>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 31 Jul 2018 20:40:51 +0530
Message-ID: <CAKTKpr7ZLru2wvtarq01p6PqJKQLEhCFtoo=tw45Svh-V_vFag@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events arm64: Update ThunderX2 implementation
 defined pmu core events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jul 31, 2018 at 7:58 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Jul 31, 2018 at 03:32:51PM +0530, Ganapatrao Kulkarni escreveu:
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>
> Can you please consider to provide an example of such counters being
> used, i.e. with a simple C synthetic test that causes these events to
> take place, then run it via 'perf stat' to show that indeed, they are
> being programmed and read correctly?
>
> Ideally for all of them, but if that becomes too burdensome, for a few
> of them?

It may be tedious for all, certainly I will provide the test
results/log for some of them(as many as possible).

>
> Thanks,
>
> - Arnaldo
>
>> ---
>>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
>>  1 file changed, 84 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> index bc03c06..752e47e 100644
>> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> @@ -12,6 +12,21 @@
>>          "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>>      },
>>      {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_INVAL",
>> +    },
>> +    {
>>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
>>      },
>>      {
>> @@ -24,9 +39,75 @@
>>          "ArchStdEvent": "L1D_TLB_WR",
>>      },
>>      {
>> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L2D_TLB_WR",
>> +    },
>> +    {
>>          "ArchStdEvent": "BUS_ACCESS_RD",
>> -   },
>> -   {
>> +    },
>> +    {
>>          "ArchStdEvent": "BUS_ACCESS_WR",
>> -   }
>> +    },
>> +    {
>> +        "ArchStdEvent": "MEM_ACCESS_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "MEM_ACCESS_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_UNDEF",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_SVC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_PABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_DABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_IRQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_FIQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_SMC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_HVC",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_PABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_DABORT",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_OTHER",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_IRQ",
>> +    },
>> +    {
>> +        "ArchStdEvent": "EXC_TRAP_FIQ",
>> +    }
>>  ]
>> --
>> 2.9.4

thanks
Ganapat
