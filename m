Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELuFcOfvP3a3SoRqPcgz+WAKFQremgVGpLDK3hdZ6FDW7UB2H1SkHGwddP7/Fv18SpJLfGPA
ARC-Seal: i=1; a=rsa-sha256; t=1521235988; cv=none;
        d=google.com; s=arc-20160816;
        b=Ww5B26ug7xUjQ8+NbjW8bLgpxK8aOLEX8uXFbYkm86tUSIrfQJp1iWzriWfcZs2BAJ
         bQZ0NMvSQhb7ZV7x7qUWyi9BhAY5D4iIR6I05xK9ELe9Q7OgNx+TXFC1pzLdJY+6ozzN
         ZbmIBm8bmRUM6P36RvnPkT1kEikMoEMOWpBcgK4P/BwXGWI8Z4PLMdXypeCpPKfubllB
         tvDzKqpa7ErSM2vQvG0+GsopUreTaJkgalsKbuXFV0bNckIK3e88QJTAtGf1wkE7rcvg
         Q7JdnGJpR9cJq2scDM/9HTGyepqFsTngxX6aiVyW1wvvGblsa7tiVtPv91R6fcrsOGjE
         naMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zttqNWiGx/DKuu2KN5AGg54envISoQcz2v/vJPxwIYU=;
        b=0FkbPeyUVFcOcwJlc9YL/MeQy7Tzg8vB/HyL6F8R5NFBInFKXkRLHtVuSTHFDsIpAt
         4fNvuPIe3H96MBqH6PmTGfXCQdDb/2IwEK76tvqZ0YpxiXtBJyppOYrEtredUa3qK2Bz
         iWafOYO23L3VkdQF9i+fGQYsc3m6ifeR6R9WvWyKwv+7lJ0fFcscVCbnTT+Em8HL3M3y
         jMYex9XVhZ3RaWp4VxJaLqaYOkPeOSc4fEwhucOZzJPAIcYdMOGwh0LtLzvPvIkZrj8v
         PnKoB0KMs4bHd/ezC8DiDUQqkh+dC+qC+JPpoBrFjplbV/nBsOSNea4vZ60QedCrxmw8
         WRgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Fri, 16 Mar 2018 14:33:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, toddpoynor@google.com,
 wei.vince.wang@gmail.com, Dan Williams <dan.j.williams@intel.com>, Michal
 Hocko <mhocko@suse.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>,
 =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Sherry Cheung <SCheung@nvidia.com>, "Oliver O'Halloran"
 <oohall@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Huang Ying
 <ying.huang@intel.com>, Dennis Zhou <dennisz@fb.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add config for readahead window
Message-Id: <20180316143306.dd98055a170497e9535cc176@linux-foundation.org>
In-Reply-To: <20180316182512.118361-1-wvw@google.com>
References: <20180316182512.118361-1-wvw@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595119752476729321?=
X-GMAIL-MSGID: =?utf-8?q?1595131547564314182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 11:25:08 -0700 Wei Wang <wvw@google.com> wrote:

> Change VM_MAX_READAHEAD value from the default 128KB to a configurable
> value. This will allow the readahead window to grow to a maximum size
> bigger than 128KB during boot, which could benefit to sequential read
> throughput and thus boot performance.

You can presently run ioctl(BLKRASET) against the block device?
