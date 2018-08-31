Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221FCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F532083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lWNFfQOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F532083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeHaTeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:34:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46450 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaTeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:34:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id a4-v6so5611161plm.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oa1MYnvIVs5eN0iARHFkVOWqEL0gw+jh924JQVDEW4k=;
        b=lWNFfQOpsVNBLLjXGY6QyabHPi9r3F4Jf/sg27TSHSuWi/m3cnIHeI+AL00iLyoI7D
         PYwHkslQrBTTk6Cndw/RbIhXhCV87gWJgvFzNjKMOKKydE7pyATSw91sCAXVcYKOmXnq
         2hUJZrcAfMY8VV3JzY9BKMXEuVTjqmXcx5GblK7jm1ZiAwC8oCH2Nb6sF1f6p1uMyq6r
         NceHK6rBy9O4d5BVXOR2vURMh9Gxs36hCrPi41r7Dr9iVhcQ2ulxVL/TDOxUIqMjSa14
         mhyy3dYv7Ec5xuNr3D9qyamsShVOar9COslggB2C2NFhsh8TKRofjT6kJ5/By8xan2AH
         HKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oa1MYnvIVs5eN0iARHFkVOWqEL0gw+jh924JQVDEW4k=;
        b=uPXvgh7VqGwn4ZVtflTpKKk4c1tfSCdY75esrZU76JeBiUu6pCX+ddpv2S+7wcu97R
         sVn2UiX2Vusb7JWzVZrN1biZQDD2t/1guSU8OFYdyLmmDHeM1uHbxXXD07sIEogmVoOM
         nbooelnB3Mzn+l44+Ze9s4ZPqsg2PN4YLomNQ6gBcRQlh52PodQzuN2Vclim1sCQ1q35
         3VYG2Ipl/tKV5e8jeW3FioTBqdD14Uys36YLr8HtCmVqGKKrn3fsJblx6hBFbtdtdSMF
         zEdqxSJPZMp3NyH6v91R7M2cCZJPciSmKJzia0XGAwr9SKgg/IGBErBh4lP+hU9Rt8x4
         7BOg==
X-Gm-Message-State: APzg51B2psXGvqrOnhC5uBkJWZRucubmfPD9WnL8Xk8MMFPxVbNunbiS
        4D4xT2LRjRqsdj2HjmolJtG5Rw==
X-Google-Smtp-Source: ANB0VdZ0L1yrHqu0SjZ73JtSLcs4QTHGGeCCAP8dUcBHCFUKqrelQtW+WQouiBIzC4w1TanC0rUETw==
X-Received: by 2002:a17:902:286a:: with SMTP id e97-v6mr16108570plb.340.1535729209826;
        Fri, 31 Aug 2018 08:26:49 -0700 (PDT)
Received: from cisco.cisco.com ([208.181.116.45])
        by smtp.gmail.com with ESMTPSA id a20-v6sm27978820pfc.14.2018.08.31.08.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:26:48 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:26:47 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
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
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180831152647.GC15213@cisco.cisco.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 06:00:51PM +0200, Julian Stecklina wrote:
> Hey everyone,
> 
> On Mon, 20 Aug 2018 15:27 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Mon, Aug 20, 2018 at 3:02 PM Woodhouse, David <dwmw@amazon.co.uk> wrote:
> >>
> >> It's the *kernel* we don't want being able to access those pages,
> >> because of the multitude of unfixable cache load gadgets.
> >
> > Ahh.
> > 
> > I guess the proof is in the pudding. Did somebody try to forward-port
> > that patch set and see what the performance is like?
> 
> I've been spending some cycles on the XPFO patch set this week. For the
> patch set as it was posted for v4.13, the performance overhead of
> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
> completely from TLB flushing. If we can live with stale TLB entries
> allowing temporary access (which I think is reasonable), we can remove
> all TLB flushing (on x86). This reduces the overhead to 2-3% for
> kernel compile.

Cool, thanks for doing this! Do you have any thoughts about what the
2-3% is? It seems to me like if we're not doing the TLB flushes, the
rest of this should be *really* cheap, even cheaper than 2-3%. Dave
Hansen had suggested coalescing things on a per mapping basis vs.
doing it per page, which might help?

> > It used to be just 500 LOC. Was that because they took horrible
> > shortcuts?
> 
> The patch is still fairly small. As for the horrible shortcuts, I let
> others comment on that.

Heh, things like xpfo_temp_map() aren't awesome, but that can
hopefully be fixed by keeping a little bit of memory around for use
where we are mapping things and can't fail. I remember some discussion
about hopefully not having to sprinkle xpfo mapping calls everywhere
in the kernel, so perhaps we could get rid of it entirely?

Anyway, I'm working on some other stuff for the kernel right now, but
I hope (:D) that it should be close to done, and I'll have more cycles
to work on this soon too.

Tycho
