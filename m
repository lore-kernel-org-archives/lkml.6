Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C414EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8741F2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550875567;
	bh=Yw2HcCuCIHwA9wSEn1s3zOskQllgjEJhcuMAL1lKx8g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kQ9+1u7JqFGIfI5k3oeEgxe0sM9sgStC1IpdF0CdDGh3HjXNv8kHc3lhyhIzmtvhJ
	 gYneLp02QXENTM4YWgWiG31Oj42tLoQCInInWpENwwAJnKZFXQ/Ag6lONTfwFInfGS
	 Oq6+vNEo3DIVhsSVuoKVj9oaZ+sFQhp/IZM0qauw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBVWqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfBVWqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:46:05 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C279206C0;
        Fri, 22 Feb 2019 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550875564;
        bh=Yw2HcCuCIHwA9wSEn1s3zOskQllgjEJhcuMAL1lKx8g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vDxTkXNmppsp7rGIv4WQe2Fx2eALwQqToZc2UmtcRs8XHSzpW9h4yP7Ehzs5Tg1qC
         8kGkBb3EqdfA0znpaMeoDI2VuwT+DfV2fLYd5X86FCi7QSIM/fwFqaQV7mOYSfK5WQ
         5C47lRW9vt7jUtHU6pl//SaZTpDVJ3LE1qsBXGbA=
Subject: Re: [RESEND PATCH v2 2/2] selftests/ftrace: Replace \e with \033
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>, shuah <shuah@kernel.org>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205351.743-1-juergh@canonical.com>
 <20190222205351.743-3-juergh@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <aedb3a7e-058e-ec62-93c7-0767717b9ea9@kernel.org>
Date:   Fri, 22 Feb 2019 15:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222205351.743-3-juergh@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 1:53 PM, Juerg Haefliger wrote:
> The \e sequence character is not POSIX. Fix that by using \033 instead.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>   tools/testing/selftests/ftrace/ftracetest | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 20c9c0ad8682..136387422b00 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -161,10 +161,10 @@ color_green=
>   color_blue=
>   # If stdout exists and number of colors is eight or more, use them
>   if [ -t 1 -a "$ncolors" -ge 8 ]; then
> -  color_reset="\e[0m"
> -  color_red="\e[31m"
> -  color_green="\e[32m"
> -  color_blue="\e[34m"
> +  color_reset="\033[0m"
> +  color_red="\033[31m"
> +  color_green="\033[32m"
> +  color_blue="\033[34m"
>   fi
>   
>   strip_esc() {
> 

Which release is this patch based on?

This one failed to apply to linux-kselftest next - I resolved a minor
merge conflict and applied it. Please review to make sure it looks good.

thanks,
-- Shuah
