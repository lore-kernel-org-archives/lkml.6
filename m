Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521422603; cv=none;
        d=google.com; s=arc-20160816;
        b=nArMrzocyTdWJ3P5l7KWGVDaMhErqkLSEQX5PvJ5ZKe2IwdwGBoWFoiwLoP1u2FMI5
         dEG2iq6B2o9qqHhgnTk5R084+7bJAXCIM14bk2MZFSfc3Xjxq25zWFbuJYSeYjxgRdCN
         qVdjPUO+e8zX1jI2K7D5kd07MBz3bAVcaxS4AqI9iRc0d5V6wug0pq0H2NnUoxogFIbA
         30l6o9M3M87Nmm8YcABWtG+WkqSTDWSDKhLKQtT0bGURV3V25IAY4Bweenfb6SVOajZ+
         qwT9Qud1BVTjbiBT5A9ZsNjgMcGJ96TKkIan8PkSN4hgVq9mCi/iV6UslHAk5A01EOfb
         mElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6F70WU6Cw3C2Ul/DmeWzBhBisSyBFQznWSTSQFdvKpc=;
        b=cc7bhKCiGk9VKrHzIRc41BjejkvkUu6JCc9hj3AN/yp2MFX4ES51AsplNJYLmJa3sT
         HvcQgvns4jfcKcIg1xSxkAP1Q3iMumUXDyOUAwoqDKax/oQ7LP8XNLPmR0jEElGMq5pb
         x4Mux4FOZe3A6UsU5vntMkfmNqJe1fizOF9SB8LgwyOtov9m1kqCKe9UTIJq17zeHgth
         G+NQGnfjPrlwQiQbC4ogtcXNotV0DXhKiILG43s42ikdK0uiCjE9iRxRxqVUeGu7zG4S
         l1x+nYB+kQicGya+C3p9jcywwi8QxRtVyj9/C5AJOt94n7AxD3vwxLqs6SfeOCkwkeXj
         RNbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SybLk61h;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SybLk61h;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuuESHa1ztGI4qPHIpa8hH0SelonqfNrw/Tq4tykr7IbsrzNcD5u3fXJc2MjOaM5koPXhnuYw==
Subject: Re: [PATCH v2 0/7] KASan for arm
To: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
 "alexander.levin@verizon.com" <alexander.levin@verizon.com>
Cc: "glider@google.com" <glider@google.com>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>,
 "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
 "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
 "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "thgarnie@google.com" <thgarnie@google.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "geert@linux-m68k.org"
 <geert@linux-m68k.org>, "tixy@linaro.org" <tixy@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "zhichao.huang@linaro.org" <zhichao.huang@linaro.org>,
 "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
 "labbott@redhat.com" <labbott@redhat.com>,
 "philip@cog.systems" <philip@cog.systems>,
 "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "opendmb@gmail.com" <opendmb@gmail.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <B8AC3E80E903784988AB3003E3E97330C0076FBE@dggemm510-mbs.china.huawei.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b9a813b8-30fe-ef17-ff79-372c2134723f@gmail.com>
Date: Sun, 18 Mar 2018 18:23:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0076FBE@dggemm510-mbs.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595327228257192836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/18/2018 06:20 PM, Liuwenliang (Abbott Liu) wrote:
> On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>> Thanks for posting these patches! Just FWIW, you cannot quite add
>> someone's Tested-by for a patch series that was just resubmitted given
>> the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>> and it looks like test_kasan.ko is passing, great job!
> 
> I'm sorry.
> Thanks for your testing very much!
> I forget to add Tested-by in cover letter patch file. But I have alreadly added
> Tested-by in some of following patch. 
> In the next version I am going to add Tested-by in all patches.

This is not exactly what I meant. When you submit a v2 of your patches,
you must wait for people to give you their test results. The Tested-by
applied to v1, and so much has changed it is no longer valid for v2
unless someone tells you they tested v2. Hope this is clearer.
-- 
Florian
