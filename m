Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbeDYRlP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:41:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754654AbeDYRlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:41:10 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCHv2 0/3] bpf: Store/dump license string for loaded program
Date: Wed, 25 Apr 2018 19:41:05 +0200
Message-Id: <20180425174108.6586-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending the change to store and dump the license
info for loaded BPF programs. It's important for
us get the license info, when investigating on
screwed up machine.

v2 changes:
  - dumping only the GPL compatible bool, without
    storing the whole license string

Adding change to bpftool to dump the license GPL
compatible info via:

  # bpftool prog list
  3: kprobe  name func_begin  tag 57cd311f2e27366b license GPL NON compatible
          loaded_at Apr 25/11:20  uid 0
          xlated 16B  not jited  memlock 4096B

  # bpftool prog list
  4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
          loaded_at Apr 25/11:20  uid 0
          xlated 16B  not jited  memlock 4096B

  # bpftool prog show --json
  [{"id":3,"type":"kprobe","name":"func ... ,"gpl_compatible":false,"loade...

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/license

thanks,
jirka


---
Jiri Olsa (3):
      bpf: Add gpl_compatible flag to struct bpf_prog_info
      tools bpf: Sync bpf.h uapi header
      tools bpftool: Display license GPL compatible in prog show/list

 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 1 +
 tools/bpf/bpftool/prog.c       | 3 +++
 tools/include/uapi/linux/bpf.h | 1 +
 4 files changed, 6 insertions(+)
