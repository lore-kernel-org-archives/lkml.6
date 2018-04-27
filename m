Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZoCZ9GsqiFWDvtuJ2/e7Yyh6TMBkNCOs4dpizuPTc39Gj2SmMA2+R2Yi0ohVoq5PXKH27UE
ARC-Seal: i=1; a=rsa-sha256; t=1524850109; cv=none;
        d=google.com; s=arc-20160816;
        b=GD2PLArXD2G11TLEzzg+bQVM1ODzoWYJlvLQFadLZqA5GWbHC9e3aKxWgU/HW1OdzM
         coFbFXxIm7dX9NODjpkGBTTnuOogKzUcAU8GEY+QKS/5Q0H0n2dpV0EP88JbzWRvTPEY
         iychlLVs0B9QvzXEdl7AnQyNEg88CA+X7HS94F54BU29BqeoRAvs1dbh6rSGix5OHLfo
         ePcWQ48E3jxfEAHZsE+U4Z/2JAdRqIAZvmMHNd4vB7vf+1Aj0+wzX6vNPEN1pDh8kRUO
         FQGHbQIXCG4d85Ltk7R5zbfcRWY/HuPvzyY1tm/b0wGeOT0e7jFlWZl7GEcHXKggrz05
         Kz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ZfYVwSf5AvNQUM5GFByxwqUkhB5g3a9rZZ6bTmRxqiQ=;
        b=TI2erSmlWurbD962juBh1IKGISfQyN4stWVUcUQgeKssbbFHhPWemTZYateIpLyNKu
         hQx/JEaW4hHpTk1ztqiP31uPT0PQ2oIrqCkoqTf1TK7CqkzpmD6p4zCk5jLAKkcN0RCS
         pPEZPwsrVBpvVi9Y/ayHRrPgfyueuEtRNLVE+1ZYkeshO1/bpYLAG/tQH+WVJOwUMiAI
         4Un19BXBuafSkP6li4O1mNa90J3kzlfdAQyVVuJYHrUPYcs12AcpdTuFHMSm/XZm3kTz
         4v92UaXRiwBJPTX+KzDUYILkYhZsGXxqzmuC/LMtA/ZG3FJMco1ihjtW6ANF6mF1uFIG
         oScQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qyRTmKRu;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qyRTmKRu;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: kernel-4.9.94 compile error: 'KMOD_DECOMP_LEN' undeclared
To: Teck Choon Giam <giamteckchoon@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 acme@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <84b1d534-9b9d-ff70-ead6-3f8bb70a4d4b@infradead.org>
Date: Fri, 27 Apr 2018 10:28:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAEwRVpOFS5UsyVHkHr+w_OR0eSpvT-CZGG6b4Vr6gxkc4rwO6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1598370592739113214?=
X-GMAIL-MSGID: =?utf-8?q?1598921228585970630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[adding some Cc:]

On 04/14/2018 02:41 AM, Teck Choon Giam wrote:
> Hi,
> 
> Compile linux-4.9.94 will have error related to KMOD_DECOMP_LEN
> undeclared.  Searching string related to KMOD_DECOMP_LEN in
> linux-4.9.94 and linux-4.15.17 sources as below:
> 
> <mock-chroot>sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.15.17
> ./linux-4.15.17/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.h:#define KMOD_DECOMP_LEN
> sizeof(KMOD_DECOMP_NAME)
> ./linux-4.15.17/tools/perf/util/annotate.c: char tmp[KMOD_DECOMP_LEN];
> ./linux-4.15.17/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> sh-4.2# grep -r KMOD_DECOMP_LEN ./linux-4.9.94
> ./linux-4.9.94/tools/perf/tests/code-reading.c: char
> decomp_name[KMOD_DECOMP_LEN];
> ./linux-4.9.94/tools/perf/util/dso.c: char newpath[KMOD_DECOMP_LEN];
> 
> So I guess for linux-4.9.94 has not define KMOD_DECOMP_LEN in
> tools/perf/util/dso.h?


4.9.9[456] lack:
#define KMOD_DECOMP_NAME  "/tmp/perf-kmod-XXXXXX"
#define KMOD_DECOMP_LEN   sizeof(KMOD_DECOMP_NAME)


However, the commit that added those macros does not apply cleanly to 4.9.96.

commit 42b3fa670825983fc8bd0ac7b80cc84ae3abb75b
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Jun 8 16:31:03 2017 +0900

    perf tools: Introduce dso__decompress_kmodule_{fd,path}


-- 
~Randy
