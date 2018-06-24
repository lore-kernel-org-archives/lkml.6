Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E743C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0586125197
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSNFt2j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0586125197
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeFXVbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:31:09 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35793 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeFXVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:31:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id i7-v6so5164426pgp.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Rjru6uP5cOfGN16NdDJ2Ndmvv1oF1kIKQ/4/S2ClKE=;
        b=gSNFt2j37t7Rem6rZgA5m0lkxDpcG3nZv5JJFiQYlWG04eHrqc17S6ECmJKaybt5Cn
         yL7BVfgMe1tQ5rsHUep5ps0AttnXz15tOenhJzPy4x0+PZb4ZAMTjPT+8szQCuiMZSjR
         5OCDYvMmlUP3qz5qp9oGSipJMduPkI63IZSaIMSLnFnN72GwoxxyOYq/GG76iZL89bxA
         bPU6oExhJ6jYYJFB7BJNMvbkgvHhMjAoiV7gPV0cOk8KyNc7S8MATRptZYnKg3QYzcT+
         WesidSMD8feBgjAM0t6GipaMBpqOpX5eyjxcOH2BXW9wC3SqrY/Ey9n5ScFlSoktoRYU
         NMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Rjru6uP5cOfGN16NdDJ2Ndmvv1oF1kIKQ/4/S2ClKE=;
        b=qsn30oKLW1mpAxJvAt/LDz20tZsv3WAaGNnVpMJyOCLFim4bOHd7K7/ImjGYVByQw4
         JmN+Wvi5+AmkbIcrd2aNrjlfUHXi7be5yTwUUIbdOu2tIQhcxELJeDWsyu/TnuLyklT4
         IJRipi9T/ueCG5EULa5DUkRlad0oOPKrS2TGQvn2BoX4tZe3o1npz64pN4fcmHRhf6+Q
         Gkg/X+fIrgJOl2UyK7H9X9v0AScbbkBT7QBIiHc56kv/lT8dc6CnqOrxB+3XcBaxc1PV
         tlZEE/wcNFuR9LtgvYalTES8VUlsXRj4m3dHNlmaPXK+y+OobGYseJyKx6K5MMbGGQQQ
         CVOw==
X-Gm-Message-State: APt69E0UHp7rFzLCvnt3Z2nyAGElyuckl93ib31ogq2O3JUuGgJbNNwL
        o+j6a/eWQSiLVG4JxEjkmRUCCE6j
X-Google-Smtp-Source: ADUXVKJvgrfs3I0ebrS8HC12oIgHByDs5bqyPSu1sBMZ3tI9L9i8/7krQfwz0vKLwfm2TUOeff6P1A==
X-Received: by 2002:a63:a543:: with SMTP id r3-v6mr7819399pgu.336.1529875866713;
        Sun, 24 Jun 2018 14:31:06 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id o12-v6sm7896621pgs.52.2018.06.24.14.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 14:31:05 -0700 (PDT)
Date:   Sun, 24 Jun 2018 14:31:03 -0700
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
Message-ID: <20180624213103.GA166241@dtor-ws>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623073502.16321-2-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 10:35:02AM +0300, Yury Norov wrote:
> On top of next-20180622 and Andy Shevchenko series:
> https://lkml.org/lkml/2018/6/18/841
> 
> The series mentioned above introduces helpers for bitmap allocation.
> tools/ has its own bitmap_alloc() which differs from bitmap_alloc()
> proposed in new kernel API, and is equivalent to bitmap_zalloc().
> In this series tools is switched to new API.
> 
> This is RFC because I didn't find counterpart free() call to some
> bitmap_zalloc()'s. So I didn't convert them to bitmap_free(). Could
> someone point me out? The functions are:
> setup_nodes();
> do_read_bitmap(); // Free is called, but only in fail path.

Yes, because if we succeed we effectively return allocated bitmap to the
caller. You'd need to trace upwards and see how it all gets cleaned up.
But given that this is userspace and is not expected to be long-lived,
maybe nobody bothered freeing memory and we instead rely on the kernel
to clean it all up when process terminates.

Thanks.

> memory_node__read();
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  tools/include/linux/bitmap.h | 19 +++++++++++++++----
>  tools/perf/builtin-c2c.c     | 10 +++++-----
>  tools/perf/tests/bitmap.c    |  4 ++--
>  tools/perf/tests/mem2node.c  |  4 ++--
>  tools/perf/util/header.c     |  6 +++---
>  5 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 48c208437bbd..b9b85b94c937 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -98,12 +98,23 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
>  }
>  
>  /**
> - * bitmap_alloc - Allocate bitmap
> - * @nbits: Number of bits
> + * Allocation and deallocation of bitmap.
>   */
> -static inline unsigned long *bitmap_alloc(int nbits)
> +static inline unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)

This makes absolutely no sense for userspace API. What gfp_t even means
here?

If you want to introduce bitmap_zalloc and bitmap_free it is fine but
adding dummy parameters to match kernel API exactly is a folly.

Thanks.

-- 
Dmitry
