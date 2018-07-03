Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38997C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D6F23C52
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsiMmCFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D6F23C52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934428AbeGCRhc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:37:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43620 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:37:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so2181882eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP8/xTgL11XDVvfG4Dhhw+f+2sOdDVOfQpS1fzBUPCs=;
        b=XsiMmCFaF56SVIWgec8nqGnvms+/BAeFYt0YjPJOZoZi6VdsOLRnBSt+aK0u2Zb5uh
         ReVs9YdpcLRA5vD0EVoGaJYJneKL6y6c4j2TwrVD1Hhp0L2wPrZ3br5fES7+1xuvStNT
         UPbiklt/Jq3ZOi6Dcu8+vMJEJC653IqgKEtnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP8/xTgL11XDVvfG4Dhhw+f+2sOdDVOfQpS1fzBUPCs=;
        b=cYXIUvTJuGFOqlxTf2d33TVOBGx0Xt6F/6shcqQdIdnndev4MS52FHhSwURSq2s6Y4
         33Ev0yuNwYM4KtEKj9qAviEVrrRpXD5jkqQnPNOPX1Qw4TkewNwh07vuOiIJlLy+nGdI
         ZsmBT8zF2K7Y0fLKuc0FI0GWqy7EWLvM6UEdMov6toWF8PlUNckfwqTKE/PmAucp6wqm
         6MGgUNcvZZNuM3zA+X7qK0sfz3N7xQ2iNs4Ha9Gue0RzAtEu7bBOFOrlY/Vu5pK1hVuU
         dKE8IyCXUMu2tx1+l5PW4BITWZCeJtjFT6Amv6gUHH5aJSLbpeqjHWhqDHxuyJxh0Zl4
         +lAA==
X-Gm-Message-State: APt69E3B4vB0+sU/U6X6YUJBCdDNiPtfbRWBlFvng1kjEAQM9cDGGIsD
        keRYA6ULe2Mk8VTGCpZ4wkhfvpdrpmWzlkEnDEyjVw==
X-Google-Smtp-Source: AAOMgpfZBprE5Pu/kzVvcs4uCt/KB0q5xVoWMXqPM2M6GA3rz+xg0RF6IkO6VruC4YlGmA4W1qlNtkW524HhotdIDaE=
X-Received: by 2002:a50:8a23:: with SMTP id i32-v6mr23998448edi.49.1530639448634;
 Tue, 03 Jul 2018 10:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org> <20180703073142.GA4581@linux.ibm.com>
In-Reply-To: <20180703073142.GA4581@linux.ibm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 3 Jul 2018 11:37:17 -0600
Message-ID: <CANLsYkxHws7JRCU9EfGsK3wQxugP5w8aVTTja=fBRn1=TqETMA@mail.gmail.com>
Subject: Re: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
To:     brueckner@linux.ibm.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 at 01:31, Hendrik Brueckner <brueckner@linux.ibm.com> wrote:
>
> On Mon, Jul 02, 2018 at 04:33:28PM -0600, Mathieu Poirier wrote:
> > It can be advantagous to have access to all the information conveyed by
> > a perf_event when setting up the AUX buffer, as it is the case when
> > dealing with PMU specific driver configuration communicated to the kernel
> > using an ioctl() call.
> >
> > As such simply replace the cpu information by the complete perf_event
> > structure and change all affected customers.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  arch/s390/kernel/perf_cpum_sf.c                  | 4 ++--
> >  arch/x86/events/intel/bts.c                      | 4 +++-
> >  arch/x86/events/intel/pt.c                       | 5 +++--
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 6 +++---
> >  drivers/perf/arm_spe_pmu.c                       | 6 +++---
> >  include/linux/perf_event.h                       | 2 +-
> >  kernel/events/ring_buffer.c                      | 2 +-
> >  7 files changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
> > index 0292d68e7dde..e06daaa08894 100644
> > --- a/arch/s390/kernel/perf_cpum_sf.c
> > +++ b/arch/s390/kernel/perf_cpum_sf.c
> > @@ -1601,8 +1601,8 @@ static void aux_buffer_free(void *data)
> >   *
> >   * Return the private AUX buffer structure if success or NULL if fails.
> >   */
> > -static void *aux_buffer_setup(int cpu, void **pages, int nr_pages,
> > -                           bool snapshot)
> > +static void *aux_buffer_setup(struct perf_event *event, void **pages,
> > +                           int nr_pages, bool snapshot);
>
> Please remove the trailing semi-colon (;) in the function definition causing
> the kbuild error.  Also, it would be great if you also could update the
> function comment and replace the @cpu by the @event.

Had I realised it was just as easy to compile for s390 as it is for
ARM64, I would have done so ahead of time.  Well done on that front.
All fixed now.

Thanks,
Mathieu

>
> Many thanks.
>
