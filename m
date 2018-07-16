Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E69ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAC520877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhC0yavg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAC520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGPPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:33:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43870 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeGPPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:33:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so4687554edt.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBmkILqKihgkRZVX3+qLNdQ1ZzqWv0eU3DJ/7Ud1jAI=;
        b=bhC0yavgO7Wqu2SQ1V6wUqicoZPdIYMHCOs2lVRhkXEbkKxqryT7lmO5cX7XL9rJ9h
         N0kvTYUkKeke7UyLwsu5rWU7xeKOPHxfw1Kas+HTnIZ4XKulkqTAbcxJHA+3A3OJrS6t
         WQ8v1dkTPwpqvFpYOwVzf4C05f+vA+HLGXjWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBmkILqKihgkRZVX3+qLNdQ1ZzqWv0eU3DJ/7Ud1jAI=;
        b=kaaAk2/vNh5GNA1oTFM56RHDac8hJkVuHFua6onHczZufR3p2qvlHiX/OCX0nD+pwg
         lB79mlmKugN1qDvUOQYCNY2k8sp3C4+3TqUadlDKZLYsQEha4rGVYKh4j8INHFoNF7BM
         v5BGw/HoDOJheDNXecNqfQ7yTTLtUnTosrvPXBsTlVySl32DxfvHy+lbO+lAag6sKQDP
         gHbfBg8ezDIqruUzmS1RHoYWX5R6+2/qMFFGlV6eKwykZG6agax+Z/pICH180ddQrAq5
         nKHl4vOLis1Yfyrsz8dWgk3UA/N9XU06RLmKAhzFUzuPTFfs5HNksrMji3MBE+rlmOjX
         DK4g==
X-Gm-Message-State: AOUpUlH3QlrxmLIlELgNEualNf9/eVPqJLXcdrC5qhyWObwZ+i5JLO7O
        eAO3/of6/nV3s+3qBiAUdDiqrUUsxYhK5VX2c1t0mQ==
X-Google-Smtp-Source: AAOMgpe9tTbmZkn2Ksalnm/735OFqHbiig/UgC0rx/wS/i0b3TZpdWWY4DY7C3+MuckQoM7MwYK+1qbVKQx3TqjbXEc=
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr17186927edd.195.1531753554294;
 Mon, 16 Jul 2018 08:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
 <1531318599-8840-7-git-send-email-suzuki.poulose@arm.com> <20180712205740.GA22128@xps15>
 <cf11b93e-6e57-7309-5364-6c1d00ff8381@arm.com>
In-Reply-To: <cf11b93e-6e57-7309-5364-6c1d00ff8381@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 16 Jul 2018 09:05:43 -0600
Message-ID: <CANLsYkzMoU=9JibeuK6dUrK+umxPEuFaYyEStY5h2p=V5ujBUA@mail.gmail.com>
Subject: Re: [PATCH 6/6] coresight: etm-perf: Add support for ETR backend
To:     "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org, Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 at 05:23, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> On 12/07/18 21:57, Mathieu Poirier wrote:
> > Hi Suzuki,
> >
> > On Wed, Jul 11, 2018 at 03:16:39PM +0100, Suzuki K Poulose wrote:
> >> Add support for using TMC-ETR as backend for ETM perf tracing.
> >> We use software double buffering at the moment. i.e, the TMC-ETR
> >> uses a separate buffer than the perf ring buffer. The data is
> >> copied to the perf ring buffer once a session completes.
> >>
> >> The TMC-ETR would try to match the larger of perf ring buffer
> >> or the ETR buffer size configured via sysfs, scaling down to
> >> a minimum limit of 1MB.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 265 +++++++++++++++++++++++-
> >>   drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
> >>   2 files changed, 265 insertions(+), 2 deletions(-)
>
> >> +/*
> >> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
> >> + * buffer to the perf ring buffer.
> >> + */
> >> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> >> +{
> >> +    long bytes, to_copy;
> >> +    long pg_idx, pg_offset, src_offset;
> >> +    unsigned long head = etr_perf->head;
> >> +    char **dst_pages, *src_buf;
> >> +    struct etr_buf *etr_buf = etr_perf->etr_buf;
> >> +
> >> +    head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> >
> > I'm puzzled here.  Since etr_perf->head is set in tmc_etr_set_perf_buffer() to
> > the value of handle->head, its value is always within the range of the perf ring
>
> IIUC, the handle->head is not necessarily guaranteed to be within the aux-ring buffer.

I just looked at the ETB code and you are correct.

>
> > buffer.  In tmc_etr_alloc_perf_buffer() etr_perf->nr_pages is set to the number
> > of pages present in that ring buffer.  As such I'm not sure as to why we need
> > the PERF_IDX2OFF() macro.
> >
> > It seems to me that "head = etr_perf->head;" above is sufficient.
> >
>
> We need to do the step at some point, which could be moved to set_perf_buffer.

That's a good idea.

>
> >> +    pg_idx = head >> PAGE_SHIFT;
> >> +    pg_offset = head & (PAGE_SIZE - 1);
> >> +    dst_pages = (char **)etr_perf->pages;
> >> +    src_offset = etr_buf->offset;
> >> +    to_copy = etr_buf->len;
> >> +
> >> +    while (to_copy > 0) {
> >> +            /*
> >> +             * We can copy minimum of :
> >
> > s/We can copy minimum of :/In one iteration we can copy a minimum of:/
> >
> > If I'm wrong about the PERF_IDX2OFF(), don't bother respinning just for that.
>
> I have some more fixes for handling the different modes (sysfs vs perf),
> which I can include in the v2.

Very well.

>
> Suzuki
