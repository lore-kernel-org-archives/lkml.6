Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AH8x225BK5NcqmCG6HDoXS8/axNLM5Ac14IX0Htl0T0SXPEWOhl4qJi078HURZcyH5T9KRa7xAgT
ARC-Seal: i=1; a=rsa-sha256; t=1518557120; cv=none;
        d=google.com; s=arc-20160816;
        b=fJ3NYCmHl5YB7G1r0HGbVzDzlpl6mD9Q2976Rjlqk54zNUejd8xwz9AgIwyzJhAUAt
         dpaXkaPn157q1eul3VcDZxPPgmto8HxQw4Z/TNtxagFaHGNkk2yLQZs21fsVGoxNvOIM
         LVnlLyAdDbgXX44PFWjbtMkn0IOxc6HFp3RIIv1lTaGo6ZgFt4TOvykBTYye0QiusbA+
         I1Cho9bJnAR2S8pLRXhetvxyUcS0GWf7duX5+a/H5RBXcqUFiclrOA39h2RHdcPLOSih
         LD7qyV2I8S/gxDsQYxXzqmsCMy3W3k2nyuS9DLausNM21RWtkpfsD5xEZUDzhCSnGe2s
         l3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=whBfjLmaDhjGWoA1M+4lE0KynTDYCtnLmOyxgBbJcog=;
        b=vSeAeYhOAw+LfRXGN3DX8dCU7jLhRL60QZTNib/Nm9qU1iVgMOIGKBDp/yT+vQ3PeK
         T7j9R2C2DuSNbYhz6yN1PDuxZiMBLjepkYLPagsiQK2StNXF5sZuvlcqYegPABDhJg+n
         P5zpJ1FY+IVoebzFF+L18t1lRo5sU1i4NQG5SUg9ykXYxxRAJRAvVZAfN7E1BUVhjvxA
         nYyEx5u993QX/FITrJazQh1oYgj2WIE7lEiJt6GJ0y3k42TLmDpziI/E4qKUJsjDbxnB
         yaa6JbOmSnJ0UHasXCgnNG2un4ulytsbewMwwwF3WB1oHI3tlgBcgxRu0LWB9k+eD3+l
         rrsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Subject: Re: [PATCH v2] selftests: sync: missing CFLAGS while compiling
To: =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
 linux-kselftest@vger.kernel.org
Cc: Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <1517955821-11511-1-git-send-email-daniel.diaz@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <24ab9c58-2f4c-b433-7b36-421e51a2e79b@osg.samsung.com>
Date: Tue, 13 Feb 2018 14:25:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517955821-11511-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591692060061952233?=
X-GMAIL-MSGID: =?utf-8?q?1592322551672596082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/06/2018 03:23 PM, Daniel Díaz wrote:
> From: Anders Roxell <anders.roxell@linaro.org>
> 
> Based on patch: https://patchwork.kernel.org/patch/10042045/
> 
> arch64-linux-gnu-gcc -c sync.c -o sync/sync.o
> sync.c:42:29: fatal error: linux/sync_file.h: No such file or directory
>  #include <linux/sync_file.h>
>                              ^
> CFLAGS is not used during the compile step, so the system instead of
> kernel headers are used.  Fix this by adding CFLAGS to the OBJS compile
> rule.
> 
> Reported-by: Lei Yang <Lei.Yang@windriver.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/sync/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sync/Makefile b/tools/testing/selftests/sync/Makefile
> index b3c8ba3..d0121a8 100644
> --- a/tools/testing/selftests/sync/Makefile
> +++ b/tools/testing/selftests/sync/Makefile
> @@ -30,7 +30,7 @@ $(TEST_CUSTOM_PROGS): $(TESTS) $(OBJS)
>  	$(CC) -o $(TEST_CUSTOM_PROGS) $(OBJS) $(TESTS) $(CFLAGS) $(LDFLAGS)
>  
>  $(OBJS): $(OUTPUT)/%.o: %.c
> -	$(CC) -c $^ -o $@
> +	$(CC) -c $^ -o $@ $(CFLAGS)
>  
>  $(TESTS): $(OUTPUT)/%.o: %.c
>  	$(CC) -c $^ -o $@
> 

Thanks for the patch. Applied to linux-kselftest fixes for 4.16-rc3

thanks,
-- Shuah
