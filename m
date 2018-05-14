Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeENOML (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753851AbeENOMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:12:09 -0400
Date: Mon, 14 May 2018 10:12:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yann Ylavic <ylavic.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Message-ID: <20180514101206.46add982@gandalf.local.home>
In-Reply-To: <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
References: <20180511194927.190877137@goodmis.org>
        <20180511195341.034688188@goodmis.org>
        <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 20:32:18 +0200
Yann Ylavic <ylavic.dev@gmail.com> wrote:

> On Fri, May 11, 2018 at 9:49 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> []
> >
> >  static int regex_match_front(char *str, struct regex *r, int len)
> >  {
> > -       if (len < r->len)
> > +       if (len && len < r->len)
> >                 return 0;
> >
> > -       if (strncmp(str, r->pattern, r->len) == 0)
> > -               return 1;
> > -       return 0;
> > +       return strncmp(str, r->pattern, len) == 0;  
> 
> strncmp(..., r->len) still?
> 
> >  }  

Ouch! Yes! I have no idea how I did that :-/

Thanks for pointing that out.

-- Steve
