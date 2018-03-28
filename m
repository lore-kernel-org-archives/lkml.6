Return-Path: <rob@landley.net>
ARC-Seal: i=1; a=rsa-sha256; t=1522212610; cv=none;
        d=google.com; s=arc-20160816;
        b=qZOXniBGNkLji99E+C09vn9q1mTsmbOrVyJMV1hnLezgxwCRu1cFdftjM1Uegoz0yU
         oKFGahh0QeVuYCauf4FQGVAjICN5kFMM924sE/ztWasWDXvvGg7Ke9Z7AuWCr25aSJrt
         Ekd5Zo4/dYA+QcVhhxUBqRVKmWSvg9wYwth9hxGaOrsuzzVCxc8XYeIOHdTHb1DQ+07R
         D97wAjtO/VD9Endih4j/TYD2ryNuylQ+RqKNQW/ujod1/KD2+JRpjBb08TpHG3eESlo8
         ERvEwIR/hFW/eAe3ILzXPWw+LADMc/82MJDlKVMYRZHV4oRqfhsi+MP4YfYnQPUDgxto
         CWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=enV9j3dbSLXmAE1CBSurMgsE0cKUXCQgdF0KSwOCHnE=;
        b=GnpDqMide6npkxsbgVumyEP3E7R56bEPYQ/9MXwBWbczdKygzdcoAr1j9/HybuyVkB
         qK/KWFcuwcfGB9NFcxWBgudVuwy0Pk7OqlZP8HSeuXJ8XJKj6yfWPOF+xLlq231dYL12
         mnCAedsJN+CjpVW0eAc/3Dai9iLIjVZR7bvZzFj4dRgRkRonLj0fpNF+LEj/rYGJTxgT
         YjqNr8T3UzJlzHtGK0gkpuNoE4B+a9DLaUCaqbI/5FxE8JS9/BFxxlzslfC6oM1jv6W1
         Vy8GogTozDSKA0Ta0BhyV16edm0/rXWBsR3QPIoJqAlc7FBCUsTjVr4Z2zAT7oPNEkKT
         ktIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=PvZKSr/5;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=PvZKSr/5;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
X-Google-Smtp-Source: AIpwx4/pc1kbDb3jsikbAw35hWxe/fTYfVZJKliV1NwBrBfYuQEbCWfXGgw+29+c9lIuZBaZlXRdtg==
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
To: Matthew Wilcox <willy@infradead.org>, Rich Felker <dalias@libc.org>
Cc: Ilya Smith <blackzert@gmail.com>, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
 linux@armlinux.org.uk, tony.luck@intel.com, fenghua.yu@intel.com,
 jhogan@kernel.org, ralf@linux-mips.org, jejb@parisc-linux.org,
 deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 ysato@users.sourceforge.jp, davem@davemloft.net, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, x86@kernel.org, nyc@holomorphy.com,
 viro@zeniv.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org,
 deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 akpm@linux-foundation.org, steve.capper@arm.com, punit.agrawal@arm.com,
 paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
 nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com,
 jglisse@redhat.com, aarcange@redhat.com, oleg@redhat.com,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <20180323180024.GB1436@brightrain.aerifal.cx>
 <20180323190618.GA23763@bombadil.infradead.org>
From: Rob Landley <rob@landley.net>
Message-ID: <7e41ef7a-0bac-02fe-21fd-a1ed86c22230@landley.net>
Date: Tue, 27 Mar 2018 23:50:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323190618.GA23763@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596155610245065329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:06 PM, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 02:00:24PM -0400, Rich Felker wrote:
>> On Fri, Mar 23, 2018 at 05:48:06AM -0700, Matthew Wilcox wrote:
>>> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>>>> Current implementation doesn't randomize address returned by mmap.
>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>> creation. After that mmap build very predictable layout of address
>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>> randomization of address on any mmap call.
>>>
>>> Why should this be done in the kernel rather than libc?  libc is perfectly
>>> capable of specifying random numbers in the first argument of mmap.
>>
>> Generally libc does not have a view of the current vm maps, and thus
>> in passing "random numbers", they would have to be uniform across the
>> whole vm space and thus non-uniform once the kernel rounds up to avoid
>> existing mappings.
> 
> I'm aware that you're the musl author, but glibc somehow manages to
> provide etext, edata and end, demonstrating that it does know where at
> least some of the memory map lies.

You can parse /proc/self/maps, but it's really expensive and disgusting.

Rob
