Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964821AbeBPLXy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:23:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47788 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935464AbeBPLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:23:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180216112330euoutp020c29c0c9263f69e3b6d845af66ffa6d1~Tyo3wSfpS2418824188euoutp02d
X-AuditID: cbfec7f4-b4fc79c0000043e4-eb-5a86bf2e5aa6
From: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH 6/7 RESEND] arm64: change arm_probe_decode_insn() function
 name
Date: Fri, 16 Feb 2018 12:23:10 +0100
Message-id: <1518780191-31094-7-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zdnZcLk7T8I+3D4NKhOxC0YlUNDXON5WIcFQ29TQtp7Lj
        NItKTWXe0hTzUukqkbEp5pyXzPsltXuuphHN0pha4DKtTExzHv32e3meh/fCS6CiRcyZiIlL
        ZBRx0lgxLsCan/59vcerK0uy706xN5VjbsUplb6cRzWU1fMoa00eoAZe/kOotJ/3UEo/aeJR
        xra7ONVb0gGo9gIdTtX1f+JTI91qhEqvacKopq5MQA3mdyPUzNwQ5kfStZW1gDaa3qJ0o8aT
        1muzcbpyOJRurL5O98y2I7S18z1O3zRoAT2vdw8RSATeUUxsTBKj2Ot7ThD9p0THS9DsuNQy
        moengg5RDrAjIHkQfs6f5dtYRGoArBr2yQGCNZ4HsLCvAmyaTA+mMU6oAbBvVbdRzAFofjbG
        s7lw8jBsGcjAbOxIHodjaSrEZkJJIwKNQ7mITXAgQ2HPonk9gJE74Qvd8FqAIIRkMCzKVHDd
        3OGHV9moje3IEDhuMKw3g+QUDmtvjKOcKRBaVVN8jh3gt0HDBrtCY3EuxnEBgD0fXbhwGYBN
        1okN4Shc1t7CbYyS22BRcylqGwKSQqjK2rgLDZtHV3gc+8Px/EI+t/FDADMHjGghcFaDLVrg
        xChZuYxhD8QxyV6sVM4q42RekfFyPVj7h+crgwutoG05oheQBBDbCx/lZ0pEPGkSmyLvBZBA
        xY7CE51ZEpEwSppymVHEhyuUsQzbC1wITOwkPOtxTSIiZdJE5iLDJDCKTRUh7JxTwRW327ky
        i/+xvIA3urqrqY/NSs8jFfervvtGBK9uPRTW4rr7ywi/fqi/9Pc9069qdcZJy64Od6dU+5WG
        0tMp4RMZIXBJiZ7RpG23BPnQaV2BGu9J3VIA6af72n3eXP5EnZwezFzwXfCyRKoqPWYcaW2Y
        YTrZ7cep6fIgS4LbOwcxxkZL93uiClb6H4+uU08LAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xa7q6+9uiDO41KVp03dvBZtGxaSar
        xcYZ61kt3i/rYbQ4evYvk0Xjp7nMFpseX2O1uLxrDpvFoal7GS329K9ms1h75C67xaUDC5gs
        mpZtZbHYur+V0eJ47wEmi5cfT7A4CHismbeG0ePytYvMHptXaHlsWtXJ5jHvZKDH5iX1Hgff
        7WHyeL/vKptH35ZVjB6fN8kFcEVx2aSk5mSWpRbp2yVwZXyfupq1YIVoxfbrPWwNjHuFuhg5
        OSQETCSuLXrB0sXIxSEksIRRYsL5t1DOZ0aJ7uNb2UGq2ATMJbYfbWEBsUUE3CRuNHYwgRQx
        C1xmkvi8YC8rSEJYwF/i9qxZzCA2i4CqxJnVJ4EaODh4geKTWosgtslJ3DzXCVbCKRAgcX/L
        FrCZQkAlaxf9YpnAyLOAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYAhvO/Zzyw7GrnfB
        hxgFOBiVeHg39LZGCbEmlhVX5h5ilOBgVhLhDd7XFiXEm5JYWZValB9fVJqTWnyIUZqDRUmc
        97xBZZSQQHpiSWp2ampBahFMlomDU6qBMenKPN0TBef9F0svV4pZursqyq0n5kdUuu9m+yVX
        JWdZfav2lnzo9ueDiJxMnph+6/T8A1L/itOzP980ZjgRs8T9dlDbrnvlMzs3fuix3tJkmdx8
        W86iIOdRo2ZVUDLrLXPVzxfvV4QstQ6wjfneMl/W4PC1L48EQle5P5Rvn+DCdyXaUq5biaU4
        I9FQi7moOBEAqeyQWV0CAAA=
X-CMS-MailID: 20180216112325eucas1p1e6c73b9b55db778aac0bbb9ad1b10fae
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180216112325eucas1p1e6c73b9b55db778aac0bbb9ad1b10fae
X-RootMTR: 20180216112325eucas1p1e6c73b9b55db778aac0bbb9ad1b10fae
References: <1518780191-31094-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180216112325eucas1p1e6c73b9b55db778aac0bbb9ad1b10fae@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM probe decoding function has similar name in arm32 -
arm_probes_decode_insn(), and arm64 - arm_probe_decode_insn(). Change arm64
probes decoding function name from arm_probe_decode_insn() to
arm64_probes_decode_insn() to minimize the risk of confusion.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 4 ++--
 arch/arm64/kernel/probes/decode-insn.h | 2 +-
 arch/arm64/kernel/probes/uprobes.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index a0597a2..37be1a9 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -78,7 +78,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
  */
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
 {
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
@@ -162,7 +162,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
+	decoded = arm64_probes_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 93e021f..e6c7b9e 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -32,7 +32,7 @@ enum probes_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
 
 extern const union decode_action uprobes_probes_actions[];
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index f99b50b..e7b8912 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -47,7 +47,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
 
-	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
+	switch (arm64_probes_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
 		return -EINVAL;
 
-- 
2.7.4
