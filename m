Return-Path: <ilina@codeaurora.org>
X-Google-Smtp-Source: AH8x227y8cWSTe2171DRgTB35kHQaX5vt4pAv9TftGVcLL35W5Fb1IlxLx/gOuQFiWqkIqOx0pvn
ARC-Seal: i=1; a=rsa-sha256; t=1517843928; cv=none;
        d=google.com; s=arc-20160816;
        b=a4ztpwGaKiYQQiljBTec1CIUUkItqrg2d3sti40UVtabupL3HHBadPoyyMqmRb5DhA
         0Q4J99UOqkVLggBcb3Z05Bk87lP3Nvh9El5hstoPtRNOH5lyyAEbiMtfXTPmIf8n3SOs
         dkku9wbdK20a/QEQxWKeJC28GyhSUoOUL8MJDFTETXp/3AZk/8rGYPpAkyYkisjdp0Lf
         HB/CsY96C6dq5kNTN3sY7MugrEZSGo8ujw5FHfMR4w6yzUkvBgpQwOM/oabbjeBewiFB
         77PE5XdDFhZGz5F/tX9z9wc4JoxkCW5w5PqHTmjro49ByoeqNC6ahiFRo6dY58MyjOdE
         o5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=focBMMfyXKs9c0ObVetF47TTL9vHqyIYgbynt8bX3fA=;
        b=EfGi01cPCguNugJuLcaRhbCPu8c2I24wincTESk85bVIOuyuhZTQxWtScojIUoIsrT
         2qAA5bVVRWlPYcGTEjYRVksDKXOhXk/lx0VBcvO2vkRdGn2RbeaRi/3CY8w7YeC9bi0y
         83TG4wc4iFMtxRWM1WizOICEZgxLDkSv65C6ru5zYe/hbs6S7ZeUZ1rHPFaiyOMWfGbH
         fHe9Y4S+v2hwlXCTPEZK/z0fW4NdObwY6f0pNc/N/hvvhFXz80wOLJmMwRJ/QvE8i0RM
         EyYH1RQ58AE3g9dWloiwQmCbBqwhsoJsqo0Q5M+C6+SvnsOp4YTsXPUCT5IY18reBazZ
         HfAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PadTBZhC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PadTBZhC;
       spf=pass (google.com: domain of ilina@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=ilina@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PadTBZhC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PadTBZhC;
       spf=pass (google.com: domain of ilina@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=ilina@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FC61601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 5 Feb 2018 15:18:46 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	sboyd@codeaurora.org, rnayak@codeaurora.org,
	asathyak@codeaurora.org, Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in FTRACE
Message-ID: <20180205151846.GA13552@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-4-ilina@codeaurora.org>
 <alpine.DEB.2.21.1802021652100.1472@nanos.tec.linutronix.de>
 <20180202230232.GB15464@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180202230232.GB15464@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591305373445487149?=
X-GMAIL-MSGID: =?utf-8?q?1591574715127036471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02 2018 at 23:02 +0000, Lina Iyer wrote:
>On Fri, Feb 02 2018 at 15:57 +0000, Thomas Gleixner wrote:
>>On Fri, 2 Feb 2018, Lina Iyer wrote:
>>>+++ b/include/trace/events/pdc.h
>>>@@ -0,0 +1,55 @@
>>>+/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>>>+ *
>>>+ * This program is free software; you can redistribute it and/or modify
>>>+ * it under the terms of the GNU General Public License version 2 and
>>>+ * only version 2 as published by the Free Software Foundation.
>>>+ *
>>>+ * This program is distributed in the hope that it will be useful,
>>>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>+ * GNU General Public License for more details.
>>
>>Can you please use the proper SPDX identifiers instead of the boiler plate?
>>Same for the driver source file.
>>
>Sure.
>
>>>+ */
>>>+
>>>+#undef TRACE_SYSTEM
>>>+#define TRACE_SYSTEM pdc
>>>+
>>>+#if !defined(_TRACE_PDC_) || defined(TRACE_HEADER_MULTI_READ)
>>>+#define _TRACE_PDC_H_
>>>+
>>>+#include <linux/tracepoint.h>
>>>+
>>>+#define PDC_ENTRY		1
>>>+#define PDC_TYPE_CONFIG		2
>>>+
>>>+TRACE_EVENT(irq_pin_config,
>>
>>This is really a too generic name for a PDC specific breakpoint.
>>
>Hmm.. right.
>
>>Aside of that the question is whether this really justifies a trace
>>point. Wouldn't it be sufficient to use the GENERIC_IRQ_DEBUGFS
>>infrastructure to make this accessible via debugfs?
>>
>>
>Some product configurations disable debugfs. I will ask around if this
>can be dropped.
>
Memory dumps after a crash have support for FTRACE and it helps greatly
on production issues. Hence the preference for FTRACE support.

-- Lina
