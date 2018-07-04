Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888F23CE4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBezMTwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888F23CE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeGDPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:36:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45526 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGDPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:36:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id m2-v6so11442288oim.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oclDJUKVFRwAWhy8jO3+HtV97HCGerAbxgROs1fAxkM=;
        b=IBezMTwcvQR+YpdmDhOIok7wqFZyBl2v3fYdwaY8FoF80Q4GhDuhomEKIfu/oQGobp
         tu8cUdbxBSQ+IXJa09elAEdtxDPv90TWkrP/wB5H3Ay2RGyvQj8AIJ92v6eT+TuzQnzM
         e0dOiFUo2lGN6dYNAbVh29vCWJo8nz05xkOv8nBbHvQTJuYt0hRXsXl6megsoZS00+ga
         Rm+VzB151vHUka+mz+qf5nWmnyLkFI01Es2liZASj8PJfldT0B9KNFL9UgspAvBNE4f9
         nl5ZI8DuK92PlcF0WlKhbeHlKACbds/x3zbbyhrgx6BUoZawcY0Pv6/PEUAXtRuKbDBF
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oclDJUKVFRwAWhy8jO3+HtV97HCGerAbxgROs1fAxkM=;
        b=ltAYam7zM3KO+muCp47URbvhleQksPagSYgyRzAUgRgp+Ylgqp0PqWmfkIctAAFf2V
         EGAoEM3fc00lF6wglxnmE08nw4ANVOoQu2AVmNnFE0olD9u8qmNQEQSAYNgsRExpMfjg
         NK+V2rfD0WTwzQJMV+sk4u3FTcBzmjsI4XDFZVnqJMe1gyMnKYzuAt5ZphsruJ6UFsPT
         k2H73xOy6jbwYatFge9CFMvnY08yZ1P23V+W6BE75QzsdYxyCx0mj9bscKA0sGX/woq7
         u3q4lBg6sgfYR8zv4s8nELjk8BUT3msUZjbddDWjsMeEIiTg9lyijESXPJBn6h6E9q2G
         FCig==
X-Gm-Message-State: APt69E2T9qtYGQiidvb/RKa0M7WRnuKyxKw2DcT9XcQ7rYw0dy6Z0HWF
        mO1pexEfwNhturoulAJ6tvc=
X-Google-Smtp-Source: AAOMgpeEwvnc3M7G0Hcz2f0WqfwMH328zMhbQd1Kvc12FlxTQTP5adhR/oiGOU4w06bqqtZsgw8wRQ==
X-Received: by 2002:aca:acb:: with SMTP id k72-v6mr2896953oiy.78.1530718585228;
        Wed, 04 Jul 2018 08:36:25 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id w40-v6sm3086677oti.80.2018.07.04.08.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:36:24 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:36:17 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180704153617.tps2asygskoym46d@penguin>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
 <20180624213103.GA166241@dtor-ws>
 <20180624224522.GA23998@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624224522.GA23998@yury-thinkpad>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:45:22AM +0300, Yury Norov wrote:
> On Sun, Jun 24, 2018 at 02:31:03PM -0700, Dmitry Torokhov wrote:
> > External Email
> > 
> > On Sat, Jun 23, 2018 at 10:35:02AM +0300, Yury Norov wrote:
> > > On top of next-20180622 and Andy Shevchenko series:
> > > https://lkml.org/lkml/2018/6/18/841
> > >
> > > The series mentioned above introduces helpers for bitmap allocation.
> > > tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
> > > proposed in new kernel API, and is equivalent to bitmap_zalloc().
> > > In this series tools is switched to new API.
> > >
> > > This is RFC because I didn't find counterpart free() call to some
> > > bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
> > > someone point me out? The functions are:
> > > setup_nodes();
> > > do_read_bitmap(); // Free is called, but only in fail path.
> > 
> > Yes, because if we succeed we effectively return allocated bitmap to the
> > caller. You'd need to trace upwards and see how it all gets cleaned up.
> > But given that this is userspace and is not expected to be long-lived,
> > maybe nobody bothered freeing memory and we instead rely on the kernel
> > to clean it all up when process terminates.
> > 
> > Thanks.
> > 
> > > memory_node__read();
> > >
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > ---
> > >  tools/include/linux/bitmap.h | 19 +++++++++++++++----
> > >  tools/perf/builtin-c2c.c     | 10 +++++-----
> > >  tools/perf/tests/bitmap.c    |  4 ++--
> > >  tools/perf/tests/mem2node.c  |  4 ++--
> > >  tools/perf/util/header.c     |  6 +++---
> > >  5 files changed, 27 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> > > index 48c208437bbd..b9b85b94c937 100644
> > > --- a/tools/include/linux/bitmap.h
> > > +++ b/tools/include/linux/bitmap.h
> > > @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
> > >  }
> > >
> > >  /**
> > > - * bitmap_alloc - Allocate bitmap
> > > - * @nbits: Number of bits
> > > + * Allocation and deallocation of bitmap.
> > >   */
> > > -static inline unsigned long *bitmap_alloc(int nbits)
> > > +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
> > 
> > This makes absolutely no sense for userspace API. What gfp_t even means
> > here?
> > 
> > If you want to introduce bitmap_zalloc and bitmap_free it is fine but
> > adding dummy parameters to match kernel API exactly is a folly.
> 
> Identical API makes easier porting the code from kernel to tools.
> Refer for example declaration of kmalloc in:
> tools/testing/radix-tree/linux.c
> tools/testing/scatterlist/linux/mm.h
> tools/virtio/linux/kernel.h
> tools/virtio/ringtest/ptr_ring.c

These are unittests for the APIs in question, of course they would have
to match exactly.

perf tool however is not a unittest, so there is no need to match kernel
API.

Thanks.

-- 
Dmitry
