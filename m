Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81659C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5EA20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfARRXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:23:15 -0500
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:51266 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727448AbfARRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:23:15 -0500
Received: from atl4mhob12.registeredsite.com (atl4mhob12.registeredsite.com [209.17.115.50])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x0IHK0Lj025942
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:20:00 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail02pod2.registeredsite.com [10.30.77.36])
        by atl4mhob12.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IHJw22006067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:19:58 -0500
Received: (qmail 1895 invoked by uid 0); 18 Jan 2019 17:19:58 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?) (dclarke@blastwave.org@174.118.245.214)
  by 0 with ESMTPA; 18 Jan 2019 17:19:58 -0000
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
 <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
From:   Dennis Clarke <dclarke@blastwave.org>
Message-ID: <37173869-7516-55c5-8e4a-0c7bef011a62@blastwave.org>
Date:   Fri, 18 Jan 2019 12:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 12:14 PM, Arnd Bergmann wrote:
> On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>>
>> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
>>> This is a minor update of the patches I posted last week, I
>>> would like to add this into linux-next now, but would still do
>>> changes if there are concerns about the contents. The first
>>> version did not see a lot of replies, which could mean that
>>> either everyone is happy with it, or that it was largely ignored.
>>>
>>> See also the article at https://lwn.net/Articles/776435/.
>>
>> I would be happy to read "Approaching the kernel year-2038 end game"
>> however it is behind a pay wall.  Perhaps it may be best to just
>> host interesting articles about open source idea elsewhere.
> 
> It's a short summary of the current state.

Oh, I pay. Also to FSF and other places however I was merely ranting
very very quietly that so much open source is becoming commercialized
in so many ways.  Sort of expected really.

Pardon my little rant .. I will go back to hacking OpenSSL 1.1.1a and
trying to get Apache httpd 2.4.38 release running cleanly.

Dennis



