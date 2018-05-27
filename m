Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeE0L1t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 07:27:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755142AbeE0L1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 07:27:47 -0400
Date: Sun, 27 May 2018 13:28:35 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH bpf 0/2] Use __aligned_u64 in UAPI fields
Message-ID: <20180527112835.GA9118@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

It was discovered during strace development that struct bpf_map_info and
struct bpf_prog_info now have different layouts of i386/compat and x86_64.
Since it's already broken and bpf syscall has no separate compat (as
far as I can see), and the affecting change was introduced recently (in
Linux 4.16), it's proposed to change the layout of these structures
on 32-bit architectures by using __aligned_u64.

In order to somewhat future-proof from this problem in future, an
approach similar to the one implemented in RDMA subsystem recently
is proposed: use __aligned_u64 consistently throughout the UAPI header.

Eugene Syromiatnikov (2):
  bpf: fix alignment of netns_dev/netns_ino fields in
    bpf_{map,prog}_info
  bpf: enforce usage of __aligned_u64 in the UAPI header

 include/uapi/linux/bpf.h       | 30 +++++++++++++++---------------
 tools/include/uapi/linux/bpf.h | 30 +++++++++++++++---------------
 2 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.1.4
