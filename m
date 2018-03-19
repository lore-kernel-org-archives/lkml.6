Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtHRhEn9KAY/3/4XOPrxRyu1wtfsr1LrkTrr7+URxvWafEW/tsUpnM/NNVEGMp+hBpX7pyq
ARC-Seal: i=1; a=rsa-sha256; t=1521483578; cv=none;
        d=google.com; s=arc-20160816;
        b=xRAsNLJ8W/Rb02v+SiXdvXZ0BKV75/YqJ4Kh8Cam6jA7WRGcDiP9B0LfEBxkdlbUWl
         VEJGftOnEBtr/Z/5C3uUlkEWfLhs65/M/OB7q+Q3h7ua6lN6w1exDFMM9cKDPk2LWjWc
         HgZZJgTXY90tWmUt0d2k/tJDVDZfywkP3M+kyUvEM3oEBNqvqY4PRwBc6OB7ivvERE8/
         OLAlIFuWmxrdQmriaLP/D8gGGCoPJMP24+LdfnNy6uhxt+pPBvYpqqfkd7NPBS5rf6py
         P6+9//ns+2jMYWnMXpMbtqv7KP+5sm1IAL7Pf67dAne4+vwwHs240sxUugxt5hW6xTVT
         6RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vNnxqQkVq+7smwG+NKZdeQsei0FVIGJaYPBRPpoTxQs=;
        b=XGkgQCztEEshxIL2xbbfiylmeW505U/W/KKhJH91Lzf/7cbDtMUVxGfpFG3J79b7N8
         RUXeQwU6kCUj/F7tiqA6zAJTREIvYBSZFgHqmmNSr3mdN0UEVU2rq3ZZcV9e6Gtyxo/V
         bB2itO1NulPZMLQ9OQxJYt11EI2nyP+LfaGh5NXW2yBcgtkzB9OYCxbV7Eg4RPAzkx3e
         UIa+DHi/Ov73Mufjt+whzyVDEr5bm0mMA+OV2Rna7a2NwXKNx1775z+6Z4Aw9WUWkoQ9
         SJ+ro4NQBtUvpQNkUsGloFVOAluo8e+CG85h0iHWRaIeI/6bxTVERVaM+5DkL/czOUYr
         3+xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 041/241] perf probe: Fix concat_probe_trace_events
Date: Mon, 19 Mar 2018 19:05:06 +0100
Message-Id: <20180319180752.898616948@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391164951127831?=
X-GMAIL-MSGID: =?utf-8?q?1595391164951127831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>


[ Upstream commit f0a30dca5f84fe8048271799b56677ac2279de66 ]

'*ntevs' contains number of elements present in 'tevs' array. If there
are no elements in array, 'tevs2' can be directly assigned to 'tevs'
without allocating more space. So the condition should be  '*ntevs == 0'
not  'ntevs == 0'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 42bba263eb58 ("perf probe: Allow wildcard for cached events")
Link: http://lkml.kernel.org/r/20170308065908.4128-1-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/probe-event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3060,7 +3060,7 @@ concat_probe_trace_events(struct probe_t
 	struct probe_trace_event *new_tevs;
 	int ret = 0;
 
-	if (ntevs == 0) {
+	if (*ntevs == 0) {
 		*tevs = *tevs2;
 		*ntevs = ntevs2;
 		*tevs2 = NULL;
