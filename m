Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeDELsc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbeDELsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:48:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BD7217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 07:48:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] trace: Fixup logic inversion on setting
 trace_global_clock defaults
Message-ID: <20180405074828.27a1f370@gandalf.local.home>
In-Reply-To: <20180404212450.26646-1-chris@chris-wilson.co.uk>
References: <7D320425-063C-4C54-BAD2-8843ADCD8D6A@goodmis.org>
        <20180404212450.26646-1-chris@chris-wilson.co.uk>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Apr 2018 22:24:50 +0100
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> In commit 932066a15335 ("tracing: Default to using trace_global_clock if
> sched_clock is unstable"), the logic for deciding to override the
> default clock if unstable was reversed from the earlier posting. I was
> trying to reduce the width of the message by using an early return
> rather than a if-block, but reverted back to using the if-block and
> accidentally left the predicate inverted.

Hey, the inversion found some issues with global clock interacting with
lockdep, so it was a good bug to have ;-)

-- Steve
