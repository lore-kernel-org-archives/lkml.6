Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756446AbeEASmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756203AbeEASmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:42:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93115236F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 1 May 2018 14:42:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, samitolvanen@google.com,
        alxmtvv@gmail.com, linux-kbuild@vger.kernel.org,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/21] trace: Use -mcount-record for dynamic ftrace
Message-ID: <20180501144248.1fb71b20@gandalf.local.home>
In-Reply-To: <20171130192233.181dad47@gandalf.local.home>
References: <20171127213423.27218-1-andi@firstfloor.org>
        <20171127213423.27218-12-andi@firstfloor.org>
        <20171130192233.181dad47@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2017 19:22:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 27 Nov 2017 13:34:13 -0800
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > gcc 5 supports a new -mcount-record option to generate ftrace
> > tables directly. This avoids the need to run record_mcount
> > manually.
> > 
> > Use this option when available.
> > 
> > So far doesn't use -mcount-nop, which also exists now.
> > 
> > This is needed to make ftrace work with LTO because the
> > normal record-mcount script doesn't run over the link
> > time output.
> > 
> > It should also improve build times slightly in the general
> > case.
> > 
> > Cc: rostedt@goodmis.org
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > ---  
> 
> Hi Andi,
> 
> Thanks for sending this. I'm currently trying to catch up on all the
> changes that need to get into 4.15 and will be doing a bit of
> traveling.
> 
> I plan on looking at this in a week or two, and add it to the 4.16
> queue.
>

Looks like it I forgot to add it to the queue (actually, I remember
having issues with that queue and restarted it), and this was dropped.

Adding it this time for 4.18

Sorry about that. :-/

-- Steve
