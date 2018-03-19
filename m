Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2355499-1521449651-2-9826713375924366168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521449650; b=RN/J00ji5FGzId56lmSwIwwvar4bmHbdQxJQs2npMIQAzeq
    n+FMKoA7C05BhU//pNAHtdJ2EXrzzrSK/GSEr9EVrf/4YnjXJNVcZMGzXwNAncjZ
    k60ojXtyaHBuIKsi1CdaY1u11HvlcQ7lwENvIAk90CtTCx55h9bvkHVIHpyJAyMn
    OyQH+VcXjE/XpRxhY47QXOu5DV5XRM3Ql3JidPOz+WJleCL1gbtOGclStgJ0z1+2
    iHgTEyE8Ml2OWOazJnuSkddacli/z2YqeJBLqFS6s0j37gBpntaN79JKGuGtzOwT
    OF1/ejbArAIaQ9pv/7fpCxNuZQQ4K9YhNe2l+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521449650; bh=g0C9UIAPQMKmJMil90YZA5xps0MYSEj9fVvMDmnm9Ac=; b=e
    ngyicY9meYruDvzUieA1siPAcfM8AhIQQpprOVEtVWHoXjGy73yb8RQVJ24DlEYG
    OVQGJkz05MIB71gfxZNuyjP6Q1KzVthRFW0A7ajmZ2CBvsMpXYzgnD7+qVhmb7hy
    o6eU4FtS58Z5sm+85eaDpY8+suAvPaj6IzipnOdQ/uIQ4YfCMga+sJK2LrgfjueZ
    dIo/6fOyrrWgYY2WioMrYlmV78XdJV0Tnka0wNYH4BccL842h8z1pUd6Qp/jMlBV
    c7S9pEpjkBUjyUCZNZvo76WyJYrS+n6jHKDR0jcO6GZwSgKcZtjqFAUqbnHOmzYi
    51bC0unjwzUZnvxWwCTFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMZ+Q+kt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjphejjfegudeftdfgtggvshesthejredttdefvdenucfhrhhomheplfhirgdqlfhuuceurghiuceosggrihhjihgrjhhuudelledtsehgmhgrihhlrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipddvgedtvdemfhdttddtmedumeduhedtudemvddttdemhegvfhgvmegrieeifhemgeeivdgrnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeiledvtdcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CVtPLZvQ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IMZ+Q+kt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduvdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjphejjfegudeftdfgtggvshesthejredttdefvdenucfhrhhomheplfhirgdqlfhuuceurghiuceosggrihhjihgrjhhuudelledtsehgmhgrihhlrdgtohhmqeenucffohhmrghinheplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeeipddvgedtvdemfhdttddtmedumeduhedtudemvddttdemhegvfhgvmegrieeifhemgeeivdgrnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeeipdhhvghlohepshhilhhvvghrrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeiledvtdcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CVtPLZvQ;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELspfjgM2Z69RdokHMLw6g1RoSc6D2xgCiqtv/cdYwryIx/Dm3Wra4Ez0Rhy8jar0nRx1UhWXA==
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <20180319083850.tglknmwwybdhahfl@mwanda>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <63a95bfd-0199-b935-b8d0-2b73d82e8d46@gmail.com>
Date: Mon, 19 Mar 2018 16:53:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180319083850.tglknmwwybdhahfl@mwanda>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: sthemmin@microsoft.com, linux-pci@vger.kernel.org, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 devel@linuxdriverproject.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/3/19 16:38, Dan Carpenter wrote:
> On Sun, Mar 18, 2018 at 10:53:02PM +0800, Jia-Ju Bai wrote:
>> hv_pci_onchannelcallback() is not called in atomic context.
>>
>> The call chain ending up at hv_pci_onchannelcallback() is:
>> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
>> hv_pci_probe() is only set as ".probe" in hv_driver
>> structure "hv_pci_drv".
>>
> Your static analysis tool is faulty and apparently so is Smatch.
>
> $ smdb function_ptrs hv_pci_onchannelcallback
>
> Says it can't find a caller.  When I look for function pointers I get:
>
> $ smdb function_ptr hv_pci_onchannelcallback
> hv_pci_onchannelcallback =  'hv_pci_onchannelcallback' , 'vmbus_open param 5' , '(struct vmbus_channel)->onchannel_callback' , '__read_once_size param 0'
>
> Anyway the call tree is:
>
> vmbus_chan_sched() <-- takes rcu_read_lock();
> -> vmbus_channel_isr()
>     -> channel->onchannel_callback() -> which is hv_pci_onchannelcallback(

Thanks for your reply :)
I admit my tool produces a false positive for this code...
Sorry for my incorrect patch.

Anyway, I find that function pointers are quite hard to analyze in the 
Linux kernel code, because their usages are often flexible.
Have you found a good way to handle function pointers? Or can you 
recommend some good tools to handle them?


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
