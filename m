Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BBFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6zDAHWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ED82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbeLERkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:40:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39316 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeLERkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:40:20 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so21484166itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nlL1p2yoBr3pIvD0HWe+y7l0ldgE13DMXETLceC1YAc=;
        b=e6zDAHWeWQi1LkMcg8FMJG37WN3/RSUBhFl2srvMe/UITnbobAHTenge8nRnEjaWDD
         AKfFNPpcUDmllnFihR6+FRQKH6eiox8ZCTlfx9epVd2t/Kcf7KlNyogM5CdYJIu16WQq
         YieWrjwv6IFauwAPdoDhWK7shcplaOvkAsqC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nlL1p2yoBr3pIvD0HWe+y7l0ldgE13DMXETLceC1YAc=;
        b=LJAoi2bhaoOd9710tKC+mFuzM2LNoDit7mdax1UpghwHdbg46MTHKfc2grw9DQDq+3
         rkwXQPyhhjbqpaUBA1rXouhMMUc3+rY+pinvEh37EZIfc/g6SBVGM3v4LW+YKIwDJd/A
         de29D8lB1akO47TJZd4xjbtBX9eUoXY0KmDWTePSKXshOwYMzYlJ/VqVGHjXKf9CgefK
         fTry4oJbVY9U66U2JNtGGGm9hG2PqQFRpon7VPtx+ZpcvfO/2oayKnl3g+teau1Gi3Nk
         jWyz6IxLVg1RiVepqKULUAqURvsYAOnzw4GJCU2b2stFmUpiGtx8oaOsGCMIXe+RdqG2
         AxWQ==
X-Gm-Message-State: AA+aEWYf+IFZ1hvTT9/2Tu71mwtKPDnTqwthfiCE/oFTbZFrxw3IGPoD
        nd5SHy2/9xU5oKVb9Ed8+3c8s82jaRL+lSsFEqBb8w==
X-Google-Smtp-Source: AFSGD/XeTfcKAAWcESEQJ2Oek/IMAgFLCpCbkHkmNqoCSJnOXJrRsSfHPX+qn4pdxSDLH2j7CffkxJpIiIuM+FGnMXI=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr23223622jad.98.1544031618491;
 Wed, 05 Dec 2018 09:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-2-git-send-email-leo.yan@linaro.org> <20181119222617.GA5628@xps15>
 <20181205062550.GC15964@leoy-ThinkPad-X240s>
In-Reply-To: <20181205062550.GC15964@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 5 Dec 2018 10:40:07 -0700
Message-ID: <CANLsYkzTJdKtXBwMMLStgjoUEKz8nsvOpKYcoULh7kHejGAGsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf cs-etm: Set branch instruction flags in packet
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Andi Kleen <andi@firstfloor.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 23:26, <leo.yan@linaro.org> wrote:
>
> On Mon, Nov 19, 2018 at 03:26:17PM -0700, Mathieu Poirier wrote:
> > On Sun, Nov 11, 2018 at 01:07:55PM +0800, Leo Yan wrote:
> > > The perf sample data contains flags to indicate the hardware trace da=
ta
> > > is belonging to which type branch instruction, thus this can be used =
to
> > > print out the human readable string.  Arm CoreSight ETM sample data i=
s
> > > missed to set flags and it is always set to zeros, this results in pe=
rf
> > > tool skips to print string for instruction types.
> > >
> > > Arm CoreSight ETM supports different kinds instruction of A64, A32 an=
d
> > > T32; this patch is to set branch instruction flags in packet for thes=
e
> > > ISAs.
> > >
> > > The brief idea for patch implementation is describe as below:
> > >
> > > - For element with OCSD_GEN_TRC_ELEM_TRACE_ON type, it is taken as tr=
ace
> > >   beginning packet; for element with OCSD_GEN_TRC_ELEM_NO_SYNC or
> > >   OCSD_GEN_TRC_ELEM_EO_TRACE, these two kinds elements are used to se=
t
> > >   for trace end;
> > >
> > >   As Mike suggested the packet stream might have more than one two
> > >   TRACE_ON packets, the first one TRACE_ON packet indicates trace end
> > >   and the second one is taken as trace restarting.  We will handle th=
is
> > >   special case in the upper layer with packet queue handling, which h=
as
> > >   more context so it's more suitable fix up for it.  This will be
> > >   accomplished in the sequential patch.
> > >
> > > - For instruction range packet, mainly base on three factors to decid=
e
> > >   the branch instruction types:
> > >
> > >   elem->last_i_type
> > >   elem->last_i_subtype
> > >   elem->last_instr_cond
> > >
> > >   If the instruction is immediate branch but without link and return
> > >   flag, we consider it as function internal branch;  in fact the
> > >   immediate branch also can be used to invoke the function entry,
> > >   usually this is only used in assembly code to directly call a symbo=
l
> > >   and don't expect to return back; after reviewing kernel normal
> > >   functions and user space programs, both of them are very seldom to =
use
> > >   immediate branch for function call.  On the other hand, if we want =
to
> > >   decide the immediate branch is for function branch jumping or for
> > >   function calling, we need to rely on the start address of next pack=
et
> > >   and check the symbol offset for the start address,  this will
> > >   introduce much complexity in the implementation.  So for this versi=
on
> > >   we simply consider immediate branch as function internal branch.
> > >   Moreover, we rely on 'elem->last_instr_cond' to decide if the branc=
h
> > >   instruction is a conditional branch or not.
> > >
> > >   If the instruction is immediate branch with link, it's instruction
> > >   'BL' and which is used for function call.
> > >
> > >   If the instruction is indirect branch and with subtype
> > >   OCSD_S_INSTR_V7_IMPLIED_RET, the decoders gives the hint the functi=
on
> > >   return for below cases related with A32/T32 instruction; set this
> > >   branch flag as function return (Thanks for Al's suggestion).
> > >
> > >     BX R14
> > >     MOV PC, LR
> > >     POP {=E2=80=A6, PC}
> > >     LDR PC, [SP], #offset
> > >
> > >   If the instruction is indirect branch without link, this is
> > >   corresponding to instruction 'BR', this instruction usually is used
> > >   for dynamic link lib with below usage; so we think it's a return
> > >   instruction.
> > >
> > >     0000000000000680 <.plt>:
> > >      680:   a9bf7bf0        stp     x16, x30, [sp, #-16]!
> > >      684:   90000090        adrp    x16, 10000 <__FRAME_END__+0xf630>
> > >      688:   f947fe11        ldr     x17, [x16, #4088]
> > >      68c:   913fe210        add     x16, x16, #0xff8
> > >      690:   d61f0220        br      x17
> > >
> > >   If the instruction is indirect branch with link, e.g BLR, we think
> > >   it's a function call.
> > >
> > >   For function return, ARMv8 introduces a dedicated instruction 'ret'=
,
> > >   which has flag of OCSD_S_INSTR_V8_RET.
> > >
> > > - For exception packets, this patch divides into three types:
> > >
> > >   The first type of exception is caused by external logics like bus,
> > >   interrupt controller, debug module or PE reset or halt; this is
> > >   corresponding to flags "bcyi" which defined in doc perf-script.txt;
> > >
> > >   The second type is for system call, this is set as "bcs" by followi=
ng
> > >   definition in the doc;
> > >
> > >   The third type is for CPU trap, data and instruction prefetch abort=
,
> > >   alignment abort; usually these exceptions are synchronous for CPU, =
so
> > >   set them as "bci" type.
> >
> > This is too long and needs to be broken down into pieces.  I would spli=
t this
> > patch in 3 heat, one for NO_SYNC and TRACE_ON, one for INSTR_RANGE and =
one for
> > ELEM_EXCEPTION/ELEM_EXCEPTION_RET.
>
> This makes sense, will split to 3 patches.
>
> > >
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Robert Walker <robert.walker@arm.com>
> > > Cc: Al Grant <Al.Grant@arm.com>
> > > Cc: Andi Kleen <andi@firstfloor.org>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 168 ++++++++++++++=
++++++++++
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   1 +
> > >  2 files changed, 169 insertions(+)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/=
perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index d1a6cbc..0e50c52 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -303,6 +303,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decod=
er *decoder,
> > >     decoder->packet_buffer[et].instr_count =3D 0;
> > >     decoder->packet_buffer[et].last_instr_taken_branch =3D false;
> > >     decoder->packet_buffer[et].last_instr_size =3D 0;
> > > +   decoder->packet_buffer[et].flags =3D 0;
> >
> > Since PERF_IP_FLAG_BRANCH is '0', I would set this to UNINT32_MAX.
>
> PERF_IP_FLAG_BRANCH is bit 0 is set (so it's 1) but not 0.  If
> initialize value to UNINT32_MAX (0xFFFF,FFFF) that means all flags has
> been set and this will introduce confusion.  So will keep to init
> flags to 0.

I just looked at this again - you are correct.

>
> > >
> > >     if (decoder->packet_count =3D=3D MAX_BUFFER - 1)
> > >             return OCSD_RESP_WAIT;
> > > @@ -437,6 +438,171 @@ cs_etm_decoder__buffer_exception_ret(struct cs_=
etm_decoder *decoder,
> > >                                          CS_ETM_EXCEPTION_RET);
> > >  }
> > >
> > > +static void cs_etm_decoder__set_sample_flags(
> > > +                           const void *context,
> > > +                           const ocsd_generic_trace_elem *elem)
> > > +{
> > > +   struct cs_etm_decoder *decoder =3D (struct cs_etm_decoder *) cont=
ext;
> > > +   struct cs_etm_packet *packet;
> > > +   u32 exc_num;
> > > +
> > > +   packet =3D &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   switch (elem->elem_type) {
> > > +   case OCSD_GEN_TRC_ELEM_TRACE_ON:
> > > +           packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                           PERF_IP_FLAG_TRACE_BEGIN;
> > > +           break;
> > > +
> > > +   case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > > +   case OCSD_GEN_TRC_ELEM_EO_TRACE:
> > > +           packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                           PERF_IP_FLAG_TRACE_END;
> > > +           break;
> > > +
> > > +   case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
> > > +           /*
> > > +            * Immediate branch instruction without neither link nor
> > > +            * return flag, it's normal branch instruction within
> > > +            * the function.
> > > +            */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_NONE) {
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH;
> > > +
> > > +                   if (elem->last_instr_cond)
> > > +                           packet->flags |=3D PERF_IP_FLAG_CONDITION=
AL;
> > > +           }
> > > +
> > > +           /*
> > > +            * Immediate branch instruction with link (e.g. BL), this=
 is
> > > +            * branch instruction for function call.
> > > +            */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_BR_LINK)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_CALL;
> > > +
> > > +           /*
> > > +            * Indirect branch instruction with subtype of
> > > +            * OCSD_S_INSTR_V7_IMPLIED_RET, this is explicit hint for
> > > +            * function return for A32/T32.
> > > +            */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR_INDIRECT &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_V7_IMPLIED_R=
ET)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_RETURN;
> > > +
> > > +           /*
> > > +            * Indirect branch instruction without link (e.g. BR), us=
ually
> > > +            * this is used for function return, especially for funct=
ions
> > > +            * within dynamic link lib.
> > > +            */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR_INDIRECT &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_NONE)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_RETURN;
> > > +
> > > +           /*
> > > +            * Indirect branch instruction with link (e.g. BLR), this=
 is
> > > +            * branch instruction for function call.
> > > +            */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR_INDIRECT &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_BR_LINK)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_CALL;
> > > +
> > > +           /* Return instruction for function return. */
> > > +           if (elem->last_i_type =3D=3D OCSD_INSTR_BR_INDIRECT &&
> > > +               elem->last_i_subtype =3D=3D OCSD_S_INSTR_V8_RET)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_RETURN;
> >
> > I would swap the last to if() condition so that the (BRANCH | RETURN) f=
lags
> > are all at the same place.
>
> Will follow this in new patch.
>
> > > +
> > > +           break;
> > > +
> > > +   case OCSD_GEN_TRC_ELEM_EXCEPTION:
> > > +
> > > +#define OCSD_EXC_RESET                     0
> > > +#define OCSD_EXC_DEBUG_HALT                1
> > > +#define OCSD_EXC_CALL                      2
> > > +#define OCSD_EXC_TRAP                      3
> > > +#define OCSD_EXC_SYSTEM_ERROR              4
> > > +#define OCSD_EXC_INST_DEBUG                6
> > > +#define OCSD_EXC_DATA_DEBUG                7
> > > +#define OCSD_EXC_ALIGNMENT         10
> > > +#define OCSD_EXC_INST_FAULT                11
> > > +#define OCSD_EXC_DATA_FAULT                12
> > > +#define OCSD_EXC_IRQ                       14
> > > +#define OCSD_EXC_FIQ                       15
> >
> > Where did you get the above?  To me this is something that should come =
from the
> > library.
>
> The concept is coming from OpenCSD lib but OpenCSD doesn't define
> macros for them.
>
> Will polish this and add these macros into OpenCSD header file.
>
> > > +
> > > +           exc_num =3D decoder->exc_num[packet->cpu];
> > > +
> > > +           /*
> > > +            * The exceptions are triggered by external signals
> > > +            * from bus, interrupt controller, debug module,
> > > +            * PE reset or halt.
> > > +            */
> > > +           if (exc_num =3D=3D OCSD_EXC_RESET ||
> > > +               exc_num =3D=3D OCSD_EXC_DEBUG_HALT ||
> > > +               exc_num =3D=3D OCSD_EXC_SYSTEM_ERROR ||
> > > +               exc_num =3D=3D OCSD_EXC_INST_DEBUG ||
> > > +               exc_num =3D=3D OCSD_EXC_DATA_DEBUG ||
> > > +               exc_num =3D=3D OCSD_EXC_IRQ ||
> > > +               exc_num =3D=3D OCSD_EXC_FIQ)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_CALL |
> > > +                                   PERF_IP_FLAG_ASYNC |
> > > +                                   PERF_IP_FLAG_INTERRUPT;
> > > +
> > > +           /* The exception is for system call. */
> > > +           if (exc_num =3D=3D OCSD_EXC_CALL)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_CALL |
> > > +                                   PERF_IP_FLAG_SYSCALLRET;
> > > +
> > > +           /*
> > > +            * The exception is introduced by trap, instruction &
> > > +            * data fault or alignment errors.
> > > +            */
> > > +           if (exc_num =3D=3D OCSD_EXC_TRAP ||
> > > +               exc_num =3D=3D OCSD_EXC_ALIGNMENT ||
> > > +               exc_num =3D=3D OCSD_EXC_INST_FAULT ||
> > > +               exc_num =3D=3D OCSD_EXC_DATA_FAULT)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_CALL |
> > > +                                   PERF_IP_FLAG_INTERRUPT;
> > > +
> > > +           break;
> > > +
> > > +   case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> > > +
> > > +           exc_num =3D decoder->exc_num[packet->cpu];
> > > +
> > > +           if (exc_num =3D=3D OCSD_EXC_CALL)
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_RETURN |
> > > +                                   PERF_IP_FLAG_SYSCALLRET;
> > > +           else
> > > +                   packet->flags =3D PERF_IP_FLAG_BRANCH |
> > > +                                   PERF_IP_FLAG_RETURN |
> > > +                                   PERF_IP_FLAG_INTERRUPT;
> > > +
> > > +           break;
> > > +
> > > +   case OCSD_GEN_TRC_ELEM_UNKNOWN:
> > > +   case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> > > +   case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> > > +   case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> > > +   case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> > > +   case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
> > > +   case OCSD_GEN_TRC_ELEM_EVENT:
> > > +   case OCSD_GEN_TRC_ELEM_SWTRACE:
> > > +   case OCSD_GEN_TRC_ELEM_CUSTOM:
> > > +   default:
> > > +           break;
> > > +   }
> > > +}
> > > +
> > >  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > >                             const void *context,
> > >                             const ocsd_trc_index_t indx __maybe_unuse=
d,
> > > @@ -484,6 +650,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_t=
race_elem_printer(
> > >             break;
> > >     }
> > >
> > > +   cs_etm_decoder__set_sample_flags(context, elem);
> > > +
> >
> > I was toying with the idea of setting the flags in each of the case sta=
tement
> > found in cs_etm_decoder__gen_trace_elem_printer().  But that would move=
 more
> > code around and the end result would be the same so let's keep it that =
way until
> > we have a good reason to split it.
>
> Do you sugguest to keep current implementation rather than to
> split flags setting in each of the case statement in
> cs_etm_decoder__gen_trace_elem_printer()?
>
> I am not 100% sure if I understand correctly for "split it" (split flags
> setting vs split functions).  So please correct me if I misunderstand
> this.

I find function cs_etm_decoder__set_sample_flags() overly long.  Since
the case statements in it are the same as the ones in
cs_etm_decoder__gen_trace_elem_printer() a different way to proceed
would be to do flag setting there rather than all in
cs_etm_decoder__set_sample_flags().  But that would introduce more
code modification and tighter coupling.  Since I don't have another
alternative I am suggesting to keep the current implementation.

>
> Thanks,
> Leo Yan
>
> > >     return resp;
> > >  }
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/=
perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > index 0d1c18d..71df908 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > > @@ -47,6 +47,7 @@ struct cs_etm_packet {
> > >     u8 last_instr_taken_branch;
> > >     u8 last_instr_size;
> > >     int cpu;
> > > +   u32 flags;
> > >  };
> > >
> > >  struct cs_etm_queue;
> > > --
> > > 2.7.4
> > >
