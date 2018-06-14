Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 255AAC004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F7A208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 02:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3BSInzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F7A208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935881AbeFNCdG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 22:33:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33820 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935733AbeFNCdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 22:33:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so2630985plq.1;
        Wed, 13 Jun 2018 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smQU4EQTLkyP63nnvVxUj5b50yax0oHX4P4ovYhPzfI=;
        b=X3BSInznjRYvgeDEh56a3bpU29nnBQ2QR5ElWdshrXDnh2DX162IC8wLCXonakFGaw
         yfgTBfLnDe37JDka2Pz4v2FtdVlr4G2t3cF/FIwVJv+d1UkEUJIOTEPX3QSfjdhHRYHF
         9vgghxlTfeGT2ztny/B3gkFyYZc4koawIIyOWVDy65U0OfXKPkJhZOc4JeQUIoEEjCoa
         0EMqzkDAkihuX+tUAruZ36oE9kvLhXExMIsBNPB3i8KOZFKpj9D5zR5o/jX/ExkzDv4T
         qrg7ikdv+NFQrZQEbPvZ5oYUEg/raCqXuZgMnyc/4lOadaAeNckLCkDvSfBBCamrMKu6
         /MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smQU4EQTLkyP63nnvVxUj5b50yax0oHX4P4ovYhPzfI=;
        b=Kh+dXAaS8l9L3wAstk4Jkac13apvS52ZGPZOsJsNpaoNLxEdzpPS7GZ1tv+RA1cj89
         gtTWzcRXvPPP9qNOr/azdf737lBUoBXczty3NZ5pqqoh/iDHjuHMrw7s9pt1ychQW/pH
         7EXtuzqO3+6nC5F/gOxaS2w+FdiGdfzqbzv7qbLPYMeh5QdrWrw3CIODcBeij1Gb2z7f
         Pza55J5UL88n1NVDiWmIBo3TLFMmntyZI579MUU7mw38XAqeT0zrrtZNx08K18z1d6E/
         aDiZwT1UAcn6eSw2KNigyRWL2upoTCiAImQcigpGi+UoRZN3dEkX4bmhD/ocLtmqS0Zv
         sNHw==
X-Gm-Message-State: APt69E1Qg8lW4WMVK5Vio/NlgtzAMhicXNWccXNzwjaDQa4jNqcEQqNl
        WciUCWQgC/4JtDz/18KhJDw=
X-Google-Smtp-Source: ADUXVKIqSHcezWECcGFKdiM3sPuw6Lzzv/i9H/zpzjoOEKjh6OUcI+3UeiANkOusoIK8Jdcfb5sX7Q==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr793201plb.295.1528943584713;
        Wed, 13 Jun 2018 19:33:04 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id h84-v6sm5974853pfd.69.2018.06.13.19.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 19:33:03 -0700 (PDT)
Date:   Thu, 14 Jun 2018 12:32:50 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
Message-ID: <20180614123250.230667f6@roar.ozlabs.ibm.com>
In-Reply-To: <20180614013117.GC22652@voyager>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
        <20180613084219.GT12258@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
        <20180613215225.2a938abc@roar.ozlabs.ibm.com>
        <20180614013117.GC22652@voyager>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 18:31:17 -0700
Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:

> On Wed, Jun 13, 2018 at 09:52:25PM +1000, Nicholas Piggin wrote:
> > On Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >   
> > > On Wed, 13 Jun 2018, Peter Zijlstra wrote:  
> > > > On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:    
> > > > > On Tue, 12 Jun 2018 17:57:32 -0700
> > > > > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > > > >     
> > > > > > Instead of exposing individual functions for the operations of the NMI
> > > > > > watchdog, define a common interface that can be used across multiple
> > > > > > implementations.
> > > > > > 
> > > > > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > > > > definitions include the enable, disable, start, stop, and cleanup
> > > > > > operations.
> > > > > > 
> > > > > > Only a single NMI watchdog can be used in the system. The operations of
> > > > > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > > > > variable is set to point the operations of the first NMI watchdog that
> > > > > > initializes successfully. Even though at this moment, the only available
> > > > > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > > > > can be added in the future.    
> > > > > 
> > > > > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > > > > least have their own NMI watchdogs, it would be good to have those
> > > > > converted as well.    
> > > > 
> > > > Yeah, agreed, this looks like half a patch.    
> > > 
> > > Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
> > > low level architecture details so having yet another 'ops' data structure
> > > with a gazillion of callbacks, checks and indirections does not provide
> > > value over the currently available weak stubs.  
> > 
> > The other way to go of course is librify the perf watchdog and make an
> > x86 watchdog that selects between perf and hpet... I also probably
> > prefer that for code such as this, but I wouldn't strongly object to
> > ops struct if I'm not writing the code. It's not that bad is it?  
> 
> My motivation to add the ops was that the hpet and perf watchdog share
> significant portions of code.

Right, a good motivation.

> I could look into creating the library for
> common code and relocate the hpet watchdog into arch/x86 for the hpet-
> specific parts.

If you can investigate that approach, that would be appreciated. I hope
I did not misunderstand you there, Thomas.

Basically you would have perf infrastructure and hpet infrastructure,
and then the x86 watchdog driver will use one or the other of those. The
generic watchdog driver will be just a simple shim that uses the perf
infrastructure. Then hopefully the powerpc driver would require almost
no change.

Thanks,
Nick
