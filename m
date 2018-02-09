Return-Path: <kernel-hardening-return-11687-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225TH+n4Ise8ibUBxVMliNxr5lFvoY0SI5sZtBOd3JaSDIwHiOFTJu00SW15Nk4yUB/ptLDV
ARC-Seal: i=1; a=rsa-sha256; t=1518193123; cv=none;
        d=google.com; s=arc-20160816;
        b=XaTYy5NCLKT9m5lyps24/T0+F+4eOwZE7kIL2Z4ds4EuYLF1fHrBWyTOuEvl2dKY0Y
         tYfAL5xsZEqNxa5wHXSBrfmFlGQ3n7p9PJ5EP2EY/RG/22vhg+L+GtnXiOccUepcfomu
         Thi6yBFAHg564++a3AH054XLVJcKN9k7eEW5DNA3S6L85O+3zNv4AV4kSsoN9FKsmLIx
         UuxgwOS5gBB5z0bmePERjlgLxH9beu+KC+idDMMkwUWwqU166Tc7HtgrCsC5rzpk8PYJ
         txhId1NfB1JemYodrVKi6F/9Y068s0Lw+ulokrmmfnOJYYfQ0m4nS+S5elU6zzg0WA5r
         4n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=TKXnyB30qceErP2gGchX/3xDaWnZb9byP4y1VqDE3NI=;
        b=A4Cnz9rZx3OCbCHcTpj9WGEw2YdtczGqkL/u8JDNM8IWGGkLjwOsQbj0sNXbyeNOy3
         zeEmvO0h8zC5HmhMa6plSzaCka+yTPN2stMn+C1Qkr2APhM8oDBfk7LxaZ0IV/yOUseF
         feuUYqad8x7gjcgESW8gTmrBz9wTXexOq1DnIkrwvqNedTmCY6jkdnnqGAgKXhsAWKCH
         lch1dcaYg8V/z6Au7CWepIaBZngZI3j0kGBod4Gcvxw+PRlGs3q3efkQ1iZqdLGZqxfC
         ifEXsFRyBJ7CbLtefdHI/arELOp4rH0AlpUS2qzECfQGC0MVITBAzQ8XDaTI4f9N3rVm
         HfwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11687-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11687-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11687-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11687-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Randy Dunlap <rdunlap@infradead.org>, <jglisse@redhat.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-2-igor.stoppa@huawei.com>
 <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <947ea9c3-b045-17d3-51e5-df80b4fb27e6@huawei.com>
Date: Fri, 9 Feb 2018 18:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <60e66c5a-c1de-246f-4be8-b02cb0275da6@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489766378692364?=
X-GMAIL-MSGID: =?utf-8?q?1591940872637821758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/18 00:34, Randy Dunlap wrote:
> On 02/04/2018 08:47 AM, Igor Stoppa wrote:

[...]

> It would be good for a lot of this to be in a source file or the
> pmalloc.rst documentation file instead of living only in the git repository.

This is actually about genalloc. The genalloc documentation is high
level and mostly about the API, while this talks about the guts of the
library. The part modified by the patch. This text doesn't seem to
belong to the generic genalloc documentation.
I will move it to the .c file, but isn't it too much text in a source file?

[...]

>> + * @order: pow of 2 represented by each entry in the bitmap
> 
>               power

ok

[...]

>> + * chunk_size - dimension of a chunk of memory
> 
> can this be more explicit about which dimension?

I'll put "size in bytes of a chunk of memory"


[...]

>> + * cleart_bits_ll - according to the mask, clears the bits specified by
> 
>       clear_bits_ll

yes :-(

[...]

>> - * bitmap_clear_ll - clear the specified number of bits at the specified position
>> + * alter_bitmap_ll - set or clear the entries associated to an allocation
> 
>                                                             with an allocation

ok


>> + * @alteration: selection if the bits selected should be set or cleared
> 
>                    indicates if

ok


[...]

>> +	/* Prepare for writing the initial part of the allocation, from
>> +	 * starting entry, to the end of the UL bitmap element which
>> +	 * contains it. It might be larger than the actual allocation.
>> +	 */
> 
> Use kernel multi-line comment style.

ok, also for further occurrences

[...]

>> +	index =  BITS_DIV_LONGS(start_bit);
> 
> 	index = BITS_DIV_LONGS
> (only 1 space after '=')

oops, yes

--
thank you, igor
