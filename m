Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeEVPnm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:43:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:35104 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:43:40 -0400
Subject: Re: [PATCH] tc-testing: flush gact actions on test teardown
To: Vlad Buslov <vladbu@mellanox.com>, linux-kselftest@vger.kernel.org,
        davem@davemloft.net
Cc: lucasb@mojatatu.com, jhs@mojatatu.com, mrv@mojatatu.com,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <1526660482-10424-1-git-send-email-vladbu@mellanox.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <11f03b6a-a8c4-e64c-7e2d-fb8218bc6320@kernel.org>
Date: Tue, 22 May 2018 09:43:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526660482-10424-1-git-send-email-vladbu@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 10:21 AM, Vlad Buslov wrote:
> Test 6fb4 creates one mirred and one pipe action, but only flushes mirred
> on teardown. Leaking pipe action causes failures in other tests.
> 
> Add additional teardown command to also flush gact actions.
> 
> Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
> ---
>  tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> index 443c9b3..acb24f7 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
> @@ -44,7 +44,8 @@
>          "matchPattern": "action order [0-9]*: mirred \\(Egress Redirect to device lo\\).*index 2 ref",
>          "matchCount": "1",
>          "teardown": [
> -            "$TC actions flush action mirred"
> +            "$TC actions flush action mirred",
> +            "$TC actions flush action gact"
>          ]
>      },
>      {
> 

I can get this into 4.18-rc1 unless there is a reason for this to go
through net tree.

thanks,
-- Shuah
