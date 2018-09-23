Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779EECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55DF0214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 02:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg766PLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DF0214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbeIWI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 04:29:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeIWI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 04:29:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id a18-v6so792586pfo.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 19:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9RwPPLzSm9occoae4x3SWJq27Arbduh+aA4ANqBDPDU=;
        b=gg766PLdxyOybwASl/uNX136rKocQ2KEsDqbgynZsNX7MKgbMwFsmphmsxD0N/owxP
         VnHWpmcRSJuG2nhwDD+lFkZ+7jahFIoMcEAQ1VBLJyVvpTNa50NdVtLqbndU+ROzgr+O
         SwnjO33tWPlnDMP6GC2cDB9usSNUsdfcpH1srVICE2rjHgITHqBG9onjT/TpR/Ywukee
         obdHMSis3bd5Orltqieti5Ywi8I7HFHSPbu96EaVQ1ZCIIzkHfcFYqR08mvJXpVBJdtS
         T6L7Birj8qlPYj1N8AyfPHfaqEszKgk15yLdmG4jJ2wW1NjOfCpTkPJQYbU1BDHXus5V
         9GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RwPPLzSm9occoae4x3SWJq27Arbduh+aA4ANqBDPDU=;
        b=or735jwEmwA1m/g1qwO/AfT6zJYNmCa3udGwu5fpAWYK081bKB+FgyL4LKDhDqFGeB
         aZIadhhQ+zu+Ulp7qmmpoF6U+/9KVmVHxCCCjmDoRJLwRGmIMpuxi7IkX2ErUXi8CkVh
         Z23CpQB0UzRVBYx8Yi+7bIpR9LLgqkdVPk2urd1bwhJSIZ6SjMCM6V2/KCvKO8tUt4gy
         1gpjeXR3e68TezfDpcZ2gtZqtrby1eR3d3ZKJ/YuQMdGTy5axg6d2scAwIVHYWNUM7aF
         BdGDYKmIXgFepOf20jeFNzxWEJTthxrBaUrvgXjeTV9NYtVMj3cHt6PCa6Xgn3grHVrV
         NiKw==
X-Gm-Message-State: APzg51DcPaTKR9NUuuGZurFRgH0EtYqUDUtoS6NGIa6U4KixwByJR0kR
        51sPPzml0IyqrPBLvGQxzK4=
X-Google-Smtp-Source: ANB0VdaFYQF+DogWpPDUKstbDosV4RNH0AJBHn3sdIpBdqT/l+IDQfzVTG4mU31xlcP4B/sDgdPB8w==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr4502681pfm.254.1537670000586;
        Sat, 22 Sep 2018 19:33:20 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id c79-v6sm3020101pfb.147.2018.09.22.19.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 19:33:19 -0700 (PDT)
Date:   Sun, 23 Sep 2018 12:33:15 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Jonathan Adams <jwadams@google.com>
Cc:     dwmw@amazon.co.uk, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        linux-mm@kvack.org, tglx@linutronix.de, joao.m.martins@oracle.com,
        pradeep.vincent@oracle.com, ak@linux.intel.com,
        khalid.aziz@oracle.com, kanth.ghatraju@oracle.com,
        liran.alon@oracle.com, keescook@google.com,
        jsteckli@os.inf.tu-dresden.de, kernel-hardening@lists.openwall.com,
        chris.hyser@oracle.com, tyhicks@canonical.com,
        john.haxby@oracle.com, jcm@redhat.com
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180923023315.GF8537@350D>
References: <20180820212556.GC2230@char.us.oracle.com>
 <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
 <20180919010337.GC8537@350D>
 <CA+VK+GM6CaPnGKcPjEn7U=4ubtC-JWZ9k98BTxzRH_TthaFXDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+VK+GM6CaPnGKcPjEn7U=4ubtC-JWZ9k98BTxzRH_TthaFXDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 08:43:07AM -0700, Jonathan Adams wrote:
> (apologies again; resending due to formatting issues)
> On Tue, Sep 18, 2018 at 6:03 PM Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Mon, Aug 20, 2018 at 09:52:19PM +0000, Woodhouse, David wrote:
> > > On Mon, 2018-08-20 at 14:48 -0700, Linus Torvalds wrote:
> > > >
> > > > Of course, after the long (and entirely unrelated) discussion about
> > > > the TLB flushing bug we had, I'm starting to worry about my own
> > > > competence, and maybe I'm missing something really fundamental, and
> > > > the XPFO patches do something else than what I think they do, or my
> > > > "hey, let's use our Meltdown code" idea has some fundamental weakness
> > > > that I'm missing.
> > >
> > > The interesting part is taking the user (and other) pages out of the
> > > kernel's 1:1 physmap.
> > >
> > > It's the *kernel* we don't want being able to access those pages,
> > > because of the multitude of unfixable cache load gadgets.
> >
> > I am missing why we need this since the kernel can't access
> > (SMAP) unless we go through to the copy/to/from interface
> > or execute any of the user pages. Is it because of the dependency
> > on the availability of those features?
> >
> SMAP protects against kernel accesses to non-PRIV (i.e. userspace)
> mappings, but that isn't relevant to what's being discussed here.
> 
> Davis is talking about the kernel Direct Map, which is a PRIV (i.e.
> kernel) mapping of all physical memory on the system, at
>   VA = (base + PA).
> Since this mapping exists for all physical addresses, speculative
> load gadgets (and the processor's prefetch mechanism, etc.) can
> load arbitrary data even if it is only otherwise mapped into user
> space.

Load aribtrary data with no permission checks (strict RWX).

> 
> XPFO fixes this by unmapping the Direct Map translations when the
> page is allocated as a user page. The mapping is only restored:
>    1. temporarily if the kernel needs direct access to the page
>       (i.e. to zero it, access it from a device driver, etc),
>    2. when the page is freed
> 
> And in so doing, significantly reduces the amount of non-kernel data
> vulnerable to speculative execution attacks against the kernel.
> (and reduces what data can be loaded into the L1 data cache while
> in kernel mode, to be peeked at by the recent L1 Terminal Fault
> vulnerability).

I see and there is no way for gadgets to invoke this path from
user space to make their speculation successful? We still have to
flush L1, indepenedent of whether XPFO is enabled or not right?

Balbir Singh.

