Return-Path: <kernel-hardening-return-11586-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2240gKdZh3u+xaeuGftw9gz4s8zS0RjNJNVtzWjdB9kJTrOAyyGgYfvbHd5EGI+RTaWaaYdL
ARC-Seal: i=1; a=rsa-sha256; t=1517789673; cv=none;
        d=google.com; s=arc-20160816;
        b=YJmPr1zsIX2Exz3ikQdzSCqIDHr3xBKBNs03Oxu7vdBWtL85B76eFBwLOCqvBGQ9UQ
         d8VblQLQ+cKC4i96gLrUYSm/VBNEsIXCi3i1UQOz+Ucu/19fVt5Y/7I5J605T6GmHK98
         JX2rcuFl6u2O6lmzAJLmA/Op1WZ26dZlsPIxmC/FlIOIZda1yEcWywifvJ7TyCFN9E41
         tmwbZ26Ur4DzQ/pTI63MyGS5rPByN14fdXGlr6VTEmW9KWAb3yVFuSkRryyuOBE8/O4f
         N6w1RaQU5QMAD1AXhllt00wKsxHN6PmEMBcEZVlI8WZV/WnYk7z5lyg1ypW45ikw2TvM
         7xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Fiz9wYWvlyntN5Z0Xu6PoQDPMSRwBhsuz3+kYy+1du8=;
        b=N56nzV3XASSsXTCvQqL9OTLAmNFsFiJneE3UIRsq6AbOLEA00zd5gg+xPFoKBZS5NU
         eCyIW3oXQ5Rc9bC1/BTh6Zz4X4GWZbt52XpQLp8cFqfzPKEOet5NeHqarCElaqpHhrlt
         WVUCNMg9ooehtdLYb1h9qwv7PiDkvAc1oG7D6vv/MkAVybjohWMslGMc92E7WDBGQwF3
         nIT9cWuFEX2gfzkGVjNRNJ+5Zbc7bsq7A3UOEjxVG/sVtMeFwUKOA83nWd4bCwVXYHA+
         KUgrrh5JZiApIQDTK8KCEq4rEdoftv5cRkV9VFY9Y/F8pnEj1O9mRBb4Pbvzucs1HJ/P
         4V4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=O8t+Llfj;
       spf=pass (google.com: domain of kernel-hardening-return-11586-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11586-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=O8t+Llfj;
       spf=pass (google.com: domain of kernel-hardening-return-11586-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11586-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Matthew Wilcox <willy@infradead.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, jglisse@redhat.com,
 keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
 hch@infradead.org, cl@linux.com, linux-security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-3-igor.stoppa@huawei.com>
 <e05598c1-3c7c-15c6-7278-ed52ceff0acf@infradead.org>
 <20180204230346.GA12502@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02f42250-949b-83af-f030-159fc46f6f81@infradead.org>
Date: Sun, 4 Feb 2018 16:14:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180204230346.GA12502@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1591517824441996480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/04/2018 03:03 PM, Matthew Wilcox wrote:
> On Sun, Feb 04, 2018 at 02:19:22PM -0800, Randy Dunlap wrote:
>>> +#ifndef __GENALLOC_SELFTEST_H__
>>> +#define __GENALLOC_SELFTEST_H__
>>
>> Please use _LINUX_GENALLOC_SELFTEST_H_
> 
> willy@bobo:~/kernel/linux$ git grep define.*_H__$ include/linux/*.h |wc -l
> 98
> willy@bobo:~/kernel/linux$ git grep define.*_H_$ include/linux/*.h |wc -l
> 110
> willy@bobo:~/kernel/linux$ git grep define.*_H$ include/linux/*.h |wc -l
> 885
> 
> No trailing underscore is 8x as common as one trailing underscore.

OK, ack.

thanks,
-- 
~Randy
