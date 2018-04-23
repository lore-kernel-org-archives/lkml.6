Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeDWG7b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:59:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751535AbeDWG73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:59:29 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 0/3] bpf: Store/dump license string for loaded program
Date: Mon, 23 Apr 2018 08:59:24 +0200
Message-Id: <20180423065927.23127-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending the change to store and dump the license
info for loaded BPF programs. It's important for
us get the license info, when investigating on
screwed up machine.

Adding change to bpftool to dump the license via:

  # bpftool prog list
  1: kprobe  name func_begin  tag 59bef35a42fda602 license GPL
          loaded_at Apr 22/15:46  uid 0
          xlated 272B  not jited  memlock 4096B  map_ids 1

  # bpftool prog show --json
  [{"id":1,"type":"kprobe","name":"fun ... ,"license":"GPL", ... ]

Also available at:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  bpf/license

thanks,
jirka


---
Jiri Olsa (3):
      bpf: Store license string for loaded program
      tools bpf: Sync bpf.h uapi header
      tools bpftool: Display license in prog show/list

 include/linux/bpf.h            | 1 +
 include/uapi/linux/bpf.h       | 3 +++
 kernel/bpf/core.c              | 1 +
 kernel/bpf/syscall.c           | 7 ++++++-
 tools/bpf/bpftool/prog.c       | 4 ++++
 tools/include/uapi/linux/bpf.h | 4 ++++
 6 files changed, 19 insertions(+), 1 deletion(-)
