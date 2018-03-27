Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AG47ELvxK3Z/MRZCM13rYLJSxiR164rMwAk/Ufq2TZYQYpZey9aRJ+IUQpTgeQL2LPKFn9xyiItK
ARC-Seal: i=1; a=rsa-sha256; t=1522150990; cv=none;
        d=google.com; s=arc-20160816;
        b=xPCPQoQCEsDCiJ/AL6dNYfVeYA9b4lC2lH7ub5wdZ0J1U0EZ3SHrHUQx5ROpoRW+ps
         9Dep6JmhhsHxBeWAK0otKN7YKM1DaQoSoyE+vJj3XFbPIurFj4SwNnvinjr/QqUJ3cHN
         Lmi3MfoR7arh9mwWhrwV2E4MnOoLPInUMhYCh0NdJ0eQPgLAkPi+lwKILdk5mlujL2Hx
         y+shk1IRd9m+9noQdtW9iK4IXD6yjOBmjBRGFvNR1IxP10EYnUUyhByRmd917gmaBBoM
         Gm6uGp8BC6XQiB705Zyln9x7FQa0f5tfiYp7K34WusltziFDxZYJK8VK4xj7Q7egu94Y
         4s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=tFTHsGSTB4qUVqRtp0EqPz5ncJrEQziiw0bIP2KWZ/I=;
        b=DVQEabJkI22oui2ZgPADajHdznloDgkzHEZq436cKd4Qek2QXOAlr/TanhLE4q0GlF
         jsDLtuWapqlbpROgnKfEqxo6gbszx/aetR0T8/liY02EcGiSzxVZhG/ryhWCvqUApZYf
         tjMwuCPIOG0nwNgk3n6OslGGMyLWSLpfE6et/v84yUxN3i6ndkxx1Bex3BGjL0lyXVB9
         gVwDhrB9iYHO0A2SRwMGPWwQsuTg7fZNKZ/FrijkdimRk/lISZtQdz1xtdpjQRod3AQj
         4Wus4ChYSiAuD83XEyvv5ijhceSArFNO6PS+lg1aM8Gs2tRtEQnQ4LRVdVfQTVkjgM5U
         NXKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=TN/DHojq;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=TN/DHojq;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180327114308epoutp021a08529f52aee3319a0032da180b8a99~fxEJxK-lt2320123201epoutp02Z
X-AuditID: b6c32a4a-d07ff70000000fed-48-5aba2e4b059b
From: Maninder Singh <maninder1.s@samsung.com>
To: aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
	kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org, vbabka@suse.cz,
	sfr@canb.auug.org.au, mhocko@suse.com, vinmenon@codeaurora.org,
	gomonovych@gmail.com, ayush.m@samsung.com
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, a.sahrawat@samsung.com, pankaj.m@samsung.com,
	v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v3] mm/page_owner: ignore everything below the IRQ entry
 point
Date: Tue, 27 Mar 2018 17:11:47 +0530
Message-Id: <1522150907-33547-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGc3pv761k3e7q1xmLrLmZMehae5sWDk4UIpnXj5huy7JY5uoN
	PQEy2rLeVsb+mUUFY7ABP7ZGIOBc1DQsNRWMFJu6ttukI42Ibl1wOhYdQxgRUEkGk7Xcmv33
	vO/ze/Ke8+YcBaEaoXIV1XYXdtqFGpbKIa/E8vM1u7Qhs84fX4eG+jFqD3RT6MmJKRrdno/Q
	qGW0kUZN02ECxUb/lqND5wIUuvjnfRlqbm8AaDjUTqF73YtyFOtsJNF9bwm6N9krQ4vzSTnq
	Dd+h0eXgaQJFBzoAavN4AQr0XqdLVvKeVIrih73HZXzfmd9ovivo5q+1DlB8cOYEzU8lkzR/
	wzdP8pGObpq/0GfgvT1+wAd67pD8YFec5meDefxEJApMr5jx5iosWLFTje0VDmu1vbKY3fW+
	ZZvFWKDjNFwRKmTVdsGGi9my3SbNO9U16auz6gNCjTvdMgmiyG7cstnpcLuwusohuorZco7T
	azldoVav12sNxn2b9MY0sh9XzV0Pymon3/wskWqiD4JE3jGwTAEZA/zF/5A4BnIUKqYfwJHx
	QSAVMwAuNHiyxTMAB0YS4EVkzBfNGmEAv509LcsYKuYJgH+c1WQ0xWihP3SNzEArmLgM3hxv
	WBpCMFEAz3kX6Ay1nDHBxJc3ljTJrIVnPS1kRiuZ7TD6UxstjcuDAz+clGfCkLlCw7Hh/qxR
	BrviEUrSy+GjH3uy/Vw4OxWmpMAhAO9efEpIxSkAZzpGSYnaCn9PfZ9OKNJnyoeB0EapXQyf
	Dv5MZDTBvAyPzz+QZRDIKOHRRpWErIWHf70kl/TrcHZ6mpQQHvou7ZVkKfQ3Z5eyD/bOPaZa
	QN6Z/0d1AeAHr+Fa0VaJRWOt3o7rtKJgE932Sm2FwxYESw97/c6r4HxydxQwCsC+pPQp+swq
	uXBArLeld6gg2BXK6ldDZpXSKtR/jp0Oi9Ndg8UoMKZ32UrkrqxwpL+J3WXhDEU6Q0FBIafT
	FRnY1crSd8vMKqZScOFPMK7Fzhc5mWJZ7kFgPvLw01ULntTQx89CVPkXIy0a0Gb496PuqxN3
	tzRtq1tdcsrQtKZu7mty3fM3dhTFLyf2xG7eNnqeq7979Jfl1uLgkeYK/sNvCjj5eOvWPb6d
	dcnJfxL4PdPw4dia5AbCqisfOhqZ8ebUdz5463H4q+36D3L2b+r0JUvHrCcnlMzbPpYUqwRu
	PeEUhf8AAHP8Su4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTtdLb1eUweED1hYXd6dazFm/hs3i
	y6R37BZXfu9nt5jwsI3dov3jXmaLww/fslo0L17PZrHi2X0mi545TYwWl3fNYbO4t+Y/q8Xh
	+W0sFvf7HCzuvdnKZPH/9zlWi617r7JbbN40ldni0Mm5jBazG/sYLdZvPcDuIOrReOMGm8fl
	vl4mj52z7rJ7LNhU6rFn4kk2j02fJrF7vDt3jt3jxIzfLB77565h91i+08Sjb8sqRo/1W66y
	eJxZcITd4/MmOY/X+w8xBvBHcdmkpOZklqUW6dslcGV8P7CJqeCNSsWpG+3sDYyn5LoYOTkk
	BEwkns84xNjFyMUhJLCbUeLghkvMEAlpiZ//3rNA2MISK/89Z4co+sQoMWveZ3aQBJuAnsSq
	XXtYQBIiAteYJA40TgarYhY4xSix9spasCphAT+J/dvPsoHYLAKqEgsbJ4CN5RVwlzh0ejY7
	xAo5iZPHJrNOYORZwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOGa0tHYwnjgR
	f4hRgINRiYd3BsfOKCHWxLLiytxDjBIczEoivJmCu6KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
	88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MOqcn7xikc+rg96W6TrvAncbnZ2U8bzQbp/s0R+v
	9y+3vyF7N/l5p/VmyXT5BTt0/gSwcC7/Fuv6XuOy8+QSd4XPWf83OBz3+xodfeuq1pKX1nrR
	7BrpjkU3Xn674/d18YktDlbPXDxDL03hXnRI9vNmxa9veW4aNP38x5UpI/Fw0a8qga+rfh9W
	YinOSDTUYi4qTgQAwgx/x5UCAAA=
X-CMS-MailID: 20180327114307epcas5p100770b64c770cc5bfb98ef1f820434ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180327114307epcas5p100770b64c770cc5bfb98ef1f820434ef
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180327114307epcas5p100770b64c770cc5bfb98ef1f820434ef
X-RootMTR: 20180327114307epcas5p100770b64c770cc5bfb98ef1f820434ef
References: <CGME20180327114307epcas5p100770b64c770cc5bfb98ef1f820434ef@epcas5p1.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596090997002612569?=
X-GMAIL-MSGID: =?utf-8?q?1596090997002612569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Check whether the allocation happens in an IRQ handler.
This lets us strip everything below the IRQ entry point to reduce the
number of unique stack traces needed to be stored.

so moved code of KASAN in generic file so that page_owner can also
do same filteration.

Initial KASAN commit
id=be7635e7287e0e8013af3c89a6354a9e0182594c

Original:-
 __alloc_pages_nodemask+0xfc/0x220
  page_frag_alloc+0x84/0x140
  __napi_alloc_skb+0x83/0xe0
  rtl8169_poll+0x1e5/0x670
  net_rx_action+0x132/0x3a0
  __do_softirq+0xce/0x298
  irq_exit+0xa3/0xb0
  do_IRQ+0x72/0xc0
  ret_from_intr+0x0/0x18
  cpuidle_enter_state+0x96/0x290
  do_idle+0x163/0x1a0

After patch:-
  __alloc_pages_nodemask+0xfc/0x220
  page_frag_alloc+0x84/0x140
  __napi_alloc_skb+0x83/0xe0
  rtl8169_poll+0x1e5/0x670
  net_rx_action+0x132/0x3a0
  __do_softirq+0xce/0x298

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
v1->v2: fix build break for tile and blackfin
(https://lkml.org/lkml/2017/12/3/287, verified for blackfin)
v2->v3: remove inline as functions are larger,
        Declarations for __irqentry_text_start and friends are redundant.

 include/linux/stacktrace.h |  3 +++
 kernel/stacktrace.c        | 22 ++++++++++++++++++++++
 mm/kasan/kasan.c           | 22 ----------------------
 mm/page_owner.c            |  1 +
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index ba29a06..1a37fcae 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -26,6 +26,8 @@ extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 extern int snprint_stack_trace(char *buf, size_t size,
 			struct stack_trace *trace, int spaces);
 
+void filter_irq_stacks(struct stack_trace *trace);
+
 #ifdef CONFIG_USER_STACKTRACE_SUPPORT
 extern void save_stack_trace_user(struct stack_trace *trace);
 #else
@@ -38,6 +40,7 @@ extern int snprint_stack_trace(char *buf, size_t size,
 # define save_stack_trace_user(trace)			do { } while (0)
 # define print_stack_trace(trace, spaces)		do { } while (0)
 # define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
+# define filter_irq_stacks(trace)			do { } while (0)
 # define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
 #endif /* CONFIG_STACKTRACE */
 
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f8edee9..b28c4e1 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -77,3 +77,25 @@ int snprint_stack_trace(char *buf, size_t size,
 	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
 	return -ENOSYS;
 }
+
+static bool in_irqentry_text(unsigned long ptr)
+{
+	return (ptr >= (unsigned long)&__irqentry_text_start &&
+		ptr < (unsigned long)&__irqentry_text_end) ||
+		(ptr >= (unsigned long)&__softirqentry_text_start &&
+		 ptr < (unsigned long)&__softirqentry_text_end);
+}
+
+void filter_irq_stacks(struct stack_trace *trace)
+{
+	int i;
+
+	if (!trace->nr_entries)
+		return;
+	for (i = 0; i < trace->nr_entries; i++)
+		if (in_irqentry_text(trace->entries[i])) {
+			/* Include the irqentry function into the stack. */
+			trace->nr_entries = i + 1;
+			break;
+		}
+}
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 405bba4..129e7b8 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -412,28 +412,6 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 			KASAN_KMALLOC_REDZONE);
 }
 
-static inline int in_irqentry_text(unsigned long ptr)
-{
-	return (ptr >= (unsigned long)&__irqentry_text_start &&
-		ptr < (unsigned long)&__irqentry_text_end) ||
-		(ptr >= (unsigned long)&__softirqentry_text_start &&
-		 ptr < (unsigned long)&__softirqentry_text_end);
-}
-
-static inline void filter_irq_stacks(struct stack_trace *trace)
-{
-	int i;
-
-	if (!trace->nr_entries)
-		return;
-	for (i = 0; i < trace->nr_entries; i++)
-		if (in_irqentry_text(trace->entries[i])) {
-			/* Include the irqentry function into the stack. */
-			trace->nr_entries = i + 1;
-			break;
-		}
-}
-
 static inline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8602fb4..30e9cb2 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -148,6 +148,7 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	depot_stack_handle_t handle;
 
 	save_stack_trace(&trace);
+	filter_irq_stacks(&trace);
 	if (trace.nr_entries != 0 &&
 	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
 		trace.nr_entries--;
-- 
1.9.1
