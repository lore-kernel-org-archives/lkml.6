Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966260AbeEJPd2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:33:28 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:39034 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964827AbeEJPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:33:26 -0400
Subject: Re: [PATCH] selftests: ftrace: Fixes for the testing script
 ftracetest
To: Jeffrin Jose T <ahiliation@yahoo.co.in>, rostedt@goodmis.org,
        mingo@redhat.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
References: <20180510152108.19750-1-ahiliation@yahoo.co.in>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <4f351384-0308-c273-9df7-c1ad3bc500c4@kernel.org>
Date: Thu, 10 May 2018 09:33:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510152108.19750-1-ahiliation@yahoo.co.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 09:21 AM, Jeffrin Jose T wrote:
> modified notification of permission requirement to run test
> to make it unified with standards
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index f9a9d424c980..0cc967344c07 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  
>  # ftracetest - Ftrace test shell scripts
>  #
> @@ -29,8 +29,11 @@ errexit() { # message
>  }
>  
>  # Ensuring user privilege
> -if [ `id -u` -ne 0 ]; then
> -  errexit "this must be run by root user"
> +msg="skip all tests:"
> +
> +if [ $UID != 0 ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
>  fi
>  
>  # Utilities
> 

Hi Jeffrin,

I already have a patch out for this. Please make sure you aren't doing
duplicate work.

thanks,
-- Shuah
