Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C90ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA32620846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXgH2S/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA32620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeGPBcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:32:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53660 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeGPBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:32:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so6126015wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4Icj72QzsgRjoe31Q2WfpLKNlOuW8rpKPFxGcV53kM=;
        b=AXgH2S/yb9JM5At+ekxDwQLLYCuqaDmZ5bRgMbTZHVIbxrH/LHRUOq7d/6/v+6G1NP
         wBUqPHBby4dBnUcfHp5IKPJXmXnfzsiMyv7vKAvsFoK2RfHoqZPYpDuIAhUMTu24nTyC
         hJx5glktlJu7AqxrVnTws9vCpeljlo2SpTTHs6jmVbjDHHjutPD0UkcdGo7QxLFpU8PB
         t8sy7dGka2IGLO2qcTQ7nAtgUD5u9xli5QfE7WIaOdxOA4htHDSYK2U03ry+3fn+Aed0
         AMWCCZffxn7GASMO4kCbHGqQhWnj/eW024KJXTJL+hh9KHfoT5TaaA9A3a5Pizkdfk3u
         kFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4Icj72QzsgRjoe31Q2WfpLKNlOuW8rpKPFxGcV53kM=;
        b=Z4pQC8w/QjPBt+NqDSKAzi97096qbd1r9qh/CAKpFle5DZfxz88495b/4CUS7ldxps
         A8JAgLyuk9TXFoEeUrR2IZZGtH8Pb29kUajEdk7Rg6826+SZFoj5Lgrz2bUAashDaK9b
         6MHwjWh/fAEejuDT15uI+J53GISqLi5884TXpoczL8RMPvHbKp+IEpx1O1rvXrUxqwyQ
         dnQvamxIZAz9rPlJGgYy66hnX/kNW++akGrLwno1V4sQSoajngJubqXtblKKWOQuotWp
         k4aBUFNWSRlIguqLpQyBRijM4rbZOLUCHbLqU1FNa5Q8yFn+016U+bjCtsvia2o5mR8E
         +G4Q==
X-Gm-Message-State: AOUpUlEmJEd69Qoy87c8jZdjWygdu6da/9u9jQQlLb+pIQ49rnImTmZZ
        Y6ZnIDiFhJIkHzFoUl7qKpk=
X-Google-Smtp-Source: AAOMgpcQb3YzP5v1RI0ulbzDhv4uUus7SzOoe4cc5p8EDAd+2LJx011x/Oi3rw/QVjSXcJIqvdy43w==
X-Received: by 2002:a1c:5c82:: with SMTP id q124-v6mr9036793wmb.24.1531703233161;
        Sun, 15 Jul 2018 18:07:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z5-v6sm41328290wrv.2.2018.07.15.18.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 18:07:12 -0700 (PDT)
Date:   Mon, 16 Jul 2018 03:07:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        dave.hansen@intel.com, kernel-team@fb.com, efault@gmx.de,
        tglx@linutronix.de, songliubraving@fb.com, hpa@zytor.com
Subject: Re: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on
 nr_cpu_ids
Message-ID: <20180716010710.GA29844@gmail.com>
References: <20180710142833.26231-1-riel@surriel.com>
 <20180710142833.26231-2-riel@surriel.com>
 <20180715225951.GC30102@gmail.com>
 <1531698618.26425.4.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531698618.26425.4.camel@surriel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@surriel.com> wrote:

> On Mon, 2018-07-16 at 00:59 +0200, Ingo Molnar wrote:
> > * Rik van Riel <riel@surriel.com> wrote:
> > 
> > > The mm_struct always contains a cpumask bitmap, regardless of
> > > CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
> > > simplify things, and simply have one bitmask at the end of the
> > > mm_struct for the mm_cpumask.
> > > 
> > > This does necessitate moving everything else in mm_struct into
> > > an anonymous sub-structure, which can be randomized when struct
> > > randomization is enabled.
> > > 
> > > The second step is to determine the correct size for the
> > > mm_struct slab object from the size of the mm_struct
> > > (excluding the cpu bitmap) and the size the cpumask.
> > > 
> > > For init_mm we can simply allocate the maximum size this
> > > kernel is compiled for, since we only have one init_mm
> > > in the system, anyway.
> > > 
> > > Pointer magic by Mike Galbraith, to evade -Wstringop-overflow
> > > getting confused by the dynamically sized array.
> > > 
> > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > 
> > Is this an Acked-by in disguise, or did this patch route via Mike?
> 
> Mike found an issue with the patch and sent a
> fix, so I added his S-o-b to this patch as
> well.

Makes sense - I'd suggest such a SoB chain:

  Signed-off-by: Rik van Riel <riel@surriel.com>
  [ Fixed crash. ]
  Signed-off-by: Mike Galbraith <efault@gmx.de>
  Signed-off-by: Rik van Riel <riel@surriel.com>

... it's a bit non-standard but we've used it in similar cases and it makes the 
routing and evolution of the patch pretty clear.

Thanks,

	Ingo
