Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5A20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak4BVu0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB5A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeK3DtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbeK3DtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:49:13 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE9D20989;
        Thu, 29 Nov 2018 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543509795;
        bh=FeqEi0Eb0SWqBsIVXnMSH6dfTtYrxgzKfWDqBZ54oUI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ak4BVu0Q/9FNLrMyQgODIlPS645py0CS1yOmkat9w2BaZvLlNWhktPbenascRWzV3
         pnrCaEL097FuFprk4uvGm0+sphRxkeX/hPehV3sFZ+T0H2Gei+Dhm1uCKbhjBdmuY8
         GHNQX8kEw8gs34Q14Yp7q6t2VQ/FhMAIxeDLtkSk=
Message-ID: <1543509793.2018.2.camel@kernel.org>
Subject: Re: [PATCH] sefltests/ftrace: Use /bin/echo for output with options
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel =?ISO-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Date:   Thu, 29 Nov 2018 10:43:13 -0600
In-Reply-To: <154350406317.4422.7595059658374071660.stgit@devbox>
References: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
         <154350406317.4422.7595059658374071660.stgit@devbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2018-11-30 at 00:07 +0900, Masami Hiramatsu wrote:
> Use /bin/echo for console output with options like non
> newline (-n) and/or backslash escape (-e).
> 
> Tom Zanussi reported that when he tested ftracetest, it
> shows "-e" and "-n" options on the console, since a system
> which uses dash as the alias of /bin/sh, uses dash built-in
> echo command which doesn't accept "-e".
> 
> To avoid this issue, use /bin/echo instead of echo for
> the output with options.
> 
> Fixes: 8f381ac4d321 ("selftests/ftrace: Add color to the PASS / FAIL
> results")
> Link: http://lkml.kernel.org/r/cover.1542221862.git.tom.zanussi@linux
> .intel.com
> Reported-by: Tom Zanussi <zanussi@kernel.org>
> Suggested-by: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest
> b/tools/testing/selftests/ftrace/ftracetest
> index 75244db70331..ba670b452bdb 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -173,8 +173,8 @@ strip_esc() {
>  }
>  
>  prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  /bin/echo -e "$@"
> +  [ "$LOG_FILE" ] && /bin/echo -e "$@" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
>    cat $1
> 

I tried this on the three systems mentioned before, and it worked fine
on all of them.

Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

