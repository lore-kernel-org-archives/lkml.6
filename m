Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1AAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF922565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mA9lfsah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BF922565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934334AbeGCRXy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:23:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51102 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934195AbeGCRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:23:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so3178911wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ys40/E/YcsUcpFbJJvBObVKVpSmn60G3t6C1cU8wAU8=;
        b=mA9lfsahcHbgoVP9DYYuyvwQM7NpH02dYcRnj0tUqZihpFUIl1zZId4nRkNrQXBDSi
         4fyowADAPYxQDhzS6+GAzjg3bf3lYx/lZJcQN3IUDAuGiByisSQmJf6mQHJSTKIXvP89
         Q+/unxcu+c/viKawAkntTAKq7iq4CECxuE1Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ys40/E/YcsUcpFbJJvBObVKVpSmn60G3t6C1cU8wAU8=;
        b=ZFBET6fY6jTXlRz6cyAqudRXbtp84qpH1SvQtEB9KDaZmrPAeqXCawBmzQ/nD2pJZf
         KHKaXVRWFlM4/wDKx9IITJrhTjN0rXX79vk0wZ3n2f7CUV9NS90eY+ctY1n8AT22PvZG
         Gsc+yGPYrnUGRte2GJVVL6rmDhTsKszu1CBf320LYOoOBpk+IWUdvJst87Y/183DIBjK
         zrPvoBGDlYFyqQzV8uBXoKgsaHA4htypvlVFx6zYpYkFuvMgr+ans8bIdia4SCnHm0gF
         nqfz+vyd4tMrosUK3iEmtMoNEX7PCRQNjTO2XFrzx/MhMPbAkoOXbLb3PZwA08ux1yMy
         Nf+g==
X-Gm-Message-State: APt69E0t749drmhN5Ww2n+tyLLmumKARvUzkpKNeX2SKxgAxXEbvyyYi
        swcKpk1CZv8bzlLp3Xx/jn4xfw==
X-Google-Smtp-Source: AAOMgpdHlzNR/KMnW3LXRfwH8b/u7Fc+XqP7oKv73/mPDcPLC8tY5m0EVt15rNTyKdS6cj27/7vx9w==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr5378101wmi.152.1530638628839;
        Tue, 03 Jul 2018 10:23:48 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id b190-v6sm3572229wma.24.2018.07.03.10.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:23:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 19:23:42 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com, davem@davemloft.net
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Message-ID: <20180703172342.GA3601@andrea>
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
 <20180628165111.GA4013@andrea>
 <20180702185415.GR3593@linux.vnet.ibm.com>
 <20180703101241.GA29602@andrea>
 <20180703155303.GA3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703155303.GA3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> commit 33a58ee5eadadfb1f4850eabd4fac332984881d5
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 3 08:48:09 2018 -0700
> 
>     tools/memory-model: Add informal LKMM documentation to MAINTAINERS
>     
>     The Linux-kernel memory model has been informal, with a number of
>     text files documenting it.  It would be good to make sure that these
>     informal descriptions are kept up to date and/or pruned appropriately.
>     This commit therefore brings more of those text files into the LKMM
>     MAINTAINERS file entry.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Alan Stern <stern@rowland.harvard.edu>
>     Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Boqun Feng <boqun.feng@gmail.com>
>     Cc: Nicholas Piggin <npiggin@gmail.com>
>     Cc: David Howells <dhowells@redhat.com>
>     Cc: Jade Alglave <j.alglave@ucl.ac.uk>
>     Cc: Luc Maranget <luc.maranget@inria.fr>
>     Cc: Akira Yokosawa <akiyks@gmail.com>
>     Cc: Daniel Lustig <dlustig@nvidia.com>
>     Cc: "David S. Miller" <davem@davemloft.net>

With the disclaimer that I'm not (yet) familiar with reST,

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Adding the linux-arch ML, as you suggested, would also make sense to me.

Thanks,
  Andrea


> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f2903b818671..2ba947fc9a2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8321,6 +8321,10 @@ L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>  F:	tools/memory-model/
> +F:	Documentation/atomic_bitops.txt
> +F:	Documentation/atomic_t.txt
> +F:	Documentation/core-api/atomic_ops.rst
> +F:	Documentation/core-api/refcount-vs-atomic.rst
>  F:	Documentation/memory-barriers.txt
>  
>  LINUX SECURITY MODULE (LSM) FRAMEWORK
> 
