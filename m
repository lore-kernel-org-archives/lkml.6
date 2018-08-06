Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63A621A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZCGzIRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63A621A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeHFTEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:04:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45471 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeHFTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:04:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so5468077edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6iKJZglGLZy1TWZrd/z+ousXVNyME8BD08KVni2WwM=;
        b=vZCGzIRnLZAmOUzECEXCnojV9MNxnP+LufoMoVAwwoHOu8liSIrMht5v96JVNaZbkG
         v7jyZ7BoD8PpUMEnASfZfjXeWjzwXtDUHFFCtDa6hNGXm04+Wf0AxqjNJnlN2ZYrnwBu
         46tzkdTNt9wDYUT6JB6H8+VGw+WcffJ5HJbKyJdg+/fV8/X04q+DJJ24a2MVGX6La0BO
         79mhV2QL4yP8MTXTodzi49Ovo+mIW+sTHIy/SBuu5/m00dCejByYaT7d+rK/VG5+gN5Q
         AeLYSTj+HCkg3ISBD4BOqhzfPp9oToSfCyoVoEiXGis/HeWvjAQySzMsFtFL/DrTrZ+h
         E64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6iKJZglGLZy1TWZrd/z+ousXVNyME8BD08KVni2WwM=;
        b=hCkqDmYWlntByveUKe9UNd/wgk95jGm3aZRslRM0gaxRbLT12Odf0dfzNLS39sf/Ge
         SksLJE9IM99vET3ubWXpMsnJzLdLYsOgQiC1lXJO5lt6EcbzIxE+I5JVTQeLfuzdYyjJ
         EKZU7DSiFHuz7/VE14iGTqVDfwgjv4dO2StgjX9czBmVB8N6SM5QoWB5vHxdKBoKtE1R
         19bOn+hmGsk4ySsDfGME0AZ+9127F3h3/bw8/cgC8TZlQrFsO8laa7x7TFtk02N+LR9q
         O0N0Bldjq+6E6KT3mm+k8ccOdJbX6CowMVn+rs7pZpGSwjrZLXaIdA9Ut/rz4ayHASMk
         Ko6Q==
X-Gm-Message-State: AOUpUlGk6/kuc0Zf5B7FtoBhZHpwi+I+1AhPCJfJBvORG2F3gn1Bo/gM
        MFaWGdA+OctkQvcHPynGmVPzSIB6e8MejC8kla9gYPsA
X-Google-Smtp-Source: AAOMgpeAGaN450E+qKO0XuH4q+C8BgjrY43XMikd0tHNWIBFb4CIaKdlnU57iyr3eSSEsWG95TWWiOwz3v1tcsTR62I=
X-Received: by 2002:a50:fe13:: with SMTP id f19-v6mr18746347edt.291.1533574474294;
 Mon, 06 Aug 2018 09:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble> <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net> <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180806154235.GO2494@hirez.programming.kicks-ass.net>
From:   Fubo Chen <fubo.chen@gmail.com>
Date:   Mon, 6 Aug 2018 09:54:23 -0700
Message-ID: <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)
To:     peterz@infradead.org
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 8:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 06, 2018 at 08:35:07AM -0700, Fubo Chen wrote:
> > On Thu, Jul 19, 2018 at 2:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> > >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> > >
> > >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > > +
> > > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1UL << 63,
> > >  };
> >
> > The above change makes sparse unhappy :-( Sparse reports the following
> > complaint about __PERF_SAMPLE_CALLCHAIN_EARLY:
>
> I thought I changed that to 1ULL before commit.

The sparse complaint was reported for code with the "1ULL << 63".

Thanks,

Fubo.
