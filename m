Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELvrmnH3SVSBk2ondv2xFyUOJGG74EjAuC9h6rCT+/DsRHAflPURfEZjNKZk2NLJHwQEB0c2
ARC-Seal: i=1; a=rsa-sha256; t=1519925096; cv=none;
        d=google.com; s=arc-20160816;
        b=iiohMfT6BboPcT1Ih6nWh4zowvllu2oftIrcf4C4QMKN+oRhRbOQltvg2C5D3alhSX
         FMDFue7SgyqcvcdS78HQUhcLfcgJx/2yk2/4rII4W6fHAbzsuJoeKvkTpKcv3VQc18wB
         MDtOu6eSSG2DzfCvDpDBG/9R3GnnQ+Z8gNySqyl6Hj2eK5KVBl8r/8vVnFyvKNsuPwUu
         mn8lQF0DGKbY8YAByMC6iGH8Ub/G+QELPz/7F+UspeUK1+x/FiPYEw2W9FnUE4DDHM09
         oqwrBfAQjx1XwfaW/tv4eZe/rx5KNuaYX+CXPmat6r0TpXibjoKrdL6fCOvKROpsJdoy
         mHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=KDTByvykgIzLopDKSD3p/gLtM9eVq4FuxScUTESVnkc=;
        b=Y9d7W2mOlSkVK3b1s7x2UwPeUZnhh/s6b25DZlj1CxrIM+KZVM0YVsa74tv5C32/SV
         PLjoXOP9e9x5RxTZUoUMSTncqEjCFgWZQrWgbVZK6KqR23OEM1ljujw3+OIt5TXaft/O
         khvHV6pTy+d6jdTrjzPcgjQFO7XBFY0lpSN8yV9dDCljDizISuI6G9kt99kBrPIsSlYI
         ylGthslwNVfLRuIrsFN8C9KZu4pDBsudbQM2eJdkkO7SstjyHHytiEyw3veL5Dyglvf3
         1yyW1TH3x6jLdWyxgEgCfXhokr/JCms5g04N1EKijDzPoL7QdDGS3XsR0HhKpdejFC4r
         Wiuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rrO+rgA+;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rrO+rgA+;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH
 and CONFIG_XEN_PVH
To: Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, jgross@suse.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
 <5be04d96-aa10-a022-2597-f7f40138f8f8@oracle.com>
 <8cdb96db-0771-f062-e0ea-54b4171d6a98@redhat.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <e8bbb473-fb06-aa33-75e1-dbb80dc1c5a2@oracle.com>
Date: Thu, 1 Mar 2018 09:24:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8cdb96db-0771-f062-e0ea-54b4171d6a98@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593756978254213138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/1/2018 7:17 AM, Paolo Bonzini wrote:
> On 01/03/2018 16:02, Boris Ostrovsky wrote:
>> On 02/28/2018 01:27 PM, Maran Wilson wrote:
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index eb7f43f23521..fa7cd0305125 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -791,6 +791,14 @@ config KVM_GUEST
>>>   	  underlying device model, the host provides the guest with
>>>   	  timing infrastructure such as time of day, and system time
>>>   
>>> +config PVH
>>> +	bool "Support for running PVH guests"
>>> +	depends on KVM_GUEST || XEN
>>
>> Not sure about XEN part. PVH is selected by XEN_PVH for Xen.
>>
>> What about introducing KVM_GUEST_PVH that will select PVH and then drop
>> dependency here?
> That is, "config KVM_GUEST_PVH" "depends on KVM_GUEST" "select PVH".
> Sounds good to me.

OK, will do.

Thanks,
-Maran

> Paolo
>
>> -boris
>>
>>> +	def_bool n
>>> +	---help---
>>> +	  This option enables the PVH entry point for guest virtual machines
>>> +	  as specified in the x86/HVM direct boot ABI.
>>> +
>>>   
>>
>>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>>> index f605825a04ab..021c8591c3c0 100644
>>> --- a/arch/x86/xen/Kconfig
>>> +++ b/arch/x86/xen/Kconfig
>>> @@ -77,8 +77,9 @@ config XEN_DEBUG_FS
>>>   	  Enabling this option may incur a significant performance overhead.
>>>   
>>>   config XEN_PVH
>>> -	bool "Support for running as a PVH guest"
>>> +	bool "Support for running as a Xen PVH guest"
>>>   	depends on XEN && XEN_PVHVM && ACPI
>>>   	# Pre-built page tables are not ready to handle 5-level paging.
>>>   	depends on !X86_5LEVEL
>>> +	select PVH
>>>   	def_bool n
