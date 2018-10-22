Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C884AECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B18205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzI9XHoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B18205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJVPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJVPtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:49:45 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D31205F4;
        Mon, 22 Oct 2018 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540193546;
        bh=e6tVQurbrJtUDSp6ciN+OZW2oeBfW62V+qrfafX7o50=;
        h=Date:From:To:Cc:Subject:From;
        b=mzI9XHoFhPHC0mnQ2RhPks6iiXOYt78pwkwQ4ggD545V0z/Ws4cK3S/PBNKAd+o3w
         fpkfKdxGV3u+iIscl6bg+Q4qRfNhthoAqVRuR9UhT1szdK3WILPkHEtTquBqzfhAAL
         xxkqKM8lU1CGYS8eM4yUS9VbEzwcHC4VYzrOuSEU=
Date:   Mon, 22 Oct 2018 08:32:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Linux 4.19
Message-ID: <20181022073224.GA5658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!

It's been a long strange journey for this kernel release...

While it was not the largest kernel release every by number of commits,
it was larger than the last 3 releases, which is a non-trivial thing to
do.  After the original -rc1 bumps, things settled down on the code side
and it looks like stuff came nicely together to make a solid kernel for
everyone to use for a while.  And given that this is going to be one of
the "Long Term" kernels I end up maintaining for a few years, that's
good news for everyone.

A small trickle of good bugfixes came in this week, showing that waiting
an extra week was a wise choice.  However odds are that linux-next is
just bursting so the next -rc1 merge window is going to be bigger than
"normal", if there is such a thing as "normal" for our rate of
development.

And speaking of development, there's that other thing that happened this
release cycle, that ended up making it such that I'm the one writing
this instead of Linus.  Allow me the guilty pleasure of taking a few
minutes to talk about that....

I've been giving my "How the kernel is developed" talk all around the
world for over a decade now.  After the first year or so, I was amazed
that it kept needing to be given as surely everyone knew how we did this
type of thing, right?  But my wife, someone much smarter than I, then
told me, "Every year there is a new kindergarten class."

And we all need to remember that, every year new people enter our
community with the goal, or requirement, to get stuff done for their
job, their hobby, or just because they want to help contribute to the
tool that has taken over the world and enabled everyone to have a solid
operating system base on which to build their dreams.

And when they come into our community, they don't have the built-in
knowledge of years of experience that thousands of us already do.
Without that experience they make mistakes and fumble and have to learn
how this all works.  Part of learning how things work is dealing with
the interaction between people, and trying to understand the basic
social norms and goals that we all share.  By providing a document in
the kernel source tree that shows that all people, developers and
maintainers alike, will be treated with respect and dignity while
working together, we help to create a more welcome community to those
newcomers, which our very future depends on if we all wish to see this
project succeed at its goals.

And that goal we all share is the key here.  We _ALL_ want to create the
best kernel that we possibly can.  We can disagree on lots of different
things in other parts of our lives, but we do share this one thing.  And
we should focus on that shared goal as it has pulled us all together in
a way that has enabled us to create something that no other company or
group of people has ever been able to accomplish.

We used to joke that our goal was "Total World Domination", but it
really wasn't a joke.  We achieved that goal, Linux really does rule the
world.  All companies use it, contribute to it, and it has ended up
making the world a much better place because of all of us working on it.

In these talks I give, I also say that "the only thing that can stop us
is ourselves, it is up to us to mess this up."  And that's truer now
than when I first started saying that a decade ago.  There is no other
operating system out there that competes against us at this time.  It
would be nice to have something to compete against, as competition is
good, and that drives us to do better, but we can live with this
situation for the moment :)

These past few months has been a tough one for our community, as it is
our community that is fighting from within itself, with prodding from
others outside of it.  Don't fall into the cycle of arguing about those
"others" in the "Judean People's Front" when we are the "We're the
People's Front of Judea!"  That is the trap that countless communities
have fallen into over the centuries.  We all share the same goal, let us
never loose sight of that.

So here is my plea to everyone out there.  Let's take a day or two off,
rest, relax with friends by sharing a meal, recharge, and then get back
to work, to help continue to create a system that the world has never
seen the likes of, together.

Personally, I'm going to take my own advice.  I'll be enjoying this week
in Edinburgh with many other kernel developers, drinking some good
whiskey, and taking some time off of reading email, by spending it with
the great friends I have made in this community.

And with that, Linus, I'm handing the kernel tree back to you.  You can
have the joy of dealing with the merge window :)

thanks,

greg k-h

P.S. Here's the shortlog from 4.19-rc8 to 4.19 for those that like
     looking at those things:


Ake Koomsin (1):
      virtio_net: avoid using netif_tx_disable() for serializing tx routine

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Alan Stern (1):
      USB: fix the usbfs flag sanitization for control transfers

Alexei Starovoitov (1):
      net/xfrm: fix out-of-bounds packet access

Andy Lutomirski (1):
      x86/entry/64: Further improve paranoid_entry comments

Arnaldo Carvalho de Melo (3):
      tools arch uapi: Sync the x86 kvm.h copy
      tools headers uapi: Sync kvm.h copy
      perf tools: Stop fallbacking to kallsyms for vdso symbols lookup

Björn Töpel (1):
      xsk: do not call synchronize_net() under RCU read lock

Boris Brezillon (1):
      drm/sun4i: Fix an ulong overflow in the dotclock driver

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting

Chris Mason (1):
      Code of conduct: Fix wording around maintainers enforcing the code of conduct

Christoph Hellwig (2):
      LICENSES: Remove CC-BY-SA-4.0 license text
      x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels

Clint Taylor (1):
      drm/edid: VSDB yCBCr420 Deep Color mode bit definitions

Colin Ian King (1):
      qed: fix spelling mistake "Ireelevant" -> "Irrelevant"

Cong Wang (1):
      llc: set SOCK_RCU_FREE in llc_sap_add_socket()

Dan Carpenter (1):
      sparc: vDSO: Silence an uninitialized variable warning

Dave Hansen (1):
      x86/entry: Add some paranoid entry/exit CR3 handling comments

David Ahern (1):
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

David Howells (5):
      afs: Fix clearance of reply
      rxrpc: Fix an uninitialised variable
      rxrpc: Fix incorrect conditional on IPV6
      rxrpc: Fix a missing rxrpc_put_peer() in the error_report handler
      fscache: Fix incomplete initialisation of inline key space

David Miller (1):
      perf cpu_map: Align cpu map synthesized events properly.

David S. Miller (9):
      sparc: Wire up io_pgetevents system call.
      sparc: Fix single-pcr perf event counter management.
      sparc: Throttle perf events properly.
      sparc64: Make proc_id signed.
      sparc64: Set %l4 properly on trap return after handling signals.
      Revert "sparc: Convert to using %pOFn instead of device_node.name"
      sparc: Fix syscall fallback bugs in VDSO.
      sparc: Revert unintended perf changes.
      Revert "bond: take rcu lock in netpoll_send_skb_on_dev"

Davide Caratti (1):
      net/sched: cls_api: add missing validation of netlink attributes

Dimitris Michailidis (1):
      net: fix pskb_trim_rcsum_slow() with odd trim offset

Eric Dumazet (2):
      bpf: do not blindly change rlimit in reuseport net selftest
      ipv6: mcast: fix a use-after-free in inet6_mc_check

Eric Sandeen (1):
      fscache: Fix out of bound read in long cookie keys

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests

Florian Fainelli (1):
      net: bcmgenet: Poll internal PHY for GENETv5

Florian Westphal (1):
      xfrm: policy: use hlist rcu variants on insert

Fugang Duan (1):
      net: fec: don't dump RX FIFO register when not available

Greg Kroah-Hartman (7):
      Code of Conduct Interpretation: Add document explaining how the Code of Conduct is to be interpreted
      Code of Conduct Interpretation: Properly reference the TAB correctly
      Code of Conduct: Provide links between the two documents
      Code of Conduct Interpretation: Put in the proper URL for the committee
      Code of Conduct: Change the contact email address
      MAINTAINERS: Add an entry for the code of conduct
      Linux 4.19

Gregory CLEMENT (1):
      net: mscc: ocelot: Fix comment in ocelot_vlant_wait_for_completion()

Gustavo A. R. Silva (4):
      IB/ucm: Fix Spectre v1 vulnerability
      RDMA/ucma: Fix Spectre v1 vulnerability
      usb: gadget: storage: Fix Spectre v1 vulnerability
      ptp: fix Spectre v1 vulnerability

Heikki Krogerus (1):
      usb: xhci: pci: Enable Intel USB role mux on Apollo Lake platforms

Heiner Kallweit (2):
      r8169: re-enable MSI-X on RTL8168g
      r8169: fix NAPI handling under high load

Helge Deller (1):
      parisc: Fix uninitialized variable usage in unwind.c

Huy Nguyen (1):
      net/mlx5: Take only bit 24-26 of wqe.pftype_wq for page fault type

Ido Schimmel (1):
      mlxsw: core: Fix use-after-free when flashing firmware during init

Jan Kiszka (1):
      x86/entry/32: Clear the CS high bits

Jarod Wilson (1):
      perf tools: Fix use of alternatives to find JDIR

Jian-Hong Pan (1):
      r8169: Enable MSI-X on RTL8106e

Jiri Olsa (5):
      Revert "perf tools: Fix PMU term format max value calculation"
      perf vendor events intel: Fix wrong filter_band* values for uncore events
      perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
      perf tools: Fix tracing_path_mount proper path
      perf tools: Pass build flags to traceevent build

Jon Maloy (2):
      tipc: initialize broadcast link stale counter correctly
      tipc: fix info leak from kernel tipc_event

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Kamal Dasu (1):
      MAINTAINERS: Add entry for Broadcom STB I2C controller

Kees Cook (1):
      sunvdc: Remove VLA usage

Keith Busch (1):
      nvme: remove ns sibling before clearing path

Leo Li (1):
      drm: Get ref on CRTC commit object when waiting for flip_done

Li RongQing (1):
      xfrm: fix gro_cells leak when remove virtual xfrm interfaces

Linus Torvalds (1):
      mremap: properly flush TLB before releasing the page

Marcelo Ricardo Leitner (1):
      sctp: fix race on sctp_id2asoc

Masami Hiramatsu (3):
      tracing: Fix synthetic event to accept unsigned modifier
      tracing: Fix synthetic event to allow semicolon at end
      selftests: ftrace: Add synthetic event syntax testcase

Mathieu Desnoyers (1):
      tracepoint: Fix tracepoint array element size mismatch

Matthew Wilcox (2):
      test_ida: Fix lockdep warning
      idr: Change documentation license

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Milian Wolff (1):
      perf report: Don't crash on invalid inline debug information

Ming Lei (1):
      block: don't deal with discard limit in blkdev_issue_discard()

Nathan Chancellor (3):
      x86/time: Correct the attribute on jiffies' definition
      x86/boot: Add -Wno-pointer-sign to KBUILD_CFLAGS
      net: qla3xxx: Remove overflowing shift statement

Nikolay Aleksandrov (1):
      net: ipmr: fix unresolved entry dumps

Oliver Neukum (1):
      cdc-acm: fix race between reset and control messaging

Paolo Abeni (1):
      udp6: fix encap return code for resubmitting

Paul Moore (1):
      MAINTAINERS: update the SELinux mailing list location

Peter Zijlstra (2):
      x86/tsc: Force inlining of cyc2ns bits
      x86/percpu: Fix this_cpu_read()

Phil Auld (1):
      sched/fair: Fix throttle_list starvation with low CFS quota

Phil Sutter (1):
      net: sched: Fix for duplicate class dump

Pieter Jansen van Vuuren (3):
      nfp: flower: fix pedit set actions for multiple partial masks
      nfp: flower: fix multiple keys per pedit action
      nfp: flower: use offsets provided by pedit instead of index for ipv6

Roopa Prabhu (1):
      Revert "neighbour: force neigh_invalidate when NUD_FAILED update is from admin"

Sabrina Dubroca (1):
      ipv6: rate-limit probes for neighbourless routes

Sebastian Andrzej Siewior (2):
      x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
      x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on context switch if there is an FPU

Shuah Khan (Samsung OSG) (2):
      selftests: usbip: add wait after attach and before checking port status
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Song Muchun (1):
      sched/fair: Fix the min_vruntime update logic in dequeue_entity()

Stefano Brivio (3):
      geneve, vxlan: Don't check skb_dst() twice
      geneve, vxlan: Don't set exceptions if skb->len < mtu
      ip6_tunnel: Fix encapsulation layout

Steffen Klassert (1):
      MAINTAINERS: Remove net/core/flow.c

Steven Rostedt (VMware) (1):
      tracing: Use trace_clock_local() for looping in preemptirq_delay_test.c

Taehee Yoo (1):
      net: bpfilter: use get_pid_task instead of pid_task

Talat Batheesh (1):
      net/mlx5: Fix memory leak when setting fpga ipsec caps

Tariq Toukan (1):
      net/mlx5: WQ, fixes for fragmented WQ buffers API

Tobias Herzog (2):
      cdc-acm: do not reset notification buffer index upon urb unlinking
      cdc-acm: correct counting of UART states in serial state notification

Tomi Valkeinen (1):
      drm: fix use of freed memory in drm_mode_setcrtc

Tung Nguyen (1):
      tipc: fix unsafe rcu locking when accessing publication list

Wan Ahmad Zainie (1):
      usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable

Wenwen Wang (3):
      ethtool: fix a missing-check bug
      ethtool: fix a privilege escalation bug
      net: socket: fix a missing-check bug

Wolfram Sang (1):
      i2c: rcar: cleanup DMA for all kinds of failure

Xin Long (4):
      sctp: use the pmtu from the icmp packet to update transport pathmtu
      sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL instead
      sctp: not free the new asoc when sctp_wait_for_connect returns err
      sctp: fix the data size calculation in sctp_data_size

YueHaibing (1):
      rxrpc: use correct kvec num when sending BUSY response packet

