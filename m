Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BCECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED7F2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovE8mj+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED7F2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeISGi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:38:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41623 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeISGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:38:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so1864259pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w2FhQqF3cR1LiV/37Tr3FjsvEl0xoLDTh6btn/5pQh4=;
        b=ovE8mj+QacYjjo+sbFgYxWtSNgO0w+U3+lY05MWpy39yRP7i+VRF6t9WkK4VZvFs0p
         BdUeRnexhtfjn3cp8Ycn1aUpxBm0Q5iw5nBBT9BEeSfih4TDKrCGhhDRB2+mFEtRumoQ
         eXoRnfPsN++c+lo+5C7zU3on4ntjEOz9SooGDTrMahlfC3RKjqd9918aKHaWTTAHMnO/
         OHz6AQq79uf/gcxJznQ4O+RYE0YhWWnR+jgb/ZcxVHKoQ464VqJ4Cy1SIbTuS71jPix7
         wtJ5u71TVlDGCWmDDBfQ2suPFiVitRd8LzE2zWQj5Ml7i8Z8BwNVtVMpqLQv+Sf+jlOe
         sbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2FhQqF3cR1LiV/37Tr3FjsvEl0xoLDTh6btn/5pQh4=;
        b=PrM232VNNsbzHhaEjb3c9NsfwXpBeG+T3epW1zBTVkgXhI1/JOmPkNo4JVVfpPUQ4a
         R3F28QoCCAhd+x7CJ3+L+ZoLq2jg5kAMP286Y5rySmpLZi78HshhQnuXA3e9qRh6FEY6
         dSyChuupHty7NizBepcUgslMbm6KUHnhJY+3yx9ZMoPRiDNRwaJNHVHU/4a2IpKMOdDa
         ZmTF0+zjJNkM8x03bLEDDYTZjx5HkvCxssEaMEGZ/u7ci6Wc49Hc1iznM2o0KJsYh3hK
         0vDiHQFt+Hbg/6xD4Ag9YJYjvfYxdms+0BU5cZcOU9TvKwGMrXg5+djuhl4+lNIbRKMy
         304A==
X-Gm-Message-State: APzg51CFWWM8OpW/KqbB6bl0s5yqUNiif3NrnyUUyy1ZYxPQUin0HXIo
        3RjebTkJyC6R8v++nGBCcJk=
X-Google-Smtp-Source: ANB0VdbbJX2N/G9iUI6K6R9Kg87dXV/ViFhF9KbVCK4vAOav5+weL5j3w9ysNNGHXVWLcBMmKqo7SA==
X-Received: by 2002:a63:798c:: with SMTP id u134-v6mr26631310pgc.111.1537319022131;
        Tue, 18 Sep 2018 18:03:42 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id b14-v6sm35131010pfc.178.2018.09.18.18.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:03:41 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:03:37 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "keescook@google.com" <keescook@google.com>,
        "jsteckli@os.inf.tu-dresden.de" <jsteckli@os.inf.tu-dresden.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180919010337.GC8537@350D>
References: <20180820212556.GC2230@char.us.oracle.com>
 <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534801939.10027.24.camel@amazon.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 09:52:19PM +0000, Woodhouse, David wrote:
> On Mon, 2018-08-20 at 14:48 -0700, Linus Torvalds wrote:
> > 
> > Of course, after the long (and entirely unrelated) discussion about
> > the TLB flushing bug we had, I'm starting to worry about my own
> > competence, and maybe I'm missing something really fundamental, and
> > the XPFO patches do something else than what I think they do, or my
> > "hey, let's use our Meltdown code" idea has some fundamental weakness
> > that I'm missing.
> 
> The interesting part is taking the user (and other) pages out of the
> kernel's 1:1 physmap.
> 
> It's the *kernel* we don't want being able to access those pages,
> because of the multitude of unfixable cache load gadgets.

I am missing why we need this since the kernel can't access
(SMAP) unless we go through to the copy/to/from interface
or execute any of the user pages. Is it because of the dependency
on the availability of those features?

Balbir Singh.

