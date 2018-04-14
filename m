Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeDNQaN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 12:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeDNQaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 12:30:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C6B2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 14 Apr 2018 12:30:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Menzel <pmenzel+linux-tracing@molgen.mpg.de>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: How to disable tracing at runtime from the Linux kernel command
 line?
Message-ID: <20180414123009.6d86d0f9@gandalf.local.home>
In-Reply-To: <2466c45d-8d77-6d57-58e2-cb1897034e2e@molgen.mpg.de>
References: <2466c45d-8d77-6d57-58e2-cb1897034e2e@molgen.mpg.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2018 15:09:33 +0200
Paul Menzel <pmenzel+linux-tracing@molgen.mpg.de> wrote:

> Dear Linux folks,
> 
> 
> I am trying to reduce the boot time of a standard Linux distribution 
> kernel. Currently, distributions – at least Debian und Ubuntu – enable 
> function tracing.
> 
> ```
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> 
> CONFIG_EVENT_TRACING=y
> ```
> 
> This is great, as it makes it easy to use tracing to hunt down things 
> holding up the boot. But it also skews the boot time quite a lot.
> 
> ```
> $ sudo dmesg
> […]
> [    0.318412] initcall init_graph_trace+0x0/0x64 returned 0 after 
> 199218 usecs
> […]
> [    1.770287] calling  event_trace_init+0x0/0x2c2 @ 1
> [    2.052871] initcall event_trace_init+0x0/0x2c2 returned 0 after 
> 275942 usecs
> […]
> ```
> 
> Is there a way to disable tracing on the Linux kernel command line to 
> disable tracing?
> 

Try initcall_blacklist. But you acquire all risks when doing so. I
never tried it, so I have no idea what side effects that may have.

-- Steve
