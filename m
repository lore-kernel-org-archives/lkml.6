Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3ECC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428F0208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4lTKG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428F0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbeHBCwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:52:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44163 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbeHBCwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:52:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so212353plb.11;
        Wed, 01 Aug 2018 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HDjYTifBppH3WUhuYDN3+Zgx+HAInc1xhVL1mYEmD2g=;
        b=nj4lTKG8poYlIiwQqU2bvBAaYN2E6FNH5+bZQE1Q8lOhDCr7kqGVlyzUAPvOeRTogT
         Foq4bS7EC8YhZUA0nh8HG/NKfh0NGx0ZykJTUC8LIZrE6pTFe0BvGkV1O9BtyDtTIJDu
         9KAfATg8/Ga5S1Oxe5ZRcjwgamsBZ+elpFK9fRRJzLQ/IUs/+bQ5ICprPv0Pj6WrfJnj
         BLUCx6lwu18ex2Y6y/J9+HwSazp4+7lvzYcRmDf262KSO1tMUk5GyxKxJtnCrqIQXulj
         ywJHL90Hcy4kbYLQh4cPrjaFwGJw8gN4wPkJFhruodd+CbTKmoGgrZVRTd9tVp94gHuH
         JHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HDjYTifBppH3WUhuYDN3+Zgx+HAInc1xhVL1mYEmD2g=;
        b=CoZtWENNsiXxdxRaV+1Bf4JbxO7TSEWuU/BeMIJIbMmRAWItFM4/KLThgUZdML1BFf
         wNJJh2ImiG7UxQA4GjsWfCcxaAyvfLeXyFnojIn+jEs2EBCMpFgl8DyrHzNVaPbcuWUx
         2uIQBj93ATmyWWy7llgc1zKAbII2UFtxW8ogh7Nqcz+yI3DHlW0NqqiupxSFL/LnujzQ
         SiTd5xB46FT1CAs+pVSQTqDerfKKOEILLKqxM+P4evNoM1Trk8gk7AwYNKNmR2ObIpQQ
         76LI9d94iQ5kDvV4uaKhdcyT6tqa3iZmCxaW9EMtY8vVebqrKTz7lNuDSmwTNLoAJCQA
         qOEg==
X-Gm-Message-State: AOUpUlHbtrNghiYCi4vyIiJfve6DYGmLsZpRzvpVprVTRXrgFFMoWdnN
        P+2QCJEiVPZS9OW54tfUXQI=
X-Google-Smtp-Source: AAOMgpf3f/dm380sT/BqZsRNSVSNOjjVNXH5waEIiGaM0/FhnOc5dGntmAdc5KlED00+kEiHoQDZKg==
X-Received: by 2002:a17:902:b708:: with SMTP id d8-v6mr509571pls.184.1533171810094;
        Wed, 01 Aug 2018 18:03:30 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e132-v6sm417313pfc.49.2018.08.01.18.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 18:03:28 -0700 (PDT)
Date:   Wed, 1 Aug 2018 18:03:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 0/5] bitmap: Introduce alloc/free helpers
Message-ID: <20180802010325.GB184797@dtor-ws>
References: <20180630201750.2588-1-andriy.shevchenko@linux.intel.com>
 <CAHp75Vd9RSxVsYrbiAFJKLPL4wNzAtS9qAPjCNJJ4E=QbeTP8A@mail.gmail.com>
 <2310fa540b9e5db3b94f4917ecae76dce2a2ca65.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2310fa540b9e5db3b94f4917ecae76dce2a2ca65.camel@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 02:35:53PM +0300, Andy Shevchenko wrote:
> On Thu, 2018-07-05 at 00:30 +0300, Andy Shevchenko wrote:
> > On Sat, Jun 30, 2018 at 11:17 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > A lot of code is using allocation of bitmaps using BITS_PER_LONG()
> > > macro and
> > > sizeof(unsigned long) operator. The readability suffers because of
> > > this.
> > > 
> > > The series introduces three helpers, i.e. bitmap_alloc(),
> > > bitmap_zalloc() and
> > > bitmap_free(), to make it more cleaner.
> > > 
> > 
> > Dmitry, it seems we are all set now and if you have no objections
> > against this version, it would be nice to see it in your tree followed
> > by upstream.
> 
> Gentle ping!

I put the first 3 patches into an immutable branch off 4.17:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/4.17-bitmap

and queued it and the other 2 patches for the next merge window.

Thanks.

-- 
Dmitry
