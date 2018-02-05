Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeBEPu5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:50:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbeBEPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:50:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4EBC6022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Mon, 5 Feb 2018 15:50:48 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in FTRACE
Message-ID: <20180205155048.GA22036@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-4-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180202142200.6229-4-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, Feb 02 2018 at 14:22 +0000, Lina Iyer wrote:
>From: Archana Sathyakumar <asathyak@codeaurora.org>
>
>Log key PDC pin configuration in FTRACE.
>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/irqchip/qcom-pdc.c |  7 ++++++
> include/trace/events/pdc.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 62 insertions(+)
> create mode 100644 include/trace/events/pdc.h
>
>diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
>index a392380eada6..7f177ad88713 100644
>--- a/drivers/irqchip/qcom-pdc.c
>+++ b/drivers/irqchip/qcom-pdc.c
>@@ -26,6 +26,8 @@
> #include <linux/platform_device.h>
> #include <linux/slab.h>
> #include <linux/types.h>
>+#define CREATE_TRACE_POINTS
>+#include "trace/events/pdc.h"
>
In addition to this PDC patch, there are a few drivers with FTRACE
support coming for up QCOM SoCs. Would it make sense to open up a new
sub-folder for SoC specific FTRACE like say,
trace/events/soc/
trace/events/soc/qcom/

What would be your recommendation?

At the very least, I am thinking of renaming this file to
trace/events/qcom-pdc.h.

Thanks,
Lina
