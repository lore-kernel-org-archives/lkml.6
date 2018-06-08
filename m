Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CrvgJmsEG1vgMgAAmS7hNA
	; Fri, 08 Jun 2018 22:35:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EAD226089E; Fri,  8 Jun 2018 22:35:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A9DF601B4;
	Fri,  8 Jun 2018 22:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A9DF601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeFHWfn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752911AbeFHWfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1C2C30001DB;
        Fri,  8 Jun 2018 22:35:41 +0000 (UTC)
Received: from redhat.com (ovpn-116-62.phx2.redhat.com [10.3.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A449426E56;
        Fri,  8 Jun 2018 22:35:41 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.89)
        (envelope-from <fche@redhat.com>)
        id 1fRPyt-0001XU-ES; Fri, 08 Jun 2018 18:35:39 -0400
Date: Fri, 8 Jun 2018 18:35:39 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: systemtap@sourceware.org
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 3.3 release
Message-ID: <20180608223539.GA29002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 08 Jun 2018 22:35:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 3.3!

  eBPF backend extensions, easier access to examples, adapting to
  meltdown/spectre complications, real-time / high-cpu-count
  concurrency fixes


= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/systemtap-3.3.tar.gz
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-3.3 (commit 48867d1cface944)

  There have been over 237 commits since the last release.
  There have been over 19 bugs fixed / features added since the last release.


= How to build it

  See the README and NEWS files at
  https://sourceware.org/git/?p=systemtap.git;a=tree

  Further information at https://sourceware.org/systemtap/wiki/


= SystemTap frontend (stap) changes

- The "stap --sysroot /PATH" option has received a revamp, so it
  works much better against cross-compiled environments.

- A new "stap --example FOO.stp" mode searches the example scripts
  distributed with systemtap for a file named FOO.stp, so its whole
  path does not need to be typed in.


= SystemTap backend changes

- The eBPF backend now supports uprobes, perf counter, timer, and
  tracepoint probes.

- The eBPF backend has learned to perform loops - at least in the
  userspace "begin/end" probe contexts, so one can iterate across BPF
  arrays for reporting.  (The linux kernel eBPF interpreter precludes
  loops and string processing.)  It can also handle much larger probe
  handler bodies, with a smarter register spiller/allocator.

- Systemtap's runtime has learned to deal with some of the collateral
  damage from kernel hardening after meltdown/spectre, including more
  pointer hiding and relocation.  The kptr_restrict procfs flag is
  forced on if running on a new enough kernel.

- Several low level locking-related fixes were added to the runtime
  that used uprobes/tracepoint apis, in order to work more reliably on
  real-time kernels and on high-cpu-count machines.


= SystemTap tapset changes

- Runtime/tapsets were ported to include up to kernel version 4.17.
  (The syscall tapsets are broken on kernel 4.17-rc, and will be fixed
  in a next release coming soon; PR23160.)

- Some MIPS support has been added.
    

= SystemTap sample scripts

 All 178 examples can be found at https://sourceware.org/systemtap/examples/

- io_submit.stp has been optimized for larger systems

- new example capture_ssl_master_secrets.stp is just as naughty as it sounds


= Examples of tested kernel versions

  2.6.32     (RHEL 6 x86 and x86_64)
  3.10.0     (RHEL 7 x86_64)
  4.16.5     (Fedora 27 x86_64)
  4.18-rc0   (Fedora rawhide x86_64)


= Known issues with this release

- The syscall tapset is broken for kernels >= 4.17.  Use the
  kernel.trace("sys_enter") probe until we get this fixed. (PR23160)

- Some post-meltdown/spectre kernel versions have broken uprobes
  (resulting in SIGILL in userspace programs) and kernel tracepoints.
  Kernel fixes are underway. (RHBZ1579521)

- Some kernel crashes continue to be reported when a script probes
  broad kernel function wildcards.  (PR2725)

- An upstream kernel commit #2062afb4f804a put "-fno-var-tracking-assignments"
  into KCFLAGS, dramatically reducing debuginfo quality, which can cause
  debuginfo failures. The simplest fix is to erase, excise, nay, eradicate
  this line from the top level linux Makefile:
  
  KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)


= Coming soon

- http and systemtap coming together, like peanut butter and chocolate


= Contributors for this release

  Aaron Merey, *Aryeh Weinreb, *Bernhard Wiedemann, David Smith, Frank
  Ch. Eigler, *Gustavo Moreira, *Igor Gnatenko, *Iryna Shcherbina, *Jafeer
  Uddin, Jeff Moyer, *Lukas Herbolt, Mark Wielaard, Martin Cermak, *Petr
  Viktorin, Serhei Makarov, Stan Cox, Stefan Hajnoczi, Timo Juhani
  Lindfors, Victor Kamensky

  Special thanks to new contributors, marked with '*' above.


= Bugs fixed for this release <https://sourceware.org/PR#####>

  21107   a few more access_ok tweaks needed      
  21890   bpf uprobes support   
  22004   dyninst does not handle R_*_IRELATIV in .rela.plt       
  22141   The RPM specfile needs an update handling the bpf bits  
  22248   failure processing linux-vdso64.so.1    
  22311   bpf: drop the copy of the bpf map logic & snapshot-based pre-post begin {} synch        
  22313   bpf: exit-state checking prologue  
  22314   bpf: add support for uprobes, uretprobe and tracepoint events   
  22323   bpf: format string tags appearing in output when wildcards are used     
  22327   the loadavg tapset no longer works on recent kernels       
  22328   bpf: add timer probes                   
  22462   quoted include path  
  22536   Add shorthand option --bpf for --runtime=bpf    
  22551   on rawhide, we're getting a compile error that init_timer() doesn't exist       
  22695   "make rpm" broken by commit 3128ca27f67476fdd5f26a44bc3809fa8396e749    
  22698   bpf translator: add support for array $context variables        
  22822   bpf translator lacks register spilling         
  22857   vfs.do_mpage_readpage doesn't work as expected on ext4 filesystems  
  23226   stap foo.stp should search a path for sample foo.stp
