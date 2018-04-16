Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753990AbeDPH0P convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:26:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:40949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752883AbeDPH0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:26:13 -0400
Message-ID: <1523863560.8337.5.camel@gmx.de>
Subject: Re: [ANNOUNCE] v4.14.34-rt27
From: Mike Galbraith <efault@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 16 Apr 2018 09:26:00 +0200
In-Reply-To: <20180413215240.scbnvz7egaauawyz@linutronix.de>
References: <20180413215240.scbnvz7egaauawyz@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gzfoWKaLa3uclzfdxIysnSzeQCacuqJzZQIg9/+Dw+fVyDKWLH/
 rc/PqGbECN5PKbSQlpzMt3tUxUurgyuIL7ifSu2Fov+Ys8iHJNIEZMAvdDM0sCq5sWsrJYz
 s5ZGJycSV4MB6HDM5ibChywT65InskhKwqTwiWGGO7tbWRi9njuAZFg+iHQjWNAtjUgJTfA
 xQMFC0qXKwButt4tCAhUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EU6Gfki+3Pc=:P/U3lNxee6TJqZKGUaLqGR
 k+PalpXW8DHoZ5sAbmBAntW3Ux4UeFkYvgeUApRDt2fy9qYKKX2u4kfIcjrXTvdlD5svSxNpr
 GzVOxjKZFzpImngogXoV7pX23L7OOnsrMk8CXW5mloOUyBuTeX4QkEb4gg9NpxJWWRTunr4/V
 apEd0inBbHv/OkKCpMjtOVcxhlX2iC5rmVcnzEKo5sa7KPlSCKVr5vwutxe7z2e08vVz4OrhQ
 INqu/3D6XllR5BciTfqzKfq1zXvZRMTOkKsp5vLmtCVJf6dwup6oOnoWUfvwMikQb52S2APz/
 KRV6TnP/hiL6QTkQ1hkVbY6MFB+GqfjOYr5+O7/hC+V3dupWul674acxzawAJmelWDI33C1A3
 hwwJvSLHWGCrPqUt0C+3/n0sfo03xrC6gpXP8iuZ/gIdo9KabX4Lg6ukWQX2xQRHBZsB7CXBR
 LQcssE3CX/VzKieFbFuSAOn9aET66gQioqpX46ixMsxNGgE460HmD9l+dU+pdHdgvJYIPPAnr
 +5tRCvJdGcEbvY/BLsnqhf9s4CdqntO/HUu4QnUXnqch3qMGgWlFeERosBB4OXjWvZpVletBu
 Qy6Npvm/IH5a9d9FETcXaUwh0hUGig6s5H/MSjx1L87eJ3I/lxhBf/hiA0q5QyRkj7Kx6zVOw
 /yvYhQqktVTdRGQPeQw1XfetcLnOs4UpdoI/4/KAIs+mFioebOn5uycdrYUd/wUEpY+D1zAbo
 t01K24LUAqGNNro0RF6sPtvtbkyCUVMXtvrmyzva0MOlbAN9BgrEjNJJt29QLTCCj82bO8vPI
 Eb4bZdhfzH8E2CER+RcxcC5sSypGtxGS4X3lQYtZhwXa2WRLeQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-13 at 23:52 +0200, Sebastian Andrzej Siewior wrote:
> 
>   - Inter-event (latency) fixes by Tom Zanussi.

  CC      kernel/trace/trace_events_hist.o
kernel/trace/trace_events_hist.c: In function ‘__update_field_vars’:
kernel/trace/trace_events_hist.c:3093:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
    strscpy(str, val_str, STR_VAR_LEN_MAX);
           ^
kernel/trace/trace_events_hist.c: In function ‘trace_event_raw_event_synth’:
kernel/trace/trace_events_hist.c:672:11: warning: ignoring return value of ‘strscpy’, declared with attribute warn_unused_result [-Wunused-result]
    strscpy(str_field, str_val, STR_VAR_LEN_MAX);

Maybe add include/linux/string.h __must_check removal?

(whacked upstream by 08a77676f9c5)

	-Mike
