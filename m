Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeDNNJi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 09:09:38 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:48307 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbeDNNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 09:09:37 -0400
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel+linux-tracing@molgen.mpg.de>
Subject: How to disable tracing at runtime from the Linux kernel command line?
Message-ID: <2466c45d-8d77-6d57-58e2-cb1897034e2e@molgen.mpg.de>
Date: Sat, 14 Apr 2018 15:09:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


I am trying to reduce the boot time of a standard Linux distribution 
kernel. Currently, distributions – at least Debian und Ubuntu – enable 
function tracing.

```
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y

CONFIG_EVENT_TRACING=y
```

This is great, as it makes it easy to use tracing to hunt down things 
holding up the boot. But it also skews the boot time quite a lot.

```
$ sudo dmesg
[…]
[    0.318412] initcall init_graph_trace+0x0/0x64 returned 0 after 
199218 usecs
[…]
[    1.770287] calling  event_trace_init+0x0/0x2c2 @ 1
[    2.052871] initcall event_trace_init+0x0/0x2c2 returned 0 after 
275942 usecs
[…]
```

Is there a way to disable tracing on the Linux kernel command line to 
disable tracing?


Kind regards,

Paul
