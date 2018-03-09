Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3447277-1520560881-2-989955360547766141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520560881; b=LrozfhFMA9EjsHhqtDZwwjY/m2yZJ8ZE6mHG34JordXEsHv
    RGgCL92c1G2rB8HRRQe7TogO5U5lRNTNSjjKN4QeKIxJhOeZH9kvGKky2STA6gKR
    LMOz1WvetOijkXdSzqvFwb3tBeH8UcNSpnIu4G07jdS3geJcpvC1BKVD0HlPw7z3
    cZvyxD7sEwncB+uqwrlymhRDp+wQksQ8lpHSYHxsUP16JleU7NCYvGEdG/yGLSwV
    AegcDlxU8chVC7ilmTUZ1z+agrnZL2VNqJ1yiMUixTuOjN0wH1onsk+gk/Ceb52C
    3EjB3sgytACg6yXQJwzkVciW1IziQlovOSeTrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520560881; bh=I/LIfm0b+Q5kCvxilLBd/y1JSQrMTotty6tDIuebt5M=; b=Z
    u5k8IijY4qI+xEeKxGn39m2yLHwT/m+ifl2cndcQyvuMktMN+hCLWIKWYb6NkA2U
    mznfkOEkGkqD6G4rKk6NRdMLFVpNnt3cNWp+E7MQXCFJmTcOgjwSJRMORya3wloH
    hr/ig71/fGFbK/dCQ/uDZVbOXV4nywMUhe+mO/1XhpHeThTsJ0m6NDftnTmea+S6
    sFBeRwJUKZuJU2f3xUx9Stu6D6euboTnCgcjiSg9r0BW6YmgJzeUNaaMSnGxSohA
    uq+5WsdQiSbxv7PQwNVwxDfjDcd0mj5MMmasVfJIeYLLeqTX0UjZks+4TqBWCWY9
    kP7TishPr98ci/TJr6h9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gziJQ66F;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gziJQ66F;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtio046KCfkcWtHM1ZV1+x/dmi4mm+p1L0oIu3I54lXjR8E3rFk1U4A4kbklVh8S6zchL/MZA==
Subject: Re: [RFC] android: ion: How to properly clean caches for uncached
 allocations
To: Liam Mark <lmark@codeaurora.org>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7812c0ba-8ef3-2291-eef7-cdbf921f400d@redhat.com>
Date: Thu, 8 Mar 2018 18:01:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 04:45 PM, Liam Mark wrote:
> On Wed, 7 Mar 2018, Laura Abbott wrote:
> 
>> On 02/28/2018 09:18 PM, Liam Mark wrote:
>>> The issue:
>>>
>>> Currently in ION if you allocate uncached memory it is possible that there
>>> are still dirty lines in the cache.  And often these dirty lines in the
>>> cache are the zeros which were meant to clear out any sensitive kernel
>>> data.
>>>
>>> What this means is that if you allocate uncached memory from ION, and then
>>> subsequently write to that buffer (using the uncached mapping you are
>>> provided by ION) then the data you have written could be corrupted at some
>>> point in the future if a dirty line is evicted from the cache.
>>>
>>> Also this means there is a potential security issue.  If an un-privileged
>>> userspace user allocated uncached memory (for example from the system heap)
>>> and then if they were to read from that buffer (through the un-cached
>>> mapping they are provided by ION), and if some of the zeros which were
>>> written to that memory are still in the cache then this un-privileged
>>> userspace user could read potentially sensitive kernel data.
>>
>> For the use case you are describing we don't actually need the
>> memory to be non-cached until it comes time to do the dma mapping.
>> Here's a proposal to shoot holes in:
>>
>> - Before any dma_buf attach happens, all mmap mappings are cached
>> - At the time attach happens, we shoot down any existing userspace
>> mappings, do the dma_map with appropriate flags to clean the pages
>> and then allow remapping to userspace as uncached. Really this
>> looks like a variation on the old Ion faulting code which I removed
>> except it's for uncached buffers instead of cached buffers.
>>
> 
> Thanks Laura, I will take a look to see if I can think of any concerns.
> 
> Initial thoughts.
> - What about any kernel mappings (kmap/vmap) the client has made?
> 

We could either synchronize with dma_buf_{begin,end}_cpu_access
or just disallow the mapping to happen if there's an outstanding
kmap or vmap. Is this an actual problem or only theoretical?

> - I guess it would be tempting to only do this behavior for memory that
> came from buddy (as opposed to the pool since it should be clean), but we
> would need to be careful that no pages sneak into the pool without being
> cleaned (example: client allocs then frees without ever call
> dma_buf_attach).
> 

You're welcome to try that optimization but I think we should
focus on the basics first. Honestly it might make sense just to
have a single pool at this point since the cost of syncing
is not happening on the allocation path.

>> Potential problems:
>> - I'm not 100% about the behavior here if the attaching device
>> is already dma_coherent. I also consider uncached mappings
>> enough of a device specific optimization that you shouldn't
>> do them unless you know it's needed.
> 
> I don't believe we want to allow uncached memory to be dma mapped by an
> io-coherent device and this is something I would like to eventually block.
> 
> Since there is always a kernel cached mapping for ION uncached memory then
> speculative access could still be putting lines in the cache, so when an
> io-coherent device tries to read this uncached memory its snoop into the
> cache could find one of these 'stale' clean cache lines and end up using
> stale data.
> Agree?
> 

Sounds right.

>> - The locking/sequencing with userspace could be tricky
>> since userspace may not like us ripping mappings out from
>> underneath if it's trying to access.
> 
> Perhaps delay this work to the dma_map_attachment call since when the data
> is dma mapped the CPU shouldn't be accessing it?
> 
> Or worst case perhaps fail all map attempts to uncached memory until the
> memory has been dma mapped (and cleaned) at least once?
> 

My concern was mostly concurrent userspace access on a buffer
that's being dma_mapped but that sounds racy to begin with.

I suggested disallowing mmap until dma_mapping before and I thought
that was not possible?

Thanks,
Laura

> Thanks,
> Liam
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
