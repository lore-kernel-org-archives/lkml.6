Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF02C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546CE20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw5/22X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546CE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeH3D5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:57:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33183 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeH3D5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:57:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id 60-v6so3009966ple.0;
        Wed, 29 Aug 2018 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qgIpSf3JqV683iVi3mdl1TgYmddlmqHbLFi0AIy6LY=;
        b=Jw5/22X/saV47QMaRzkfCNsetsb+RRM20D7gu4LWlp7i6wMI64ZScEeitqN95ltdow
         8J7S+oTpk2uku/NtsKbFUvawa8KKpie6fI9IfUrRWbf6a5f5u1PRMz5TOGrKbecn4hWW
         XlUIaogFHjS5C2f/0Tqjhwpr9uLY6A8slHCIJoB78ueob5gkCX0F62pri5dJxhbYatkI
         QawhsehrDCdfcdHHapwzQVNzCLP/wyp58Hg19DX1rKAGzdjyTMGd1/QUz3jagVeBJb31
         sBO+xrSalwu8DB/ngWEhri0lpo+zrJ/KEs7PK4wEL90jl1cgkLMWd43Qn9K3Vj3PopZb
         IPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qgIpSf3JqV683iVi3mdl1TgYmddlmqHbLFi0AIy6LY=;
        b=djgMdlDjthEZnejKHSCbNGOf/LYU8l3sdMak0XJ4519xPCts9uqtbtny1rK5pXqBj4
         yOJSWXkn41/1dfrPzb82EQBnRMitaqELjYc5puGPcASd5jo23kE3R8G7Kjs75tqNeXy/
         lolsoPyrgJ3Tx9VLS3r2kCTULN5jhTbgJrt4b5kLG2JywHXuMZqf0YTCaPb/ixotrHRy
         hXUM3XutizgUSx2JOZsCL6OTu+0tXwhPYlsDLYluNn02E736zBXYZiMh3Bnm3BjOKKTI
         C+QzUfS9OR3MAx6Dmk5BeOjk4x6GtdL1bVJcxX8rIqFpFAZL/z6oi2RilaGBTfbLv0PD
         SPZQ==
X-Gm-Message-State: APzg51AKThqkVtw6I3KqaOkhVFW47bKZKwLbmOleGDSoO7KX/YDG31Ig
        nudTKCxFlpKJaBQ7WpajS2DQIiWV
X-Google-Smtp-Source: ANB0VdbCCxc5G1V7EqLUb7z0Rk9FvKwaSLXTxaIyir/cPojgnjh9z4cf5M0AqlKzEOhPqMOhGAASWg==
X-Received: by 2002:a17:902:b20d:: with SMTP id t13-v6mr8034308plr.107.1535587074078;
        Wed, 29 Aug 2018 16:57:54 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id g5-v6sm15723018pgn.73.2018.08.29.16.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 16:57:53 -0700 (PDT)
Date:   Thu, 30 Aug 2018 09:57:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling
 in fork
Message-ID: <20180830095747.491f7770@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-3-npiggin@gmail.com>
        <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
        <20180830091213.78b64354@roar.ozlabs.ibm.com>
        <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 16:15:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 29, 2018 at 4:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Dirty micro fault seems to be the big one for my Skylake, takes 300
> > nanoseconds per access. Accessed takes about 100. (I think, have to
> > go over my benchmark a bit more carefully and re-test).  
> 
> Yeah, but they only happen for shared areas after fork, which sounds
> like it shouldn't be a big deal in most cases.

You might be right there.

> 
> And I'm not entirely objecting to your patch per se, I just would want
> to keep the accessed bit changes separate from the dirty bit ones.
> 
> *If* somebody has bisectable issues with it (performance or not), it
> will then be clearer what the exact issue is.

Yeah that makes a lot of sense. I'll do a bit more testing and send
Andrew a respin at least with those split (and a good comment for
the dirty bit vs unmap handling that you pointed out).

Thanks,
Nick
