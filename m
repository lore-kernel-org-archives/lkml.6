Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AG47ELsAPPu/HIbwuEYoySyOS+rhBhpbXkQq8ukvn4J0xY0iE4bbAKFvmo6+U4QJ5OjD9gFaq8Un
ARC-Seal: i=1; a=rsa-sha256; t=1522058423; cv=none;
        d=google.com; s=arc-20160816;
        b=MDYD9rcoC7/QcR8zho0dVRoyYRLdWUgh1VentlYvclQR4zNoELjV0z8evEvN0SQRwH
         dGzGSVu+e1er42pmzQ3Mqsy/wRKWZl/ZJRR0a5TA0V58/lssMeb/LEQoXJcgGEBNv6Yv
         m9Vh5r64hh/yuC9ZfI0+eUhao0WvLoVeCPOUdluV2TE/9HtlDH9kmoNMnmfN9yNbG5t1
         Iq/JClxAOhJg9/dlqhJXIjn9Fv6fzW3oTI3ZqSZeF1vbfHwrMiO16EUO26oLCZcJDuv4
         x7WMCq7UhbXGG+sy1IWnX+kLoSEipfkAGLSSKjiUibVdLFq2eXUzlmtd9Z2TF1PHW6K0
         jm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=Fw4tYXjekgzZ+WvSkqJFnHW5+XAs+NHgRWtXJaRPgNw=;
        b=qAXhrf72WiYpZbIDRwrn/5v8axvZdF/UtUDkDfB4hqJXwQQxpekwdLmBiEZiMad8Sd
         /qs+FnZKYqhWRiAtY/9WoZxa+7Qin/7ApnI+RECHG1N+kKaYwsXm7TEKugm4MlJ1fAjW
         YMD82BCAMEV+qyfbDZLx9DvkvPrelvPcljt9M8akul3HT20u6AhyaAULY6MOSrWH/Xdu
         fycjqzQADhFuvPJqA4UVoBXJ83PAY3sTtt4cVSF8f7KQLX+ZCuJNSGCTIBHBtCOkbFGw
         ZOK21K5aiR9RQti3eBviPqJlUMvvD191kAkfeBgo5ojxgfc5uNzngC70Gxn7igK8SolU
         UmDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=UcXG49oD;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=UcXG49oD;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180326100021epoutp019a74a7a4c055730aaf151219077355e6~fcBH3VINK2854728547epoutp01W
X-AuditID: b6c32a4b-fb3ff70000000fe6-05-5ab8c4b46b62
From: Maninder Singh <maninder1.s@samsung.com>
To: aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
	kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org, vbabka@suse.cz,
	sfr@canb.auug.org.au, mhocko@suse.com, vinmenon@codeaurora.org,
	gomonovych@gmail.com, ayush.m@samsung.com
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, a.sahrawat@samsung.com, pankaj.m@samsung.com,
	v.narang@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] mm/page_owner: ignore everything below the IRQ entry
 point
Date: Mon, 26 Mar 2018 15:28:24 +0530
Message-Id: <1522058304-35934-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTf2wTVRz33V3vCrFwKRCfU2Y9hViSdb3abq/IGMRFL2FgFyKJMzgu27lN
	2+vSazfmH6ZjyyAEKq0YCGxsyh80dVJytLJfzUw7lQWtW+aS6QRccI2Cm26DDd3i7O0w/vf5
	fN/n8/nmffKeFtdPkDnaWtEreETeyZBric9TRmNebLC73Lz47fNopE9AbdEuEt0PzVDo+6UB
	Cp2abKXQ0dkEjlKT0xrUfDFKonDmNoZOtB0BaLS3jUS3ulY0KNXRSqDbgV3o1u9xDK0spTUo
	nhij0FX5Ixwlh9oBOt8UACga/4LatYlrGh8nudHASYzrOXeT4jplH9cfHCI5eS5EcTPpNMVd
	P7tEcAPtXRR3qcfKBWIRwEVjYwT3Tecgxc3Ludy9gSRwrC8XdtQIfJXgMQhipbuqVqwuYvbs
	r3i5wlZgZvNYOypkDCLvEoqYklJH3iu1zuzVGUM97/RlRw5ekpj8nTs8bp9XMNS4JW8R8ybL
	WkysudBksVhMVtvB7RZbVnJIqMn0hYm6v5nD4Qc3SD84sfk40GohbYWXT9uPg7VaPd0H4NXQ
	AqWSOQBbPnmYJWuyZAHAkQW7ghXD0SsLmCpKABj7VSZU0X0A0xGngknaBCO9/YQi2kgPYnD4
	tyO4QnA6CeDFwPJq7AbaASeGE6SCCXoLvPPHB6tYR78K703eINV1uXDoqw81ihnSMgUzwWag
	HpTAmcsrGhVvgHe/jlEqzoHzM0qoYmgG8KfwA1wlpwGca58kVFUx/Hn8S0qpAKeNMNqbr46L
	4ETrp6uhOL0Onlz6BVNb0sFjrXpVsgW2/HDl0d6n4Pzs7KNEDk7fkTEV74ahnpsatZaDcNaf
	0pwCuef+X9YJQAQ8KdRJrmpBstW9KAoNJol3ST6x2lTpdslg9WFv29MN5HRpEtBawDyug1h3
	uV7D10uNrmyLWpzZqFvXkR3pqvjG9wSPu8LjcwpSEtiybQbxnE2V7uw3Eb0VrNVuthYUFLJm
	s93KPKHbXVZSrqerea/wriDUCZ7/fJh2TY4fHHINginH1tRbjpYDTcuPbfc/t7O97Okz/4yt
	v8B/NrG8P5664H+9PrP3tcIf7zre2EdMWb9bTD4rRmxej7FsJBg0mM6PFr9/Ld/PojN/wg59
	+IX5v66VTjeymfiBgZJnHpYNv7N4eG9/sQe6jcwI6eubakiEtr6tP3Z9c8z6ccNLDCHV8Ow2
	3CPx/wLc5Hov7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXnfzkR1RBkcuW1lc3J1qMWf9GjaL
	L5PesVtc+b2f3WLCwzZ2i/aPe5ktDj98y2rRvHg9m8WKZ/eZLHrmNDFaXN41h83i3pr/rBaH
	57exWNzvc7C492Yrk8X/3+dYLbbuvcpusXnTVGaLQyfnMlrMbuxjtFi/9QC7g6hH440bbB6X
	+3qZPHbOusvusWBTqceeiSfZPDZ9msTu8e7cOXaPEzN+s3jsn7uG3WP5ThOPvi2rGD3Wb7nK
	4nFmwRF2j8+b5Dxe7z/EGMAfxWWTkpqTWZZapG+XwJXxbPcKloJfShUrvp5ma2Dske1i5OSQ
	EDCRaN/wjQnEFhLYzShx8YYqRFxa4ue/9ywQtrDEyn/P2bsYuYBqPjFKHH93jB0kwSagJ7Fq
	1x4WkISIwDUmiQONk8GqmAVOMUqsvbIWrEpYwE9iavsKsFEsAqoSj9/3s4HYvALuEq8fnmaD
	WCEncfLYZNYJjDwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4yW5g7Gy0vi
	DzEKcDAq8fBKMO2IEmJNLCuuzD3EKMHBrCTCyzcfKMSbklhZlVqUH19UmpNafIhRmoNFSZz3
	ad6xSCGB9MSS1OzU1ILUIpgsEwenVAPjsq8zfJc7HhTeopWXk/Kju+lgMMO3hP2nYq5KTyy6
	afT34tfPDcJMf25cPLtZpmbSqUhWnaBnFzgKPmqFCOyXEPCbkTx7x4w5Uy+ciOBT+fYxelMp
	u/2umPY+37gp/J1WRWbXz873/flawlVa0ZprulrTdv0t+5OZPz6ct1xCVCljie+dXWv1lViK
	MxINtZiLihMBj8poTpQCAAA=
X-CMS-MailID: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
X-RootMTR: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
References: <CGME20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41@epcas5p2.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595993933133123096?=
X-GMAIL-MSGID: =?utf-8?q?1595993933133123096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Check whether the allocation happens in an IRQ handler.
This lets us strip everything below the IRQ entry point to reduce the
number of unique stack traces needed to be stored.

so moved code of KASAN in generic file so that page_owner can also
do same filteration.

Initial KASAN commit
id=be7635e7287e0e8013af3c89a6354a9e0182594c

original:- 
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

 include/linux/stacktrace.h | 26 ++++++++++++++++++++++++++
 mm/kasan/kasan.c           | 22 ----------------------
 mm/page_owner.c            |  1 +
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index ba29a06..3d3e49d 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+extern char __irqentry_text_start[], __irqentry_text_end[];
+extern char __softirqentry_text_start[], __softirqentry_text_end[];
 struct task_struct;
 struct pt_regs;
 
@@ -26,6 +28,28 @@ extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 extern int snprint_stack_trace(char *buf, size_t size,
 			struct stack_trace *trace, int spaces);
 
+static inline int in_irqentry_text(unsigned long ptr)
+{
+	return (ptr >= (unsigned long)&__irqentry_text_start &&
+		ptr < (unsigned long)&__irqentry_text_end) ||
+		(ptr >= (unsigned long)&__softirqentry_text_start &&
+		 ptr < (unsigned long)&__softirqentry_text_end);
+}
+
+static inline void filter_irq_stacks(struct stack_trace *trace)
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
+
 #ifdef CONFIG_USER_STACKTRACE_SUPPORT
 extern void save_stack_trace_user(struct stack_trace *trace);
 #else
@@ -38,6 +62,8 @@ extern int snprint_stack_trace(char *buf, size_t size,
 # define save_stack_trace_user(trace)			do { } while (0)
 # define print_stack_trace(trace, spaces)		do { } while (0)
 # define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
+# define filter_irq_stacks(trace)			do { } while (0)
+# define in_irqentry_text(ptr)				do { } while (0)
 # define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
 #endif /* CONFIG_STACKTRACE */
 
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
