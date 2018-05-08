Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeEHADq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:03:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36040 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeEHADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:03:44 -0400
X-Google-Smtp-Source: AB8JxZoOPJ5Ta9vwUB6HvyF1ZgNlht5dOtfv5tCADtouOctEkigEh75ZtB1pHRaAMpsBo24HqMlLtg==
Subject: Re: [PATCH 06/24] selftests: exec: return Kselftest Skip code for
 skipped tests
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180505011328.32078-1-shuah@kernel.org>
 <20180505011328.32078-6-shuah@kernel.org>
From: Steve Muckle <smuckle.linux@gmail.com>
Message-ID: <cb8cefa1-a355-789a-ff79-10c8e3393723@gmail.com>
Date: Mon, 7 May 2018 17:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180505011328.32078-6-shuah@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 06:13 PM, Shuah Khan (Samsung OSG) wrote:
> When execveat test is skipped because of unmet dependencies and/or
> unsupported configuration, it exits with error which is treated as
> a fail by the Kselftest framework. This leads to false negative
> result even when the test could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Change it to use ksft_exit_skip() when kernel doesn't support execveat.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>   tools/testing/selftests/exec/execveat.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index 67cd4597db2b..47cbf54d0801 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -20,6 +20,8 @@
>   #include <string.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
> +
>   static char longpath[2 * PATH_MAX] = "";
>   static char *envp[] = { "IN_TEST=yes", NULL, NULL };
>   static char *argv[] = { "execveat", "99", NULL };
> @@ -249,8 +251,8 @@ static int run_tests(void)
>   	errno = 0;
>   	execveat_(-1, NULL, NULL, NULL, 0);
>   	if (errno == ENOSYS) {
> -		printf("[FAIL] ENOSYS calling execveat - no kernel support?\n");
> -		return 1;
> +		ksft_exit_skip(
> +			"ENOSYS calling execveat - no kernel support?\n");
>   	}
>   
>   	/* Change file position to confirm it doesn't affect anything */
> 
LGTM.

thanks,
Steve
