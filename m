Return-Path: <kernel-hardening-return-12197-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtRKQJljcTShUo+8szxRFuG+qjVk5ji4/bIaPULSKL0yBQnvkEjHf2LN/CsCHYSY/YomcVf
ARC-Seal: i=1; a=rsa-sha256; t=1520434162; cv=none;
        d=google.com; s=arc-20160816;
        b=ElxFHAXl34i/7wIHGv6bsUDXTFIpNHYf3JRt1KrH8YnAMKc2hV0KtsXIKvFl4CFHEf
         WY81xJjrdt+4b2QGFVpPzNvD+1YIqVQ7lUXA+uNuZCVGxnhpx2ud7WE6c4kWycHay4Op
         NQq9oURFmM3nfleosGt28hr1SEogBMYa4Sb0CaXOsyeRw7doXYkUdq52kbz/J3xNkX6Y
         dtIiu17y4fFj+6m96dpyirDoy9XTLy7zaTIKuC+mQI0W0u2WMAeqza+Za+aI2DZa3HRk
         VYUIFm7mwT2WlbsZFaKaXySky6gHtAHz+Ldep9kEhDTKuVhf/sakn5BaFx/B0dxMBsW/
         VpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=JQWT5y5+gEG9qZ1/JyC5eK0t2RsSUOSYL6wpz+bL6kE=;
        b=qzWvN6474mpy89w0jfRE29V7p24WRVs4zEyKRX9OQMn7K15I0nZfrhKzybpk9z39VH
         f9dJQRFsy+m0zXb6MJkyFxwpidVnLiq0Tb40hFrhdsrFaq/aOlHTZ6ZzQaF0vebdHm6f
         L2VK4xOFLmQrZsmrWbK6vkEJbE7yXJrxe2oMyje6Bn+O4HCv3dPWkEtT6TBt/xlF0S8a
         d2vgkyQL7Da3CHSFjUNR9OpFugwLmPVKpaVdR8ViibUtxC75KsAMMAhoMlwqUQsKgtrE
         uyEJB7nBZB0eKECPY2zP3dRPy0/GpaO/Hh4Yy0qh4X3+LQfgxQZrJtESAMANqun22fgv
         qwtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12197-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12197-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12197-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12197-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
 <20180306131856.GD19349@rapoport-lnx>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <54e95716-9d61-51a3-9ae8-196e60625b76@huawei.com>
Date: Wed, 7 Mar 2018 16:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306131856.GD19349@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594290772790091016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 06/03/18 15:19, Mike Rapoport wrote:
> On Wed, Feb 28, 2018 at 10:06:14PM +0200, Igor Stoppa wrote:

[...]

> If I'm not mistaken, several kernel-doc descriptions are duplicated now.
> Can you please keep a single copy? ;-)

What's the preferred approach?
Document the functions that are API in the .h file and leave in the .c
those which are not API?

[...]

>> + * The alignment at which to perform the research for sequence of empty
> 
>                                            ^ search?

yes

>> + * get_boundary() - verifies address, then measure length.
> 
> There's some lack of consistency between the name and implementation and
> the description.
> It seems that it would be simpler to actually make it get_length() and
> return the length of the allocation or nentries if the latter is smaller.
> Then in gen_pool_free() there will be no need to recalculate nentries
> again.

There is an error in the documentation. I'll explain below.

> 
>>   * @map: pointer to a bitmap
>> - * @start: a bit position in @map
>> - * @nr: number of bits to set
>> + * @start_entry: the index of the first entry in the bitmap
>> + * @nentries: number of entries to alter
> 
> Maybe: "maximal number of entries to check"?

No, it's actually the total number of entries in the chunk.

[...]

>> +	return nentries - start_entry;
> 
> Shouldn't it be "nentries + start_entry"?

And in the light of the correct comment, also what I am doing should be
now more clear:

* start_entry is the index of the initial entry
* nentries is the number of entries in the chunk

If I iterate over the rest of the chunk:

(i = start_entry + 1; i < nentries; i++)

without finding either another HEAD or an empty slot, then it means I
was measuring the length of the last allocation in the chunk, which was
taking up all the space, to the end.

Simple example:

- chunk with 7 entries -> nentries is 7
- start_entry is 2, meaning that the last allocation starts from the 3rd
element, iow it occupies indexes from 2 to 6, for a total of 5 entries
- so the length is (nentries - start_entry) = (7 - 2) = 5


But yeah, the kerneldoc was wrong.

[...]

>> - * gen_pool_alloc_algo - allocate special memory from the pool
>> + * gen_pool_alloc_algo() - allocate special memory from the pool
> 
> + using specified algorithm

ok

> 
>>   * @pool: pool to allocate from
>>   * @size: number of bytes to allocate from the pool
>>   * @algo: algorithm passed from caller
>> @@ -285,14 +502,18 @@ EXPORT_SYMBOL(gen_pool_alloc);
>>   * Uses the pool allocation function (with first-fit algorithm by default).
> 
> "uses the provided @algo function to find room for the allocation"

ok

--
igor
