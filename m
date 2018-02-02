Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x224rexaQJNk6dTmmLk19V0pucLtywe2e+Z+gIh1doymS0CHVCo6DPdYfuAE9LZVCbmx94j4o
ARC-Seal: i=1; a=rsa-sha256; t=1517587064; cv=none;
        d=google.com; s=arc-20160816;
        b=vK2NfuDqMrtkRMyUvuKnU4cnjovu49HmJdBO0a0widB/UuqqQ27dVoMSgrywQ/ZPtr
         UMfQNEV0Isifl566hV+t4naOXs93aN/6eWHMyXUK93gMgOGlv/bZ9CSVS0EPmPCrFo8/
         0IIuZZ2pp7npXX0YSILuCCjfzFzcCiJN03Jwq9P3m+Sh2rOmhey7K/YDWivZZJ0kdg+9
         4Fl0sXaT3lbTM+qrLlnN1ubYb88t0pHww8nl0OBxC1xXbX3In9B/29mOTD0QkaryIT0f
         gaQYa4+7ofAGZFa4jDqOaVq1wcRMcl32UBcMyoPONu7wSP+nOFmaidjZLVTEmq97jCju
         445g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=oEj2/lB9cBnq41p6AXVit7h/8H5/9zxKMARgiObPOgc=;
        b=h2GJjTDiwqQCZ0iCRQ6PV4hwhQfLYvM4Pe8yJLvD+EL1cwAlnpNLzyKyrorR9OaVNy
         n+zXGGkcf2twRCFcYsVBrW+y+JUwoeCcvjExrsALk+gbwPzR5fsOZFbQ9knpr1DRFg9r
         zblQ9dm4mpbLcPzcLdLXhL0+4zhSYb1QS1fRkzNROZFtrFbT59Cabo3JHaSxWUh6Ge+Y
         RBSnexFFaJBzdIHSgimvAM5XbXdtBgn7pK85J+3yxU0axBCqRBUbBa35Sr5uKCoxsAAC
         SUKK8NLq/dqzVoEVxAmOM48C+t9o76+FNAbUbCFqo/t7x0m+SG8bTHfp1LPrrUAGZlcm
         0YuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Fri, 2 Feb 2018 16:57:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lina Iyer <ilina@codeaurora.org>
cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
    LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
    sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
    Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in
 FTRACE
In-Reply-To: <20180202142200.6229-4-ilina@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1802021652100.1472@nanos.tec.linutronix.de>
References: <20180202142200.6229-1-ilina@codeaurora.org> <20180202142200.6229-4-ilina@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591305373445487149?=
X-GMAIL-MSGID: =?utf-8?q?1591305373445487149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Feb 2018, Lina Iyer wrote:
> +++ b/include/trace/events/pdc.h
> @@ -0,0 +1,55 @@
> +/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Can you please use the proper SPDX identifiers instead of the boiler plate?
Same for the driver source file.

> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pdc
> +
> +#if !defined(_TRACE_PDC_) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PDC_H_
> +
> +#include <linux/tracepoint.h>
> +
> +#define PDC_ENTRY		1
> +#define PDC_TYPE_CONFIG		2
> +
> +TRACE_EVENT(irq_pin_config,

This is really a too generic name for a PDC specific breakpoint.

Aside of that the question is whether this really justifies a trace
point. Wouldn't it be sufficient to use the GENERIC_IRQ_DEBUGFS
infrastructure to make this accessible via debugfs?

Thanks,

	tglx
