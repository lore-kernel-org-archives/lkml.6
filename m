Return-Path: <kernel-hardening-return-13115-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqNaRS4YzxWgV5Yx9DNAXljfbVFYDdKYe00Kria3DlNcWhrRVhg4vi8mTtjLBi8Lj1Z0bDF
ARC-Seal: i=1; a=rsa-sha256; t=1524582254; cv=none;
        d=google.com; s=arc-20160816;
        b=q7xHqFTaMyr5npDdYXtxOdFESG+Mr6EnVdh/vf/fEpgJJJbjowfrPyimSF2w5vx2Cy
         nAGsaOCrOmRB82NBcDp1kZoQY68ySb1o/AtfDXtZqZtRIfl5CacSGDiSfSdUOP0frqVg
         a33SyrZmkXK1e6sD1Qitinc50NFXcrSVdYWMqN1yBrRwS4KPSX6x0TlO5o36M1qyn16p
         kLDu5xQGQNtTsDmrL2C2G4F0y/04S3hvUn3jjACyEUwZAWUmb+719/JkM0qJtIV7dnu+
         d6PFhaLSBe4OOImDVCvfkIbtZlFCUULFKDMS52IAzGeghklSL3cjjHXxUUkzxzTAvfoX
         1leQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Rrr1wZYOcV/oSVGRw5kJ9SBE6NWwZikLyYHyczv+g+I=;
        b=nTHOf/SLome9EWCbdK17Hv+3U88c6K3MGyfJxnN7+NzekZdmpPN0ZfKGWAa7fyZGmW
         aH45KQoCEEHa4HanArX87eBMpCLN3mdmpc3jnjq5poxLlQhPaKp9gzWJDcLWHvzRL7Ns
         St6uK1WUVTdX8EPG7DDR9cl4OVu1ufeGmuwe4assK2UAcwGts86hofuDNzkop1g+iJEg
         1aFtoDB0pzhAPYbb5BODXmH4IZcWdWybc6cMNyyoXeYWOYmoYI+8zjA1xbWzHAX/aVDK
         B5bV//DbfdELkh8U6WThlqwPQYaQKBpp8lhPc67l6klDqWG0JcRpUcgip7jSbJo9dXon
         5fcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AONbjbkL;
       spf=pass (google.com: domain of kernel-hardening-return-13115-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13115-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AONbjbkL;
       spf=pass (google.com: domain of kernel-hardening-return-13115-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13115-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
To: Matthew Wilcox <willy@infradead.org>
Cc: Igor Stoppa <igor.stoppa@gmail.com>, keescook@chromium.org,
 paul@paul-moore.com, sds@tycho.nsa.gov, mhocko@kernel.org, corbet@lwn.net,
 labbott@redhat.com, linux-cc=david@fromorbit.com,
 --cc=rppt@linux.vnet.ibm.com, --security-module@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Igor Stoppa <igor.stoppa@huawei.com>,
 Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
 Remi Denis Courmont <remi.denis.courmont@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
 <20180424115050.GD26636@bombadil.infradead.org>
 <eb23fbd9-1b9e-8633-b0eb-241b8ad24d95@gmail.com>
 <20180424144404.GF26636@bombadil.infradead.org>
From: lazytyped <lazytyped@gmail.com>
Message-ID: <b1efb813-3629-518c-4eeb-7d15eb5e7319@gmail.com>
Date: Tue, 24 Apr 2018 17:03:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424144404.GF26636@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598640362287726984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/24/18 4:44 PM, Matthew Wilcox wrote:
> On Tue, Apr 24, 2018 at 02:32:36PM +0200, lazytyped wrote:
>> On 4/24/18 1:50 PM, Matthew Wilcox wrote:
>>> struct modifiable_data {
>>> 	struct immutable_data *d;
>>> 	...
>>> };
>>>
>>> Then allocate a new pool, change d and destroy the old pool.
>> With the above, you have just shifted the target of the arbitrary write
>> from the immutable data itself to the pointer to the immutable data, so
>> got no security benefit.
> There's always a pointer to the immutable data.  How do you currently
> get to the selinux context?  file->f_security.  You can't make 'file'
> immutable, so file->f_security is the target of the arbitrary write.
> All you can do is make life harder, and reduce the size of the target.

So why adding an extra pointer/indirection helps here? It adds attacking
surface.
>
>> The goal of the patch is to reduce the window when stuff is writeable,
>> so that an arbitrary write is likely to hit the time when data is read-only.
> Yes, reducing the size of the target in time as well as bytes.  This patch
> gives attackers a great roadmap (maybe even gadget) to unprotecting
> a pool.

I don't think this is relevant to the threat model this patch addresses.
If the attacker can already execute code, it doesn't matter whether this
specific piece of code exists or not. In general, if an attacker got to
the point of using gadgets, you've lost.

On the contrary, it opens the road to design trusted paths that can
write to or access data that would generally be read-only or not
accessible (with, of course, all the complexity, limitations and
penalties of doing this purely in software on a page sized basis).


            -   Enrico
