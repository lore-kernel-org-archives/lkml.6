Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeCGRqx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:46:53 -0500
Received: from ms.lwn.net ([45.79.88.28]:58548 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbeCGRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:46:51 -0500
Date: Wed, 7 Mar 2018 10:46:49 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Du, Changbin" <changbin.du@intel.com>, mingo@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Include linux trace docs to Sphinx TOC tree
Message-ID: <20180307104649.4db521a5@lwn.net>
In-Reply-To: <20180227174337.37ecb348@vmware.local.home>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
        <20180227093421.yd674oaklthaljgh@intel.com>
        <20180227174337.37ecb348@vmware.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 17:43:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 27 Feb 2018 17:34:22 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
>
> > Ten days past, will you accept this serias? Thank you!
> 
> Currently I'm very overloaded with other code that needs to get done
> ASAP, and I need to balance what is critical and what is not. I don't
> have time to review this, as this isn't critical, and can wait.
> 
> If Jon can review it to make sure that it doesn't change the
> readability of the text, then I'll trust his judgment. 

So I've spent a while working through the patches.  I think it's a
well-done RST conversion carried out with a light hand; I do not believe
there are any readability issues with the resulting text files.

I will note that the series adds some new build warnings:

> Documentation/trace/events.rst:45: WARNING: Inline emphasis start-string without end-string.
> Documentation/trace/events.rst:49: WARNING: Inline emphasis start-string without end-string.
> Documentation/trace/events.rst:193: WARNING: Inline emphasis start-string without end-string.
> Documentation/trace/events.rst:114: WARNING: Unknown target name: "common".
> Documentation/trace/ftrace.rst:2620: WARNING: Inline emphasis start-string without end-string.

These point to places where the resulting formatted docs are, in fact,
incorrect.  I had to append the attached patch to the series to make those
problems go away.  The warnings are there for a purpose!

Anyway, with that, the patch series is applied.  Thanks for helping to
improve the docs, and my apologies for taking so long to get to this.

jon

>From 6234c7bd8c14508fb76c0a4d6f01eb81c8ce9cbf Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 7 Mar 2018 10:44:08 -0700
Subject: [PATCH] docs: ftrace: fix a few formatting issues

Make sure that literal * characters are not interpreted as emphasis
markers.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/trace/events.rst | 10 +++++-----
 Documentation/trace/ftrace.rst |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 27bfd06ae29d..bdf1963ba6ba 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -42,7 +42,7 @@ To disable all events, echo an empty line to the set_event file::
 
 	# echo > /sys/kernel/debug/tracing/set_event
 
-To enable all events, echo '*:*' or '*:' to the set_event file::
+To enable all events, echo ``*:*`` or ``*:`` to the set_event file::
 
 	# echo *:* > /sys/kernel/debug/tracing/set_event
 
@@ -50,7 +50,7 @@ The events are organized into subsystems, such as ext4, irq, sched,
 etc., and a full event name looks like this: <subsystem>:<event>.  The
 subsystem name is optional, but it is displayed in the available_events
 file.  All of the events in a subsystem can be specified via the syntax
-"<subsystem>:*"; for example, to enable all irq events, you can use the
+``<subsystem>:*``; for example, to enable all irq events, you can use the
 command::
 
 	# echo 'irq:*' > /sys/kernel/debug/tracing/set_event
@@ -111,8 +111,8 @@ It also displays the format string that will be used to print the
 event in text mode, along with the event name and ID used for
 profiling.
 
-Every event has a set of 'common' fields associated with it; these are
-the fields prefixed with 'common_'.  The other fields vary between
+Every event has a set of ``common`` fields associated with it; these are
+the fields prefixed with ``common_``.  The other fields vary between
 events and correspond to the fields defined in the TRACE_EVENT
 definition for that event.
 
@@ -190,7 +190,7 @@ And for string fields they are:
 
 ==, !=, ~
 
-The glob (~) accepts a wild card character (*,?) and character classes
+The glob (~) accepts a wild card character (\*,?) and character classes
 ([). For example::
 
   prev_comm ~ "*sh"
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 636aa9bf5674..0bc33ad4a3f9 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2615,13 +2615,13 @@ To see which functions are being traced, you can cat the file:
 
 Perhaps this is not enough. The filters also allow glob(7) matching.
 
-  <match>*
+  ``<match>*``
 	will match functions that begin with <match>
-  *<match>
+  ``*<match>``
 	will match functions that end with <match>
-  *<match>*
+  ``*<match>*``
 	will match functions that have <match> in it
-  <match1>*<match2>
+  ``<match1>*<match2>``
 	will match functions that begin with <match1> and end with <match2>
 
 .. note::
-- 
2.14.3
