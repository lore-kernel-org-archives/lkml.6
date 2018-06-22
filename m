Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386A243D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d22JOnl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E386A243D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933663AbeFVOin (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:38:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45915 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFVOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:38:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16-v6so1353411eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1BVUShw/c1CtFh+zpyKTXaY1cI6eAzry/m/a/DLYG4=;
        b=d22JOnl+U6/uuDpW7zf5M7Tti8MQuQ79pPu/wan4EbKCtySOcTOsbGCFliYY3Y3C6e
         qrM3MG5fjg8z41q1ctCEH4Vbv0CL/TUEZDwWUGs6G0cDyIm6F6oIDIW8msnBPg/tAxZi
         1fnHb2ipgMG7DglJNBdkLHuB4U4sgYl+mtGmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1BVUShw/c1CtFh+zpyKTXaY1cI6eAzry/m/a/DLYG4=;
        b=kvY0ZEwUu4TJTv1Ogc/Gi1UfloShcpurANUGAVWlwifBXYgMmkfkkM7DSrnW5P2sxy
         C/iFeIGjYB1R1Yc/zra7vlfUc+LSfsk8dbynvP497hRhf9U67ePhKs5Ca7u04ye6Jwyo
         SQlFx8MHonlqtTm0LRQ1sEqe6XE2uPqTRL7z1aQ65SZCT85SbGOuZx0HR2uHAZAaPKay
         WADv9vqjutpwufBv1sRXJk9wJdNI8BwozOZ3dHcKnj7ZboOGHRvicCOD+82ODgLzlpJG
         pQbbphUhLYeYvxWaVBYlVX1Xn+pvC5q3k8YijWpWKEHjMucY/LMhAsVlzbgMqq5pCEmg
         iuxg==
X-Gm-Message-State: APt69E1kOa1Sy1HGmTNBKHxk9o6LWtMICZ0OuxJaAQ4UlIuILCVWNS1o
        LkUAYan9T2MatoAkm/o3OGcnnNPqAVVTDcHon5rfdc+b
X-Google-Smtp-Source: ADUXVKIIVCYOMxPQZkxR5W6FTQp7/my9OWtk+QK748ciqyVoG3ArTzfzJ4fbba4wZty1IbcutrFIxE6aWMV2g5VcKBg=
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr2011634edd.293.1529678319627;
 Fri, 22 Jun 2018 07:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-6-git-send-email-suzuki.poulose@arm.com>
 <20180621171337.GA10307@xps15> <d5bbff9b-2730-f708-8a4e-f16241f6f5ce@arm.com>
In-Reply-To: <d5bbff9b-2730-f708-8a4e-f16241f6f5ce@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 22 Jun 2018 08:38:28 -0600
Message-ID: <CANLsYkw_kACzKatgarLDUnT910K2T70qeSeZBU8Brxai6k1Lhw@mail.gmail.com>
Subject: Re: [PATCH 5/6] coresight: catu: Add support for scatter gather tables
To:     "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 at 03:01, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 21/06/18 18:13, Mathieu Poirier wrote:
>
> >> +
> >> +/*
> >> + * catu_populate_table : Populate the given CATU table.
> >> + * The table is always populated as a circular table.
> >> + * i.e, the "prev" link of the "first" table points to the "last"
> >> + * table and the "next" link of the "last" table points to the
> >> + * "first" table. The buffer should be made linear by calling
> >> + * catu_set_table().
> >> + */
> >> +static void
> >> +catu_populate_table(struct tmc_sg_table *catu_table)
> >> +{
> >> +    int i, dpidx, s_dpidx;
> >> +    unsigned long offset, buf_size, last_offset;
> >> +    dma_addr_t data_daddr;
> >> +    dma_addr_t prev_taddr, next_taddr, cur_taddr;
> >> +    cate_t *table_ptr, *next_table;
> >> +
> >> +    buf_size = tmc_sg_table_buf_size(catu_table);
> >> +    dpidx = s_dpidx = 0;
> >
> >  From the reading the code below variable s_dpidx stands for "small" data page
> > index, which isn't obvious from the get go and could easily be mistaken for
> > "system" data page index.  Please add a comment to make your intentions clear.
>
> Sure, I will add comments. They are supposed to mean :
>
> dpidx => Data page index
> s_dpidx => Sub-page index within the System page.
>
> May be I can rename the variables to =>
>
> sys_pidx and catu_pidx

Perfect, this leaves no place for interpretation.

Thanks for being considerate.

>
>
> >
> >> +    offset = 0;
> >> +
> >> +    table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
> >> +    prev_taddr = 0; /* Prev link for the first table */
> >> +
> >> +    while (offset < buf_size) {
> >> +            /*
> >> +             * The @offset is always 1M aligned here and we have an
> >> +             * empty table @table_ptr to fill. Each table can address
> >> +             * upto 1MB data buffer. The last table may have fewer
> >> +             * entries if the buffer size is not aligned.
> >> +             */
> >> +            last_offset = (offset + SZ_1M) < buf_size ?
> >> +                          (offset + SZ_1M) : buf_size;
> >> +            for (i = 0; offset < last_offset;
> >> +                 i++, offset += CATU_PAGE_SIZE) {
> >
> > I really like the choice of "table_end" in function catu_dump_table().  I think
> > using the same denomination here would make it easier to understand the code.
> >
> > I wouldn't bother with such details if you weren't respinning this set.  But now
> > that you are and these are extremely simple I think it's worth it, and it will
> > help slowing the prolifiration of gray hair around my head when I look back at
> > this a year or two down the road.
>
> Sure, I can make those changes in the next revision. Thanks for the review.
>
> Cheers
> Suzuki
