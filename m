Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015A0208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015A0208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeHYBXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeHYBXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:23:38 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239B6208B2;
        Fri, 24 Aug 2018 21:47:12 +0000 (UTC)
Date:   Fri, 24 Aug 2018 17:47:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/32] selftests/ftrace: Add case number prefix to
 logfile
Message-ID: <20180824174710.3a5050ca@gandalf.local.home>
In-Reply-To: <153443706488.23257.9219288456614329354.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443706488.23257.9219288456614329354.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:31:05 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a case number prefix to each logfile. This makes
> it easier to find which logfile is corresponding
> to which failure.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve

> ---
>  tools/testing/selftests/ftrace/ftracetest |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 8debd37038e4..3ca596255eff 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -284,13 +284,13 @@ __run_test() { # testfile
>  # Run one test case
>  run_test() { # testfile
>    local testname=`basename $1`
> +  testcase $1
>    if [ ! -z "$LOG_FILE" ] ; then
> -    local testlog=`mktemp $LOG_DIR/${testname}-log.XXXXXX`
> +    local testlog=`mktemp $LOG_DIR/${CASENO}-${testname}-log.XXXXXX`
>    else
>      local testlog=/proc/self/fd/1
>    fi
>    export TMPDIR=`mktemp -d /tmp/ftracetest-dir.XXXXXX`
> -  testcase $1
>    echo "execute$INSTANCE: "$1 > $testlog
>    SIG_RESULT=0
>    if [ $VERBOSE -eq -1 ]; then

