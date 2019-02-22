Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BEC2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBVAYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBVAYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:24:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01832080F;
        Fri, 22 Feb 2019 00:24:38 +0000 (UTC)
Date:   Thu, 21 Feb 2019 19:24:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <shuahkhan@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] selftests/ftrace: Handle the absence of tput
Message-ID: <20190221192437.2c2fe9f6@gandalf.local.home>
In-Reply-To: <20190222090534.12c57ef31518d2cb48670123@kernel.org>
References: <20190220153706.24686-1-juergh@canonical.com>
        <20190222090534.12c57ef31518d2cb48670123@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 09:05:34 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 20 Feb 2019 16:37:06 +0100
> Juerg Haefliger <juerg.haefliger@canonical.com> wrote:
> 
> > In environments where tput is not availbale, we get the following
> > error
> > $ ./ftracetest: 163: [: Illegal number:
> > because ncolors is an empty string. Fix that by setting it to 0 if the
> > tput command fails.
> > 
> > Signed-off-by: Juerg Haefliger <juergh@canonical.com>  
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Shuah,

Want to take this?

 https://lore.kernel.org/lkml/20190220153706.24686-1-juergh@canonical.com/T/#u

-- Steve

> 
> Thank you!
> 
> > ---
> >  tools/testing/selftests/ftrace/ftracetest | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index 75244db70331..fc755e1b50f1 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -154,13 +154,13 @@ fi
> >  
> >  # Define text colors
> >  # Check available colors on the terminal, if any
> > -ncolors=`tput colors 2>/dev/null`
> > +ncolors=`tput colors 2>/dev/null || echo 0`
> >  color_reset=
> >  color_red=
> >  color_green=
> >  color_blue=
> >  # If stdout exists and number of colors is eight or more, use them
> > -if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> > +if [ -t 1 -a "$ncolors" -ge 8 ]; then
> >    color_reset="\e[0m"
> >    color_red="\e[31m"
> >    color_green="\e[32m"
> > -- 
> > 2.19.1
> >   
> 
> 

