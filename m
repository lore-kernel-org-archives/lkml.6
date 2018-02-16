Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935580AbeBPLXf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:23:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44767 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935541AbeBPLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:27 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180216112325euoutp013300ceff22aa863c16d3e123e9d61711~TyozKoCXK2298222982euoutp01C
X-AuditID: cbfec7f2-5ffe19c000011644-d9-5a86bf298e59
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 0/7 RESEND] arm64: uprobes - ARM32 instruction probing
Date: Fri, 16 Feb 2018 12:23:04 +0100
Message-id: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7djP87qa+9uiDL49lbfoureDzaJj00xW
        i40z1rNavF/Ww2hx9OxfJovGT3OZLTY9vsZqcXnXHDaLQ1P3Mlrs6V/NZrH2yF12i0sHFjBZ
        NC3bymKxdX8ro8Xx3gNMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPQ6+
        28Pk8X7fVTaPvi2rGD0+b5IL4IrisklJzcksSy3St0vgyni6pomp4JVCRc+rPawNjCfFuxg5
        OCQETCQm/3fsYuTiEBJYwSgxefpCdgjnM6PExQU32LoYOcGKbpyYxASRWMYo0f9sMyuE85FR
        Yu6NxSwgVWwC5hLbj7aA2SICbhI3GjvAOpgFLjNJXD7RzQSSEAZKrPzbBmazCKhKvHvaCbaC
        V8BfYvW0fSwQ6+Qkbp7rZAZplhA4wSbx68hZVoiEi8TaC41QNwlLvDq+hR3ClpG4PLkbqrmf
        UeLgbWmI5hmMElvfP4JKWEv8WTURrJlZgE9i0rbpzJAQ4JXoaBOCKPGQeHJ/HiOE7SixZPpZ
        sFYhgViJ/49b2SYwSi5gZFjFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmAZO/zv+aQfj
        10tJhxgFOBiVeHg39LZGCbEmlhVX5h5ilOBgVhLhvTW9LUqINyWxsiq1KD++qDQntfgQozQH
        i5I4b5xGXZSQQHpiSWp2ampBahFMlomDU6qBUXuZ2aI/Uh+4Xb8f4RKPXn/nw5wLXkc3fli/
        KSZVP9h08umAx/+yDS97bsn1N+OX+s5s11jC+WdbxBlv7/qFPjz6X22nvS1PCeBZqeSW8fTh
        zgtXz4WUbtlhfdHnzQ6bVUIRlzYsyCvPTLdZKx+erTPnQ2LzQWcTVseXj2zvcvD6nl7SX+qQ
        qsRSnJFoqMVcVJwIAMpHo/H/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xq7oa+9uiDL6rWHTd28Fm0bFpJqvF
        xhnrWS3eL+thtDh69i+TReOnucwWmx5fY7W4vGsOm8WhqXsZLfb0r2azWHvkLrvFpQMLmCya
        lm1lsdi6v5XR4njvASaLlx9PsDgIeKyZt4bR4/K1i8wem1doeWxa1cnmMe9koMfmJfUeB9/t
        YfJ4v+8qm0ffllWMHp83yQVwRXHZpKTmZJalFunbJXBlPF3TxFTwSqGi59Ue1gbGk+JdjJwc
        EgImEjdOTGLqYuTiEBJYwijxf8dyKOczo8TSB1uZQKrYBMwlth9tYQGxRQTcJG40doAVMQtc
        ZpL4vGAvK0hCGCix8m8bWAOLgKrEu6edbCA2r4C/xOpp+1gg1slJ3DzXyTyBkWsBI8MqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwJDcduznlh2MXe+CDzEKcDAq8fBu6G2NEmJNLCuuzD3E
        KMHBrCTCG7yvLUqINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMH
        p1QDo5+324uo/T95ux2iot73LJ0v943z6Ip/fbFF9T8eTFRauSrLvvfp1nX7n96tXbrLLPNg
        vkJNYMK1enGeZdbveNbmVIi2347MD9p0krlW4Rsr366V9VPUXvCwBsYoOS31PqbRMSnNuON6
        FMPJQq9K/s+STNdT1mv1LWOfW1yjIP+30u1xeaqwEktxRqKhFnNRcSIATThY0UUCAAA=
X-CMS-MailID: 20180216112320eucas1p104a5cca53f8ee7d9b727479b2a362e93
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112320eucas1p104a5cca53f8ee7d9b727479b2a362e93
X-RootMTR: 20180216112320eucas1p104a5cca53f8ee7d9b727479b2a362e93
References: <CGME20180216112320eucas1p104a5cca53f8ee7d9b727479b2a362e93@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uprobe feature on ARM64 kernel does not support ARM A32 instruction
probing, making 32 bit apps running on 64 bit kernel unprobeable.

This patchset utilizes ARM32 uprobe code in ARM64 tree with following
modifications:
- moves ARM32 uprobes code form arch/arm to lib/uprobes/arm to be reused
by ARM64 code
- makes adjustments in api so that it suits the one used by ARM64 kernel, e.g.
struct pt_regs, register numbers
- takes into account differences between 32 and 64 bit ARM architectures.
A64 instruction handling is left unchanged.

Detect what kind of instruction is being probed and depending on the result:
- if an A64 instruction handle it the old way, using existing A64 instructions
probing code,
- if an A32 instruction decode it and handle using the new code, moved from
32 bit arm kernel tree.

Currently following test cases have been carried out with positive results:
- simulation-able instructions, like: STM, LDM, BLX, BL
- xol-able instructions, like: STR, LDR, ADD, CMN, CMP
- branching
- uretprobes.

This patchset does not implement T32 (Thumb) instructions probing (which is
also unsupported on "native" ARM32 arch).

Maciej Slodczyk (7):
  arm64: move arm uprobes code to be reused by arm64
  arm64: uprobes - fix checkpatch.pl issues
  arm64: introduce get_swbp_insn() instead of static assignment
  arm64: change arm64 probes handler prototype
  arm64: make arm uprobes code reusable by arm64
  arm64: change arm_probe_decode_insn() function name
  arm64: uprobes - ARM32 instruction probing

 arch/arm/include/asm/probes.h                      |   8 ++
 arch/arm/include/asm/ptrace.h                      |  32 +++++
 arch/arm/include/asm/uprobes.h                     |   2 +-
 arch/arm/probes/Makefile                           |   8 +-
 arch/arm/probes/kprobes/actions-arm.c              |   2 +-
 arch/arm/probes/kprobes/checkers-arm.c             |   4 +-
 arch/arm/probes/kprobes/checkers-common.c          |   4 +-
 arch/arm/probes/kprobes/checkers-thumb.c           |   2 +-
 arch/arm/probes/kprobes/checkers.h                 |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/core.h                     |   2 +-
 arch/arm/probes/uprobes/Makefile                   |   2 +-
 arch/arm/probes/uprobes/core.c                     |  10 +-
 arch/arm64/include/asm/probes.h                    |  24 +++-
 arch/arm64/include/asm/ptrace.h                    |  21 +++
 arch/arm64/include/asm/uprobes.h                   |  21 ++-
 arch/arm64/kernel/debug-monitors.c                 |   8 ++
 arch/arm64/kernel/probes/Makefile                  |   2 +
 arch/arm64/kernel/probes/decode-insn.c             |  30 ++--
 arch/arm64/kernel/probes/decode-insn.h             |  15 +-
 arch/arm64/kernel/probes/kprobes.c                 |   4 +-
 arch/arm64/kernel/probes/simulate-insn.c           |  32 +++--
 arch/arm64/kernel/probes/simulate-insn.h           |  24 ++--
 arch/arm64/kernel/probes/uprobes.c                 | 121 ++++++++++++++--
 include/linux/uprobes.h                            |   1 +
 kernel/events/uprobes.c                            |  12 +-
 lib/Makefile                                       |   2 +
 lib/probes/Makefile                                |   2 +
 lib/probes/arm/Makefile                            |  11 ++
 .../uprobes => lib/probes/arm}/actions-arm.c       | 153 ++++++++++++++++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.c   |  57 +++++---
 {arch/arm/probes => lib/probes/arm}/decode-arm.h   |   4 +-
 {arch/arm/probes => lib/probes/arm}/decode.c       |  18 ++-
 {arch/arm/probes => lib/probes/arm}/decode.h       |  48 ++++---
 34 files changed, 549 insertions(+), 141 deletions(-)
 create mode 100644 lib/probes/Makefile
 create mode 100644 lib/probes/arm/Makefile
 rename {arch/arm/probes/uprobes => lib/probes/arm}/actions-arm.c (61%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.c (95%)
 rename {arch/arm/probes => lib/probes/arm}/decode-arm.h (94%)
 rename {arch/arm/probes => lib/probes/arm}/decode.c (98%)
 rename {arch/arm/probes => lib/probes/arm}/decode.h (94%)

-- 
2.7.4
