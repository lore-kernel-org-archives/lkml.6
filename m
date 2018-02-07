Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2995463-1517981158-2-9630952786424511549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517981157; b=iTLXimyHFnMG42vorb9Wab8gWTn6zi2F9n1hIsNcLLE30Xj
    5oQ8tjKmBr1s8Jr18awJhPDayLwer8sic2wpx35yGjR5uSRr5x6MUz/oWV183n7v
    zphaA4PfHDVbztj23oEfcuSAIqtzG1LQPY5OAfCHlS0/fjFx7T1gGQvD2+2IssZT
    lv4abX2WWuT2UAhLN/BXHlwxymuPpc3L6h4z1fJip9T80v5oSPYYxeRQgQgxtSxB
    3Y3PeQck4RJwEbvZ+67+kXiGOozr1j5Z0c4G/hFO+d8aPwJNf8KNgVBHkvZfyu+1
    xM17mR8BlCXgQ3r81PRb+6FR1jkED1UmaVXVJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517981157; bh=w
    YJNSOPYfV0wa3WE+rZDyzx6WF6IlaJeXkUREBl+7DE=; b=hhXhc1KXXj1vTq+M3
    8QUpq0XTHhHNcxE8RouwhUa+0mCLvXl396c5Lal4wApSe2eXuWJ+dxOvH+4w7PO8
    nJJ8zbW/kkAkBL29q0D3c3ooZ3HYAebybDbHfc5AsBA/khehmo7QuA7K2cw3YsQG
    IxdQNAP9hYVkfWOrYo0d9UC68MVa43gFYEvBxcdC2Hgzw3OcdTun62+0HYZE/UIj
    q1xl/Ry/U9Ns4YIJP58ANPWlH9FzY77jsDDCTij7Pq5zCFnkNAXAqNladCcWmZvl
    I7BDzhip+Qta83tJuoUtUtKhZC77PDjm+UoC7HqcJ4ORSkdQdVY5NuackmjZkBid
    AWjRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000"; d="scan'208";a="17849599"
Subject: Re: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
To: Laura Abbott <labbott@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com>
 <20180131130047.GA22917@kroah.com>
 <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
 <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com>
From: Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <7d836085-cd8d-300b-56be-e8db4ff37afc@intel.com>
Date: Wed, 7 Feb 2018 07:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com>
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
Cc: devel@driverdev.osuosl.org, tkjos@android.com, rve@android.com,
 linux-kernel@vger.kernel.org, maco@android.com, sumit.semwal@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/07/2018 01:56 AM, Laura Abbott wrote:
> On 01/31/2018 10:10 PM, Alexey Skidanov wrote:
>>
>> On 01/31/2018 03:00 PM, Greg KH wrote:
>>> On Wed, Jan 31, 2018 at 02:03:42PM +0200, Alexey Skidanov wrote:
>>>> Any driver may access shared buffers, created by ion, using
>>>> dma_buf_vmap and
>>>> dma_buf_vunmap dma-buf API that maps/unmaps previosuly allocated
>>>> buffers into
>>>> the kernel virtual address space. The implementation of these API is
>>>> missing in
>>>> the current ion implementation.
>>>>
>>>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
>>>> ---
>>>
>>> No review from any other Intel developers? :(
>> Will add.
>>>
>>> Anyway, what in-tree driver needs access to these functions?
>> I'm not sure that there are the in-tree drivers using these functions
>> and ion as> buffer exporter because they are not implemented in ion :)
>> But there are some in-tre> drivers using these APIs (gpu drivers) with
>> other buffer exporters.
> 
> It's still not clear why you need to implement these APIs.
How the importing kernel module may access the content of the buffer? :)
With the current ion implementation it's only possible by dma_buf_kmap,
mapping one page at a time. For pretty large buffers, it might have some
performance impact.
(Probably, the page by page mapping is the only way to access large
buffers on 32 bit systems, where the vmalloc range is very small. By the
way, the current ion dma_map_kmap doesn't really map only 1 page at a
time - it uses the result of vmap() that might fail on 32 bit systems.)

> Are you planning to use Ion with GPU drivers? I'm especially
> interested in this if you have a non-Android use case.
Yes, my use case is the non-Android one. But not with GPU drivers.
> 
> Thanks,
> Laura

Thanks,
Alexey
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
