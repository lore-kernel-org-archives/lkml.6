Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B83C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E12145D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJo8NH/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186E12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeKUDYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:24:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34017 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUDYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:24:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so2273101ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeYMHxCjbMx9R8QtfZbmS0dyzPtgVYLrnclfmbjlYZo=;
        b=fJo8NH/rh9KcFSlBJX3AIK6+qiiupNxQtGCZtbKqGBS/oladQuhBeZJsj42D1kTkMZ
         wgx8FVQT6xDS1NakEiHiWoMzSxfOvxlmbaHXUCeffKiJ32KWuCzA079DVkQBDvrBk0As
         D/rzccdTAGM683Hz4tY2LCe3FuRuRd61N5rIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeYMHxCjbMx9R8QtfZbmS0dyzPtgVYLrnclfmbjlYZo=;
        b=mlQcXR5oVZV++IjaA+cX2PWzdiI0kK1N7jrL6oUAvp9fMpFEwlN3z129j+wH3l9VrC
         CDc+DloILumRE1Euh4JVXXVxRwZclQGhjGuZm5J+Bpr35QmSQP3yF8tOOZm9sIyc3qJV
         z5eFf1mZkzEXr39AeaxqMgQIVZz0iy+uEHB4tPyAVfa2DTmDGrZqhrXR0e351sFR4c5b
         x/Bdn6DKR/dNaSlQwdrsAjt1OV46ogdMWlHo0Y9vyWUcGurIEwkCXA3NcH5EZcfrK9/E
         TM9btPzTA+aThn/henzBBhkD4ZxrZOFHKFcM+BORfgS5IPj0i1kst+FskwUdAKsdrHf2
         DSbw==
X-Gm-Message-State: AGRZ1gJFJxAps9armk/jEOOety+sKxd9udbMxFs6QtD70EDVJd3MV4Mw
        ukb6kacU9Q+G63zVDvZd0ncQoQkH2yeJA0rrTespYA==
X-Google-Smtp-Source: AFSGD/Xh8GV5Pl02RaToYaq2kgHPekjLVC1GXIWtooesaRk62WieqS1BNarF6nAnfTEL7/7fxjrENJpV/I8Hxwk6j/k=
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr1655174ljt.159.1542732832942;
 Tue, 20 Nov 2018 08:53:52 -0800 (PST)
MIME-Version: 1.0
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-3-git-send-email-leo.yan@linaro.org> <20181119232202.GA7001@xps15>
In-Reply-To: <20181119232202.GA7001@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 20 Nov 2018 09:53:41 -0700
Message-ID: <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf cs-etm: Add support sample flags
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
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 at 16:22, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Sun, Nov 11, 2018 at 01:07:56PM +0800, Leo Yan wrote:
> > We have prepared the flags in the packet structure, so need to copy
> > the related value into sample structure thus perf tool can facilitate
> > sample flags.
> >
> > The PREV_PACKET contains the branch instruction flags and PACKET
> > actually contains the flags for next branch instruction.  So this patch
> > is to set sample flags with 'etmq->prev_packet->flags'.
> >
> > This patch includes three fixing up for sample flags based on the
> > packets context:
> >
> > - If the packet is exception packet or exception return packet, update
> >   the previous packet for exception specific flags;
> > - If there has TRACE_ON or TRACE_OFF packet in the middle of instruction
> >   packets, this indicates the trace is discontinuous, so append the flag
> >   PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
> >   has been ended;
> > - If one instruction packet is behind TRACE_OFF packet, this instruction
> >   is restarting trace packet.  So set flag PERF_IP_FLAG_TRACE_START to
> >   TRACE_OFF packet if one, this flag isn't used by TRACE_OFF packet but
> >   used to indicate trace restarting when generate sample.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 455f132..afca6f3 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -676,7 +676,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >       sample.stream_id = etmq->etm->instructions_id;
> >       sample.period = period;
> >       sample.cpu = etmq->packet->cpu;
> > -     sample.flags = 0;
> > +     sample.flags = etmq->prev_packet->flags;
> >       sample.insn_len = 1;
> >       sample.cpumode = event->sample.header.misc;
> >
> > @@ -735,7 +735,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
> >       sample.stream_id = etmq->etm->branches_id;
> >       sample.period = 1;
> >       sample.cpu = etmq->packet->cpu;
> > -     sample.flags = 0;
> > +     sample.flags = etmq->prev_packet->flags;
> >       sample.cpumode = event->sample.header.misc;
> >
> >       /*
> > @@ -878,6 +878,43 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
> >       return 0;
> >  }
> >
> > +static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
> > +{
> > +     /*
> > +      * Decoding stream might insert one TRACE_OFF packet in the
> > +      * middle of instruction packets, this means it doesn't
> > +      * contain the pair packets with TRACE_OFF and TRACE_ON.
> > +      * For this case, the instruction packet follows with
> > +      * TRACE_OFF packet so we need to fixup prev_packet with flag
> > +      * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
> > +      * instruction packet to generate samples.
> > +      */
> > +     if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
> > +         etmq->packet->sample_type == CS_ETM_RANGE)
> > +             etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +                                        PERF_IP_FLAG_TRACE_BEGIN;
> > +
> > +     if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> > +             /*
> > +              * When the exception packet is inserted, update flags
> > +              * so tell perf it is exception related branches.
> > +              */
> > +             if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
> > +                 etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
> > +                     etmq->prev_packet->flags = etmq->packet->flags;
> > +
> > +             /*
> > +              * The trace is discontinuous, weather this is caused by
> > +              * TRACE_ON packet or TRACE_OFF packet is coming, if the
> > +              * previous packet is instruction packet, simply set flag
> > +              * PERF_IP_FLAG_TRACE_END for previous packet.
> > +              */
> > +             if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
> > +                 etmq->packet->sample_type == CS_ETM_TRACE_OFF)
> > +                     etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
> > +     }
> > +}
> > +
>
> I think it would be better to keep all the flag related processing in
> cs-etm-decoder.c so that things in cs-etm.c are only concered with dealing with
> perf.
>
> Look at function cs_etm__alloc_queue(), there you'll find "d_params.data = etmq".
>
> In function cs_etm_decoder__new(), decoder->data = d_params->data;
>
> This means that anywhere you have a decoder, decoder->data is an etmq.  I've
> used this profusely in my work on CPU-wide trace scenarios.  Because you're
> getting there ahead of me you'll need to fix the declaration of struct
> cs_etm_queue but that's easy.

I've been thinking further about this and manipulating the etmq packet
and prev_packet from the cs-etm-decoder.c won't work because all we
have at that time is the decoder's packet queue.  My goal is to
manipulate the flags in only one place - either in cs-etm.c or
cs-etm-decoder.c but not in both.  It might be worth trying to do the
implementation in cs-etm.c since there is already a lot of packet flow
intelligence happening there.

>
> Regards,
> Mathieu
>
> >  static int cs_etm__sample(struct cs_etm_queue *etmq)
> >  {
> >       struct cs_etm_auxtrace *etm = etmq->etm;
> > @@ -1100,6 +1137,8 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >                                        */
> >                                       break;
> >
> > +                             cs_etm__fixup_flags(etmq);
> > +
> >                               switch (etmq->packet->sample_type) {
> >                               case CS_ETM_RANGE:
> >                                       /*
> > --
> > 2.7.4
> >
