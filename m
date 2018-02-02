Return-Path: <ilina@codeaurora.org>
X-Google-Smtp-Source: AH8x2248lgEvY2N9jJ1nVTJLxGkI77ISzZHzrIsmG71Zb9txWM4UrypXnZlIU+ziC4504twgi3Lh
ARC-Seal: i=1; a=rsa-sha256; t=1517612554; cv=none;
        d=google.com; s=arc-20160816;
        b=tsyOEAkLNI0TpT/A2HHR3Dytybn2esKEI/nvfC5ikYYrM0ovQmn+7eMPvpdoW8K74u
         NEpCjE4V6yfCC7y0JuQe0DUXbLe4z1kGCrAogeanDOGWVaaxNHNlm7vel3OmXQcrEjmR
         UshnWstPAnoIKDy7/WyR/He5KnSuHf378viKLmxBNNNXjjSfIIO4P5FX7lnyxDa1KgMD
         3WqyXQtQ8ENF8qZEdomyzfrLHtW4LXlz+GOKNr9APRNNmCdBFW8RC3It4D4KHRQKWvvI
         fm08jDcaxy2VHf2C+jGLIM2OEd+KzJxMLQDba7+tTj7R1CdeyMH+2ojcymJtwktVnYoP
         AGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=2V6wX3N12UIlsNTs6da0XdA0V9BYWgA/hJ1wDtVB7cY=;
        b=jdl7lrTslmgyKtdy8vmllJtge2YnQfV/P+yoA7q61U69KpAGiH6iGVQYrZNdc2tI2L
         iM1nCowpyDjA7Aqo+elMpuW5mX4SJ61SvhY+m/0jtaIhUxQgbBj7doJWDj2RgHj2AusF
         0oesn1EMUQuF1KogYUIUfRDI36bR5QhNbioxfXu2CYnqla15HZFp4NNSMpJsenlcbeXI
         zNuFuVA3gJW1ybJz7AjeJnOWE9ltGxgHN6sDn62TgU1ggqhUUd7PLYxMTpTTSde+w2Wm
         1gUOlWaCjcNIzFzpiXa3e/b+fZXtCwbsy4zj72F1+QICZAajWYAc2wbf81Nta2sanF+g
         OrhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dzJMMgSk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dzJMMgSk;
       spf=pass (google.com: domain of ilina@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=ilina@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dzJMMgSk;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dzJMMgSk;
       spf=pass (google.com: domain of ilina@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=ilina@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA085601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 2 Feb 2018 23:02:32 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	sboyd@codeaurora.org, rnayak@codeaurora.org,
	asathyak@codeaurora.org, Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in FTRACE
Message-ID: <20180202230232.GB15464@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-4-ilina@codeaurora.org>
 <alpine.DEB.2.21.1802021652100.1472@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802021652100.1472@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591305373445487149?=
X-GMAIL-MSGID: =?utf-8?q?1591332101372317777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02 2018 at 15:57 +0000, Thomas Gleixner wrote:
>On Fri, 2 Feb 2018, Lina Iyer wrote:
>> +++ b/include/trace/events/pdc.h
>> @@ -0,0 +1,55 @@
>> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>
>Can you please use the proper SPDX identifiers instead of the boiler plate?
>Same for the driver source file.
>
Sure.

>> + */
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM pdc
>> +
>> +#if !defined(_TRACE_PDC_) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_PDC_H_
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +#define PDC_ENTRY		1
>> +#define PDC_TYPE_CONFIG		2
>> +
>> +TRACE_EVENT(irq_pin_config,
>
>This is really a too generic name for a PDC specific breakpoint.
>
Hmm.. right.

>Aside of that the question is whether this really justifies a trace
>point. Wouldn't it be sufficient to use the GENERIC_IRQ_DEBUGFS
>infrastructure to make this accessible via debugfs?
>
>
Some product configurations disable debugfs. I will ask around if this
can be dropped.

-- Lina
