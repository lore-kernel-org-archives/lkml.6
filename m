Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7D62083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQiNW1wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7D62083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJOW2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeJOW2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:28:08 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383D320652;
        Mon, 15 Oct 2018 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539614553;
        bh=/Zv8tYo7ab8C/hc6Zpzejb57DmKdMf+/VIl7IP/KCLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BQiNW1wTBHfb9+Y8DjG22A5n2xeK3trzpHfm/Tjg1puCe9ClphtWh/DHeXcL2mHJY
         SPTKXzpLgp3MdZxMj0Dz4E3uRRdH34mGVvWrH0kjhpM9wVG/DxnQfwOiV6C6gtnK4s
         iWMSiOuiVgUKhEWBuli+UZGAcPHgdaaW9t2Umud8=
Date:   Mon, 15 Oct 2018 23:42:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
Message-Id: <20181015234231.e163ab77fd42dbd3ac9c84d5@kernel.org>
In-Reply-To: <20181012222106.7f38b667@vmware.local.home>
References: <20181012222106.7f38b667@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 22:21:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Now that ftracetest has over 80 tests, it is difficult to simply scroll
> up the console window to find the failed tests when it reports just two
> tests have failed. In order to make this stand out better, have the
> color of the word "PASS" be green, "FAIL" and "XFAIL" be red, and all
> other results be blue. This helps tremendously in quickly spotting the
> failed tests by just scrolling up the console window.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 5c71d58..4946b2e 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -153,7 +153,7 @@ else
>  fi
>  
>  prlog() { # messages
> -  [ -z "$LOG_FILE" ] && echo "$@" || echo "$@" | tee -a $LOG_FILE
> +  [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE
>  }
>  catlog() { #file
>    [ -z "$LOG_FILE" ] && cat $1 || cat $1 | tee -a $LOG_FILE
> @@ -195,37 +195,37 @@ test_on_instance() { # testfile
>  eval_result() { # sigval
>    case $1 in
>      $PASS)
> -      prlog "	[PASS]"
> +      prlog "	[\e[32mPASS\e[30m]"
>        PASSED_CASES="$PASSED_CASES $CASENO"
>        return 0
>      ;;
>      $FAIL)
> -      prlog "	[FAIL]"
> +      prlog "	[\e[31mFAIL\e[30m]"
>        FAILED_CASES="$FAILED_CASES $CASENO"
>        return 1 # this is a bug.
>      ;;
>      $UNRESOLVED)
> -      prlog "	[UNRESOLVED]"
> +      prlog "	[\e[34mUNRESOLVED\e[30m]"
>        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
>        return 1 # this is a kind of bug.. something happened.
>      ;;
>      $UNTESTED)
> -      prlog "	[UNTESTED]"
> +      prlog "	[\e[34mUNTESTED\e[30m]"
>        UNTESTED_CASES="$UNTESTED_CASES $CASENO"
>        return 0
>      ;;
>      $UNSUPPORTED)
> -      prlog "	[UNSUPPORTED]"
> +      prlog "	[\e[34mUNSUPPORTED\e[30m]"
>        UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
>        return $UNSUPPORTED_RESULT # depends on use case
>      ;;
>      $XFAIL)
> -      prlog "	[XFAIL]"
> +      prlog "	[\e[31mXFAIL\e[30m]"
>        XFAILED_CASES="$XFAILED_CASES $CASENO"
>        return 0
>      ;;
>      *)
> -      prlog "	[UNDEFINED]"
> +      prlog "	[\e[34mUNDEFINED\e[30m]"
>        UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
>        return 1 # this must be a test bug
>      ;;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
