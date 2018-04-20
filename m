Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AIpwx4/SIr57hZRy2B8VpY+Nlj86CEAFPeOLBgvixHm3TLk/n0veB0zhIKe/2k1kKxWeSqzSbfsX
ARC-Seal: i=1; a=rsa-sha256; t=1524215373; cv=none;
        d=google.com; s=arc-20160816;
        b=Dc7We3f+lla7jWGpGaEil+BiPBHq8ZsR/GsNZ6vVpYf/56nruD3VghKUga/2YCMFFG
         h/Y7NzG9WFoDwz1/U8useQcLlzY4SbxB9MIEGt5i66lfCYhUbKfv7uV9nWN0mNLgiu0x
         sLvCHZtqH+PXqItXChJropEyWWhszlMz1/anqeed7ukk2TUApsElvSs37KrSDnU+rdIn
         7zbbLOwcJZ5ZllHKiVB6qr+EKaL4PPy0V5ZuxM3RfdEZDzxqxs9YQEYFPQRu7b92PPnK
         B8AJM2QCIGhDv+jtaE+kzO86tubH30m7YWnKGFdTvJmTOuuyyGl9nj0fi5mtXIRJx1eS
         +0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=tkYfi7OAgQcElyGeFm5zD8ukCCd+WlVcguexQbZynvY=;
        b=rebrTSmakeuGVXDdYWYfeY6uIskfO/mP9uOotgqiRzLMZv2WX/g5z28m1fmGxklKIV
         vDtFWGp6mITbhP06jc7IodbFSBrkK69t8iWxc7W85L04gs03Sy4gZIXE8obR8q9uE91y
         kbKjieSnrth0rXm+0LPA8pn/sSnrtfpgFXftTR1TlICCM2ISOcsice1ZywZCJiJMdxKO
         9hzFxDyIu4nz5UvJa2WHDsKZv/gGJhaXYuLTBy3ZSTgu3xRKdrITe+DIj3noF30dAX2s
         13Xx6/Dlwkykn+rG8/NhEqjn5HgETLGBkmxMIz1Cr+cAGnjbUKL7oh3wmNKH0WqM2NV1
         m/YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=CFBSOMNx;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=CFBSOMNx;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180420090932epoutp030f539feb15ddb6297a66f1d79f27f807~nGc415ECQ0223102231epoutp03o
X-AuditID: b6c32a4b-fcbff70000000fe6-64-5ad9ae4b4849
From: Maninder Singh <maninder1.s@samsung.com>
To: jdike@addtoit.com, richard@nod.at, kstewart@linuxfoundation.org,
	tglx@linutronix.de, gregkh@linuxfoundation.org, pombredanne@nexb.com
Cc: user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com, Maninder
	Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] um: add IRQENTRY and SOFTIRQENTRY points.
Date: Fri, 20 Apr 2018 14:37:10 +0530
Message-Id: <1524215230-44763-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQ9d73c0og0u/zCwu7k61aF68ns1i
	/Z6H7BY9c5oYLS7vmsNmcXh+G4vFvTdbmSz+/z7HajF55xtGi82bpjJbzOqdwmLxZ8YSZotD
	J+cyOvB6/Pp3md3j3blz7B77565h99i94DOTx/KdJh435xV69G1ZxejxeZNcAEdUqk1GamJK
	apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
	4mIlfTubovzSklSFjPziElulaENDIz1DA3M9IyMjPRPTWCsjU6CShNSM/vffmQv+8lS8a4tp
	YLzI1cXIySEhYCLRe/IvC4gtJLCbUeLu7qouRi4g+xOjRP/50+wQiW+MEs0bU7oYOcAabl0K
	gajZyyhx82EPO4TzhVHi2b/lrCANbAJ6Eqt27WEBSYgIdDNKvD7XAlbFLPCWUWLdge2MIFXC
	AnYSb750M4PYLAKqEt+7LoDdwSvgLnH4xyoWiPvkJE4em8wK0iwhcIRNYuGybawQd7hIPL3g
	D1EjLPHq+BZ2CFtK4mV/GztEfTOjxJ0VX5khnCmMEp/mPoSaai/x4MZRdpBBzAKaEut36UOE
	bSV+XDgDdhyzAJ9E7+8nTBC7eCU62oQgSlQlWm5uYIWwpSU+f/zIAlHiIfH9iixE2FHixOJ3
	bJCQi5X4tXoL0wRGuVkIuxYwMq5ilEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhOi1re
	Oxg3nfM5xCjAwajEw/th3Y0oIdbEsuLK3EOMEhzMSiK8CWY3o4R4UxIrq1KL8uOLSnNSiw8x
	mgLDciKzlGhyPjBl55XEG5pYGpiYmZkbGhhYmiiJ8xqEnYkSEkhPLEnNTk0tSC2C6WPi4JRq
	YMy3PMVlyv/jlG9cwnarsC+S/z/8n3eYf+9649a+Oc9nPk/uEXCe9vJlWdxT5U0pMWXFW3o1
	V0092qx2z71hoY1Oi0W3o0hHnQhr7xyp8+xGxbYFwmdOKZdffxFkzqXL9HKD4NV1Cr+CTpzT
	nyqxd77D1uT+7L/c7xbd+lK/gsH8Mt/BnN4MXyWW4oxEQy3mouJEAEStiSOhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnK73uptRBl8OSVpc3J1q0bx4PZvF
	+j0P2S165jQxWlzeNYfN4vD8NhaLe2+2Mln8/32O1WLyzjeMFps3TWW2mNU7hcXiz4wlzBaH
	Ts5ldOD1+PXvMrvHu3Pn2D32z13D7rF7wWcmj+U7TTxuziv06NuyitHj8ya5AI4oLpuU1JzM
	stQifbsEroz+99+ZC/7yVLxri2lgvMjVxcjBISFgInHrUkgXIxeHkMBuRolzL04wdjFyAsWl
	JX7+e88CYQtLrPz3nB2i6BOjRMuz+8wgCTYBPYlVu/awgCREBCYzSnxd+YoVxGEW+MwocWTa
	R7BRwgJ2Em++dIN1sAioSnzvugA2llfAXeLwj1VQK+QkTh6bzDqBkWcBI8MqRsnUguLc9Nxi
	wwLDvNRyveLE3OLSvHS95PzcTYzg0NTS3MF4eUn8IUYBDkYlHl6PjTeihFgTy4orcw8xSnAw
	K4nwJpjdjBLiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qB
	kfXiLx3dnH3Tn54SiTR6FHX/Txtvr6rs8XQ19duHBXb76RSefJdyeWkhn8O9Q1cPPub73m3/
	menJ+UNH9Hu3Kblb/dgsGacVMNM63SAvrpT5QHJ28IP5S7Rtfv/t0RYRf+759ZhuZFrS/V+y
	6bdmqs1JqTuQkf4x/tgDpnC9A8miWxeu2sz9TImlOCPRUIu5qDgRAI/4NhZJAgAA
X-CMS-MailID: 20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84
X-RootMTR: 20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84
References: <CGME20180420090931epcas5p47799b0f1aef5b1bb70e33118bc167c84@epcas5p4.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598255660237750194?=
X-GMAIL-MSGID: =?utf-8?q?1598255660237750194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchs add sections for IRQENTRY and SOFTIRQENTRY.
Initially added by below kernel patch for all architecture,
but missed in um.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=be7635e7287e0e8013af3c89a6354a9e0182594c

We need to add both sections because if someone has to use
stackdepot feature for stacktrace and want to filter IRQ stack
entries, it will break build for um.

Below patch is breaking build break for um.
mm/page_owner: ignore everything below the IRQ entry point.
V2:- https://lkml.org/lkml/2018/3/26/178
V3:- https://lkml.org/lkml/2018/3/27/357

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/um/kernel/dyn.lds.S | 2 ++
 arch/um/kernel/uml.lds.S | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index d417e38..0fb2d3a 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -71,6 +71,8 @@ SECTIONS
     SCHED_TEXT
     CPUIDLE_TEXT
     LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
     *(.fixup)
     *(.stub .text.* .gnu.linkonce.t.*)
     /* .gnu.warning sections are handled specially by elf32.em.  */
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 3d6ed6b..f12b856 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -31,6 +31,8 @@ SECTIONS
     SCHED_TEXT
     CPUIDLE_TEXT
     LOCK_TEXT
+    IRQENTRY_TEXT
+    SOFTIRQENTRY_TEXT
     *(.fixup)
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
-- 
1.9.1
