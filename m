Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeD3Pu4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:50:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbeD3Puy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:50:54 -0400
Date: Mon, 30 Apr 2018 17:50:50 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Hashed pointer issues
Message-ID: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled over an issue with hashed pointers and tracing. 

I'm using trace points for examination and on error the trace buffers
are dumped. The error occurs when entropy has not been set up, so the
pointers are not hashed and only (ptrval) is printed instead. The
pointers are required to distinguish the different objects in the
trace.

Beside workarounds like patching lib/vsprintf.c helpers before testing
or dumping trace buffers later (given that kernel comes up properly
and entropy is set up), is there a possible generic solution for this
issue? A commandline option for disabling the pointer obfuscation
would be a pretty handy tool.


Thanks,

      Anna-Maria
