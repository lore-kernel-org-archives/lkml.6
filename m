Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB946C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8375320673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwTbfBV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8375320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeH0Pbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:31:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39520 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0Pbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:31:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so9298042uam.6;
        Mon, 27 Aug 2018 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYz82dCxFS/P7Gl7HvchvLLoXhDUYjhwn6gpnwgwNH0=;
        b=jwTbfBV15ahO4xfnrKUkGZ0r74qh0PUk5P4Y4kf8ZyQResi9RsEWUMdvhfShiZScNj
         qmEHdKNE3ErtJwYaWAnB9RGwBXVU9Z8CdGPMNTCXQoD95p8EyisEmJlkKkfUFonSEYGV
         xczKxQhGJH2KUSrbK1oxlPYdB1OKNo4FfiNCaY1myMV9QVzNuBbtg9COoWIDkw2O7cjk
         harHLCPi4D+bBOBQ/88S5dC083tP1MZrR40sTqeGCr/ZiyYKyvfEDxm5JvsxN5CkEKx2
         C+vkdfBEAY7Pa1I1vN7T7dBW5DQuSGWjJqqnV811A1W1GzsE4W3731NKUAoo4vFuZbI+
         nvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYz82dCxFS/P7Gl7HvchvLLoXhDUYjhwn6gpnwgwNH0=;
        b=jA/FNcKcM1zNlWLTWSGScQERcIB/HXpxEgf8kbFobgqkZExcoTSv98GjdaK7Qu0qFg
         c8pjjYxJ/mQsCwYg2vqv76WCLBViLVnJyUn3J7/4uTt6JMPzMIi2UEbjvH37hWvMaHif
         rHW9xxp8+CfSO5elQDzLfwsyC2a1A6Yfr4oQk6MkcgtdYcENyzi9rKlJzNK3FQI9Pwxl
         h/7Xf1+eYxguifImwPLctcMlTvu/IhSaH3ti82j7k6hlm4NEh0JFbxmnfLbWtO8yBSaw
         3xxgGXGjvLUE/3xvy994DS0Zez/nxPHblRthmeoiJuuYTQDqHbyQr9MUc3kubdd450Mv
         AqVQ==
X-Gm-Message-State: APzg51CMQAQM0ym6pig/9hGDbeedZ9Bo9mAzGlcP51hIo3ktzIx0a+Lu
        h74fXU6cJkTVM0HM0gZ5R2xT6UJF84oNYix/rcw=
X-Google-Smtp-Source: ANB0VdYVhJhNJ602w4S4RMcw+40Lt8pkHUbO9nQuIMaDtHZOkjBIwZghuNT9PChfcm/sPqN86K4P6UAmUZpRxZwje/U=
X-Received: by 2002:ab0:7039:: with SMTP id u25-v6mr8085912ual.133.1535370314381;
 Mon, 27 Aug 2018 04:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180823134525.5f12b0d3@roar.ozlabs.ibm.com> <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net> <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com> <20180827074701.GW24124@hirez.programming.kicks-ass.net>
 <20180827085708.GA27172@infradead.org>
In-Reply-To: <20180827085708.GA27172@infradead.org>
From:   Jason Duerstock <evilmoo@gmail.com>
Date:   Mon, 27 Aug 2018 07:45:03 -0400
Message-ID: <CAP5F8cK7Yik27YT32EeJi1Hm19HFVA5bRmCbrd8ytnHQWtOEUg@mail.gmail.com>
Subject: Re: removig ia64, was: Re: [PATCH 3/4] mm/tlb, x86/mm: Support
 invalidating TLB caches for RCU_TABLE_FREE
To:     hch@infradead.org
Cc:     peterz@infradead.org, npiggin@gmail.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, benh@au1.ibm.com, luto@kernel.org,
        x86@kernel.org, bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        davem@davemloft.net, schwidefsky@de.ibm.com, mpe@ellerman.id.au,
        tony.luck@intel.com, fenghua.yu@intel.com,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot speak to how widespread it has been adopted, but the linux
(kernel) package for version 4.17.17 has been successfully built and
installed for ia64 under Debian ports.  There is clearly more work to
do to get ia64 rehabilitated, but there are over 10,000 packages
currently successfully built for ia64 under Debian ports[1].

Jason

[1] https://buildd.debian.org/status/architecture.php?a=ia64&suite=sid
On Mon, Aug 27, 2018 at 4:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 27, 2018 at 09:47:01AM +0200, Peter Zijlstra wrote:
> > sh is trivial, arm seems doable, with a bit of luck we can do 'rm -rf
> > arch/ia64' leaving us with s390.
>
> Is removing ia64 a serious plan?  It is the cause for a fair share of
> oddities in dma lang, and I did not have much luck getting maintainer
> replies lately, but I didn't know of a plan to get rid of it.
>
> What is the state of people still using ia64 mainline kernels vs just
> old distros in the still existing machines?
