Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC151C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F7A2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550847495;
	bh=lZJVLEuoUWjOmNdsPu6jRYp4GSGkV+jvi5cZUMfuRWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TB5arKu8WzuoA2gBkpTuO0xK/ZhV8RdMY58c7fVl1aOUi+AgN2uFJ4ZZiPqoyL3mm
	 EwKDPkG77rX7uCPvyqu4BZoASmX4dsXy7r/bsSbcZU5SCrn+ccoYMm0vP2FMH/wvqo
	 Sz4mwjixI6AQ1L3ie9Sz3rPef73SzSquo/n95Ecw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfBVO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfBVO6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:58:14 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647C320657;
        Fri, 22 Feb 2019 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550847493;
        bh=lZJVLEuoUWjOmNdsPu6jRYp4GSGkV+jvi5cZUMfuRWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TDni8ZVuf+vo68gaUPayClM87nz78MKAJqO3kyc1Cp2mlI9naLJPchihLfO0IeehI
         hSsL/fEdILE0J62foG7FmQSo8N8sCaqz8fXrBMdNFIhcyL708Gw9ngFmxToFsqEEcB
         EKM/B84dxOyJsLL83m70GMtiYDcCSt7Tgu3uajTo=
Date:   Fri, 22 Feb 2019 23:58:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 1/2] selftests/ftrace: Replace echo -e with printf
Message-Id: <20190222235810.ae69b00c57442b5fb9dd01a8@kernel.org>
In-Reply-To: <20190222091021.10178-2-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
        <20190222091021.10178-1-juergh@canonical.com>
        <20190222091021.10178-2-juergh@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 10:10:20 +0100
Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> echo -e is not POSIX. Depending on what /bin/sh is, we can get
> incorrect output like:
> $ -e -n [1] Basic trace file check
> $ -e 	[PASS]
> 
> Fix that by using printf instead.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  tools/testing/selftests/ftrace/ftracetest | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index fc755e1b50f1..20c9c0ad8682 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -173,8 +173,13 @@ strip_esc() {
>  }
>  
>  prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  newline="\n"
> +  if [ "$1" = "-n" ] ; then
> +    newline=
> +    shift
> +  fi
> +  printf "$*$newline"
> +  [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
>    cat $1
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
