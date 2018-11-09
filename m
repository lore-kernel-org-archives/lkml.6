Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26657C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C484B20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Epf0ZZ9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C484B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKJDOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:14:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40281 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:14:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so2263021lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8/PX1YN5m9OHw/AjVaRH5r3N+I6WkepCd/b2GMboxE=;
        b=Epf0ZZ9DsQm/m0sYfhYai+aEjOdFYsPJIGTrjgQC/zd4OBrSFYE/0U5yWRoYFb28TA
         xyOd+km7Gi6bePW5qL7vYUTtnStSLewCX6x9wli+eaD3FBspNoGl1gn4GvptsVacFvhi
         Nax30a3ufTdPJMv8OCZulqzAxKLtye2C+LEII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8/PX1YN5m9OHw/AjVaRH5r3N+I6WkepCd/b2GMboxE=;
        b=eVhsGvxnSLPz36Otz/J5DLaju/oxSwK7LHuSUA8FKuGz9I4r8K/bqmQJY6jM12hWUu
         yE8oa16ANjn/XmEisGPTM5pjJfJLpJsvM3LGgnUFk4fQKQdsS2oBGUWw1AL16py1i381
         hW2bvd7+jmasYCfTnKT5RGTWxHHm+8IDrF9Gx5Et5o2huANMIpGeKcBhVB7vg5iA5cc7
         WYAWu1rTskWLe8S2lBPOWIpZhFNGlnyRTLmuYomn9Wc82ZTVPwLI/dIo8b5ntVSQMcKu
         pjciX10pchoT7WvrxnrpCqkead+nyfPUbfSvdlLhQuyLBK6bnFsbx4s5Rn53wl75ygG2
         hhvg==
X-Gm-Message-State: AGRZ1gLyMCYz3mGaVggui9UIfGVrxdErnPTVKs0jnZl0mjy+5Q1GPekm
        096QN7Mo+iHO9D730d4nr7PRW206TaDCIvM94ejxKQ==
X-Google-Smtp-Source: AJdET5dWDBXhobMVdNXmHmLphXDKe6lsBNTaUTIsODfghQAxSsmEIU+SF5MGb+BsJUA6ea4BrwCeJ3ui8cN/KUsHsMY=
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr6679539lji.133.1541784760827;
 Fri, 09 Nov 2018 09:32:40 -0800 (PST)
MIME-Version: 1.0
References: <1541754686-19222-1-git-send-email-robert.walker@arm.com>
In-Reply-To: <1541754686-19222-1-git-send-email-robert.walker@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 9 Nov 2018 10:32:29 -0700
Message-ID: <CANLsYkxyeQcNskLC_zz=Yy2yGqswDbL=cZ7gijXnrNTdyQeoWQ@mail.gmail.com>
Subject: Re: [PATCH v5] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
To:     Robert Walker <robert.walker@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        CoreSight@lists.linaro.org, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 at 02:11, Robert Walker <robert.walker@arm.com> wrote:
>
> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
>
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.10.0 of OpenCSD.  A check for the OpenCSD
> library version has been added to the feature check for OpenCSD.
>
> Signed-off-by: Robert Walker <robert.walker@arm.com>

Arnaldo,

Please consider for inclusion in the 4.21 cycle.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Leo has also tested this set [1].

Thanks,
Mathieu


[1]. https://lkml.org/lkml/2018/11/9/756


> ---
>
> Changes since v4:
>  Formatting of comment block
>
>  tools/build/feature/test-libopencsd.c           |  8 +++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++++
>  tools/perf/util/cs-etm.c                        | 70 +++++++++++--------------
>  4 files changed, 78 insertions(+), 39 deletions(-)
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 5ff1246..d68eb4f 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -1,6 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <opencsd/c_api/opencsd_c_api.h>
>
> +/*
> + * Check OpenCSD library version is sufficient to provide required features
> + */
> +#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
> +#if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> +#error "OpenCSD >= 0.10.0 is required"
> +#endif
> +
>  int main(void)
>  {
>         (void)ocsd_get_version();
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 938def6..5efb616 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -263,9 +263,12 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>         decoder->tail = 0;
>         decoder->packet_count = 0;
>         for (i = 0; i < MAX_BUFFER; i++) {
> +               decoder->packet_buffer[i].isa = CS_ETM_ISA_UNKNOWN;
>                 decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
>                 decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
> +               decoder->packet_buffer[i].instr_count = 0;
>                 decoder->packet_buffer[i].last_instr_taken_branch = false;
> +               decoder->packet_buffer[i].last_instr_size = 0;
>                 decoder->packet_buffer[i].exc = false;
>                 decoder->packet_buffer[i].exc_ret = false;
>                 decoder->packet_buffer[i].cpu = INT_MIN;
> @@ -294,11 +297,15 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>         decoder->packet_count++;
>
>         decoder->packet_buffer[et].sample_type = sample_type;
> +       decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
>         decoder->packet_buffer[et].exc = false;
>         decoder->packet_buffer[et].exc_ret = false;
>         decoder->packet_buffer[et].cpu = *((int *)inode->priv);
>         decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
>         decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
> +       decoder->packet_buffer[et].instr_count = 0;
> +       decoder->packet_buffer[et].last_instr_taken_branch = false;
> +       decoder->packet_buffer[et].last_instr_size = 0;
>
>         if (decoder->packet_count == MAX_BUFFER - 1)
>                 return OCSD_RESP_WAIT;
> @@ -321,8 +328,28 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>
>         packet = &decoder->packet_buffer[decoder->tail];
>
> +       switch (elem->isa) {
> +       case ocsd_isa_aarch64:
> +               packet->isa = CS_ETM_ISA_A64;
> +               break;
> +       case ocsd_isa_arm:
> +               packet->isa = CS_ETM_ISA_A32;
> +               break;
> +       case ocsd_isa_thumb2:
> +               packet->isa = CS_ETM_ISA_T32;
> +               break;
> +       case ocsd_isa_tee:
> +       case ocsd_isa_jazelle:
> +       case ocsd_isa_custom:
> +       case ocsd_isa_unknown:
> +       default:
> +               packet->isa = CS_ETM_ISA_UNKNOWN;
> +       }
> +
>         packet->start_addr = elem->st_addr;
>         packet->end_addr = elem->en_addr;
> +       packet->instr_count = elem->num_instr_range;
> +
>         switch (elem->last_i_type) {
>         case OCSD_INSTR_BR:
>         case OCSD_INSTR_BR_INDIRECT:
> @@ -336,6 +363,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>                 break;
>         }
>
> +       packet->last_instr_size = elem->last_instr_sz;
> +
>         return ret;
>  }
>
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 612b575..9351bd1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -28,11 +28,21 @@ enum cs_etm_sample_type {
>         CS_ETM_TRACE_ON = 1 << 1,
>  };
>
> +enum cs_etm_isa {
> +       CS_ETM_ISA_UNKNOWN,
> +       CS_ETM_ISA_A64,
> +       CS_ETM_ISA_A32,
> +       CS_ETM_ISA_T32,
> +};
> +
>  struct cs_etm_packet {
>         enum cs_etm_sample_type sample_type;
> +       enum cs_etm_isa isa;
>         u64 start_addr;
>         u64 end_addr;
> +       u32 instr_count;
>         u8 last_instr_taken_branch;
> +       u8 last_instr_size;
>         u8 exc;
>         u8 exc_ret;
>         int cpu;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 73430b7..48ad217 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -31,14 +31,6 @@
>
>  #define MAX_TIMESTAMP (~0ULL)
>
> -/*
> - * A64 instructions are always 4 bytes
> - *
> - * Only A64 is supported, so can use this constant for converting between
> - * addresses and instruction counts, calculting offsets etc
> - */
> -#define A64_INSTR_SIZE 4
> -
>  struct cs_etm_auxtrace {
>         struct auxtrace auxtrace;
>         struct auxtrace_queues queues;
> @@ -510,21 +502,17 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
>         etmq->last_branch_rb->nr = 0;
>  }
>
> -static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
> -{
> -       /* Returns 0 for the CS_ETM_TRACE_ON packet */
> -       if (packet->sample_type == CS_ETM_TRACE_ON)
> -               return 0;
> +static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> +                                        u64 addr) {
> +       u8 instrBytes[2];
>
> +       cs_etm__mem_access(etmq, addr, ARRAY_SIZE(instrBytes), instrBytes);
>         /*
> -        * The packet records the execution range with an exclusive end address
> -        *
> -        * A64 instructions are constant size, so the last executed
> -        * instruction is A64_INSTR_SIZE before the end address
> -        * Will need to do instruction level decode for T32 instructions as
> -        * they can be variable size (not yet supported).
> +        * T32 instruction size is indicated by bits[15:11] of the first
> +        * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
> +        * denote a 32-bit instruction.
>          */
> -       return packet->end_addr - A64_INSTR_SIZE;
> +       return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>  }
>
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> @@ -536,27 +524,32 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>         return packet->start_addr;
>  }
>
> -static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
> +static inline
> +u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
>  {
> -       /*
> -        * Only A64 instructions are currently supported, so can get
> -        * instruction count by dividing.
> -        * Will need to do instruction level decode for T32 instructions as
> -        * they can be variable size (not yet supported).
> -        */
> -       return (packet->end_addr - packet->start_addr) / A64_INSTR_SIZE;
> +       /* Returns 0 for the CS_ETM_TRACE_ON packet */
> +       if (packet->sample_type == CS_ETM_TRACE_ON)
> +               return 0;
> +
> +       return packet->end_addr - packet->last_instr_size;
>  }
>
> -static inline u64 cs_etm__instr_addr(const struct cs_etm_packet *packet,
> +static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> +                                    const struct cs_etm_packet *packet,
>                                      u64 offset)
>  {
> -       /*
> -        * Only A64 instructions are currently supported, so can get
> -        * instruction address by muliplying.
> -        * Will need to do instruction level decode for T32 instructions as
> -        * they can be variable size (not yet supported).
> -        */
> -       return packet->start_addr + offset * A64_INSTR_SIZE;
> +       if (packet->isa == CS_ETM_ISA_T32) {
> +               u64 addr = packet->start_addr;
> +
> +               while (offset > 0) {
> +                       addr += cs_etm__t32_instr_size(etmq, addr);
> +                       offset--;
> +               }
> +               return addr;
> +       }
> +
> +       /* Assume a 4 byte instruction size (A32/A64) */
> +       return packet->start_addr + offset * 4;
>  }
>
>  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
> @@ -888,9 +881,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>         struct cs_etm_auxtrace *etm = etmq->etm;
>         struct cs_etm_packet *tmp;
>         int ret;
> -       u64 instrs_executed;
> +       u64 instrs_executed = etmq->packet->instr_count;
>
> -       instrs_executed = cs_etm__instr_count(etmq->packet);
>         etmq->period_instructions += instrs_executed;
>
>         /*
> @@ -920,7 +912,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>                  * executed, but PC has not advanced to next instruction)
>                  */
>                 u64 offset = (instrs_executed - instrs_over - 1);
> -               u64 addr = cs_etm__instr_addr(etmq->packet, offset);
> +               u64 addr = cs_etm__instr_addr(etmq, etmq->packet, offset);
>
>                 ret = cs_etm__synth_instruction_sample(
>                         etmq, addr, etm->instructions_sample_period);
> --
> 2.7.4
>
