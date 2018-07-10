Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D91C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95535208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ClgJMNt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95535208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeGJOfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:35:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45536 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933449AbeGJOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:35:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so2200768wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DrkARnj1Y5uzN7GxT/J+PMXh7Sow81EEX/wPymjML4I=;
        b=ClgJMNt5dq9bMsxxmSlxRahH8dq6+spehLIzkkAUi9AksjualIw7CPuloJOteswrzA
         oEzcWakQYVAILwCs2g2cGJY9pEwBebSkMZ16ym5Is5T1LvSGb30Dw7q8ym5Ufv6pMRKx
         eOd+zdwVn7sx3bj1em2olBpAu+VMWocBWH170=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DrkARnj1Y5uzN7GxT/J+PMXh7Sow81EEX/wPymjML4I=;
        b=l9HIDd83vr0nvdjvwTJa/C1ZzNaGTZ2YDNjPzZELTGxJEaMXVTrvq4yYaQygKgEjUh
         Dqmbi6PIPnSpivjQGNs8uODUTJLWX9y/feYg1RiP3VJ7veWE0Lnr3R3bZozW1XELo1ub
         u9ta7bVaKPuU0HkMN3TLSyD/pZaBorrRDp9KtWjnhWnjN2Ke80559wmH7oIgrY3jo9xH
         9C6Qs1W1XadK42Tdf6GmDS+8KUd8b462I29J6JYXA3PYT1bXWLJZXRaKKBxso8tuV74F
         ZzmyLnjkk77Nd1N/uqHYAb+uYfB4Osayif4ST7F81SlGUfVg1W1KwCRHQSkGYTvQ8Pb+
         jlEw==
X-Gm-Message-State: APt69E2aCniCBf9e9yVNgJbUsowDEI7Ql8/XUa4SawHaEoMd+ej2CBns
        uCQmJDEuxgnBjPZ6iqJMoxGjMCpU
X-Google-Smtp-Source: AAOMgpfCjmnLE/IgoCphxyhC5IEojMLtlZlIGNcIN7KVYGsoHMYRINN6gLrO97US/YfJpgCpWM1kiA==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr18581763wrc.164.1531233307334;
        Tue, 10 Jul 2018 07:35:07 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id i190-v6sm25640741wmd.33.2018.07.10.07.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:35:06 -0700 (PDT)
Date:   Tue, 10 Jul 2018 16:34:59 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Message-ID: <20180710143459.GA10527@andrea>
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:02:23PM +0200, Andrea Parri wrote:
> Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> with smp_cond_load_acquire()") by updating the documentation accordingly.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/memory-barriers.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 0d8d7ef131e9a..987a4e6cc0cd8 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -471,8 +471,8 @@ And a couple of implicit varieties:
>       operations after the ACQUIRE operation will appear to happen after the
>       ACQUIRE operation with respect to the other components of the system.
>       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> -     semantics from relying on a control dependency and smp_rmb().
> +     and smp_cond_load_acquire() operations. The later builds the necessary
> +     ACQUIRE semantics from relying on a control dependency and smp_rmb().

Still not completely accurate: smp_rmb() would better be replaced by
smp_acquire__after_ctrl_dep() (arm64 excluded).  Mmh... I think I'll
just remove that "The latter builds the [...]" and resend; thoughts?

  Andrea


>  
>       Memory operations that occur before an ACQUIRE operation may appear to
>       happen after it completes.
> -- 
> 2.7.4
> 
