Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-255570-1520464514-2-4392889339489113684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520464513; b=NbgVsaLc6DGveC39sxLtLo0v6tXPMiW9R5MoDoKneFozdyl
    +uCX5wF2F4gCJ0KuYyw7RrDmFDPlhN+8N+tdhJGWHar0LAboyB6JhlUYtOqOtUKg
    q9N0RIc0LZgsh7lj1Ipy53Ceu6Ui6YVqgOW5eQZKEJQVQRe9b3eLkj3vEL8oZyHo
    shYeCHfPThbaEoAuE65Z358+cwwbSC4CWKAAWCLBRs+FVFK+z1BV9pdJQCjars52
    uh2606ykFLGJ/G2rBHabJu7cIKXoUyIR+D1F+vhQKDBcyaYC+4Nyx2oMNdWRUZxx
    xujV5VY5YgE3m+OzLEEWwR6/MYmf2mFc/UH9ixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1520464513; bh=ykLPCzvtjYEDO76royWlEJ9NIvgIu5zQ4gMd96S825A=; b=O
    TfTEELsNKpynxUZc0/ZS/vlCmKNX5Yaiu99TFHi5brKQwrEz5NgAz/fU6o0+wHje
    OilNROLsWFGK6TJYBMxhSkN1UEPkt1MKSHAGiUuD6gHaabVYNBe9t8M3krixv6f9
    Mad46s/6gu3oL/hOQv8R8RZ8pCjvM0jrn18qna1RoHDOzSatTVNS6Nd9V+XAA6Wy
    9Z6tiIseeoRIOAlxIxacW5EBFJltKThPNjzcvSxcwKIv3bU2s0M5pOVHz6zCj3Fi
    nrHPIGHJQ0w0Y/saShOhUXiziKMfhzmtgULj1WQ7yESesuu0zqamtteSivjgsDk6
    p8ADQtqrJxbhxLnrfgSkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bco8FBCb;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bco8FBCb;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtD9KqcWKfX+qUnezg0cLCYO9zqwwK1rDXZwZE02pDGgZX0n8XLLFOT+IFO0gE7LJf7OUQxcQ==
Subject: Re: [RFC] android: ion: How to properly clean caches for uncached
 allocations
To: Liam Mark <lmark@codeaurora.org>, Sumit Semwal <sumit.semwal@linaro.org>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
Date: Wed, 7 Mar 2018 15:15:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
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
 Martijn Coenen <maco@android.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 09:18 PM, Liam Mark wrote:
> The issue:
> 
> Currently in ION if you allocate uncached memory it is possible that there
> are still dirty lines in the cache.  And often these dirty lines in the
> cache are the zeros which were meant to clear out any sensitive kernel
> data.
> 
> What this means is that if you allocate uncached memory from ION, and then
> subsequently write to that buffer (using the uncached mapping you are
> provided by ION) then the data you have written could be corrupted at some
> point in the future if a dirty line is evicted from the cache.
> 
> Also this means there is a potential security issue.  If an un-privileged
> userspace user allocated uncached memory (for example from the system heap)
> and then if they were to read from that buffer (through the un-cached
> mapping they are provided by ION), and if some of the zeros which were
> written to that memory are still in the cache then this un-privileged
> userspace user could read potentially sensitive kernel data.

For the use case you are describing we don't actually need the
memory to be non-cached until it comes time to do the dma mapping.
Here's a proposal to shoot holes in:

- Before any dma_buf attach happens, all mmap mappings are cached
- At the time attach happens, we shoot down any existing userspace
mappings, do the dma_map with appropriate flags to clean the pages
and then allow remapping to userspace as uncached. Really this
looks like a variation on the old Ion faulting code which I removed
except it's for uncached buffers instead of cached buffers.

Potential problems:
- I'm not 100% about the behavior here if the attaching device
is already dma_coherent. I also consider uncached mappings
enough of a device specific optimization that you shouldn't
do them unless you know it's needed.
- The locking/sequencing with userspace could be tricky
since userspace may not like us ripping mappings out from
underneath if it's trying to access.

Thoughts?

Thanks,
Laura
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
