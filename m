Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9231BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E962174E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ebpkwQPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E962174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeHUBxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:53:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37264 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:53:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8-v6so1032690pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZQbG4V4EedqTpURBgPf/kOwUVXopT/oElfUNJde8eo=;
        b=ebpkwQPofxwxky3IRFL/M1DHb99ljilCxMi5CnjsxImO3Nduyx/bM9e+jZjyLtHARl
         f3Ylq8K0Uvos1IdcIRBGhi4Fwa5SHkXWWaDVH3AsjF5Op7P7/LWHfCrvMncPF6digYbO
         lsHUxLKvlVZd7lEC/epMTiunlV7mUAIU3Zo348lcb9F+XDpBFfj59x8Hzts5SwOk6WPj
         Pt82m8w/mXVOAAONmKieS/hyhpgavXIzF57t2ZlHYhpzciihNcZ9Gla81ZmsPr9Xock3
         YDbhC/VrOsb6ayrHvDziIyRaxdG1n4TBNrMEgWlNXsp57sKcm+jOyQwUvTAk2DR0Kfgg
         2LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZQbG4V4EedqTpURBgPf/kOwUVXopT/oElfUNJde8eo=;
        b=B0S94oP4Fj7zD7E5mqN+KpSJhb3TlVA/JybuTbvcoGptI00dV8KMO1aj4NcaDFf1CY
         wtACo9SoXTZFT64iyM4Uj2EhN0ylI1yZagsx3OlDgbGfBaMoA72voQm70QXlNh5Qj2Kb
         QT/bH5sKdB8XbP895uOP5tAb9heZgfUbVe8WkPGflgonF/iZ7v+QXs3TmQGlSpP6HN0I
         2jPiCUSLQBUX7PbDujYL2yzOEzYoLf8M4LmHF2DUe4EO9Lur+GtuHKfvJU7rc0uELM8i
         ud7cliCJLerrXQg44t3bF/qy8Rhkm0IAzVxG1Seu86WmezCWFAL8lS7hRUyQMIkLSK0w
         jMFg==
X-Gm-Message-State: AOUpUlGrT5CXR/uNBflr934HtGzYuMmcvOpz5aMGzHZFbjDxSGbEjgW/
        qY2BH1drAaL+hatAQAsBV9nOng==
X-Google-Smtp-Source: AA+uWPw6c+K2QssPhel4hIOv3517AHbmgEmr7t1cdiFfdh5z+G5WM16iusdTvvaUcJUpj1CT1nUpkw==
X-Received: by 2002:a63:db4f:: with SMTP id x15-v6mr44065083pgi.214.1534804561018;
        Mon, 20 Aug 2018 15:36:01 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.175])
        by smtp.gmail.com with ESMTPSA id p3-v6sm14720635pfo.130.2018.08.20.15.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:36:00 -0700 (PDT)
Date:   Mon, 20 Aug 2018 16:35:57 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>, jsteckli@os.inf.tu-dresden.de,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180820223557.GC16961@cisco.cisco.com>
References: <20180820212556.GC2230@char.us.oracle.com>
 <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
 <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 03:27:52PM -0700, Linus Torvalds wrote:
> On Mon, Aug 20, 2018 at 3:02 PM Woodhouse, David <dwmw@amazon.co.uk> wrote:
> >
> > It's the *kernel* we don't want being able to access those pages,
> > because of the multitude of unfixable cache load gadgets.
> 
> Ahh.
> 
> I guess the proof is in the pudding. Did somebody try to forward-port
> that patch set and see what the performance is like?
> 
> It used to be just 500 LOC. Was that because they took horrible
> shortcuts? Are the performance numbers for the 32-bit case that
> already had the kmap() overhead?

The last version I worked on was a bit before Meltdown was public:
https://lkml.org/lkml/2017/9/7/445

The overhead was a lot, but Dave Hansen gave some ideas about how to
speed things up in this thread: https://lkml.org/lkml/2017/9/20/828

Since meltdown hit, I haven't worked seriously on understand and
implementing his suggestions, in part because it wasn't clear to me
what pieces of the infrastructure we might be able to re-use. Someone
who knows more about mm/ might be able to suggest an approach, though.

Tycho
