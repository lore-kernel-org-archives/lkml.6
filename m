Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F218C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5775123F3E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OqrBVYm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5775123F3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeFVI4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:56:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43240 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFVI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:56:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so5863385wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CscDHABnPX/8unneFqUexvLkrTWF55xHuWlgniYLer0=;
        b=OqrBVYm+SGg2+XMLjImRdXtRJT1Gcbsw9ZkCScMVrGN7Zhm65R+7wrLFfckTf8abPf
         G2PCl0ycQhARQSIADYRGlSeNzC8+ND94LtrF8lXsFhsGD6Tp9dDcFCEdWfCMdwln5ube
         02pHZSIvzx3uWgEUBGNHbPyjoUyB8q+SXWlic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CscDHABnPX/8unneFqUexvLkrTWF55xHuWlgniYLer0=;
        b=nVtye67ogdCfKK0s5wnqLV9rOmhTntg+y4O5bX5ozY0FiuP8baWZTE99UxGvNAfVai
         s/a92YVAPso0vggYgGL4y+tAA6yXOBVGtRQCZ3sTJUMadftuGdrHGGWcdcyeFv0A7PCf
         9ViAbK/T6pmMZEn+2i2TeIyCAHDeRCTkuvEvA/vJxHT1NF5/ujmI94hbpU+pTuYLuPb2
         t89nMbauINnrvKIixFN00ToXTrPzsrnMiEuHiTpVJpiTOyM58MwPTV+WNNjGrtdYu3jl
         +N0llxzPvEAona4QrOcgN3KcrgGh3R5WjQgjQKdqF/o26iFXjrvv442Ldf4ijkM8ZOJw
         WPpA==
X-Gm-Message-State: APt69E0KF6D29ntz1jI+mxJ2+7HJFhchAwQsXP34cACm9Mmiql0BYfFg
        Oyrd1iEVDek3RugosCu2IVtiLQvV
X-Google-Smtp-Source: ADUXVKJKvBGGeaPQFo8hPX0sVx70JdReVWUs4huYarVx0ysa/hp8qfrNsUC4UUc0vCf/trWoGiD8hQ==
X-Received: by 2002:a5d:4204:: with SMTP id n4-v6mr759011wrq.55.1529657793915;
        Fri, 22 Jun 2018 01:56:33 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id i14-v6sm4331079wrp.24.2018.06.22.01.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 01:56:33 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:56:27 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tools/memory-model: Change rel-rfi-acq ordering to
 (rel-rf-acq-po & int)
Message-ID: <20180622085627.GA6933@andrea>
References: <Pine.LNX.4.44L0.1806211315550.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806211315550.2381-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:26:49PM -0400, Alan Stern wrote:
> This patch changes the LKMM rule which says that an acquire which
> reads from an earlier release must be executed after that release (in
> other words, the release cannot be forwarded to the acquire).  This is
> not true on PowerPC, for example.
> 
> What is true instead is that any instruction following the acquire
> must be executed after the release.  On some architectures this is
> because a write-release cannot be forwarded to a read-acquire; on
> others (including PowerPC) it is because the implementation of
> smp_load_acquire() places a memory barrier immediately after the
> load.
> 
> This change to the model does not cause any change to the model's
> predictions.  This is because any link starting from a load must be an
> instance of either po or fr.  In the po case, the new rule will still
> provide ordering.  In the fr case, we also have ordering because there
> must be a co link to the same destination starting from the
> write-release.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> 
> ---
> 
> 
> [as1870]
> 
> 
>  tools/memory-model/Documentation/explanation.txt |   35 ++++++++++++-----------
>  tools/memory-model/linux-kernel.cat              |    6 +--
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,7 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
>  
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,9 +60,9 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = to-r | to-w | fence
> +let ppo = to-r | to-w | fence | (rel-rf-acq-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -1067,27 +1067,30 @@ allowing out-of-order writes like this t
>  violating the write-write coherence rule by requiring the CPU not to
>  send the W write to the memory subsystem at all!)
>  
> -There is one last example of preserved program order in the LKMM: when
> -a load-acquire reads from an earlier store-release.  For example:
> +There is one last example of preserved program order in the LKMM; it
> +applies to instructions po-after a load-acquire which reads from an
> +earlier store-release.  For example:
>  
>  	smp_store_release(&x, 123);
>  	r1 = smp_load_acquire(&x);
> +	WRITE_ONCE(&y, 246);
>  
>  If the smp_load_acquire() ends up obtaining the 123 value that was
> -stored by the smp_store_release(), the LKMM says that the load must be
> -executed after the store; the store cannot be forwarded to the load.
> -This requirement does not arise from the operational model, but it
> -yields correct predictions on all architectures supported by the Linux
> -kernel, although for differing reasons.
> -
> -On some architectures, including x86 and ARMv8, it is true that the
> -store cannot be forwarded to the load.  On others, including PowerPC
> -and ARMv7, smp_store_release() generates object code that starts with
> -a fence and smp_load_acquire() generates object code that ends with a
> -fence.  The upshot is that even though the store may be forwarded to
> -the load, it is still true that any instruction preceding the store
> -will be executed before the load or any following instructions, and
> -the store will be executed before any instruction following the load.
> +written by the smp_store_release(), the LKMM says that the store to y
> +must be executed after the store to x.  In fact, the only way this
> +could fail would be if the store-release was forwarded to the
> +load-acquire; the LKMM says it holds even in that case.  This
> +requirement does not arise from the operational model, but it yields
> +correct predictions on all architectures supported by the Linux
> +kernel, although for differing reasons:
> +
> +On some architectures, including x86 and ARMv8, a store-release cannot
> +be forwarded to a load-acquire.  On others, including PowerPC and
> +ARMv7, smp_load_acquire() generates object code that ends with a
> +fence.  The result is that even though the store-release may be
> +forwarded to the load-acquire, it is still true that the store-release
> +(and all preceding instructions) will be executed before any
> +instruction following the load-acquire.
>  
>  
>  AND THEN THERE WAS ALPHA
> 
