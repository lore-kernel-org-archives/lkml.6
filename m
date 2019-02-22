Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DF220665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550847559;
	bh=a8qydsBpMJvEh5eEyoXAs5wpFk2lkc/+zRRAUbYCz/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r/QUQBr7B83VAbkr0opAm0ZrSSuxaMco16wulD3OObDEr5o5oSE/S3WpvuANiJGFZ
	 rYDHHns0t1ZVAhumPAvV+sUbz+N7beOmgJc0QutluHtvzklkCpP8D1j4tNYUNePlp5
	 w9XnB7ZBYaBqIVO1X3DFHgaNAoJ1tsimJqQaokPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBVO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfBVO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:59:18 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6A420657;
        Fri, 22 Feb 2019 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550847557;
        bh=a8qydsBpMJvEh5eEyoXAs5wpFk2lkc/+zRRAUbYCz/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XXn/YagAaWWLTyQEqhvloSvfvJ2jKDRx8Fj68gnKo4YdMOSmxfwYJ9B4UTOf5piWz
         wVTpIw+WD6d3HKZJHp0jKBb7H6oqjGjPmCQUvllViQEz1vKXuxMVRiuXudGs/E380O
         rir9EbTyTEVh6E2WslIX32BjMD9ZX7Xz4yqWm6P4=
Date:   Fri, 22 Feb 2019 23:59:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Replace \e with \033
Message-Id: <20190222235915.bdf82008eef24f8189bd33ec@kernel.org>
In-Reply-To: <20190222091021.10178-3-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
        <20190222091021.10178-1-juergh@canonical.com>
        <20190222091021.10178-3-juergh@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 10:10:21 +0100
Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> The \e sequence character is not POSIX. Fix that by using \033 instead.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

This also looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  tools/testing/selftests/ftrace/ftracetest | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 20c9c0ad8682..136387422b00 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -161,10 +161,10 @@ color_green=
>  color_blue=
>  # If stdout exists and number of colors is eight or more, use them
>  if [ -t 1 -a "$ncolors" -ge 8 ]; then
> -  color_reset="\e[0m"
> -  color_red="\e[31m"
> -  color_green="\e[32m"
> -  color_blue="\e[34m"
> +  color_reset="\033[0m"
> +  color_red="\033[31m"
> +  color_green="\033[32m"
> +  color_blue="\033[34m"
>  fi
>  
>  strip_esc() {
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
