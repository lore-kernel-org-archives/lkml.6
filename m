Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbeCIXw2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932206AbeCIXw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:52:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3318F208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 18:52:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Subject: Re: [PATCH v4 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180309185223.19aa6c84@gandalf.local.home>
In-Reply-To: <20180309232543.24636-4-ilina@codeaurora.org>
References: <20180309232543.24636-1-ilina@codeaurora.org>
        <20180309232543.24636-4-ilina@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 16:25:36 -0700
Lina Iyer <ilina@codeaurora.org> wrote:

> Log sent RPMH requests and interrupt responses in FTRACE.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> 
> Changes in v4:
> 	- fix compilation issues, use __assign_str
> 	- use %#x instead of 0x%08x

Hmm, I don't believe libtraceevent (used by trace-cmd and perf)
supports "%#x". But that needs to be fixed in libtraceevent and you
don't need to modify this patch.

+			 __field(bool, wait)

Usually I would recommend against 'bool' in structures, but it
shouldn't affect the tracing code. Might want to look at how it
converts it in the /sys/kernel/tracing/events/rpmh/rpmh_send_msg/format
file. It probably makes no difference if it was an int.

Other than that... Looks good.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Changes in v3:
> 	- Use __string() instead of char *
> 	- fix TRACE_INCLUDE_PATH
> ---
