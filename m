Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuHYiXNALW/FO0hH1FLGW47HaZ7s8mZ6FGFW8EeXu57YUXoLqfPMPA/bJcbcHMFFilxM7Va
ARC-Seal: i=1; a=rsa-sha256; t=1520989759; cv=none;
        d=google.com; s=arc-20160816;
        b=Ggpuq6xkYbVFMH0VOVI7c8Wr2nuR9h9ew646YbPZN3soB1ZxaZi8cAzodIUtIsYXAT
         y51OkjSd5XtlRr+leHUyPk+IaL5l+/M423MENB9DOR6u448wkgXrD4Ct/+DfxJsdI6F8
         TGyRmll0pBgc03lVc4Av0LW4o15lRkY1ONs3bgVULB8BbIdIhM2PeSZN51HCvEYtK6F9
         Rrfz3fN6uVbu7WobDdCCAoLpy4qufedF1S185th4BaXq0g0CoI2+8FjDSxvQegrFEL3e
         3KYf9QVbBJWoPOhSb5EdqMRo9M3/xqgSFtM1N0zOiuoR9N/saZQIEByT9gHQD2dDbq2J
         sQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=FktR0faMikVyiZfKd7QMvwk3/4fo7UWlbhwF4KBBwGc=;
        b=m4+rCQfzXog14pR92t29GLxhQW9IUmFCIXtbOX4qJU9wM2Fizlo3Z308EgYRnvGo58
         j6k/WFUnX07ovfs3pIH8xjRbqYEiPKfaXYlmv0+Llo/xb5n8JHq7E/bnAyrpL/b7IeNp
         yQSApZhki/0Nt6L33sn7S0JVbgKtltAVq3yWadzftx35NjZ9SDzc6mt3THLJH3N3TLMy
         wWHqklU8NedwxZ4ATw2egodGniR+iXyFBUcqeaxiNphtsosK9pQF95NXExfP+ps9jP+Y
         KOpLouUNm9gIHTV/hevqdALUPE6do6Wgb58iDXNI4wzrZaa12DTAjPd17WlS2XIAE3cm
         ZrsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=VdJQH7vW;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@oracle.com header.s=corp-2017-10-26 header.b=VdJQH7vW;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeCNBJT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Mar 2018 21:09:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35544 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeCNBJS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Mar 2018 21:09:18 -0400
Subject: Re: [PATCH 1/2] selftests/memfd/memfd_test.c: fix implicit
 declaration
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        dh.herrmann@gmail.com
References: <20180313114205.27714-1-anders.roxell@linaro.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c3341eb3-623a-b5dd-e0d1-e7b9b6650932@oracle.com>
Date: Tue, 13 Mar 2018 18:09:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180313114205.27714-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140009
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822578193743011?=
X-GMAIL-MSGID: =?utf-8?q?1594873358224001600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 04:42 AM, Anders Roxell wrote:
> gcc warns about implicit declaration.
> 
> gcc -D_FILE_OFFSET_BITS=64 -I../../../../include/uapi/
>     -I../../../../include/ -I../../../../usr/include/
>     memfd_test.c common.o  -o memfd_test
> memfd_test.c: In function ‘mfd_assert_get_seals’:
> memfd_test.c:74:6: warning: implicit declaration of function ‘fcntl’
>     [-Wimplicit-function-declaration]
>   r = fcntl(fd, F_GET_SEALS);
>       ^~~~~
> memfd_test.c: In function ‘mfd_assert_open’:
> memfd_test.c:197:6: warning: implicit declaration of function ‘open’
>     [-Wimplicit-function-declaration]
>   r = open(buf, flags, mode);
>       ^~~~
> memfd_test.c: In function ‘mfd_assert_write’:
> memfd_test.c:328:6: warning: implicit declaration of function ‘fallocate’
>     [-Wimplicit-function-declaration]
>   r = fallocate(fd,
>       ^~~~~~~~~
> 
> In the current code, we include the headers that the functions want
> according to the man pages, and we add some defines that will be used if
> they isn't found in glibc.  The defines was added into the kernel source
> in kernel >= 3.16 and glibc requires kernel header files >= 3.2.
> 
> Fixes: 4f5ce5e8d7e2 ("selftests: add memfd_create() + sealing tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 10baa1652fc2..0dbeb29c094c 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -6,7 +6,6 @@
>  #include <inttypes.h>
>  #include <limits.h>
>  #include <linux/falloc.h>
> -#include <linux/fcntl.h>
>  #include <linux/memfd.h>
>  #include <sched.h>
>  #include <stdio.h>
> @@ -14,13 +13,37 @@
>  #include <signal.h>
>  #include <string.h>
>  #include <sys/mman.h>
> +#include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <sys/wait.h>
> +#include <fcntl.h>
>  #include <unistd.h>

I suspect there is some guiding philosophy for selftests that I am
unfamiliar with.  However, it seems that tests should use as much
of the header files in the current kernel source tree as possible.
This change removes the include of a header in the current source
tree <linux/fcntl.h>.  It replaces that with the header <fcntl.h>
from the host system (and some other changes).

To me, this seems like step in the wrong direction.  But, I could
be totally wrong and perhaps self tests should primarily target the
host system header files.
-- 
Mike Kravetz
