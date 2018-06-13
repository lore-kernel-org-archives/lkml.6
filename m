Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0586C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C53A20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWHMNP+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53A20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935476AbeFMLwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:52:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36767 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFMLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:52:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so1412979plp.3;
        Wed, 13 Jun 2018 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHP63akbmOCK9w66nTvtTr+3CBGZxOtuokziagq9pH0=;
        b=lWHMNP+lP4YbgUPaGysFv5pOZjA4I5OgSSHB0o+32Zi1X78g3qiRBQXlmoUl/11ocb
         UCk5x2XE8RZJ7oui6V01UxCQhz+m8FQ4wuWAv47uKFd1Wkm50cn/oMXBgNA2BFXLUltL
         8Drv2qVLV93HG0IkeHI/2Zr3yEzyinaU8T28XexVRIw4aWK2t9PgZmebwEGIhZf3PNpj
         VQBHjmh0rMEKf+z3uzvSZZ7D5jVaz868s7dW3tfcROa+RCLAzOidJ7xx16G5FI5x93a3
         vCQaRAjVoIcqNRzxKSGFPKQ2lQEJadjw1fCxysfQFhgp7TkxtU4LAW/yngcWWockOCb+
         DupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHP63akbmOCK9w66nTvtTr+3CBGZxOtuokziagq9pH0=;
        b=kVTpjo0e6WyUhPmAZzdYSiWLM4nL4LVGF7M4qdSin8sFtlPfYsWhDJ62zAn+rkPRh/
         UFBgBYYYY5eg3sIg+9xvXKuwugZHkoDolXHXqnbwfBlahAQScWq+E6ZyQa6UkJDDoLgK
         qbq7SggnmIBUuCX0nF9TXtvuevI2QLMaw9iJmu06zKP45933pltQNx+W3iR4ZCsP0Li/
         8eU3cEdC3UX6k6LezlJvdGztA3GQ+NIpPfFC6GR8ZXQQPy1OMZfe7prACTHwNDb7oT34
         QIR3S3v/0FyRTk8Z0AIrekrddAENm0BiK58DnPNVhCH8npm+rAmjB+dXRlBJZwnQidYK
         BRPg==
X-Gm-Message-State: APt69E2Ea7nU5cYWrGR/LPi7dZ7spKjEm+isBhmCB0K1HLPizHbrPKaF
        sIPRmCAvXWys6QXNjEFlKBE=
X-Google-Smtp-Source: ADUXVKKfKLUJeln14IJPr8LP5+xHb/HEA5Ma638m6hsmordyQEbAcnkzP9y43aJ4Dd2G22ch5SwkWA==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr4826342plp.333.1528890759307;
        Wed, 13 Jun 2018 04:52:39 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id e192-v6sm3917039pfg.187.2018.06.13.04.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 04:52:38 -0700 (PDT)
Date:   Wed, 13 Jun 2018 21:52:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
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
Message-ID: <20180613215225.2a938abc@roar.ozlabs.ibm.com>
In-Reply-To: <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
        <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
        <20180613084219.GT12258@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1806131121180.2280@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 11:26:49 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 13 Jun 2018, Peter Zijlstra wrote:
> > On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:  
> > > On Tue, 12 Jun 2018 17:57:32 -0700
> > > Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > >   
> > > > Instead of exposing individual functions for the operations of the NMI
> > > > watchdog, define a common interface that can be used across multiple
> > > > implementations.
> > > > 
> > > > The struct nmi_watchdog_ops is defined for such operations. These initial
> > > > definitions include the enable, disable, start, stop, and cleanup
> > > > operations.
> > > > 
> > > > Only a single NMI watchdog can be used in the system. The operations of
> > > > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > > > variable is set to point the operations of the first NMI watchdog that
> > > > initializes successfully. Even though at this moment, the only available
> > > > NMI watchdog is the perf-based hardlockup detector. More implementations
> > > > can be added in the future.  
> > > 
> > > Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> > > least have their own NMI watchdogs, it would be good to have those
> > > converted as well.  
> > 
> > Yeah, agreed, this looks like half a patch.  
> 
> Though I'm not seeing the advantage of it. That kind of NMI watchdogs are
> low level architecture details so having yet another 'ops' data structure
> with a gazillion of callbacks, checks and indirections does not provide
> value over the currently available weak stubs.

The other way to go of course is librify the perf watchdog and make an
x86 watchdog that selects between perf and hpet... I also probably
prefer that for code such as this, but I wouldn't strongly object to
ops struct if I'm not writing the code. It's not that bad is it?

Thanks,
Nick
