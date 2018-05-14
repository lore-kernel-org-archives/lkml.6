Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeENCW7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:22:59 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:55582 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751903AbeENCW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:22:58 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 14 May 2018 11:23:09 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Yann Ylavic <ylavic.dev@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-rt-users@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter
 logic be full string
Message-ID: <20180514022309.GA9220@sejong>
References: <20180511194927.190877137@goodmis.org>
 <20180511195341.034688188@goodmis.org>
 <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 12, 2018 at 08:32:18PM +0200, Yann Ylavic wrote:
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

Yep, I think so.  Otherwise it'll always return true when len is 0.

Thanks,
Namhyung
