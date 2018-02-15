Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162916AbeBOUvk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1167057AbeBOUvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:51:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8622921723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Feb 2018 15:51:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180215155135.187b1501@gandalf.local.home>
In-Reply-To: <20180215204118.GF23714@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
        <20180215173507.10989-4-ilina@codeaurora.org>
        <20180215204118.GF23714@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 20:41:18 +0000
Lina Iyer <ilina@codeaurora.org> wrote:


> >--- a/drivers/soc/qcom/Makefile
> >+++ b/drivers/soc/qcom/Makefile
> >@@ -1,4 +1,5 @@
> > # SPDX-License-Identifier: GPL-2.0
> >+CFLAGS_trace-rpmh.o := -I$(src)  
> I did this here..

Needs to be:

 CFLAGS_rpmh-rsc.o

You need to use the C file that has the CREATE_TRACE_POINTS define.

-- Steve

> 
> ...
> 
> >+#undef TRACE_INCLUDE_PATH
> >+#define TRACE_INCLUDE_PATH ../../drivers/soc/qcom
> >+  
> Yet, I had to define the whole path here for it to compile. Per comments
> I should just need to do this -
> 
> #define TRACE_INCLUDE_PATH .
> 
> But it doesn't work. What am I missing?
> 
> >+#undef TRACE_INCLUDE_FILE
> >+#define TRACE_INCLUDE_FILE trace-rpmh
> >+
> >+#include <trace/define_trace.h>
> >--  
> 
> Thanks,
> Lina
