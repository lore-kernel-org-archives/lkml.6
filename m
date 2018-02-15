Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167222AbeBOUzg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:55:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51700 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162995AbeBOUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:55:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6077460386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 15 Feb 2018 20:55:32 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180215205532.GA29280@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-4-ilina@codeaurora.org>
 <20180215204118.GF23714@codeaurora.org>
 <20180215155135.187b1501@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180215155135.187b1501@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15 2018 at 20:51 +0000, Steven Rostedt wrote:
>On Thu, 15 Feb 2018 20:41:18 +0000
>Lina Iyer <ilina@codeaurora.org> wrote:
>
>
>> >--- a/drivers/soc/qcom/Makefile
>> >+++ b/drivers/soc/qcom/Makefile
>> >@@ -1,4 +1,5 @@
>> > # SPDX-License-Identifier: GPL-2.0
>> >+CFLAGS_trace-rpmh.o := -I$(src)
>> I did this here..
>
>Needs to be:
>
> CFLAGS_rpmh-rsc.o
>
>You need to use the C file that has the CREATE_TRACE_POINTS define.
>
Thank you so much.

-- Lina

>-- Steve
>
>>
>> ...
>>
>> >+#undef TRACE_INCLUDE_PATH
>> >+#define TRACE_INCLUDE_PATH ../../drivers/soc/qcom
>> >+
>> Yet, I had to define the whole path here for it to compile. Per comments
>> I should just need to do this -
>>
>> #define TRACE_INCLUDE_PATH .
>>
>> But it doesn't work. What am I missing?
>>
>> >+#undef TRACE_INCLUDE_FILE
>> >+#define TRACE_INCLUDE_FILE trace-rpmh
>> >+
>> >+#include <trace/define_trace.h>
>> >--
>>
>> Thanks,
>> Lina
>
