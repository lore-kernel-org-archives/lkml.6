Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67D02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdocE2iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67D02089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJPXRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeJPXRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:17:33 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DDB2083C;
        Tue, 16 Oct 2018 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539703595;
        bh=ACXox51dDgGsy+J2wwHPeURhjx6sOgxqY6vXLCXWSF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fdocE2iCTJw555y1elcIsT7efIqZ5BHjnzQXnjrr4N4/yV2Ob5zuePdIbN+0ckPm+
         DVKs1rw1OY3kBauDMVDX9C7MTrBNzQTk93po8NQHBqApNNQhLQr/CWYw4NnrsDIJsN
         XNec1pxSib3fqhG6YuRKzPPMHcsMwaf74M/hcSJ4=
Date:   Wed, 17 Oct 2018 00:26:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
Message-Id: <20181017002632.20fcb18bf94efb79aa58219b@kernel.org>
In-Reply-To: <20181015234231.e163ab77fd42dbd3ac9c84d5@kernel.org>
References: <20181012222106.7f38b667@vmware.local.home>
        <20181015234231.e163ab77fd42dbd3ac9c84d5@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 23:42:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 12 Oct 2018 22:21:06 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Now that ftracetest has over 80 tests, it is difficult to simply scroll
> > up the console window to find the failed tests when it reports just two
> > tests have failed. In order to make this stand out better, have the
> > color of the word "PASS" be green, "FAIL" and "XFAIL" be red, and all
> > other results be blue. This helps tremendously in quickly spotting the
> > failed tests by just scrolling up the console window.
> > 
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Oops, I found some problems.

> 
> Thanks!
> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index 5c71d58..4946b2e 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -153,7 +153,7 @@ else
> >  fi
> >  
> >  prlog() { # messages
> > -  [ -z "$LOG_FILE" ] && echo "$@" || echo "$@" | tee -a $LOG_FILE
> > +  [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE

I think we should strip escape-sequences from log files, like below;

strip_esc() {
  sed -E "s/[[:cntrl:]]\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

  [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | strip_esc | tee -a $LOG_FILE


> >  }
> >  catlog() { #file
> >    [ -z "$LOG_FILE" ] && cat $1 || cat $1 | tee -a $LOG_FILE
> > @@ -195,37 +195,37 @@ test_on_instance() { # testfile
> >  eval_result() { # sigval
> >    case $1 in
> >      $PASS)
> > -      prlog "	[PASS]"
> > +      prlog "	[\e[32mPASS\e[30m]"

The last one should be "\e[0m" (reset), "\e[30m" just set the color "black".
That doesn't work on my terminal, which is "white on black".

Thank you,


-- 
Masami Hiramatsu
