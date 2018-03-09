Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3323866-1520556324-2-8453299534993252350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-15', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520556323; b=KdgGfGvk3igM5q+jSV0EGBZKlwHczXj8ulcYj08dn5Uf9gv
    Xccfdp9f74ryXC8s4iFAqookPbvVhFV4Ek0pzEz0er/o9rxzJGXaZbm+XSMnNUKG
    zpjflNQ0YCh0cEfvArm5Z68IuwGVAJTG4qtY7txlGLo8zL17I0TQXX8TdOT2T2L3
    J8tvz0dOpBCJKCxUxAzBDwhcIYGPVcfzTz39Kt6jAmnYwHOaTx7wrGinIq4pqWk2
    IT0nHUfL79r5aWHg5vYw2AwF6UaN59qZLMFZzuLCBkYgPoKixvJZHSz0GfNwAM0X
    JvBwjdoCFmqewl7yxvEOYxL/4Ygl8gVfEPWFOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520556323; bh=j
    zzjWSZuEfPVaZ4mlRAb/P8a3d7iHYjpmauCc+lL/G4=; b=bcGifRAe0anrNvwMX
    a8q7RcIdeeua5YiXANfJCYBFZ2BWnVR0phZpYnbJzwxgwYA6D/SheYD8OPpOvIr+
    4mMgOU3UNlG5thgyfj3B3P87DDKboP7phzwAOHK+0qEEepX1nRowuPWQ6PDu63nE
    1sxX57t94kOFFiXoHhUCsZENoJP5srIPQ6ujSi8nFgd7opADoACao0+zNaX7+t8R
    IHwEOa1dcYBJUxMoaD+uzRTeW252aCKxbY5u1+6JXbHZ0/cAQoiiOLmTZWeCcmp/
    kk3Z1IS+ADrDHU6udLMRc6RhvqBb3U+ZZDRcrF5FGTF5FKyPxd7MmINy8g/TGiNh
    lp8Bg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=G0shxkgx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UnyDmZNT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=G0shxkgx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UnyDmZNT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2A036071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Thu, 8 Mar 2018 16:45:14 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC] android: ion: How to properly clean caches for uncached
 allocations
In-Reply-To: <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
Message-ID: <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
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
 =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018, Laura Abbott wrote:

> On 02/28/2018 09:18 PM, Liam Mark wrote:
> > The issue:
> > 
> > Currently in ION if you allocate uncached memory it is possible that there
> > are still dirty lines in the cache.  And often these dirty lines in the
> > cache are the zeros which were meant to clear out any sensitive kernel
> > data.
> > 
> > What this means is that if you allocate uncached memory from ION, and then
> > subsequently write to that buffer (using the uncached mapping you are
> > provided by ION) then the data you have written could be corrupted at some
> > point in the future if a dirty line is evicted from the cache.
> > 
> > Also this means there is a potential security issue.  If an un-privileged
> > userspace user allocated uncached memory (for example from the system heap)
> > and then if they were to read from that buffer (through the un-cached
> > mapping they are provided by ION), and if some of the zeros which were
> > written to that memory are still in the cache then this un-privileged
> > userspace user could read potentially sensitive kernel data.
> 
> For the use case you are describing we don't actually need the
> memory to be non-cached until it comes time to do the dma mapping.
> Here's a proposal to shoot holes in:
> 
> - Before any dma_buf attach happens, all mmap mappings are cached
> - At the time attach happens, we shoot down any existing userspace
> mappings, do the dma_map with appropriate flags to clean the pages
> and then allow remapping to userspace as uncached. Really this
> looks like a variation on the old Ion faulting code which I removed
> except it's for uncached buffers instead of cached buffers.
> 

Thanks Laura, I will take a look to see if I can think of any concerns.

Initial thoughts.
- What about any kernel mappings (kmap/vmap) the client has made?

- I guess it would be tempting to only do this behavior for memory that 
came from buddy (as opposed to the pool since it should be clean), but we 
would need to be careful that no pages sneak into the pool without being 
cleaned (example: client allocs then frees without ever call 
dma_buf_attach).

> Potential problems:
> - I'm not 100% about the behavior here if the attaching device
> is already dma_coherent. I also consider uncached mappings
> enough of a device specific optimization that you shouldn't
> do them unless you know it's needed.

I don't believe we want to allow uncached memory to be dma mapped by an 
io-coherent device and this is something I would like to eventually block.

Since there is always a kernel cached mapping for ION uncached memory then 
speculative access could still be putting lines in the cache, so when an 
io-coherent device tries to read this uncached memory its snoop into the 
cache could find one of these 'stale' clean cache lines and end up using 
stale data. 
Agree?

> - The locking/sequencing with userspace could be tricky
> since userspace may not like us ripping mappings out from
> underneath if it's trying to access.

Perhaps delay this work to the dma_map_attachment call since when the data 
is dma mapped the CPU shouldn't be accessing it? 

Or worst case perhaps fail all map attempts to uncached memory until the 
memory has been dma mapped (and cleaned) at least once?

Thanks,
Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
