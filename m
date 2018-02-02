Return-Path: <kernel-hardening-return-11556-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227ynVP+HmvqSd595MAU8QG2c4CVBTPYaYD48WrlAppwmLoGfBbFwgqb0eAL/S+V3rXKDdFW
ARC-Seal: i=1; a=rsa-sha256; t=1517587014; cv=none;
        d=google.com; s=arc-20160816;
        b=rIkkwAXD+zLHnOWQWn/IH5FieNNTs3rasrEv9fdu/YEENwDRFq5JErU3iwBTc0e4lj
         9YDdkYVH925CNavhlVV+m4cU/A3qkeXMr17fmFnW6/SSygp0MXJClboLzPQVc/W43Tx6
         Ax4+QPZFsaLSJyKOySqklaEAZVARlQy9Z0e/RKO23pAp3SSdixuZRwwQvfcd2ioYoivO
         IpBL9S8dcbOQN1MqPXfVLKWESEIZED6STN/ImRlY9kCyUvp409RhGzaZuEBxz1Wat45/
         BNLRIkDSznl7gBOoDukF0JDI6HUMFPdjdBsLdElp9PGGnexy6bhVwTEOmk189ZoqEgxX
         sKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=1g7Nbsuwc/kOI+75/otZNS3Ko6Szeh+z6hva4mH7z3U=;
        b=0d+TgRMQLWlMJaf1GUXaFUd6PluW6wA2T0Egucpze2Ad6tPmFqNb8tn0t2GFV3vi6a
         boF+57q2kaMh7ypJp3p/ucHcFlWUTJua/E1Su332YIKI51NzM/CzS1h1UrydwnvnCOAt
         m63PphT6JIGy6LXL1wcjNSM2DlR4XrarMnojAjUjFV/5UvQ1rLH1qzxUlWfTc9C77LNQ
         d4GFfJbxHCr0oh/nm1t8Nb8BJy2PGPuap2eYo01pOdGoxCBnCaBVJDcz+WRNuxD+yW9e
         FZyvHbEHqOi61fXO1VxgucXjh8nItCd6M2DX3Vm76BTmdvniFsqWiCCVwbvKSirRSviM
         XryQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11556-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11556-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11556-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11556-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/6] Documentation for Pmalloc
To: Jonathan Corbet <corbet@lwn.net>
CC: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>,
	<cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-6-igor.stoppa@huawei.com>
 <20180130100852.2213b94d@lwn.net>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
Date: Fri, 2 Feb 2018 17:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180130100852.2213b94d@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031095823992296?=
X-GMAIL-MSGID: =?utf-8?q?1591305321433364004?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for the review and apologies for the delay.
Replies inlined below.

On 30/01/18 19:08, Jonathan Corbet wrote:
> On Tue, 30 Jan 2018 17:14:45 +0200
> Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

> Please don't put plain-text files into core-api - that's a directory full

ok

>> diff --git a/Documentation/core-api/pmalloc.txt b/Documentation/core-api/pmalloc.txt
>> new file mode 100644
>> index 0000000..934d356
>> --- /dev/null
>> +++ b/Documentation/core-api/pmalloc.txt
>> @@ -0,0 +1,104 @@
> 
> We might as well put the SPDX tag here, it's a new file.

ok, this is all new stuff to me ... I suppose I should do it also for
all the other new files I create

But what is the license for the documentation? It's not code, so GPL
seems wrong. Creative commons?

I just noticed a patch for checkpatch.pl about SPDX and asked the same
question there.

https://lkml.org/lkml/2018/2/2/365

>> +============================
>> +Protectable memory allocator
>> +============================
>> +
>> +Introduction
>> +------------

[...]

> This is all good information, but I'd suggest it belongs more in the 0/n
> patch posting than here.  The introduction of *this* document should say
> what it actually covers.

ok

> 
>> +
>> +Design
>> +------

[...]

>> +To keep it to a minimum, locking is left to the user of the API, in
>> +those cases where it's not strictly needed.
> 
> This seems like a relevant and important aspect of the API that shouldn't
> be buried in the middle of a section talking about random things.

I'll move it to the Use section.

[...]

>> +Use
>> +---
>> +
>> +The typical sequence, when using pmalloc, is:
>> +
>> +1. create a pool
>> +2. [optional] pre-allocate some memory in the pool
>> +3. issue one or more allocation requests to the pool
>> +4. initialize the memory obtained
>> +   - iterate over points 3 & 4 as needed -
>> +5. write protect the pool
>> +6. use in read-only mode the handlers obtained through the allocations
>> +7. [optional] destroy the pool
> 
> So one gets this far, but has no actual idea of how to do these things.
> Which leads me to wonder: what is this document for?  Who are you expecting
> to read it?

I will add a reference to the selftest file.
In practice it can also work as example.

> You could improve things a lot by (once again) going to RST and using
> directives to bring in the kerneldoc comments from the source (which, I
> note, do exist).  But I'd suggest rethinking this document and its
> audience.  Most of the people reading it are likely wanting to learn how to
> *use* this API; I think it would be best to not leave them frustrated.

ok, the example route should be more explicative.

--
thanks again for the review, igor
