Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932771AbeCJDSn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751347AbeCJDSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:18:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 22:18:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180309221839.661d4f3f@vmware.local.home>
In-Reply-To: <20180310023907.798690563@goodmis.org>
References: <20180310023442.791997138@goodmis.org>
        <20180310023907.798690563@goodmis.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ This time replying to the email I expected to ]

On Fri, 09 Mar 2018 21:34:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>  2 files changed, 1050 insertions(+), 1273 deletions(-)  

BTW, it's a bit bigger impact than 223 deletions. As I added a lot of
comments to explain the logic better. Removing comments and white space
from the modifications we have:

 649 insertions(+), 1035 deletions(-)

That's 386 lines of code removed.

-- Steve
