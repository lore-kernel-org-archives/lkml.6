Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbeCWKlf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:41:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755922AbeCWKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:41:31 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 0/2] bpf: Change print_bpf_insn interface
Date: Fri, 23 Mar 2018 11:41:27 +0100
Message-Id: <20180323104129.14989-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset removes struct bpf_verifier_env argument
from print_bpf_insn function (patch 1) and changes user
space bpftool user to use it that way (patch 2).

thanks,
jirka

---
Jiri Olsa (2):
      bpf: Remove struct bpf_verifier_env argument from print_bpf_insn
      bpftool: Adjust to new print_bpf_insn interface

 kernel/bpf/disasm.c               | 52 ++++++++++++++++++++++++++--------------------------
 kernel/bpf/disasm.h               |  5 +----
 kernel/bpf/verifier.c             | 44 +++++++++++++++++++++++++++-----------------
 tools/bpf/bpftool/xlated_dumper.c | 12 ++++++------
 4 files changed, 60 insertions(+), 53 deletions(-)
