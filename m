Return-Path: <kernel-hardening-return-11686-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226RCkK7vPgapD6r0l1SXb/IM9MOI5noZIOGNV9xcANgfDEdslOf/NqiosXdBMw7lAmQTYeQ
ARC-Seal: i=1; a=rsa-sha256; t=1518186659; cv=none;
        d=google.com; s=arc-20160816;
        b=SPZap7Abu/BIAsEG6syVeToBZqgUdJ4kMsU2090xXcwgLuPb9Q9BMkPerZep9uiglo
         Frsj++J/WotgeXA6F2I5sUhrm2y1ibxG9ZuIKF/qhmosU5DfphvsUCSWK8lWmMMVD5XK
         FeTuBL4ZMvXEI58a9Nwjm0JD6VIdHHBzQWihCiNsGmiImAV7mjDCcxrSTGXZTgnchk9S
         7UNGF75oZBsX0WL2dhQJLxleEmRT9Ji0n0d/5wxLTWeZ7HHqFSTxZHZqbzQvPm2ZMONf
         LcbylzcPkdHzZwAKx0jf8yJlMuBob6Q6EQVAREuDA6CiL2thqE8CPF6eiCjk6IuTuPpS
         cs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=ELyCQCDoOrhm8VIvNRPOGBbnIv77Q3HJxwhaSwhohzk=;
        b=gCSRb9tApGFgHnszwFoaQRA1isSkWupzKdh/9jBgYQg6wQHLaPzIK9UL5YvVtiLRHZ
         BOsXbvbp8Rgpjn1G1EzO8NuxT7zTKWy5ByWSwi+p8VrfJjVedqnVC3NUEc9tUDA74VyQ
         7eDn7Wpqnfy0muzJSCviUocF+25B8D5QO+Ti5l48VTdKO/KSQovq9oa6S8vXFYHSnUf5
         qtsQuHjcWYYx/6r+Ffp/kTK+a887griOvu3pJVqgRdZziFlNEtZ7E7o50CNCJ4vFBPl5
         Bpz3rnrrZ+ozrSeL18d6v4/Q6qND5Pi/eZVz1HScDVghxdcYMflzbFg7rUX8LG5FK+6V
         euiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11686-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11686-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11686-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11686-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-3-igor.stoppa@huawei.com>
 <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
 <20180204230346.GA12502@bombadil.infradead.org>
 <02f42250-949b-83af-f030-159fc46f6f81@infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <fe437c92-98a7-aba9-33eb-f6aaa5526ef9@huawei.com>
Date: Fri, 9 Feb 2018 16:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <02f42250-949b-83af-f030-159fc46f6f81@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1591934094266322691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/18 02:14, Randy Dunlap wrote:
> On 02/04/2018 03:03 PM, Matthew Wilcox wrote:
>> On Sun, Feb 04, 2018 at 02:19:22PM -0800, Randy Dunlap wrote:
>>>> +#ifndef __GENALLOC_SELFTEST_H__
>>>> +#define __GENALLOC_SELFTEST_H__
>>>
>>> Please use _LINUX_GENALLOC_SELFTEST_H_
>>
>> willy@bobo:~/kernel/linux$ git grep define.*_H__$ include/linux/*.h |wc -l
>> 98
>> willy@bobo:~/kernel/linux$ git grep define.*_H_$ include/linux/*.h |wc -l
>> 110
>> willy@bobo:~/kernel/linux$ git grep define.*_H$ include/linux/*.h |wc -l
>> 885
>>
>> No trailing underscore is 8x as common as one trailing underscore.
> 
> OK, ack.

ok, I'll move to _LINUX_xxx_yyy_H format

--
thanks, igor
