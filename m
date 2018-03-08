Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu6s77hA8dtEuL6CUtcwKjlLr9nomWvLEEDnE9Y1nE49Z6tNV2kxkik+cdIqPM/1YMsMigM
ARC-Seal: i=1; a=rsa-sha256; t=1520537528; cv=none;
        d=google.com; s=arc-20160816;
        b=xjROk4uJlhl2TUWfmFNfMWNT0f+BKJAiEcD/BLBuiSl/PbSrtZ9gbdbTz55GpNHCCO
         ZupOHqdkZdqUqPFK8YvdzuJScjovX1i95QsWyFvo1jjcdw4gkf3K4y9zJAiXXNzjNDPy
         0pgM8tqfTJYJsa/E17DkldacafWuaaJauHsXnVr0gKh8UAyS2Ir9+Gjyu0uMu+iJ7huN
         lSlK2FRHv0j6gsSeKverdNaxRtrFGze9HmYT0wb5tPePU94Ec1YefmIuuwqm5G1UJYZd
         G/aaA3jl797ZuGq9WA+WpIQnW0lyYrRajAxQYdJhxwjgghDuoPCWGz2THzKdGfvHbRzY
         P3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=5GfnDo69rsGcfCl4r1pmA7SkFUql0LQZAezQtY23QmE=;
        b=KsbNePuVWM4tDFa90h1MQNGNW95AdMC1tzmvDDZspfQJeCVtMeYnVgLrIhSIoxx9L1
         hLGONOKPlRWr/z/m8RVSnSUkBt/mGnFgQA2F4R/2x6Ju6Ylj71wDdEte1huMGI8uO6YM
         jEfxgM6Vtmy28YN/y2kLACf6yt8yUySPbOnnm9lPYH3JUIVehgz26QPdzxdc74A60NxZ
         ckTvTdOdRLMxkUVWeXcI0rxpHYPtzjBjRtM4n5sgZLDgDW5EnW/nPKrpuREqW5JQpmcw
         VLv1fIyYqNkM0oOKlR+cnlJF8LpzlOLjRtHMTfnFkIj52eCsaC6+h+WWyqt47/pEisLu
         wXIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeCHTcI (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 14:32:08 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33520 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeCHTcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 14:32:06 -0500
Subject: Re: [PATCH] selftests/android/ion: Makefile: fix build error
To: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc: pintu.ping@gmail.com, daniel.vetter@ffwll.ch,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308143741.4415-1-anders.roxell@linaro.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <9e41eb91-8bac-0bf0-987d-8d95c0bfce94@redhat.com>
Date: Thu, 8 Mar 2018 11:32:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308143741.4415-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594380652226081333?=
X-GMAIL-MSGID: =?utf-8?q?1594399159568296511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 06:37 AM, Anders Roxell wrote:
> Fails to build iomap_test.c due to missing include
> 
> gcc  -I. -I../../../../../drivers/staging/android/uapi/ -Wall -O2 -g
> ionmap_test.c ipcsocket.c ionutils.c   -o ionmap_test
> ionmap_test.c:12:27: fatal error: linux/dma-buf.h: No such file or
> directory
>   #include <linux/dma-buf.h>
>                             ^
> compilation terminated.
> <builtin>: recipe for target 'ionmap_test' failed
> make[2]: *** [ionmap_test] Error 1
> 
> In the current code, we add a new -I ../../../../../usr/include/ to the
> INCLUDEDIR variable. Also add ionmap_test to the .gitignore file.
> > Fixes: ac93f7046a53 ("selftests: ion: Add simple test with the vgem driver")

Where is this hash from? It's not in Linus' master branch.
Are the /usr/include header properly sanitized, if so that's nice
because there's been debates before about how best to pick up
the sanitized headers. I see that used several other places
around self-tests too. Anyway, you can add

Acked-by: Laura Abbott <labbott@redhat.com>

Thanks,
Laura

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/android/ion/.gitignore | 1 +
>   tools/testing/selftests/android/ion/Makefile   | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/android/ion/.gitignore b/tools/testing/selftests/android/ion/.gitignore
> index 67e6f391b2a9..95e8f4561474 100644
> --- a/tools/testing/selftests/android/ion/.gitignore
> +++ b/tools/testing/selftests/android/ion/.gitignore
> @@ -1,2 +1,3 @@
>   ionapp_export
>   ionapp_import
> +ionmap_test
> diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
> index d23b6d537d8b..e03695287f76 100644
> --- a/tools/testing/selftests/android/ion/Makefile
> +++ b/tools/testing/selftests/android/ion/Makefile
> @@ -1,5 +1,5 @@
>   
> -INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
> +INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/
>   CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
>   
>   TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
> 

