Return-Path: <kernel-hardening-return-11706-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2242n4Wb+s4ZA+HfsNNEldD01MpBX/8l+vFQ8VgEcHxZrfx7n8fI+A9PGlVYgqtnG8RSG3Uf
ARC-Seal: i=1; a=rsa-sha256; t=1518380858; cv=none;
        d=google.com; s=arc-20160816;
        b=kNKXDjpxn5g9R1jT+idQZw3+fCKJWuPaXC1FpVHUTJcOFlM24Nf0NiMWL3QcNDClxk
         NTzYeTjJx4hjYCRJ5sm1WNiU/oPvGd1vDqVaA0pED65fORwJm3FovkA4HuqhAukTdUQe
         HOtwaQyz8vqVF+VZO260BGMh6SyS+yln8z0l9IAJzzJGns4D5tS8knHJkuIwfCMJeY2j
         4t2Ph9C3QCXA0/Mca/6nPkKdeBEF7PHjT1m/0wclQJClGVswK9ajuR1f8vIqLS6jiw28
         xwgWlcxCH9p7zVRS90mCxuEKwp/qroXnYITPc4GwRp7MOMCo5HnqcKpbpME5AFxudIzv
         lVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QRSm1Nc6TebnZVOSgVBzpvS8y9TFc9rygqDZ4NjtEg8=;
        b=QN8fzIufxucKvqZSALR5OBFwyuEtkjYAX6ZESd5Vb3NRA2ROuD3OqjaCwKCAGjE4jm
         8Ubp3Zkd8pKkqIlb6OOOA2xIffehBdfvfjdapWXk/KBAdVOhYRbR0IEgm5HNJtQpQKTl
         1N2eJMpXxUabpihE3z/x9AlsfuminobKZ5Wvkf/5Fc/n8aHyHrj927Olp2xfZK3H+fh7
         oySgfWAb+UR4NCyUCV8gRJQEEZgD/pQJQJS5pO7n6v7ozztuysOiDndaDaMQmDUqHMpA
         cZGARNa2CQRiM9A/Nhomns34STDgtt92651pyFcQYfSeVDNLczhcgP3SxkXG++D2dM1W
         6ghQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=jF06J4IS;
       spf=pass (google.com: domain of kernel-hardening-return-11706-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11706-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=jF06J4IS;
       spf=pass (google.com: domain of kernel-hardening-return-11706-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11706-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Philippe Ombredanne <pombredanne@nexb.com>,
 Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Kees Cook <keescook@chromium.org>, mhocko@kernel.org, labbott@redhat.com,
 jglisse@redhat.com, Christoph Hellwig <hch@infradead.org>, cl@linux.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-3-igor.stoppa@huawei.com>
 <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f95a064d-75e9-6ff3-2c11-4158a0ad1ca9@infradead.org>
Date: Sun, 11 Feb 2018 12:27:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1592137727224199640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/11/18 12:22, Philippe Ombredanne wrote:
> On Sun, Feb 11, 2018 at 4:19 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> Introduce a set of macros for writing concise test cases for genalloc.
>>
>> The test cases are meant to provide regression testing, when working on
>> new functionality for genalloc.
>>
>> Primarily they are meant to confirm that the various allocation strategy
>> will continue to work as expected.
>>
>> The execution of the self testing is controlled through a Kconfig option.
>>
>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> 
> <snip>
> 
>> --- /dev/null
>> +++ b/include/linux/genalloc-selftest.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0
> 
> nit... For a comment in .h this line should be instead its own comment
> as the first line:
>> +/* SPDX-License-Identifier: GPL-2.0 */

Why are we treating header files (.h) differently than .c files?
Either one can use the C++ "//" comment syntax.

> <snip>
> 
>> --- /dev/null
>> +++ b/lib/genalloc-selftest.c
>> @@ -0,0 +1,400 @@
>> +/* SPDX-License-Identifier: GPL-2.0
> 
> And for a comment in .c this line should use C++ style as the first line:
> 
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Please check the docs for this (I know this can feel surprising but
> this has been debated at great length on list)
> 
> Thank you!
> 


-- 
~Randy
