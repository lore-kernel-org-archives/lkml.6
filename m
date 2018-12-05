Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D06BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93EF2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4Xf3TEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93EF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbeLESDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:03:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42565 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:03:41 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so17400957ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWfZeS78Vkx1R058+bEflsF9sIFx63RBTJ9viV3bmPE=;
        b=Z4Xf3TEtbIW8eDV74nk3AVE9E2eifE6bl+pryztTQP0WSgwDE03Tr0qL7Nw26GMdK5
         wnYoMK2C0wKQDAw2qgBTxzAVOhf88t7+b2yDPV+giitUZOGMxNjvW8D/oNpS5FBwkcRs
         3wxlB5ZzOa/4arCbELlFiNOEvheEPgFF7oZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWfZeS78Vkx1R058+bEflsF9sIFx63RBTJ9viV3bmPE=;
        b=UhT+EsC7zGMhmaIqOsKdxFyy+GJDGNhcHD73D5lCuYKuqhF7JipQIkjJMetw9iTi5d
         s6raDN+hZlaNR5wOKIxCue2T9mgC7GZYvQtsNguukHvRDaHGJe6UUHGVGQY3O0VnuS4j
         7S32W/wIuxv2XVvNo7YDOPtNtZG20MjKXfjhHzJCg1FO493iFoj+xPUqCATRJGRD98u8
         95L2NVqkA+HWOSA5tZxZtZR6Ms7JgfE+IiYv4nWU0Gw+rN6PWXp+ll7ipF3FV172SajC
         qUVGXZU6t/OnS/3Rb11KvyTRlhSNvhIm5OBQ2IA41dcZiv+COyXUwhY1EiF2dxNyiUob
         3C+g==
X-Gm-Message-State: AA+aEWa/7YqUMZ9uyza6rW+CwVUMW3RwGlx2dDoGS0S7qN8HBMta9klO
        Z6fIyZBVmlVtBmElOla3TCdLSP1BVTCr75Ss7ypMBDOg
X-Google-Smtp-Source: AFSGD/VVxVoA1iYAS8DUaYuslDs6TjP6ByhgvFeUC4srpHiYDFijWu069qopJoAOtLOsCSwRayVVcMcwZUvOClQAMMg=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr19582901iom.11.1544033020093;
 Wed, 05 Dec 2018 10:03:40 -0800 (PST)
MIME-Version: 1.0
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org> <20181119204749.GB608@xps15>
 <20181205034950.GB15964@leoy-ThinkPad-X240s>
In-Reply-To: <20181205034950.GB15964@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 5 Dec 2018 11:03:29 -0700
Message-ID: <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
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

On Tue, 4 Dec 2018 at 20:49, <leo.yan@linaro.org> wrote:
>
> On Mon, Nov 19, 2018 at 01:47:49PM -0700, Mathieu Poirier wrote:
> > On Sun, Nov 11, 2018 at 12:59:43PM +0800, Leo Yan wrote:
> > > When an exception packet comes, it contains the info for exception
> > > number; the exception number indicates the exception types, so from it
> > > we can know if the exception is taken for interrupt, system call or
> > > other traps, etc.  But because the exception return packet cannot
> > > delivery exception number correctly by decoder thus when prepare sample
> > > flags we cannot know what's type for exception return.
> > >
> > > This patch adds a new 'exc_num' array in decoder structure to record
> > > exception number per CPU, the exception number is recorded in the array
> > > when the exception packet comes and this exception number can be used by
> > > exception return packet.  If detect there have discontinuous trace with
> > > TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
> > > value.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
> > >  1 file changed, 59 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index b8cb7a3e..d1a6cbc 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -43,6 +43,7 @@ struct cs_etm_decoder {
> > >     u32 packet_count;
> > >     u32 head;
> > >     u32 tail;
> > > +   u32 *exc_num;
> > >     struct cs_etm_packet packet_buffer[MAX_BUFFER];
> > >  };
> > >
> > > @@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> > >                              const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_TRACE_OFF);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_TRACE_OFF);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /* Clear execption number for discontinuous trace */
> > > +   decoder->exc_num[packet->cpu] = UINT32_MAX;
> > > +
> > > +   return ret;
> > >  }
> > >
> > >  static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> > >                             const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_TRACE_ON);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_TRACE_ON);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /* Clear execption number for discontinuous trace */
> > > +   decoder->exc_num[packet->cpu] = UINT32_MAX;
> > > +
> > > +   return ret;
> > >  }
> > >
> > >  static ocsd_datapath_resp_t
> > >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > > +                            const ocsd_generic_trace_elem *elem,
> > >                              const uint8_t trace_chan_id)
> > >  {
> > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > -                                        CS_ETM_EXCEPTION);
> > > +   int ret;
> > > +   struct cs_etm_packet *packet;
> > > +
> > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > +                                       CS_ETM_EXCEPTION);
> > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > +           return ret;
> > > +
> > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > +
> > > +   /*
> > > +    * Exception number is recorded per CPU and later can be used
> > > +    * for exception return instruction analysis.
> > > +    */
> > > +   decoder->exc_num[packet->cpu] = elem->exception_number;
> >
> > Am I missing something or the information about the exception number that is
> > recorded here isn't used anywhere?
>
> The exception number will be used to set branch flag patch [1].

Right, I realised that when I started reviewing that set.  The rule of
thumb here is to introduce code in the same patchset it is used so
that we avoid adding needless code to the kernel.

> According to exception number we can know it's for system call,
> interrupt or other traps.
>
> [1] http://archive.armlinux.org.uk/lurker/message/20181111.050755.d1c1b257.en.html
>
> > If you want to use this in perf report/script,
> > the exception number will have to be added to the cs_etm_packet struct.
>
> Actually before has discussed this with Mike but found it's hard to
> save the exception number in cs_etm_packet struct.  The reason is the
> exception packet contains the correct exception number, but the
> exception return packet doesn't contain exception number.  Thus this
> patch uses cs_etm_decoder struct to save exception number per CPU
> context when receive exception packet, and later the saved exception
> number will be used by exception return packet.
>
> Please see related discussion at the end of page [2].

I find Mike's point about the possibility of seeing exception returns
without having a prior exception due to various factors very
interesting.  I will make sure to keep an eye out for that in the next
revision.

>
> [2] https://lists.linaro.org/pipermail/coresight/2018-October/001832.html
>
> > I am done with the revision of this set.
>
> Thanks a lot for reviewing.
>
> [...]
>
> Thanks,
> Leo Yan
