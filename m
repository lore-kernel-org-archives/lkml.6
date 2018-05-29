Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965602AbeE2Ryq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:54:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36114 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965349AbeE2Ryn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:54:43 -0400
Subject: Re: [PATCH] [RESEND] selftest: intel_pstate: debug support message
 from aperf.c and return value fix.
To: Jeffrin Jose T <ahiliation@gmail.com>, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180529172436.4432-1-ahiliation@gmail.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <e68e630d-c8fd-41cd-b579-1bfffa8a1042@kernel.org>
Date: Tue, 29 May 2018 11:54:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529172436.4432-1-ahiliation@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 11:24 AM, Jeffrin Jose T wrote:
> Additional message along with an error message which is more
> verbose for debug support from aperf.c and updated with the
> new return value "KSFT_SKIP".
> 
> Signed-off-by: Jeffrin Jose T [Rajagiri SET] <ahiliation@gmail.com>
> ---
>  tools/testing/selftests/intel_pstate/aperf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
> index d21edea9c560..f6cd03a87493 100644
> --- a/tools/testing/selftests/intel_pstate/aperf.c
> +++ b/tools/testing/selftests/intel_pstate/aperf.c
> @@ -9,6 +9,8 @@
>  #include <sys/timeb.h>
>  #include <sched.h>
>  #include <errno.h>
> +#include <string.h>
> +#include "../kselftest.h"
>  
>  void usage(char *name) {
>  	printf ("Usage: %s cpunum\n", name);
> @@ -41,8 +43,8 @@ int main(int argc, char **argv) {
>  	fd = open(msr_file_name, O_RDONLY);
>  
>  	if (fd == -1) {
> -		perror("Failed to open");
> -		return 1;
> +		printf("/dev/cpu/%d/msr: %s\n", cpu, strerror(errno));
> +		return KSFT_SKIP;
>  	}
>  
>  	CPU_ZERO(&cpuset);
> 

Thanks, Applied to linux-kselftest next for 4.18-rc1

-- Shuah
