Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A70A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551106277;
	bh=7gCYvmgOv9bLKE2LtOcJ5izhujOIUz0P3h3p7M1h6mE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=buj/uad4Jl14HyB3gAM1vwyD53gnwPU1h22bv0sz4LMRnPwluyaIYR1SlzdVVRNWG
	 UENNvNJJi0TO+V1tCmXxf+xQZO/8X7hIMZ2NjuY+w+6s5aZ4wyCOc8+gNfQbJxwdNP
	 +0U31WFH31QeoW1uH4jX1+ZzgauawuRYRCyAL/zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBYOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfBYOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:51:15 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4446F20663;
        Mon, 25 Feb 2019 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551106274;
        bh=7gCYvmgOv9bLKE2LtOcJ5izhujOIUz0P3h3p7M1h6mE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uLTxuLQKAVmtZ6XIHzLupOccgtKjvsi3p33huj2wnhouHBhnu/gFL7/lmhJGOK51d
         ozYRvGaybZb/u0UMZsB6kt/5qHNOAn8W3MU42q6LzH8mSKgJbLRH7/Jn4IosItMQ5A
         yhLPF112+WP7sbC/QyI7UrqPWl9g+A4yjT/yJI+A=
Subject: Re: [RESEND PATCH] selftests/ftrace: Handle the absence of tput
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>, shuah <shuah@kernel.org>
References: <20190220153706.24686-1-juergh@canonical.com>
 <20190225131450.4775-1-juergh@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <41adf479-e6e3-8233-4066-983d5e701177@kernel.org>
Date:   Mon, 25 Feb 2019 07:51:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225131450.4775-1-juergh@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 6:14 AM, Juerg Haefliger wrote:
> In environments where tput is not available, we get the following
> error
> $ ./ftracetest: 163: [: Illegal number:
> because ncolors is an empty string. Fix that by setting it to 0 if the
> tput command fails.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>   tools/testing/selftests/ftrace/ftracetest | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 75244db70331..fc755e1b50f1 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -154,13 +154,13 @@ fi
>   
>   # Define text colors
>   # Check available colors on the terminal, if any
> -ncolors=`tput colors 2>/dev/null`
> +ncolors=`tput colors 2>/dev/null || echo 0`
>   color_reset=
>   color_red=
>   color_green=
>   color_blue=
>   # If stdout exists and number of colors is eight or more, use them
> -if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> +if [ -t 1 -a "$ncolors" -ge 8 ]; then
>     color_reset="\e[0m"
>     color_red="\e[31m"
>     color_green="\e[32m"
> 

Juerg!

Thanks for the resend. Applied to linux-kselftest next for 5.1-rc1.

Since I applied this patch out of order, I had to resolve minor merge
conflict. Please review.

thanks,
-- Shuah
