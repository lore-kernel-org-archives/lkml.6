Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeBERA1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753028AbeBERAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:00:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0063E2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 12:00:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in
 FTRACE
Message-ID: <20180205120017.4a386f0f@gandalf.local.home>
In-Reply-To: <20180205155048.GA22036@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
        <20180202142200.6229-4-ilina@codeaurora.org>
        <20180205155048.GA22036@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018 15:50:48 +0000
Lina Iyer <ilina@codeaurora.org> wrote:


> >diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> >index a392380eada6..7f177ad88713 100644
> >--- a/drivers/irqchip/qcom-pdc.c
> >+++ b/drivers/irqchip/qcom-pdc.c
> >@@ -26,6 +26,8 @@
> > #include <linux/platform_device.h>
> > #include <linux/slab.h>
> > #include <linux/types.h>
> >+#define CREATE_TRACE_POINTS
> >+#include "trace/events/pdc.h"
> >  
> In addition to this PDC patch, there are a few drivers with FTRACE
> support coming for up QCOM SoCs. Would it make sense to open up a new
> sub-folder for SoC specific FTRACE like say,
> trace/events/soc/
> trace/events/soc/qcom/
> 
> What would be your recommendation?
> 
> At the very least, I am thinking of renaming this file to
> trace/events/qcom-pdc.h.

I'm thinking it makes more sense to create the trace.h file inside the
drivers/irqchip/ directory. xfs does this, as well as other locations.

The include/trace/events/ was more of a generic method, but when events
start getting more specific, they should be in their own directories.

See samples/trace_events/* on how to have the file locally (or look at
xfs, search for trace in fs/xfs/Makefile).

-- Steve
