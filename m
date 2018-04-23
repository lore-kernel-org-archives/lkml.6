Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755495AbeDWOzn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755198AbeDWOzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:55:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A7C2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 11:55:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: valdis.kletnieks@vt.edu, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: next-20180416 - warnings from 'make tools/perf'
Message-ID: <20180423145537.GJ30324@kernel.org>
References: <61890.1524462741@turing-police.cc.vt.edu>
 <20180423065204.cgzu7mvivrph3gfw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423065204.cgzu7mvivrph3gfw@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 23, 2018 at 08:52:04AM +0200, Ingo Molnar escreveu:
> 
> * valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu> wrote:
> 
> > Seeing these warnings.  'diff' tells me that the files
> > are in fact significantly different.
> > 
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
> > Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
> > Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
> > Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
> > Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'
> 
> The warnings are harmless, and they should be fixed in v4.17-rc2.

Yeah, its just a way for us to get warned that new APIs were introduced,
so we need to check if changes are needed in the tools, sometimes those
changes take place automagically when we update the copies we have.

We're not expecting or asking anybody to care about tools/ when doing
changes in kernel headers that we have copies, that would possibly annoy
kernel developers and we want to keep them super happy and productive
:-)

- Arnaldo
