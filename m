Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF321C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE32683A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE32683A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964770AbeFZJt3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:49:29 -0400
Received: from osg.samsung.com ([64.30.133.232]:36974 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933312AbeFZJtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:49:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id A44F030BD9;
        Tue, 26 Jun 2018 02:49:23 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uhPSFBLPwUAt; Tue, 26 Jun 2018 02:49:20 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id 76DBB30B8B;
        Tue, 26 Jun 2018 02:49:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkb4-0000mE-DC; Tue, 26 Jun 2018 06:49:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        James Morris <james.morris@microsoft.com>,
        Xiongwei Song <sxwjean@me.com>,
        Changbin Du <changbin.du@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 9/9] docs: histogram.txt: convert it to ReST file format
Date:   Tue, 26 Jun 2018 06:49:11 -0300
Message-Id: <4e8df7559e48b4b90bca73cf08d4e01497a39066.1530005114.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530005114.git.mchehab+samsung@kernel.org>
References: <cover.1530005114.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite being mentioned at Documentation/trace/ftrace.rst as a
rst file, this file was still a text one, with several issues.

Convert it to ReST and add it to the trace index:
- Mark the document title as such;
- Identify and indent the literal blocks;
- Use the proper markups for table.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/trace/events.rst                |    2 +-
 .../trace/{histogram.txt => histogram.rst}    | 1242 +++++++++--------
 Documentation/trace/index.rst                 |    1 +
 kernel/trace/Kconfig                          |    2 +-
 4 files changed, 627 insertions(+), 620 deletions(-)
 rename Documentation/trace/{histogram.txt => histogram.rst} (73%)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 696dc69b8158..f7e1fcc0953c 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -524,4 +524,4 @@ The following commands are supported:
   totals derived from one or more trace event format fields and/or
   event counts (hitcount).
 
-  See Documentation/trace/histogram.txt for details and examples.
+  See Documentation/trace/histogram.rst for details and examples.
diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.rst
similarity index 73%
rename from Documentation/trace/histogram.txt
rename to Documentation/trace/histogram.rst
index 7ffea6aa22e3..5ac724baea7d 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.rst
@@ -1,6 +1,8 @@
-			     Event Histograms
+================
+Event Histograms
+================
 
-		    Documentation written by Tom Zanussi
+Documentation written by Tom Zanussi
 
 1. Introduction
 ===============
@@ -19,7 +21,7 @@
   derived from one or more trace event format fields and/or event
   counts (hitcount).
 
-  The format of a hist trigger is as follows:
+  The format of a hist trigger is as follows::
 
         hist:keys=<field1[,field2,...]>[:values=<field1[,field2,...]>]
           [:sort=<field1[,field2,...]>][:size=#entries][:pause][:continue]
@@ -68,6 +70,7 @@
   modified by appending any of the following modifiers to the field
   name:
 
+	=========== ==========================================
         .hex        display a number as a hex value
 	.sym        display an address as a symbol
 	.sym-offset display an address as a symbol and offset
@@ -75,6 +78,7 @@
 	.execname   display a common_pid as a program name
 	.log2       display log2 value rather than raw number
 	.usecs      display a common_timestamp in microseconds
+	=========== ==========================================
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
@@ -92,15 +96,15 @@
       pid-specific comm fields in the event itself.
 
   A typical usage scenario would be the following to enable a hist
-  trigger, read its current contents, and then turn it off:
+  trigger, read its current contents, and then turn it off::
 
-  # echo 'hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+    # echo 'hist:keys=skbaddr.hex:vals=len' > \
+      /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
-  # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
+    # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
 
-  # echo '!hist:keys=skbaddr.hex:vals=len' > \
-    /sys/kernel/debug/tracing/events/net/netif_rx/trigger
+    # echo '!hist:keys=skbaddr.hex:vals=len' > \
+      /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   The trigger file itself can be read to show the details of the
   currently attached hist trigger.  This information is also displayed
@@ -140,7 +144,7 @@
   can be attached to a given event, allowing that event to kick off
   and stop aggregations on a host of other events.
 
-  The format is very similar to the enable/disable_event triggers:
+  The format is very similar to the enable/disable_event triggers::
 
       enable_hist:<system>:<event>[:count]
       disable_hist:<system>:<event>[:count]
@@ -153,16 +157,16 @@
   A typical usage scenario for the enable_hist/disable_hist triggers
   would be to first set up a paused hist trigger on some event,
   followed by an enable_hist/disable_hist pair that turns the hist
-  aggregation on and off when conditions of interest are hit:
+  aggregation on and off when conditions of interest are hit::
 
-  # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
-    /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
+   # echo 'hist:keys=skbaddr.hex:vals=len:pause' > \
+      /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
 
-  # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
+    # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
+      /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
 
-  # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
-    /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
+    # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
+      /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
 
   The above sets up an initially paused hist trigger which is unpaused
   and starts aggregating events when a given program is executed, and
@@ -172,8 +176,8 @@
   The examples below provide a more concrete illustration of the
   concepts and typical usage patterns discussed above.
 
-  'special' event fields
-  ------------------------
+'special' event fields
+------------------------
 
   There are a number of 'special event fields' available for use as
   keys or values in a hist trigger.  These look like and behave as if
@@ -182,14 +186,16 @@
   event, and can be used anywhere an actual event field could be.
   They are:
 
-    common_timestamp       u64 - timestamp (from ring buffer) associated
-                                 with the event, in nanoseconds.  May be
-				 modified by .usecs to have timestamps
-				 interpreted as microseconds.
-    cpu                    int - the cpu on which the event occurred.
+    ====================== ==== =======================================
+    common_timestamp       u64  timestamp (from ring buffer) associated
+                                with the event, in nanoseconds.  May be
+			        modified by .usecs to have timestamps
+			        interpreted as microseconds.
+    cpu                    int  the cpu on which the event occurred.
+    ====================== ==== =======================================
 
-  Extended error information
-  --------------------------
+Extended error information
+--------------------------
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
@@ -199,7 +205,7 @@
   be available until the next hist trigger command for that event.
 
   If available for a given error condition, the extended error
-  information and usage takes the following form:
+  information and usage takes the following form::
 
     # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
     echo: write error: Invalid argument
@@ -213,7 +219,7 @@
 
   The first set of examples creates aggregations using the kmalloc
   event.  The fields that can be used for the hist trigger are listed
-  in the kmalloc event's format file:
+  in the kmalloc event's format file::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/format
     name: kmalloc
@@ -232,7 +238,7 @@
 
   We'll start by creating a hist trigger that generates a simple table
   that lists the total number of bytes requested for each function in
-  the kernel that made one or more calls to kmalloc:
+  the kernel that made one or more calls to kmalloc::
 
     # echo 'hist:key=call_site:val=bytes_req' > \
             /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -247,7 +253,7 @@
 
   We'll let it run for awhile and then dump the contents of the 'hist'
   file in the kmalloc event's subdirectory (for readability, a number
-  of entries have been omitted):
+  of entries have been omitted)::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
@@ -287,7 +293,7 @@
   specified in the trigger, followed by the value(s) also specified in
   the trigger.  At the beginning of the output is a line that displays
   the trigger info, which can also be displayed by reading the
-  'trigger' file:
+  'trigger' file::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
     hist:keys=call_site:vals=bytes_req:sort=hitcount:size=2048 [active]
@@ -317,7 +323,7 @@
   frequencies.
 
   To turn the hist trigger off, simply call up the trigger in the
-  command history and re-execute it with a '!' prepended:
+  command history and re-execute it with a '!' prepended::
 
     # echo '!hist:key=call_site:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -325,7 +331,7 @@
   Finally, notice that the call_site as displayed in the output above
   isn't really very useful.  It's an address, but normally addresses
   are displayed in hex.  To have a numeric field displayed as a hex
-  value, simply append '.hex' to the field name in the trigger:
+  value, simply append '.hex' to the field name in the trigger::
 
     # echo 'hist:key=call_site.hex:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -370,7 +376,7 @@
   when looking at text addresses are the corresponding symbols
   instead.  To have an address displayed as symbolic value instead,
   simply append '.sym' or '.sym-offset' to the field name in the
-  trigger:
+  trigger::
 
     # echo 'hist:key=call_site.sym:val=bytes_req' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -420,7 +426,7 @@
   run.  If instead we we wanted to see the top kmalloc callers in
   terms of the number of bytes requested rather than the number of
   calls, and we wanted the top caller to appear at the top, we can use
-  the 'sort' parameter, along with the 'descending' modifier:
+  the 'sort' parameter, along with the 'descending' modifier::
 
     # echo 'hist:key=call_site.sym:val=bytes_req:sort=bytes_req.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -461,7 +467,7 @@
         Dropped: 0
 
   To display the offset and size information in addition to the symbol
-  name, just use 'sym-offset' instead:
+  name, just use 'sym-offset' instead::
 
     # echo 'hist:key=call_site.sym-offset:val=bytes_req:sort=bytes_req.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -500,7 +506,7 @@
   We can also add multiple fields to the 'values' parameter.  For
   example, we might want to see the total number of bytes allocated
   alongside bytes requested, and display the result sorted by bytes
-  allocated in a descending order:
+  allocated in a descending order::
 
     # echo 'hist:keys=call_site.sym:values=bytes_req,bytes_alloc:sort=bytes_alloc.descending' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -543,7 +549,7 @@
   the hist trigger display symbolic call_sites, we can have the hist
   trigger additionally display the complete set of kernel stack traces
   that led to each call_site.  To do that, we simply use the special
-  value 'stacktrace' for the key parameter:
+  value 'stacktrace' for the key parameter::
 
     # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
            /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger
@@ -554,7 +560,7 @@
   event, along with a running total of any of the event fields for
   that event.  Here we tally bytes requested and bytes allocated for
   every callpath in the system that led up to a kmalloc (in this case
-  every callpath to a kmalloc for a kernel compile):
+  every callpath to a kmalloc for a kernel compile)::
 
     # cat /sys/kernel/debug/tracing/events/kmem/kmalloc/hist
     # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
@@ -652,7 +658,7 @@
   gather and display sorted totals for each process, you can use the
   special .execname modifier to display the executable names for the
   processes in the table rather than raw pids.  The example below
-  keeps a per-process sum of total bytes read:
+  keeps a per-process sum of total bytes read::
 
     # echo 'hist:key=common_pid.execname:val=count:sort=count.descending' > \
            /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/trigger
@@ -693,7 +699,7 @@
   gather and display a list of systemwide syscall hits, you can use
   the special .syscall modifier to display the syscall names rather
   than raw ids.  The example below keeps a running total of syscall
-  counts for the system during the run:
+  counts for the system during the run::
 
     # echo 'hist:key=id.syscall:val=hitcount' > \
            /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
@@ -735,19 +741,19 @@
         Entries: 72
         Dropped: 0
 
-    The syscall counts above provide a rough overall picture of system
-    call activity on the system; we can see for example that the most
-    popular system call on this system was the 'sys_ioctl' system call.
+  The syscall counts above provide a rough overall picture of system
+  call activity on the system; we can see for example that the most
+  popular system call on this system was the 'sys_ioctl' system call.
 
-    We can use 'compound' keys to refine that number and provide some
-    further insight as to which processes exactly contribute to the
-    overall ioctl count.
+  We can use 'compound' keys to refine that number and provide some
+  further insight as to which processes exactly contribute to the
+  overall ioctl count.
 
-    The command below keeps a hitcount for every unique combination of
-    system call id and pid - the end result is essentially a table
-    that keeps a per-pid sum of system call hits.  The results are
-    sorted using the system call id as the primary key, and the
-    hitcount sum as the secondary key:
+  The command below keeps a hitcount for every unique combination of
+  system call id and pid - the end result is essentially a table
+  that keeps a per-pid sum of system call hits.  The results are
+  sorted using the system call id as the primary key, and the
+  hitcount sum as the secondary key::
 
     # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount' > \
            /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
@@ -793,11 +799,11 @@
         Entries: 323
         Dropped: 0
 
-    The above list does give us a breakdown of the ioctl syscall by
-    pid, but it also gives us quite a bit more than that, which we
-    don't really care about at the moment.  Since we know the syscall
-    id for sys_ioctl (16, displayed next to the sys_ioctl name), we
-    can use that to filter out all the other syscalls:
+  The above list does give us a breakdown of the ioctl syscall by
+  pid, but it also gives us quite a bit more than that, which we
+  don't really care about at the moment.  Since we know the syscall
+  id for sys_ioctl (16, displayed next to the sys_ioctl name), we
+  can use that to filter out all the other syscalls::
 
     # echo 'hist:key=id.syscall,common_pid.execname:val=hitcount:sort=id,hitcount if id == 16' > \
            /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger
@@ -829,18 +835,18 @@
         Entries: 103
         Dropped: 0
 
-    The above output shows that 'compiz' and 'Xorg' are far and away
-    the heaviest ioctl callers (which might lead to questions about
-    whether they really need to be making all those calls and to
-    possible avenues for further investigation.)
+  The above output shows that 'compiz' and 'Xorg' are far and away
+  the heaviest ioctl callers (which might lead to questions about
+  whether they really need to be making all those calls and to
+  possible avenues for further investigation.)
 
-    The compound key examples used a key and a sum value (hitcount) to
-    sort the output, but we can just as easily use two keys instead.
-    Here's an example where we use a compound key composed of the the
-    common_pid and size event fields.  Sorting with pid as the primary
-    key and 'size' as the secondary key allows us to display an
-    ordered summary of the recvfrom sizes, with counts, received by
-    each process:
+  The compound key examples used a key and a sum value (hitcount) to
+  sort the output, but we can just as easily use two keys instead.
+  Here's an example where we use a compound key composed of the the
+  common_pid and size event fields.  Sorting with pid as the primary
+  key and 'size' as the secondary key allows us to display an
+  ordered summary of the recvfrom sizes, with counts, received by
+  each process::
 
     # echo 'hist:key=common_pid.execname,size:val=hitcount:sort=common_pid,size' > \
            /sys/kernel/debug/tracing/events/syscalls/sys_enter_recvfrom/trigger
@@ -893,7 +899,7 @@
   demonstrates how you can manually pause and continue a hist trigger.
   In this example, we'll aggregate fork counts and don't expect a
   large number of entries in the hash table, so we'll drop it to a
-  much smaller number, say 256:
+  much smaller number, say 256::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -929,7 +935,7 @@
 
   If we want to pause the hist trigger, we can simply append :pause to
   the command that started the trigger.  Notice that the trigger info
-  displays as [paused]:
+  displays as [paused]::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:pause' >> \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -966,7 +972,7 @@
 
   To manually continue having the trigger aggregate events, append
   :cont instead.  Notice that the trigger info displays as [active]
-  again, and the data has changed:
+  again, and the data has changed::
 
     # echo 'hist:key=child_comm:val=hitcount:size=256:cont' >> \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1020,7 +1026,7 @@
   wget.
 
   First we set up an initially paused stacktrace trigger on the
-  netif_receive_skb event:
+  netif_receive_skb event::
 
     # echo 'hist:key=stacktrace:vals=len:pause' > \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1031,7 +1037,7 @@
   set up on netif_receive_skb if and only if it sees a
   sched_process_exec event with a filename of '/usr/bin/wget'.  When
   that happens, all netif_receive_skb events are aggregated into a
-  hash table keyed on stacktrace:
+  hash table keyed on stacktrace::
 
     # echo 'enable_hist:net:netif_receive_skb if filename==/usr/bin/wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
@@ -1039,7 +1045,7 @@
   The aggregation continues until the netif_receive_skb is paused
   again, which is what the following disable_hist event does by
   creating a similar setup on the sched_process_exit event, using the
-  filter 'comm==wget':
+  filter 'comm==wget'::
 
     # echo 'disable_hist:net:netif_receive_skb if comm==wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exit/trigger
@@ -1051,7 +1057,7 @@
   The overall effect is that netif_receive_skb events are aggregated
   into the hash table for only the duration of the wget.  Executing a
   wget command and then listing the 'hist' file will display the
-  output generated by the wget command:
+  output generated by the wget command::
 
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
@@ -1136,13 +1142,13 @@
   Suppose we wanted to try another run of the previous example but
   this time also wanted to see the complete list of events that went
   into the histogram.  In order to avoid having to set everything up
-  again, we can just clear the histogram first:
+  again, we can just clear the histogram first::
 
     # echo 'hist:key=stacktrace:vals=len:clear' >> \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
 
   Just to verify that it is in fact cleared, here's what we now see in
-  the hist file:
+  the hist file::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
     # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
@@ -1156,7 +1162,7 @@
   event occurring during the new run, which are in fact the same
   events being aggregated into the hash table, we add some additional
   'enable_event' events to the triggering sched_process_exec and
-  sched_process_exit events as such:
+  sched_process_exit events as such::
 
     # echo 'enable_event:net:netif_receive_skb if filename==/usr/bin/wget' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
@@ -1167,7 +1173,7 @@
   If you read the trigger files for the sched_process_exec and
   sched_process_exit triggers, you should see two triggers for each:
   one enabling/disabling the hist aggregation and the other
-  enabling/disabling the logging of events:
+  enabling/disabling the logging of events::
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_process_exec/trigger
     enable_event:net:netif_receive_skb:unlimited if filename==/usr/bin/wget
@@ -1181,13 +1187,13 @@
   sched_process_exit events is hit and matches 'wget', it enables or
   disables both the histogram and the event log, and what you end up
   with is a hash table and set of events just covering the specified
-  duration.  Run the wget command again:
+  duration.  Run the wget command again::
 
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
   Displaying the 'hist' file should show something similar to what you
   saw in the last run, but this time you should also see the
-  individual events in the trace file:
+  individual events in the trace file::
 
     # cat /sys/kernel/debug/tracing/trace
 
@@ -1220,7 +1226,7 @@
   attached to a given event.  This capability can be useful for
   creating a set of different summaries derived from the same set of
   events, or for comparing the effects of different filters, among
-  other things.
+  other things::
 
     # echo 'hist:keys=skbaddr.hex:vals=len if len < 0' >> \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1241,7 +1247,7 @@
   any existing hist triggers beforehand).
 
   Displaying the contents of the 'hist' file for the event shows the
-  contents of all five histograms:
+  contents of all five histograms::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist
 
@@ -1361,7 +1367,7 @@
   output of events generated by tracepoints contained inside inline
   functions, but names can be used in a hist trigger on any event.
   For example, these two triggers when hit will update the same 'len'
-  field in the shared 'foo' histogram data:
+  field in the shared 'foo' histogram data::
 
     # echo 'hist:name=foo:keys=skbaddr.hex:vals=len' > \
            /sys/kernel/debug/tracing/events/net/netif_receive_skb/trigger
@@ -1369,7 +1375,7 @@
            /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   You can see that they're updating common histogram data by reading
-  each event's hist files at the same time:
+  each event's hist files at the same time::
 
     # cat /sys/kernel/debug/tracing/events/net/netif_receive_skb/hist;
       cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
@@ -1482,7 +1488,7 @@
   And here's an example that shows how to combine histogram data from
   any two events even if they don't share any 'compatible' fields
   other than 'hitcount' and 'stacktrace'.  These commands create a
-  couple of triggers named 'bar' using those fields:
+  couple of triggers named 'bar' using those fields::
 
     # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
            /sys/kernel/debug/tracing/events/sched/sched_process_fork/trigger
@@ -1490,7 +1496,7 @@
           /sys/kernel/debug/tracing/events/net/netif_rx/trigger
 
   And displaying the output of either shows some interesting if
-  somewhat confusing output:
+  somewhat confusing output::
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_process_fork/hist
     # cat /sys/kernel/debug/tracing/events/net/netif_rx/hist
@@ -1705,7 +1711,7 @@ to any event field.
 
 Either keys or values can be saved and retrieved in this way.  This
 creates a variable named 'ts0' for a histogram entry with the key
-'next_pid':
+'next_pid'::
 
   # echo 'hist:keys=next_pid:vals=$ts0:ts0=common_timestamp ... >> \
 	event/trigger
@@ -1721,40 +1727,40 @@ Because 'vals=' is used, the common_timestamp variable value above
 will also be summed as a normal histogram value would (though for a
 timestamp it makes little sense).
 
-The below shows that a key value can also be saved in the same way:
+The below shows that a key value can also be saved in the same way::
 
   # echo 'hist:timer_pid=common_pid:key=timer_pid ...' >> event/trigger
 
 If a variable isn't a key variable or prefixed with 'vals=', the
 associated event field will be saved in a variable but won't be summed
-as a value:
+as a value::
 
   # echo 'hist:keys=next_pid:ts1=common_timestamp ...' >> event/trigger
 
 Multiple variables can be assigned at the same time.  The below would
 result in both ts0 and b being created as variables, with both
-common_timestamp and field1 additionally being summed as values:
+common_timestamp and field1 additionally being summed as values::
 
   # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ...' >> \
 	event/trigger
 
 Note that variable assignments can appear either preceding or
 following their use.  The command below behaves identically to the
-command above:
+command above::
 
   # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ...' >> \
 	event/trigger
 
 Any number of variables not bound to a 'vals=' prefix can also be
 assigned by simply separating them with colons.  Below is the same
-thing but without the values being summed in the histogram:
+thing but without the values being summed in the histogram::
 
   # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ...' >> event/trigger
 
 Variables set as above can be referenced and used in expressions on
 another event.
 
-For example, here's how a latency can be calculated:
+For example, here's how a latency can be calculated::
 
   # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
   # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
@@ -1764,7 +1770,7 @@ variable ts0.  In the next line, ts0 is subtracted from the second
 event's timestamp to produce the latency, which is then assigned into
 yet another variable, 'wakeup_lat'.  The hist trigger below in turn
 makes use of the wakeup_lat variable to compute a combined latency
-using the same key and variable from yet another event:
+using the same key and variable from yet another event::
 
   # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
@@ -1784,7 +1790,7 @@ separated by semicolons, to the tracing/synthetic_events file.
 
 For instance, the following creates a new event named 'wakeup_latency'
 with 3 fields: lat, pid, and prio.  Each of those fields is simply a
-variable reference to a variable on another event:
+variable reference to a variable on another event::
 
   # echo 'wakeup_latency \
           u64 lat; \
@@ -1793,13 +1799,13 @@ variable reference to a variable on another event:
 	  /sys/kernel/debug/tracing/synthetic_events
 
 Reading the tracing/synthetic_events file lists all the currently
-defined synthetic events, in this case the event defined above:
+defined synthetic events, in this case the event defined above::
 
   # cat /sys/kernel/debug/tracing/synthetic_events
     wakeup_latency u64 lat; pid_t pid; int prio
 
 An existing synthetic event definition can be removed by prepending
-the command that defined it with a '!':
+the command that defined it with a '!'::
 
   # echo '!wakeup_latency u64 lat pid_t pid int prio' >> \
     /sys/kernel/debug/tracing/synthetic_events
@@ -1811,13 +1817,13 @@ and variables defined on other events (see Section 2.2.3 below on
 how that is done using hist trigger 'onmatch' action). Once that is
 done, the 'wakeup_latency' synthetic event instance is created.
 
-A histogram can now be defined for the new synthetic event:
+A histogram can now be defined for the new synthetic event::
 
   # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
         /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
 
 The new event is created under the tracing/events/synthetic/ directory
-and looks and behaves just like any other event:
+and looks and behaves just like any other event::
 
   # ls /sys/kernel/debug/tracing/events/synthetic/wakeup_latency
         enable  filter  format  hist  id  trigger
@@ -1872,74 +1878,74 @@ hist trigger specification.
     As an example the below defines a simple synthetic event and uses
     a variable defined on the sched_wakeup_new event as a parameter
     when invoking the synthetic event.  Here we define the synthetic
-    event:
+    event::
 
-    # echo 'wakeup_new_test pid_t pid' >> \
-           /sys/kernel/debug/tracing/synthetic_events
+      # echo 'wakeup_new_test pid_t pid' >> \
+             /sys/kernel/debug/tracing/synthetic_events
 
-    # cat /sys/kernel/debug/tracing/synthetic_events
-          wakeup_new_test pid_t pid
+      # cat /sys/kernel/debug/tracing/synthetic_events
+            wakeup_new_test pid_t pid
 
     The following hist trigger both defines the missing testpid
     variable and specifies an onmatch() action that generates a
     wakeup_new_test synthetic event whenever a sched_wakeup_new event
     occurs, which because of the 'if comm == "cyclictest"' filter only
-    happens when the executable is cyclictest:
+    happens when the executable is cyclictest::
 
-    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
-            wakeup_new_test($testpid) if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+      # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
+              wakeup_new_test($testpid) if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
     Creating and displaying a histogram based on those events is now
     just a matter of using the fields and new synthetic event in the
-    tracing/events/synthetic directory, as usual:
+    tracing/events/synthetic directory, as usual::
 
-    # echo 'hist:keys=pid:sort=pid' >> \
-           /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
+      # echo 'hist:keys=pid:sort=pid' >> \
+             /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/trigger
 
     Running 'cyclictest' should cause wakeup_new events to generate
     wakeup_new_test synthetic events which should result in histogram
-    output in the wakeup_new_test event's hist file:
+    output in the wakeup_new_test event's hist file::
 
-    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
+      # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_new_test/hist
 
     A more typical usage would be to use two events to calculate a
     latency.  The following example uses a set of hist triggers to
-    produce a 'wakeup_latency' histogram:
+    produce a 'wakeup_latency' histogram.
 
-    First, we define a 'wakeup_latency' synthetic event:
+    First, we define a 'wakeup_latency' synthetic event::
 
-    # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
-            /sys/kernel/debug/tracing/synthetic_events
+      # echo 'wakeup_latency u64 lat; pid_t pid; int prio' >> \
+              /sys/kernel/debug/tracing/synthetic_events
 
     Next, we specify that whenever we see a sched_waking event for a
-    cyclictest thread, save the timestamp in a 'ts0' variable:
+    cyclictest thread, save the timestamp in a 'ts0' variable::
 
-    # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=common_timestamp.usecs \
-            if comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+      # echo 'hist:keys=$saved_pid:saved_pid=pid:ts0=common_timestamp.usecs \
+              if comm=="cyclictest"' >> \
+	      /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
     Then, when the corresponding thread is actually scheduled onto the
     CPU by a sched_switch event, calculate the latency and use that
     along with another variable and an event field to generate a
-    wakeup_latency synthetic event:
+    wakeup_latency synthetic event::
 
-    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
-            onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
-	            $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+      # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
+              onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\
+	              $saved_pid,next_prio) if next_comm=="cyclictest"' >> \
+	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
 
     We also need to create a histogram on the wakeup_latency synthetic
-    event in order to aggregate the generated synthetic event data:
+    event in order to aggregate the generated synthetic event data::
 
-    # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
-            /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
+      # echo 'hist:keys=pid,prio,lat:sort=pid,lat' >> \
+              /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
 
     Finally, once we've run cyclictest to actually generate some
     events, we can see the output by looking at the wakeup_latency
-    synthetic event's hist file:
+    synthetic event's hist file::
 
-    # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
+      # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
 
   - onmax(var).save(field,..	.)
 
@@ -1961,38 +1967,38 @@ hist trigger specification.
     back to that pid, the timestamp difference is calculated.  If the
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, the values specified in the save() fields are
-    recorded:
+    recorded::
 
-    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
-            if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+      # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+              if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
-    # echo 'hist:keys=next_pid:\
-            wakeup_lat=common_timestamp.usecs-$ts0:\
-            onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
-            if next_comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+      # echo 'hist:keys=next_pid:\
+              wakeup_lat=common_timestamp.usecs-$ts0:\
+              onmax($wakeup_lat).save(next_comm,prev_pid,prev_prio,prev_comm) \
+              if next_comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
 
     When the histogram is displayed, the max value and the saved
     values corresponding to the max are displayed following the rest
-    of the fields:
+    of the fields::
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
-      { next_pid:       2255 } hitcount:        239
-        common_timestamp-ts0:          0
-        max:         27
-	next_comm: cyclictest
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+        { next_pid:       2255 } hitcount:        239
+          common_timestamp-ts0:          0
+          max:         27
+	  next_comm: cyclictest
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
 
-      { next_pid:       2256 } hitcount:       2355
-        common_timestamp-ts0: 0
-        max:         49  next_comm: cyclictest
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
+        { next_pid:       2256 } hitcount:       2355
+          common_timestamp-ts0: 0
+          max:         49  next_comm: cyclictest
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/0
 
-      Totals:
-          Hits: 12970
-          Entries: 2
-          Dropped: 0
+        Totals:
+            Hits: 12970
+            Entries: 2
+            Dropped: 0
 
 3. User space creating a trigger
 --------------------------------
@@ -2002,24 +2008,24 @@ ring buffer. This can also act like an event, by writing into the trigger
 file located in /sys/kernel/tracing/events/ftrace/print/
 
 Modifying cyclictest to write into the trace_marker file before it sleeps
-and after it wakes up, something like this:
+and after it wakes up, something like this::
 
-static void traceputs(char *str)
-{
+  static void traceputs(char *str)
+  {
 	/* tracemark_fd is the trace_marker file descriptor */
 	if (tracemark_fd < 0)
 		return;
 	/* write the tracemark message */
 	write(tracemark_fd, str, strlen(str));
-}
+  }
 
-And later add something like:
+And later add something like::
 
 	traceputs("start");
 	clock_nanosleep(...);
 	traceputs("end");
 
-We can make a histogram from this:
+We can make a histogram from this::
 
  # cd /sys/kernel/tracing
  # echo 'latency u64 lat' > synthetic_events
@@ -2034,7 +2040,7 @@ it will call the "latency" synthetic event with the calculated latency as its
 parameter. Finally, a histogram is added to the latency synthetic event to
 record the calculated latency along with the pid.
 
-Now running cyclictest with:
+Now running cyclictest with::
 
  # ./cyclictest -p80 -d0 -i250 -n -a -t --tracemark -b 1000
 
@@ -2049,297 +2055,297 @@ Now running cyclictest with:
 
 Note, the -b 1000 is used just to make --tracemark available.
 
-Then we can see the histogram created by this with:
+Then we can see the histogram created by this with::
 
  # cat events/synthetic/latency/hist
-# event histogram
-#
-# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
-#
+ # event histogram
+ #
+ # trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
+ #
 
-{ lat:        107, common_pid:       2039 } hitcount:          1
-{ lat:        122, common_pid:       2041 } hitcount:          1
-{ lat:        166, common_pid:       2039 } hitcount:          1
-{ lat:        174, common_pid:       2039 } hitcount:          1
-{ lat:        194, common_pid:       2041 } hitcount:          1
-{ lat:        196, common_pid:       2036 } hitcount:          1
-{ lat:        197, common_pid:       2038 } hitcount:          1
-{ lat:        198, common_pid:       2039 } hitcount:          1
-{ lat:        199, common_pid:       2039 } hitcount:          1
-{ lat:        200, common_pid:       2041 } hitcount:          1
-{ lat:        201, common_pid:       2039 } hitcount:          2
-{ lat:        202, common_pid:       2038 } hitcount:          1
-{ lat:        202, common_pid:       2043 } hitcount:          1
-{ lat:        203, common_pid:       2039 } hitcount:          1
-{ lat:        203, common_pid:       2036 } hitcount:          1
-{ lat:        203, common_pid:       2041 } hitcount:          1
-{ lat:        206, common_pid:       2038 } hitcount:          2
-{ lat:        207, common_pid:       2039 } hitcount:          1
-{ lat:        207, common_pid:       2036 } hitcount:          1
-{ lat:        208, common_pid:       2040 } hitcount:          1
-{ lat:        209, common_pid:       2043 } hitcount:          1
-{ lat:        210, common_pid:       2039 } hitcount:          1
-{ lat:        211, common_pid:       2039 } hitcount:          4
-{ lat:        212, common_pid:       2043 } hitcount:          1
-{ lat:        212, common_pid:       2039 } hitcount:          2
-{ lat:        213, common_pid:       2039 } hitcount:          1
-{ lat:        214, common_pid:       2038 } hitcount:          1
-{ lat:        214, common_pid:       2039 } hitcount:          2
-{ lat:        214, common_pid:       2042 } hitcount:          1
-{ lat:        215, common_pid:       2039 } hitcount:          1
-{ lat:        217, common_pid:       2036 } hitcount:          1
-{ lat:        217, common_pid:       2040 } hitcount:          1
-{ lat:        217, common_pid:       2039 } hitcount:          1
-{ lat:        218, common_pid:       2039 } hitcount:          6
-{ lat:        219, common_pid:       2039 } hitcount:          9
-{ lat:        220, common_pid:       2039 } hitcount:         11
-{ lat:        221, common_pid:       2039 } hitcount:          5
-{ lat:        221, common_pid:       2042 } hitcount:          1
-{ lat:        222, common_pid:       2039 } hitcount:          7
-{ lat:        223, common_pid:       2036 } hitcount:          1
-{ lat:        223, common_pid:       2039 } hitcount:          3
-{ lat:        224, common_pid:       2039 } hitcount:          4
-{ lat:        224, common_pid:       2037 } hitcount:          1
-{ lat:        224, common_pid:       2036 } hitcount:          2
-{ lat:        225, common_pid:       2039 } hitcount:          5
-{ lat:        225, common_pid:       2042 } hitcount:          1
-{ lat:        226, common_pid:       2039 } hitcount:          7
-{ lat:        226, common_pid:       2036 } hitcount:          4
-{ lat:        227, common_pid:       2039 } hitcount:          6
-{ lat:        227, common_pid:       2036 } hitcount:         12
-{ lat:        227, common_pid:       2043 } hitcount:          1
-{ lat:        228, common_pid:       2039 } hitcount:          7
-{ lat:        228, common_pid:       2036 } hitcount:         14
-{ lat:        229, common_pid:       2039 } hitcount:          9
-{ lat:        229, common_pid:       2036 } hitcount:          8
-{ lat:        229, common_pid:       2038 } hitcount:          1
-{ lat:        230, common_pid:       2039 } hitcount:         11
-{ lat:        230, common_pid:       2036 } hitcount:          6
-{ lat:        230, common_pid:       2043 } hitcount:          1
-{ lat:        230, common_pid:       2042 } hitcount:          2
-{ lat:        231, common_pid:       2041 } hitcount:          1
-{ lat:        231, common_pid:       2036 } hitcount:          6
-{ lat:        231, common_pid:       2043 } hitcount:          1
-{ lat:        231, common_pid:       2039 } hitcount:          8
-{ lat:        232, common_pid:       2037 } hitcount:          1
-{ lat:        232, common_pid:       2039 } hitcount:          6
-{ lat:        232, common_pid:       2040 } hitcount:          2
-{ lat:        232, common_pid:       2036 } hitcount:          5
-{ lat:        232, common_pid:       2043 } hitcount:          1
-{ lat:        233, common_pid:       2036 } hitcount:          5
-{ lat:        233, common_pid:       2039 } hitcount:         11
-{ lat:        234, common_pid:       2039 } hitcount:          4
-{ lat:        234, common_pid:       2038 } hitcount:          2
-{ lat:        234, common_pid:       2043 } hitcount:          2
-{ lat:        234, common_pid:       2036 } hitcount:         11
-{ lat:        234, common_pid:       2040 } hitcount:          1
-{ lat:        235, common_pid:       2037 } hitcount:          2
-{ lat:        235, common_pid:       2036 } hitcount:          8
-{ lat:        235, common_pid:       2043 } hitcount:          2
-{ lat:        235, common_pid:       2039 } hitcount:          5
-{ lat:        235, common_pid:       2042 } hitcount:          2
-{ lat:        235, common_pid:       2040 } hitcount:          4
-{ lat:        235, common_pid:       2041 } hitcount:          1
-{ lat:        236, common_pid:       2036 } hitcount:          7
-{ lat:        236, common_pid:       2037 } hitcount:          1
-{ lat:        236, common_pid:       2041 } hitcount:          5
-{ lat:        236, common_pid:       2039 } hitcount:          3
-{ lat:        236, common_pid:       2043 } hitcount:          9
-{ lat:        236, common_pid:       2040 } hitcount:          7
-{ lat:        237, common_pid:       2037 } hitcount:          1
-{ lat:        237, common_pid:       2040 } hitcount:          1
-{ lat:        237, common_pid:       2036 } hitcount:          9
-{ lat:        237, common_pid:       2039 } hitcount:          3
-{ lat:        237, common_pid:       2043 } hitcount:          8
-{ lat:        237, common_pid:       2042 } hitcount:          2
-{ lat:        237, common_pid:       2041 } hitcount:          2
-{ lat:        238, common_pid:       2043 } hitcount:         10
-{ lat:        238, common_pid:       2040 } hitcount:          1
-{ lat:        238, common_pid:       2037 } hitcount:          9
-{ lat:        238, common_pid:       2038 } hitcount:          1
-{ lat:        238, common_pid:       2039 } hitcount:          1
-{ lat:        238, common_pid:       2042 } hitcount:          3
-{ lat:        238, common_pid:       2036 } hitcount:          7
-{ lat:        239, common_pid:       2041 } hitcount:          1
-{ lat:        239, common_pid:       2043 } hitcount:         11
-{ lat:        239, common_pid:       2037 } hitcount:         11
-{ lat:        239, common_pid:       2038 } hitcount:          6
-{ lat:        239, common_pid:       2036 } hitcount:          7
-{ lat:        239, common_pid:       2040 } hitcount:          1
-{ lat:        239, common_pid:       2042 } hitcount:          9
-{ lat:        240, common_pid:       2037 } hitcount:         29
-{ lat:        240, common_pid:       2043 } hitcount:         15
-{ lat:        240, common_pid:       2040 } hitcount:         44
-{ lat:        240, common_pid:       2039 } hitcount:          1
-{ lat:        240, common_pid:       2041 } hitcount:          2
-{ lat:        240, common_pid:       2038 } hitcount:          1
-{ lat:        240, common_pid:       2036 } hitcount:         10
-{ lat:        240, common_pid:       2042 } hitcount:         13
-{ lat:        241, common_pid:       2036 } hitcount:         21
-{ lat:        241, common_pid:       2041 } hitcount:         36
-{ lat:        241, common_pid:       2037 } hitcount:         34
-{ lat:        241, common_pid:       2042 } hitcount:         14
-{ lat:        241, common_pid:       2040 } hitcount:         94
-{ lat:        241, common_pid:       2039 } hitcount:         12
-{ lat:        241, common_pid:       2038 } hitcount:          2
-{ lat:        241, common_pid:       2043 } hitcount:         28
-{ lat:        242, common_pid:       2040 } hitcount:        109
-{ lat:        242, common_pid:       2041 } hitcount:        506
-{ lat:        242, common_pid:       2039 } hitcount:        155
-{ lat:        242, common_pid:       2042 } hitcount:         21
-{ lat:        242, common_pid:       2037 } hitcount:         52
-{ lat:        242, common_pid:       2043 } hitcount:         21
-{ lat:        242, common_pid:       2036 } hitcount:         16
-{ lat:        242, common_pid:       2038 } hitcount:        156
-{ lat:        243, common_pid:       2037 } hitcount:         46
-{ lat:        243, common_pid:       2039 } hitcount:         40
-{ lat:        243, common_pid:       2042 } hitcount:        119
-{ lat:        243, common_pid:       2041 } hitcount:        611
-{ lat:        243, common_pid:       2036 } hitcount:         69
-{ lat:        243, common_pid:       2038 } hitcount:        784
-{ lat:        243, common_pid:       2040 } hitcount:        323
-{ lat:        243, common_pid:       2043 } hitcount:         14
-{ lat:        244, common_pid:       2043 } hitcount:         35
-{ lat:        244, common_pid:       2042 } hitcount:        305
-{ lat:        244, common_pid:       2039 } hitcount:          8
-{ lat:        244, common_pid:       2040 } hitcount:       4515
-{ lat:        244, common_pid:       2038 } hitcount:        371
-{ lat:        244, common_pid:       2037 } hitcount:         31
-{ lat:        244, common_pid:       2036 } hitcount:        114
-{ lat:        244, common_pid:       2041 } hitcount:       3396
-{ lat:        245, common_pid:       2036 } hitcount:        700
-{ lat:        245, common_pid:       2041 } hitcount:       2772
-{ lat:        245, common_pid:       2037 } hitcount:        268
-{ lat:        245, common_pid:       2039 } hitcount:        472
-{ lat:        245, common_pid:       2038 } hitcount:       2758
-{ lat:        245, common_pid:       2042 } hitcount:       3833
-{ lat:        245, common_pid:       2040 } hitcount:       3105
-{ lat:        245, common_pid:       2043 } hitcount:        645
-{ lat:        246, common_pid:       2038 } hitcount:       3451
-{ lat:        246, common_pid:       2041 } hitcount:        142
-{ lat:        246, common_pid:       2037 } hitcount:       5101
-{ lat:        246, common_pid:       2040 } hitcount:         68
-{ lat:        246, common_pid:       2043 } hitcount:       5099
-{ lat:        246, common_pid:       2039 } hitcount:       5608
-{ lat:        246, common_pid:       2042 } hitcount:       3723
-{ lat:        246, common_pid:       2036 } hitcount:       4738
-{ lat:        247, common_pid:       2042 } hitcount:        312
-{ lat:        247, common_pid:       2043 } hitcount:       2385
-{ lat:        247, common_pid:       2041 } hitcount:        452
-{ lat:        247, common_pid:       2038 } hitcount:        792
-{ lat:        247, common_pid:       2040 } hitcount:         78
-{ lat:        247, common_pid:       2036 } hitcount:       2375
-{ lat:        247, common_pid:       2039 } hitcount:       1834
-{ lat:        247, common_pid:       2037 } hitcount:       2655
-{ lat:        248, common_pid:       2037 } hitcount:         36
-{ lat:        248, common_pid:       2042 } hitcount:         11
-{ lat:        248, common_pid:       2038 } hitcount:        122
-{ lat:        248, common_pid:       2036 } hitcount:        135
-{ lat:        248, common_pid:       2039 } hitcount:         26
-{ lat:        248, common_pid:       2041 } hitcount:        503
-{ lat:        248, common_pid:       2043 } hitcount:         66
-{ lat:        248, common_pid:       2040 } hitcount:         46
-{ lat:        249, common_pid:       2037 } hitcount:         29
-{ lat:        249, common_pid:       2038 } hitcount:          1
-{ lat:        249, common_pid:       2043 } hitcount:         29
-{ lat:        249, common_pid:       2039 } hitcount:          8
-{ lat:        249, common_pid:       2042 } hitcount:         56
-{ lat:        249, common_pid:       2040 } hitcount:         27
-{ lat:        249, common_pid:       2041 } hitcount:         11
-{ lat:        249, common_pid:       2036 } hitcount:         27
-{ lat:        250, common_pid:       2038 } hitcount:          1
-{ lat:        250, common_pid:       2036 } hitcount:         30
-{ lat:        250, common_pid:       2040 } hitcount:         19
-{ lat:        250, common_pid:       2043 } hitcount:         22
-{ lat:        250, common_pid:       2042 } hitcount:         20
-{ lat:        250, common_pid:       2041 } hitcount:          1
-{ lat:        250, common_pid:       2039 } hitcount:          6
-{ lat:        250, common_pid:       2037 } hitcount:         48
-{ lat:        251, common_pid:       2037 } hitcount:         43
-{ lat:        251, common_pid:       2039 } hitcount:          1
-{ lat:        251, common_pid:       2036 } hitcount:         12
-{ lat:        251, common_pid:       2042 } hitcount:          2
-{ lat:        251, common_pid:       2041 } hitcount:          1
-{ lat:        251, common_pid:       2043 } hitcount:         15
-{ lat:        251, common_pid:       2040 } hitcount:          3
-{ lat:        252, common_pid:       2040 } hitcount:          1
-{ lat:        252, common_pid:       2036 } hitcount:         12
-{ lat:        252, common_pid:       2037 } hitcount:         21
-{ lat:        252, common_pid:       2043 } hitcount:         14
-{ lat:        253, common_pid:       2037 } hitcount:         21
-{ lat:        253, common_pid:       2039 } hitcount:          2
-{ lat:        253, common_pid:       2036 } hitcount:          9
-{ lat:        253, common_pid:       2043 } hitcount:          6
-{ lat:        253, common_pid:       2040 } hitcount:          1
-{ lat:        254, common_pid:       2036 } hitcount:          8
-{ lat:        254, common_pid:       2043 } hitcount:          3
-{ lat:        254, common_pid:       2041 } hitcount:          1
-{ lat:        254, common_pid:       2042 } hitcount:          1
-{ lat:        254, common_pid:       2039 } hitcount:          1
-{ lat:        254, common_pid:       2037 } hitcount:         12
-{ lat:        255, common_pid:       2043 } hitcount:          1
-{ lat:        255, common_pid:       2037 } hitcount:          2
-{ lat:        255, common_pid:       2036 } hitcount:          2
-{ lat:        255, common_pid:       2039 } hitcount:          8
-{ lat:        256, common_pid:       2043 } hitcount:          1
-{ lat:        256, common_pid:       2036 } hitcount:          4
-{ lat:        256, common_pid:       2039 } hitcount:          6
-{ lat:        257, common_pid:       2039 } hitcount:          5
-{ lat:        257, common_pid:       2036 } hitcount:          4
-{ lat:        258, common_pid:       2039 } hitcount:          5
-{ lat:        258, common_pid:       2036 } hitcount:          2
-{ lat:        259, common_pid:       2036 } hitcount:          7
-{ lat:        259, common_pid:       2039 } hitcount:          7
-{ lat:        260, common_pid:       2036 } hitcount:          8
-{ lat:        260, common_pid:       2039 } hitcount:          6
-{ lat:        261, common_pid:       2036 } hitcount:          5
-{ lat:        261, common_pid:       2039 } hitcount:          7
-{ lat:        262, common_pid:       2039 } hitcount:          5
-{ lat:        262, common_pid:       2036 } hitcount:          5
-{ lat:        263, common_pid:       2039 } hitcount:          7
-{ lat:        263, common_pid:       2036 } hitcount:          7
-{ lat:        264, common_pid:       2039 } hitcount:          9
-{ lat:        264, common_pid:       2036 } hitcount:          9
-{ lat:        265, common_pid:       2036 } hitcount:          5
-{ lat:        265, common_pid:       2039 } hitcount:          1
-{ lat:        266, common_pid:       2036 } hitcount:          1
-{ lat:        266, common_pid:       2039 } hitcount:          3
-{ lat:        267, common_pid:       2036 } hitcount:          1
-{ lat:        267, common_pid:       2039 } hitcount:          3
-{ lat:        268, common_pid:       2036 } hitcount:          1
-{ lat:        268, common_pid:       2039 } hitcount:          6
-{ lat:        269, common_pid:       2036 } hitcount:          1
-{ lat:        269, common_pid:       2043 } hitcount:          1
-{ lat:        269, common_pid:       2039 } hitcount:          2
-{ lat:        270, common_pid:       2040 } hitcount:          1
-{ lat:        270, common_pid:       2039 } hitcount:          6
-{ lat:        271, common_pid:       2041 } hitcount:          1
-{ lat:        271, common_pid:       2039 } hitcount:          5
-{ lat:        272, common_pid:       2039 } hitcount:         10
-{ lat:        273, common_pid:       2039 } hitcount:          8
-{ lat:        274, common_pid:       2039 } hitcount:          2
-{ lat:        275, common_pid:       2039 } hitcount:          1
-{ lat:        276, common_pid:       2039 } hitcount:          2
-{ lat:        276, common_pid:       2037 } hitcount:          1
-{ lat:        276, common_pid:       2038 } hitcount:          1
-{ lat:        277, common_pid:       2039 } hitcount:          1
-{ lat:        277, common_pid:       2042 } hitcount:          1
-{ lat:        278, common_pid:       2039 } hitcount:          1
-{ lat:        279, common_pid:       2039 } hitcount:          4
-{ lat:        279, common_pid:       2043 } hitcount:          1
-{ lat:        280, common_pid:       2039 } hitcount:          3
-{ lat:        283, common_pid:       2036 } hitcount:          2
-{ lat:        284, common_pid:       2039 } hitcount:          1
-{ lat:        284, common_pid:       2043 } hitcount:          1
-{ lat:        288, common_pid:       2039 } hitcount:          1
-{ lat:        289, common_pid:       2039 } hitcount:          1
-{ lat:        300, common_pid:       2039 } hitcount:          1
-{ lat:        384, common_pid:       2039 } hitcount:          1
+ { lat:        107, common_pid:       2039 } hitcount:          1
+ { lat:        122, common_pid:       2041 } hitcount:          1
+ { lat:        166, common_pid:       2039 } hitcount:          1
+ { lat:        174, common_pid:       2039 } hitcount:          1
+ { lat:        194, common_pid:       2041 } hitcount:          1
+ { lat:        196, common_pid:       2036 } hitcount:          1
+ { lat:        197, common_pid:       2038 } hitcount:          1
+ { lat:        198, common_pid:       2039 } hitcount:          1
+ { lat:        199, common_pid:       2039 } hitcount:          1
+ { lat:        200, common_pid:       2041 } hitcount:          1
+ { lat:        201, common_pid:       2039 } hitcount:          2
+ { lat:        202, common_pid:       2038 } hitcount:          1
+ { lat:        202, common_pid:       2043 } hitcount:          1
+ { lat:        203, common_pid:       2039 } hitcount:          1
+ { lat:        203, common_pid:       2036 } hitcount:          1
+ { lat:        203, common_pid:       2041 } hitcount:          1
+ { lat:        206, common_pid:       2038 } hitcount:          2
+ { lat:        207, common_pid:       2039 } hitcount:          1
+ { lat:        207, common_pid:       2036 } hitcount:          1
+ { lat:        208, common_pid:       2040 } hitcount:          1
+ { lat:        209, common_pid:       2043 } hitcount:          1
+ { lat:        210, common_pid:       2039 } hitcount:          1
+ { lat:        211, common_pid:       2039 } hitcount:          4
+ { lat:        212, common_pid:       2043 } hitcount:          1
+ { lat:        212, common_pid:       2039 } hitcount:          2
+ { lat:        213, common_pid:       2039 } hitcount:          1
+ { lat:        214, common_pid:       2038 } hitcount:          1
+ { lat:        214, common_pid:       2039 } hitcount:          2
+ { lat:        214, common_pid:       2042 } hitcount:          1
+ { lat:        215, common_pid:       2039 } hitcount:          1
+ { lat:        217, common_pid:       2036 } hitcount:          1
+ { lat:        217, common_pid:       2040 } hitcount:          1
+ { lat:        217, common_pid:       2039 } hitcount:          1
+ { lat:        218, common_pid:       2039 } hitcount:          6
+ { lat:        219, common_pid:       2039 } hitcount:          9
+ { lat:        220, common_pid:       2039 } hitcount:         11
+ { lat:        221, common_pid:       2039 } hitcount:          5
+ { lat:        221, common_pid:       2042 } hitcount:          1
+ { lat:        222, common_pid:       2039 } hitcount:          7
+ { lat:        223, common_pid:       2036 } hitcount:          1
+ { lat:        223, common_pid:       2039 } hitcount:          3
+ { lat:        224, common_pid:       2039 } hitcount:          4
+ { lat:        224, common_pid:       2037 } hitcount:          1
+ { lat:        224, common_pid:       2036 } hitcount:          2
+ { lat:        225, common_pid:       2039 } hitcount:          5
+ { lat:        225, common_pid:       2042 } hitcount:          1
+ { lat:        226, common_pid:       2039 } hitcount:          7
+ { lat:        226, common_pid:       2036 } hitcount:          4
+ { lat:        227, common_pid:       2039 } hitcount:          6
+ { lat:        227, common_pid:       2036 } hitcount:         12
+ { lat:        227, common_pid:       2043 } hitcount:          1
+ { lat:        228, common_pid:       2039 } hitcount:          7
+ { lat:        228, common_pid:       2036 } hitcount:         14
+ { lat:        229, common_pid:       2039 } hitcount:          9
+ { lat:        229, common_pid:       2036 } hitcount:          8
+ { lat:        229, common_pid:       2038 } hitcount:          1
+ { lat:        230, common_pid:       2039 } hitcount:         11
+ { lat:        230, common_pid:       2036 } hitcount:          6
+ { lat:        230, common_pid:       2043 } hitcount:          1
+ { lat:        230, common_pid:       2042 } hitcount:          2
+ { lat:        231, common_pid:       2041 } hitcount:          1
+ { lat:        231, common_pid:       2036 } hitcount:          6
+ { lat:        231, common_pid:       2043 } hitcount:          1
+ { lat:        231, common_pid:       2039 } hitcount:          8
+ { lat:        232, common_pid:       2037 } hitcount:          1
+ { lat:        232, common_pid:       2039 } hitcount:          6
+ { lat:        232, common_pid:       2040 } hitcount:          2
+ { lat:        232, common_pid:       2036 } hitcount:          5
+ { lat:        232, common_pid:       2043 } hitcount:          1
+ { lat:        233, common_pid:       2036 } hitcount:          5
+ { lat:        233, common_pid:       2039 } hitcount:         11
+ { lat:        234, common_pid:       2039 } hitcount:          4
+ { lat:        234, common_pid:       2038 } hitcount:          2
+ { lat:        234, common_pid:       2043 } hitcount:          2
+ { lat:        234, common_pid:       2036 } hitcount:         11
+ { lat:        234, common_pid:       2040 } hitcount:          1
+ { lat:        235, common_pid:       2037 } hitcount:          2
+ { lat:        235, common_pid:       2036 } hitcount:          8
+ { lat:        235, common_pid:       2043 } hitcount:          2
+ { lat:        235, common_pid:       2039 } hitcount:          5
+ { lat:        235, common_pid:       2042 } hitcount:          2
+ { lat:        235, common_pid:       2040 } hitcount:          4
+ { lat:        235, common_pid:       2041 } hitcount:          1
+ { lat:        236, common_pid:       2036 } hitcount:          7
+ { lat:        236, common_pid:       2037 } hitcount:          1
+ { lat:        236, common_pid:       2041 } hitcount:          5
+ { lat:        236, common_pid:       2039 } hitcount:          3
+ { lat:        236, common_pid:       2043 } hitcount:          9
+ { lat:        236, common_pid:       2040 } hitcount:          7
+ { lat:        237, common_pid:       2037 } hitcount:          1
+ { lat:        237, common_pid:       2040 } hitcount:          1
+ { lat:        237, common_pid:       2036 } hitcount:          9
+ { lat:        237, common_pid:       2039 } hitcount:          3
+ { lat:        237, common_pid:       2043 } hitcount:          8
+ { lat:        237, common_pid:       2042 } hitcount:          2
+ { lat:        237, common_pid:       2041 } hitcount:          2
+ { lat:        238, common_pid:       2043 } hitcount:         10
+ { lat:        238, common_pid:       2040 } hitcount:          1
+ { lat:        238, common_pid:       2037 } hitcount:          9
+ { lat:        238, common_pid:       2038 } hitcount:          1
+ { lat:        238, common_pid:       2039 } hitcount:          1
+ { lat:        238, common_pid:       2042 } hitcount:          3
+ { lat:        238, common_pid:       2036 } hitcount:          7
+ { lat:        239, common_pid:       2041 } hitcount:          1
+ { lat:        239, common_pid:       2043 } hitcount:         11
+ { lat:        239, common_pid:       2037 } hitcount:         11
+ { lat:        239, common_pid:       2038 } hitcount:          6
+ { lat:        239, common_pid:       2036 } hitcount:          7
+ { lat:        239, common_pid:       2040 } hitcount:          1
+ { lat:        239, common_pid:       2042 } hitcount:          9
+ { lat:        240, common_pid:       2037 } hitcount:         29
+ { lat:        240, common_pid:       2043 } hitcount:         15
+ { lat:        240, common_pid:       2040 } hitcount:         44
+ { lat:        240, common_pid:       2039 } hitcount:          1
+ { lat:        240, common_pid:       2041 } hitcount:          2
+ { lat:        240, common_pid:       2038 } hitcount:          1
+ { lat:        240, common_pid:       2036 } hitcount:         10
+ { lat:        240, common_pid:       2042 } hitcount:         13
+ { lat:        241, common_pid:       2036 } hitcount:         21
+ { lat:        241, common_pid:       2041 } hitcount:         36
+ { lat:        241, common_pid:       2037 } hitcount:         34
+ { lat:        241, common_pid:       2042 } hitcount:         14
+ { lat:        241, common_pid:       2040 } hitcount:         94
+ { lat:        241, common_pid:       2039 } hitcount:         12
+ { lat:        241, common_pid:       2038 } hitcount:          2
+ { lat:        241, common_pid:       2043 } hitcount:         28
+ { lat:        242, common_pid:       2040 } hitcount:        109
+ { lat:        242, common_pid:       2041 } hitcount:        506
+ { lat:        242, common_pid:       2039 } hitcount:        155
+ { lat:        242, common_pid:       2042 } hitcount:         21
+ { lat:        242, common_pid:       2037 } hitcount:         52
+ { lat:        242, common_pid:       2043 } hitcount:         21
+ { lat:        242, common_pid:       2036 } hitcount:         16
+ { lat:        242, common_pid:       2038 } hitcount:        156
+ { lat:        243, common_pid:       2037 } hitcount:         46
+ { lat:        243, common_pid:       2039 } hitcount:         40
+ { lat:        243, common_pid:       2042 } hitcount:        119
+ { lat:        243, common_pid:       2041 } hitcount:        611
+ { lat:        243, common_pid:       2036 } hitcount:         69
+ { lat:        243, common_pid:       2038 } hitcount:        784
+ { lat:        243, common_pid:       2040 } hitcount:        323
+ { lat:        243, common_pid:       2043 } hitcount:         14
+ { lat:        244, common_pid:       2043 } hitcount:         35
+ { lat:        244, common_pid:       2042 } hitcount:        305
+ { lat:        244, common_pid:       2039 } hitcount:          8
+ { lat:        244, common_pid:       2040 } hitcount:       4515
+ { lat:        244, common_pid:       2038 } hitcount:        371
+ { lat:        244, common_pid:       2037 } hitcount:         31
+ { lat:        244, common_pid:       2036 } hitcount:        114
+ { lat:        244, common_pid:       2041 } hitcount:       3396
+ { lat:        245, common_pid:       2036 } hitcount:        700
+ { lat:        245, common_pid:       2041 } hitcount:       2772
+ { lat:        245, common_pid:       2037 } hitcount:        268
+ { lat:        245, common_pid:       2039 } hitcount:        472
+ { lat:        245, common_pid:       2038 } hitcount:       2758
+ { lat:        245, common_pid:       2042 } hitcount:       3833
+ { lat:        245, common_pid:       2040 } hitcount:       3105
+ { lat:        245, common_pid:       2043 } hitcount:        645
+ { lat:        246, common_pid:       2038 } hitcount:       3451
+ { lat:        246, common_pid:       2041 } hitcount:        142
+ { lat:        246, common_pid:       2037 } hitcount:       5101
+ { lat:        246, common_pid:       2040 } hitcount:         68
+ { lat:        246, common_pid:       2043 } hitcount:       5099
+ { lat:        246, common_pid:       2039 } hitcount:       5608
+ { lat:        246, common_pid:       2042 } hitcount:       3723
+ { lat:        246, common_pid:       2036 } hitcount:       4738
+ { lat:        247, common_pid:       2042 } hitcount:        312
+ { lat:        247, common_pid:       2043 } hitcount:       2385
+ { lat:        247, common_pid:       2041 } hitcount:        452
+ { lat:        247, common_pid:       2038 } hitcount:        792
+ { lat:        247, common_pid:       2040 } hitcount:         78
+ { lat:        247, common_pid:       2036 } hitcount:       2375
+ { lat:        247, common_pid:       2039 } hitcount:       1834
+ { lat:        247, common_pid:       2037 } hitcount:       2655
+ { lat:        248, common_pid:       2037 } hitcount:         36
+ { lat:        248, common_pid:       2042 } hitcount:         11
+ { lat:        248, common_pid:       2038 } hitcount:        122
+ { lat:        248, common_pid:       2036 } hitcount:        135
+ { lat:        248, common_pid:       2039 } hitcount:         26
+ { lat:        248, common_pid:       2041 } hitcount:        503
+ { lat:        248, common_pid:       2043 } hitcount:         66
+ { lat:        248, common_pid:       2040 } hitcount:         46
+ { lat:        249, common_pid:       2037 } hitcount:         29
+ { lat:        249, common_pid:       2038 } hitcount:          1
+ { lat:        249, common_pid:       2043 } hitcount:         29
+ { lat:        249, common_pid:       2039 } hitcount:          8
+ { lat:        249, common_pid:       2042 } hitcount:         56
+ { lat:        249, common_pid:       2040 } hitcount:         27
+ { lat:        249, common_pid:       2041 } hitcount:         11
+ { lat:        249, common_pid:       2036 } hitcount:         27
+ { lat:        250, common_pid:       2038 } hitcount:          1
+ { lat:        250, common_pid:       2036 } hitcount:         30
+ { lat:        250, common_pid:       2040 } hitcount:         19
+ { lat:        250, common_pid:       2043 } hitcount:         22
+ { lat:        250, common_pid:       2042 } hitcount:         20
+ { lat:        250, common_pid:       2041 } hitcount:          1
+ { lat:        250, common_pid:       2039 } hitcount:          6
+ { lat:        250, common_pid:       2037 } hitcount:         48
+ { lat:        251, common_pid:       2037 } hitcount:         43
+ { lat:        251, common_pid:       2039 } hitcount:          1
+ { lat:        251, common_pid:       2036 } hitcount:         12
+ { lat:        251, common_pid:       2042 } hitcount:          2
+ { lat:        251, common_pid:       2041 } hitcount:          1
+ { lat:        251, common_pid:       2043 } hitcount:         15
+ { lat:        251, common_pid:       2040 } hitcount:          3
+ { lat:        252, common_pid:       2040 } hitcount:          1
+ { lat:        252, common_pid:       2036 } hitcount:         12
+ { lat:        252, common_pid:       2037 } hitcount:         21
+ { lat:        252, common_pid:       2043 } hitcount:         14
+ { lat:        253, common_pid:       2037 } hitcount:         21
+ { lat:        253, common_pid:       2039 } hitcount:          2
+ { lat:        253, common_pid:       2036 } hitcount:          9
+ { lat:        253, common_pid:       2043 } hitcount:          6
+ { lat:        253, common_pid:       2040 } hitcount:          1
+ { lat:        254, common_pid:       2036 } hitcount:          8
+ { lat:        254, common_pid:       2043 } hitcount:          3
+ { lat:        254, common_pid:       2041 } hitcount:          1
+ { lat:        254, common_pid:       2042 } hitcount:          1
+ { lat:        254, common_pid:       2039 } hitcount:          1
+ { lat:        254, common_pid:       2037 } hitcount:         12
+ { lat:        255, common_pid:       2043 } hitcount:          1
+ { lat:        255, common_pid:       2037 } hitcount:          2
+ { lat:        255, common_pid:       2036 } hitcount:          2
+ { lat:        255, common_pid:       2039 } hitcount:          8
+ { lat:        256, common_pid:       2043 } hitcount:          1
+ { lat:        256, common_pid:       2036 } hitcount:          4
+ { lat:        256, common_pid:       2039 } hitcount:          6
+ { lat:        257, common_pid:       2039 } hitcount:          5
+ { lat:        257, common_pid:       2036 } hitcount:          4
+ { lat:        258, common_pid:       2039 } hitcount:          5
+ { lat:        258, common_pid:       2036 } hitcount:          2
+ { lat:        259, common_pid:       2036 } hitcount:          7
+ { lat:        259, common_pid:       2039 } hitcount:          7
+ { lat:        260, common_pid:       2036 } hitcount:          8
+ { lat:        260, common_pid:       2039 } hitcount:          6
+ { lat:        261, common_pid:       2036 } hitcount:          5
+ { lat:        261, common_pid:       2039 } hitcount:          7
+ { lat:        262, common_pid:       2039 } hitcount:          5
+ { lat:        262, common_pid:       2036 } hitcount:          5
+ { lat:        263, common_pid:       2039 } hitcount:          7
+ { lat:        263, common_pid:       2036 } hitcount:          7
+ { lat:        264, common_pid:       2039 } hitcount:          9
+ { lat:        264, common_pid:       2036 } hitcount:          9
+ { lat:        265, common_pid:       2036 } hitcount:          5
+ { lat:        265, common_pid:       2039 } hitcount:          1
+ { lat:        266, common_pid:       2036 } hitcount:          1
+ { lat:        266, common_pid:       2039 } hitcount:          3
+ { lat:        267, common_pid:       2036 } hitcount:          1
+ { lat:        267, common_pid:       2039 } hitcount:          3
+ { lat:        268, common_pid:       2036 } hitcount:          1
+ { lat:        268, common_pid:       2039 } hitcount:          6
+ { lat:        269, common_pid:       2036 } hitcount:          1
+ { lat:        269, common_pid:       2043 } hitcount:          1
+ { lat:        269, common_pid:       2039 } hitcount:          2
+ { lat:        270, common_pid:       2040 } hitcount:          1
+ { lat:        270, common_pid:       2039 } hitcount:          6
+ { lat:        271, common_pid:       2041 } hitcount:          1
+ { lat:        271, common_pid:       2039 } hitcount:          5
+ { lat:        272, common_pid:       2039 } hitcount:         10
+ { lat:        273, common_pid:       2039 } hitcount:          8
+ { lat:        274, common_pid:       2039 } hitcount:          2
+ { lat:        275, common_pid:       2039 } hitcount:          1
+ { lat:        276, common_pid:       2039 } hitcount:          2
+ { lat:        276, common_pid:       2037 } hitcount:          1
+ { lat:        276, common_pid:       2038 } hitcount:          1
+ { lat:        277, common_pid:       2039 } hitcount:          1
+ { lat:        277, common_pid:       2042 } hitcount:          1
+ { lat:        278, common_pid:       2039 } hitcount:          1
+ { lat:        279, common_pid:       2039 } hitcount:          4
+ { lat:        279, common_pid:       2043 } hitcount:          1
+ { lat:        280, common_pid:       2039 } hitcount:          3
+ { lat:        283, common_pid:       2036 } hitcount:          2
+ { lat:        284, common_pid:       2039 } hitcount:          1
+ { lat:        284, common_pid:       2043 } hitcount:          1
+ { lat:        288, common_pid:       2039 } hitcount:          1
+ { lat:        289, common_pid:       2039 } hitcount:          1
+ { lat:        300, common_pid:       2039 } hitcount:          1
+ { lat:        384, common_pid:       2039 } hitcount:          1
 
-Totals:
-    Hits: 67625
-    Entries: 278
-    Dropped: 0
+ Totals:
+     Hits: 67625
+     Entries: 278
+     Dropped: 0
 
 Note, the writes are around the sleep, so ideally they will all be of 250
 microseconds. If you are wondering how there are several that are under
@@ -2350,7 +2356,7 @@ will be at 200 microseconds.
 
 But this could easily be done in userspace. To make this even more
 interesting, we can mix the histogram between events that happened in the
-kernel with trace_marker.
+kernel with trace_marker::
 
  # cd /sys/kernel/tracing
  # echo 'latency u64 lat' > synthetic_events
@@ -2362,177 +2368,177 @@ The difference this time is that instead of using the trace_marker to start
 the latency, the sched_waking event is used, matching the common_pid for the
 trace_marker write with the pid that is being woken by sched_waking.
 
-After running cyclictest again with the same parameters, we now have:
+After running cyclictest again with the same parameters, we now have::
 
  # cat events/synthetic/latency/hist
-# event histogram
-#
-# trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
-#
+ # event histogram
+ #
+ # trigger info: hist:keys=lat,common_pid:vals=hitcount:sort=lat:size=2048 [active]
+ #
 
-{ lat:          7, common_pid:       2302 } hitcount:        640
-{ lat:          7, common_pid:       2299 } hitcount:         42
-{ lat:          7, common_pid:       2303 } hitcount:         18
-{ lat:          7, common_pid:       2305 } hitcount:        166
-{ lat:          7, common_pid:       2306 } hitcount:          1
-{ lat:          7, common_pid:       2301 } hitcount:         91
-{ lat:          7, common_pid:       2300 } hitcount:         17
-{ lat:          8, common_pid:       2303 } hitcount:       8296
-{ lat:          8, common_pid:       2304 } hitcount:       6864
-{ lat:          8, common_pid:       2305 } hitcount:       9464
-{ lat:          8, common_pid:       2301 } hitcount:       9213
-{ lat:          8, common_pid:       2306 } hitcount:       6246
-{ lat:          8, common_pid:       2302 } hitcount:       8797
-{ lat:          8, common_pid:       2299 } hitcount:       8771
-{ lat:          8, common_pid:       2300 } hitcount:       8119
-{ lat:          9, common_pid:       2305 } hitcount:       1519
-{ lat:          9, common_pid:       2299 } hitcount:       2346
-{ lat:          9, common_pid:       2303 } hitcount:       2841
-{ lat:          9, common_pid:       2301 } hitcount:       1846
-{ lat:          9, common_pid:       2304 } hitcount:       3861
-{ lat:          9, common_pid:       2302 } hitcount:       1210
-{ lat:          9, common_pid:       2300 } hitcount:       2762
-{ lat:          9, common_pid:       2306 } hitcount:       4247
-{ lat:         10, common_pid:       2299 } hitcount:         16
-{ lat:         10, common_pid:       2306 } hitcount:        333
-{ lat:         10, common_pid:       2303 } hitcount:         16
-{ lat:         10, common_pid:       2304 } hitcount:        168
-{ lat:         10, common_pid:       2302 } hitcount:        240
-{ lat:         10, common_pid:       2301 } hitcount:         28
-{ lat:         10, common_pid:       2300 } hitcount:         95
-{ lat:         10, common_pid:       2305 } hitcount:         18
-{ lat:         11, common_pid:       2303 } hitcount:          5
-{ lat:         11, common_pid:       2305 } hitcount:          8
-{ lat:         11, common_pid:       2306 } hitcount:        221
-{ lat:         11, common_pid:       2302 } hitcount:         76
-{ lat:         11, common_pid:       2304 } hitcount:         26
-{ lat:         11, common_pid:       2300 } hitcount:        125
-{ lat:         11, common_pid:       2299 } hitcount:          2
-{ lat:         12, common_pid:       2305 } hitcount:          3
-{ lat:         12, common_pid:       2300 } hitcount:          6
-{ lat:         12, common_pid:       2306 } hitcount:         90
-{ lat:         12, common_pid:       2302 } hitcount:          4
-{ lat:         12, common_pid:       2303 } hitcount:          1
-{ lat:         12, common_pid:       2304 } hitcount:        122
-{ lat:         13, common_pid:       2300 } hitcount:         12
-{ lat:         13, common_pid:       2301 } hitcount:          1
-{ lat:         13, common_pid:       2306 } hitcount:         32
-{ lat:         13, common_pid:       2302 } hitcount:          5
-{ lat:         13, common_pid:       2305 } hitcount:          1
-{ lat:         13, common_pid:       2303 } hitcount:          1
-{ lat:         13, common_pid:       2304 } hitcount:         61
-{ lat:         14, common_pid:       2303 } hitcount:          4
-{ lat:         14, common_pid:       2306 } hitcount:          5
-{ lat:         14, common_pid:       2305 } hitcount:          4
-{ lat:         14, common_pid:       2304 } hitcount:         62
-{ lat:         14, common_pid:       2302 } hitcount:         19
-{ lat:         14, common_pid:       2300 } hitcount:         33
-{ lat:         14, common_pid:       2299 } hitcount:          1
-{ lat:         14, common_pid:       2301 } hitcount:          4
-{ lat:         15, common_pid:       2305 } hitcount:          1
-{ lat:         15, common_pid:       2302 } hitcount:         25
-{ lat:         15, common_pid:       2300 } hitcount:         11
-{ lat:         15, common_pid:       2299 } hitcount:          5
-{ lat:         15, common_pid:       2301 } hitcount:          1
-{ lat:         15, common_pid:       2304 } hitcount:          8
-{ lat:         15, common_pid:       2303 } hitcount:          1
-{ lat:         15, common_pid:       2306 } hitcount:          6
-{ lat:         16, common_pid:       2302 } hitcount:         31
-{ lat:         16, common_pid:       2306 } hitcount:          3
-{ lat:         16, common_pid:       2300 } hitcount:          5
-{ lat:         17, common_pid:       2302 } hitcount:          6
-{ lat:         17, common_pid:       2303 } hitcount:          1
-{ lat:         18, common_pid:       2304 } hitcount:          1
-{ lat:         18, common_pid:       2302 } hitcount:          8
-{ lat:         18, common_pid:       2299 } hitcount:          1
-{ lat:         18, common_pid:       2301 } hitcount:          1
-{ lat:         19, common_pid:       2303 } hitcount:          4
-{ lat:         19, common_pid:       2304 } hitcount:          5
-{ lat:         19, common_pid:       2302 } hitcount:          4
-{ lat:         19, common_pid:       2299 } hitcount:          3
-{ lat:         19, common_pid:       2306 } hitcount:          1
-{ lat:         19, common_pid:       2300 } hitcount:          4
-{ lat:         19, common_pid:       2305 } hitcount:          5
-{ lat:         20, common_pid:       2299 } hitcount:          2
-{ lat:         20, common_pid:       2302 } hitcount:          3
-{ lat:         20, common_pid:       2305 } hitcount:          1
-{ lat:         20, common_pid:       2300 } hitcount:          2
-{ lat:         20, common_pid:       2301 } hitcount:          2
-{ lat:         20, common_pid:       2303 } hitcount:          3
-{ lat:         21, common_pid:       2305 } hitcount:          1
-{ lat:         21, common_pid:       2299 } hitcount:          5
-{ lat:         21, common_pid:       2303 } hitcount:          4
-{ lat:         21, common_pid:       2302 } hitcount:          7
-{ lat:         21, common_pid:       2300 } hitcount:          1
-{ lat:         21, common_pid:       2301 } hitcount:          5
-{ lat:         21, common_pid:       2304 } hitcount:          2
-{ lat:         22, common_pid:       2302 } hitcount:          5
-{ lat:         22, common_pid:       2303 } hitcount:          1
-{ lat:         22, common_pid:       2306 } hitcount:          3
-{ lat:         22, common_pid:       2301 } hitcount:          2
-{ lat:         22, common_pid:       2300 } hitcount:          1
-{ lat:         22, common_pid:       2299 } hitcount:          1
-{ lat:         22, common_pid:       2305 } hitcount:          1
-{ lat:         22, common_pid:       2304 } hitcount:          1
-{ lat:         23, common_pid:       2299 } hitcount:          1
-{ lat:         23, common_pid:       2306 } hitcount:          2
-{ lat:         23, common_pid:       2302 } hitcount:          6
-{ lat:         24, common_pid:       2302 } hitcount:          3
-{ lat:         24, common_pid:       2300 } hitcount:          1
-{ lat:         24, common_pid:       2306 } hitcount:          2
-{ lat:         24, common_pid:       2305 } hitcount:          1
-{ lat:         24, common_pid:       2299 } hitcount:          1
-{ lat:         25, common_pid:       2300 } hitcount:          1
-{ lat:         25, common_pid:       2302 } hitcount:          4
-{ lat:         26, common_pid:       2302 } hitcount:          2
-{ lat:         27, common_pid:       2305 } hitcount:          1
-{ lat:         27, common_pid:       2300 } hitcount:          1
-{ lat:         27, common_pid:       2302 } hitcount:          3
-{ lat:         28, common_pid:       2306 } hitcount:          1
-{ lat:         28, common_pid:       2302 } hitcount:          4
-{ lat:         29, common_pid:       2302 } hitcount:          1
-{ lat:         29, common_pid:       2300 } hitcount:          2
-{ lat:         29, common_pid:       2306 } hitcount:          1
-{ lat:         29, common_pid:       2304 } hitcount:          1
-{ lat:         30, common_pid:       2302 } hitcount:          4
-{ lat:         31, common_pid:       2302 } hitcount:          6
-{ lat:         32, common_pid:       2302 } hitcount:          1
-{ lat:         33, common_pid:       2299 } hitcount:          1
-{ lat:         33, common_pid:       2302 } hitcount:          3
-{ lat:         34, common_pid:       2302 } hitcount:          2
-{ lat:         35, common_pid:       2302 } hitcount:          1
-{ lat:         35, common_pid:       2304 } hitcount:          1
-{ lat:         36, common_pid:       2302 } hitcount:          4
-{ lat:         37, common_pid:       2302 } hitcount:          6
-{ lat:         38, common_pid:       2302 } hitcount:          2
-{ lat:         39, common_pid:       2302 } hitcount:          2
-{ lat:         39, common_pid:       2304 } hitcount:          1
-{ lat:         40, common_pid:       2304 } hitcount:          2
-{ lat:         40, common_pid:       2302 } hitcount:          5
-{ lat:         41, common_pid:       2304 } hitcount:          1
-{ lat:         41, common_pid:       2302 } hitcount:          8
-{ lat:         42, common_pid:       2302 } hitcount:          6
-{ lat:         42, common_pid:       2304 } hitcount:          1
-{ lat:         43, common_pid:       2302 } hitcount:          3
-{ lat:         43, common_pid:       2304 } hitcount:          4
-{ lat:         44, common_pid:       2302 } hitcount:          6
-{ lat:         45, common_pid:       2302 } hitcount:          5
-{ lat:         46, common_pid:       2302 } hitcount:          5
-{ lat:         47, common_pid:       2302 } hitcount:          7
-{ lat:         48, common_pid:       2301 } hitcount:          1
-{ lat:         48, common_pid:       2302 } hitcount:          9
-{ lat:         49, common_pid:       2302 } hitcount:          3
-{ lat:         50, common_pid:       2302 } hitcount:          1
-{ lat:         50, common_pid:       2301 } hitcount:          1
-{ lat:         51, common_pid:       2302 } hitcount:          2
-{ lat:         51, common_pid:       2301 } hitcount:          1
-{ lat:         61, common_pid:       2302 } hitcount:          1
-{ lat:        110, common_pid:       2302 } hitcount:          1
+ { lat:          7, common_pid:       2302 } hitcount:        640
+ { lat:          7, common_pid:       2299 } hitcount:         42
+ { lat:          7, common_pid:       2303 } hitcount:         18
+ { lat:          7, common_pid:       2305 } hitcount:        166
+ { lat:          7, common_pid:       2306 } hitcount:          1
+ { lat:          7, common_pid:       2301 } hitcount:         91
+ { lat:          7, common_pid:       2300 } hitcount:         17
+ { lat:          8, common_pid:       2303 } hitcount:       8296
+ { lat:          8, common_pid:       2304 } hitcount:       6864
+ { lat:          8, common_pid:       2305 } hitcount:       9464
+ { lat:          8, common_pid:       2301 } hitcount:       9213
+ { lat:          8, common_pid:       2306 } hitcount:       6246
+ { lat:          8, common_pid:       2302 } hitcount:       8797
+ { lat:          8, common_pid:       2299 } hitcount:       8771
+ { lat:          8, common_pid:       2300 } hitcount:       8119
+ { lat:          9, common_pid:       2305 } hitcount:       1519
+ { lat:          9, common_pid:       2299 } hitcount:       2346
+ { lat:          9, common_pid:       2303 } hitcount:       2841
+ { lat:          9, common_pid:       2301 } hitcount:       1846
+ { lat:          9, common_pid:       2304 } hitcount:       3861
+ { lat:          9, common_pid:       2302 } hitcount:       1210
+ { lat:          9, common_pid:       2300 } hitcount:       2762
+ { lat:          9, common_pid:       2306 } hitcount:       4247
+ { lat:         10, common_pid:       2299 } hitcount:         16
+ { lat:         10, common_pid:       2306 } hitcount:        333
+ { lat:         10, common_pid:       2303 } hitcount:         16
+ { lat:         10, common_pid:       2304 } hitcount:        168
+ { lat:         10, common_pid:       2302 } hitcount:        240
+ { lat:         10, common_pid:       2301 } hitcount:         28
+ { lat:         10, common_pid:       2300 } hitcount:         95
+ { lat:         10, common_pid:       2305 } hitcount:         18
+ { lat:         11, common_pid:       2303 } hitcount:          5
+ { lat:         11, common_pid:       2305 } hitcount:          8
+ { lat:         11, common_pid:       2306 } hitcount:        221
+ { lat:         11, common_pid:       2302 } hitcount:         76
+ { lat:         11, common_pid:       2304 } hitcount:         26
+ { lat:         11, common_pid:       2300 } hitcount:        125
+ { lat:         11, common_pid:       2299 } hitcount:          2
+ { lat:         12, common_pid:       2305 } hitcount:          3
+ { lat:         12, common_pid:       2300 } hitcount:          6
+ { lat:         12, common_pid:       2306 } hitcount:         90
+ { lat:         12, common_pid:       2302 } hitcount:          4
+ { lat:         12, common_pid:       2303 } hitcount:          1
+ { lat:         12, common_pid:       2304 } hitcount:        122
+ { lat:         13, common_pid:       2300 } hitcount:         12
+ { lat:         13, common_pid:       2301 } hitcount:          1
+ { lat:         13, common_pid:       2306 } hitcount:         32
+ { lat:         13, common_pid:       2302 } hitcount:          5
+ { lat:         13, common_pid:       2305 } hitcount:          1
+ { lat:         13, common_pid:       2303 } hitcount:          1
+ { lat:         13, common_pid:       2304 } hitcount:         61
+ { lat:         14, common_pid:       2303 } hitcount:          4
+ { lat:         14, common_pid:       2306 } hitcount:          5
+ { lat:         14, common_pid:       2305 } hitcount:          4
+ { lat:         14, common_pid:       2304 } hitcount:         62
+ { lat:         14, common_pid:       2302 } hitcount:         19
+ { lat:         14, common_pid:       2300 } hitcount:         33
+ { lat:         14, common_pid:       2299 } hitcount:          1
+ { lat:         14, common_pid:       2301 } hitcount:          4
+ { lat:         15, common_pid:       2305 } hitcount:          1
+ { lat:         15, common_pid:       2302 } hitcount:         25
+ { lat:         15, common_pid:       2300 } hitcount:         11
+ { lat:         15, common_pid:       2299 } hitcount:          5
+ { lat:         15, common_pid:       2301 } hitcount:          1
+ { lat:         15, common_pid:       2304 } hitcount:          8
+ { lat:         15, common_pid:       2303 } hitcount:          1
+ { lat:         15, common_pid:       2306 } hitcount:          6
+ { lat:         16, common_pid:       2302 } hitcount:         31
+ { lat:         16, common_pid:       2306 } hitcount:          3
+ { lat:         16, common_pid:       2300 } hitcount:          5
+ { lat:         17, common_pid:       2302 } hitcount:          6
+ { lat:         17, common_pid:       2303 } hitcount:          1
+ { lat:         18, common_pid:       2304 } hitcount:          1
+ { lat:         18, common_pid:       2302 } hitcount:          8
+ { lat:         18, common_pid:       2299 } hitcount:          1
+ { lat:         18, common_pid:       2301 } hitcount:          1
+ { lat:         19, common_pid:       2303 } hitcount:          4
+ { lat:         19, common_pid:       2304 } hitcount:          5
+ { lat:         19, common_pid:       2302 } hitcount:          4
+ { lat:         19, common_pid:       2299 } hitcount:          3
+ { lat:         19, common_pid:       2306 } hitcount:          1
+ { lat:         19, common_pid:       2300 } hitcount:          4
+ { lat:         19, common_pid:       2305 } hitcount:          5
+ { lat:         20, common_pid:       2299 } hitcount:          2
+ { lat:         20, common_pid:       2302 } hitcount:          3
+ { lat:         20, common_pid:       2305 } hitcount:          1
+ { lat:         20, common_pid:       2300 } hitcount:          2
+ { lat:         20, common_pid:       2301 } hitcount:          2
+ { lat:         20, common_pid:       2303 } hitcount:          3
+ { lat:         21, common_pid:       2305 } hitcount:          1
+ { lat:         21, common_pid:       2299 } hitcount:          5
+ { lat:         21, common_pid:       2303 } hitcount:          4
+ { lat:         21, common_pid:       2302 } hitcount:          7
+ { lat:         21, common_pid:       2300 } hitcount:          1
+ { lat:         21, common_pid:       2301 } hitcount:          5
+ { lat:         21, common_pid:       2304 } hitcount:          2
+ { lat:         22, common_pid:       2302 } hitcount:          5
+ { lat:         22, common_pid:       2303 } hitcount:          1
+ { lat:         22, common_pid:       2306 } hitcount:          3
+ { lat:         22, common_pid:       2301 } hitcount:          2
+ { lat:         22, common_pid:       2300 } hitcount:          1
+ { lat:         22, common_pid:       2299 } hitcount:          1
+ { lat:         22, common_pid:       2305 } hitcount:          1
+ { lat:         22, common_pid:       2304 } hitcount:          1
+ { lat:         23, common_pid:       2299 } hitcount:          1
+ { lat:         23, common_pid:       2306 } hitcount:          2
+ { lat:         23, common_pid:       2302 } hitcount:          6
+ { lat:         24, common_pid:       2302 } hitcount:          3
+ { lat:         24, common_pid:       2300 } hitcount:          1
+ { lat:         24, common_pid:       2306 } hitcount:          2
+ { lat:         24, common_pid:       2305 } hitcount:          1
+ { lat:         24, common_pid:       2299 } hitcount:          1
+ { lat:         25, common_pid:       2300 } hitcount:          1
+ { lat:         25, common_pid:       2302 } hitcount:          4
+ { lat:         26, common_pid:       2302 } hitcount:          2
+ { lat:         27, common_pid:       2305 } hitcount:          1
+ { lat:         27, common_pid:       2300 } hitcount:          1
+ { lat:         27, common_pid:       2302 } hitcount:          3
+ { lat:         28, common_pid:       2306 } hitcount:          1
+ { lat:         28, common_pid:       2302 } hitcount:          4
+ { lat:         29, common_pid:       2302 } hitcount:          1
+ { lat:         29, common_pid:       2300 } hitcount:          2
+ { lat:         29, common_pid:       2306 } hitcount:          1
+ { lat:         29, common_pid:       2304 } hitcount:          1
+ { lat:         30, common_pid:       2302 } hitcount:          4
+ { lat:         31, common_pid:       2302 } hitcount:          6
+ { lat:         32, common_pid:       2302 } hitcount:          1
+ { lat:         33, common_pid:       2299 } hitcount:          1
+ { lat:         33, common_pid:       2302 } hitcount:          3
+ { lat:         34, common_pid:       2302 } hitcount:          2
+ { lat:         35, common_pid:       2302 } hitcount:          1
+ { lat:         35, common_pid:       2304 } hitcount:          1
+ { lat:         36, common_pid:       2302 } hitcount:          4
+ { lat:         37, common_pid:       2302 } hitcount:          6
+ { lat:         38, common_pid:       2302 } hitcount:          2
+ { lat:         39, common_pid:       2302 } hitcount:          2
+ { lat:         39, common_pid:       2304 } hitcount:          1
+ { lat:         40, common_pid:       2304 } hitcount:          2
+ { lat:         40, common_pid:       2302 } hitcount:          5
+ { lat:         41, common_pid:       2304 } hitcount:          1
+ { lat:         41, common_pid:       2302 } hitcount:          8
+ { lat:         42, common_pid:       2302 } hitcount:          6
+ { lat:         42, common_pid:       2304 } hitcount:          1
+ { lat:         43, common_pid:       2302 } hitcount:          3
+ { lat:         43, common_pid:       2304 } hitcount:          4
+ { lat:         44, common_pid:       2302 } hitcount:          6
+ { lat:         45, common_pid:       2302 } hitcount:          5
+ { lat:         46, common_pid:       2302 } hitcount:          5
+ { lat:         47, common_pid:       2302 } hitcount:          7
+ { lat:         48, common_pid:       2301 } hitcount:          1
+ { lat:         48, common_pid:       2302 } hitcount:          9
+ { lat:         49, common_pid:       2302 } hitcount:          3
+ { lat:         50, common_pid:       2302 } hitcount:          1
+ { lat:         50, common_pid:       2301 } hitcount:          1
+ { lat:         51, common_pid:       2302 } hitcount:          2
+ { lat:         51, common_pid:       2301 } hitcount:          1
+ { lat:         61, common_pid:       2302 } hitcount:          1
+ { lat:        110, common_pid:       2302 } hitcount:          1
 
-Totals:
-    Hits: 89565
-    Entries: 158
-    Dropped: 0
+ Totals:
+     Hits: 89565
+     Entries: 158
+     Dropped: 0
 
 This doesn't tell us any information about how late cyclictest may have
 woken up, but it does show us a nice histogram of how long it took from
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b58c10b04e27..306997941ba1 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -18,6 +18,7 @@ Linux Tracing Technologies
    events-nmi
    events-msr
    mmiotrace
+   histogram
    hwlat_detector
    intel_th
    stm
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..2bd4a9181a0f 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -605,7 +605,7 @@ config HIST_TRIGGERS
 	  Inter-event tracing of quantities such as latencies is also
 	  supported using hist triggers under this option.
 
-	  See Documentation/trace/histogram.txt.
+	  See Documentation/trace/histogram.rst.
 	  If in doubt, say N.
 
 config MMIOTRACE_TEST
-- 
2.17.1

