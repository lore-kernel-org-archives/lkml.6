Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B6C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 05:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D0C218E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 05:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0MCAvXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D0C218E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHKI16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 04:27:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38687 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHKI16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 04:27:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so5306057pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 22:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJQTjyw7C/Rn0yK9V/daxdTjipBgHq3qYkne2SKS9MA=;
        b=S0MCAvXCxzH9PH+7lMENYxcjJ2coykviiRynbNVP1Zq7/z3eYvbFx78AN55ll+umHo
         6zKjO5K/lXENZ3gqJcmEdUG+ZoU4evwgGmxJtdwQS4UpzxxW/kr2kmclY8WnctrytQEx
         urpv+oIyNXhRh2Ccwb74eb9eFGnTMeNx6jNDatyoTu81pCCHnAtgcMdCBU6WpYXrM3dE
         G+n2FaeXwjqikaKKu+ipBe1ho54GV5Io3JR1lNejbTxkFPOSiBORWC6l8ZL9tqc3ota5
         6rWY5oOVMvx9f0ZFfXV3Ui9jcOCyCFM3hnmSIvka7f9LEdG5pWthZitnCDQjwWQBlLCX
         sgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJQTjyw7C/Rn0yK9V/daxdTjipBgHq3qYkne2SKS9MA=;
        b=KMCE/UqzfnZVhBvThZ1Rhqv96pl6HNMN8pPZJ/tEdCiwVPOwhsO+boZPQSG6Fey66n
         vdDGnyQFUBKxzQJvPxb1egh5Nz3xf15siOxLdqhxGdsjFuBaNHGqlzXxpr7ptynusZwD
         y1j2nr8n509egKxZvsGtjwnXscQTDeeb1p+CNbO8vjeVV/hSkUBC2taYWU2hPjpfsFnp
         42P1HJyi6C2bDn+lRqJJEDBP5+2AZK2lGefgVootNonA/rSvj5TWkcv1dZeXxdv2LP6A
         2ja0i+usv4FT06mTBATlwzMJVrw+ScfxEJn6L0TVJGrFWVW0Gm7nTn7ExgwhXVbfzNv5
         c6/A==
X-Gm-Message-State: AOUpUlGBjJHQGmTD3CJ21rXlVgv+3oGTHZhP3BEBdP+IFya7OrduwxJv
        AXs0RAuAwpvW7R0KKm8FpuTOmlZb
X-Google-Smtp-Source: AA+uWPyO7SFjmtBDnx+fxC2TUn1Mg4CekLKDlkb6iXAJBe4zTCA6OR1wvFd64rOi/Fm3/GFY65Gn3w==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr9107940pge.324.1533966897224;
        Fri, 10 Aug 2018 22:54:57 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (123-243-222-142.tpgi.com.au. [123.243.222.142])
        by smtp.gmail.com with ESMTPSA id d19-v6sm35834209pfe.42.2018.08.10.22.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 22:54:56 -0700 (PDT)
Date:   Sat, 11 Aug 2018 15:54:49 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org,
        huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore
 sprs using opal
Message-ID: <20180811155449.020de1e8@roar.ozlabs.ibm.com>
In-Reply-To: <20180808154116.GA31919@in.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
 <20180803000547.08a37175@roar.ozlabs.ibm.com>
 <20180808154116.GA31919@in.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 21:11:16 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Fri, Aug 03, 2018 at 12:05:47AM +1000, Nicholas Piggin wrote:
> > On Thu,  2 Aug 2018 10:21:32 +0530
> > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> >   
> > > From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> > > 
> > > If a state has "opal-supported" compat flag in device-tree, an opal call
> > > needs to be made during the entry and exit of the stop state. This patch
> > > passes a hint to the power9_idle_stop and power9_offline_stop.
> > > 
> > > This patch moves the saving and restoring of sprs for P9 cpuidle
> > > from kernel to opal. This patch still uses existing code to detect
> > > first thread in core.
> > > In an attempt to make the powernv idle code backward compatible,
> > > and to some extent forward compatible, add support for pre-stop entry
> > > and post-stop exit actions in OPAL. If a kernel knows about this
> > > opal call, then just a firmware supporting newer hardware is required,
> > > instead of waiting for kernel updates.  
> > 
> > Still think we should make these do-everything calls. Including
> > executing nap/stop instructions, restoring timebase, possibly even
> > saving and restoring SLB (although a return code could be used to
> > tell the kernel to do that maybe if performance advantage is  
> enough).
> 
> So, if we execute the stop instruction in opal, the wakeup from stop
> still happens at the hypervisor 0x100. On wake up, we need to check
> SRR1 to see if we have lost state, in which case, the stop exit also
> needs to be handled inside opal.

Yes. That's okay, SRR1 seems to be pretty well architected.

> On return from this opal call, we
> need to unwind the extra stack frame that would have been created when
> kernel entered opal to execute the stop from which there was no
> return. In the case where a lossy stop state was requested, but wakeup
> happened from a lossless stop state, this adds additional overhead.

True, but you're going from 1 OPAL call to 2. So you still have that
overhead. Although possibly we could implement some special light
weight stackless calls (I'm thinking about doing that for MCE handling
too). Or you could perhaps just discard the stack without needing to
unwind anything in the case of a lossless wakeup.

> 
> Furthermore, the measurements show that the additional time taken to
> perform the restore of the resources in OPAL vs doing so in Kernel on
> wakeup from stop takes additional 5-10us. For the current stop states
> that lose hypervisor state, since the latency is relatively high (100s
> of us), this is a relatively small penalty (~1%) .

Yeah OPAL is pretty heavy to enter. We can improve that a bit. But
yes for P10 timeframe it may be still heavy weight.

> 
> However, in future if we do have states that lose only a part of
> hypervisor state to provide a wakeup latency in the order of few tens
> of microseconds the additional latency caused by OPAL call would
> become noticable, no ?

I think so long as we can do shallow states in Linux it really won't
be that big a deal (even if we don't do any of the above speedup
tricks).

I think it's really desirable to have a complete firmware
implementation. Having this compromise seems like the worst of both
in a way (does not allow firmware to control everything, and does
not have great performance).

> 
> 	
> > 
> > I haven't had a lot of time to go through it, I'm working on moving
> > ~all of idle_book3s.S to C code, I'd like to do that before this
> > OPAL idle driver if possible.
> > 
> > A minor thing I just noticed, you don't have to allocate the opal
> > spr save space in Linux, just do it all in OPAL.  
> 
> The idea was to not leave any state in OPAL, as OPAL is supposed to be
> state-less. However, I agree, that if OPAL is not going to interpret
> the contents of the save/area, it should be harmless to move that bit
> into OPAL.
> 
> That said, if we are going to add the logic of determining the first
> thread in the core waking up, etc, then we have no choice but to
> maintain that state in OPAL.

I don't think it's such a problem for particular very carefully
defined cases like this.

Thanks,
Nick
