Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeBFHTp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:19:45 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52975 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFHTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:19:37 -0500
X-Google-Smtp-Source: AH8x227nvqaNHbnC9Y1PLOiy033KK7Eipzkk2SZ6Jn3/JPrpY2vppRgy3zXtsl6OH4HNviDZNZNrmA==
Date: Tue, 6 Feb 2018 08:19:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, luto@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
Message-ID: <20180206071933.3rbyglzndtsxcu47@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205114250.zd3nbe5yl2mnd54m@gmail.com>
 <20180205155837.GK30338@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205155837.GK30338@tassilo.jf.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@linux.intel.com> wrote:

> >      - There's various conditional pieces of entry code that run before any 
> >        RBP-clobbering C function is called. While none of them has an exploitable 
> >        Spectre 'gadget' at the moment, we'd have to consider this for every future
> >        change.
> 
> The Frame Pointer is always set up in assembler too, just in another macro.

As I replied to Andy, that's not universally true: there are code paths where RBP 
is not set before calling C code or going into the more complex parts of the 
kernel entry code.

This RBP value leak in fact demonstrates the validity of my robustness argument:

> >   I.e. we cannot universally rely on RBP being sanitized. In _practice_ it 
> >   will be sanitized, but we don't know for sure without expending quite some 
> >   effort to think through all the cases.

Thanks,

	Ingo
