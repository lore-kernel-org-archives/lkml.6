Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC88C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8320838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550793941;
	bh=eyGlHdc55Cdnt691PUvPVTdBePNskTUBCSnEsXp4sGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yYgm/lsKnV3k5GG+DkHWk62Stvn2izOUZG5608XHUkUfZzei4WZqwOPgq4vCfsFCX
	 Wlh9PUkIiOC8YXotpbGZBG8mC36/ZJ/GM0xGjquzRkSHn1Kh8Cg8pQ9jXThtAQOwJK
	 nWuiAr8Q7H1nTRUhYMLnbUuDGEeDoTFctkCHZPWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBVAFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfBVAFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:05:38 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEFA20836;
        Fri, 22 Feb 2019 00:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550793937;
        bh=eyGlHdc55Cdnt691PUvPVTdBePNskTUBCSnEsXp4sGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GP4iz7erOqtMyJoDYieVJtx8Puk7RUap4lpspzapjfT/xC6yAjXpZdlf8L2B5xMCt
         iugO9OhzvmLScWCR8HW5QQLYuJa5jNDbknvPxLCwZir1mCIb6UEmNaDuaLcXTe1kf2
         JEsueeAQctaITWDu8ohv6PyN9OHsMAPL4RYrkiWU=
Date:   Fri, 22 Feb 2019 09:05:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Handle the absence of tput
Message-Id: <20190222090534.12c57ef31518d2cb48670123@kernel.org>
In-Reply-To: <20190220153706.24686-1-juergh@canonical.com>
References: <20190220153706.24686-1-juergh@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 16:37:06 +0100
Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> In environments where tput is not availbale, we get the following
> error
> $ ./ftracetest: 163: [: Illegal number:
> because ncolors is an empty string. Fix that by setting it to 0 if the
> tput command fails.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  tools/testing/selftests/ftrace/ftracetest | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 75244db70331..fc755e1b50f1 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -154,13 +154,13 @@ fi
>  
>  # Define text colors
>  # Check available colors on the terminal, if any
> -ncolors=`tput colors 2>/dev/null`
> +ncolors=`tput colors 2>/dev/null || echo 0`
>  color_reset=
>  color_red=
>  color_green=
>  color_blue=
>  # If stdout exists and number of colors is eight or more, use them
> -if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> +if [ -t 1 -a "$ncolors" -ge 8 ]; then
>    color_reset="\e[0m"
>    color_red="\e[31m"
>    color_green="\e[32m"
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
