Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeDIQEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:04:14 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:59955 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbeDIQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:04:09 -0400
Subject: Re: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
Date: Mon, 9 Apr 2018 09:03:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 06:57 AM, Laurent Dufour wrote:
> The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
> per architecture header files. This doesn't allow to make other
> configuration dependent on it.

So I understand this series has more "readability" value and I'm fine with this 
change but I wonder if you really would want to make something depend on it or 
make this de-configurable. PTE special is really a fundamental construct - e.g. it 
is used for anon mapped pages where zero page has been wired up etc...

-Vineet

> This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
> setting it automatically when architectures was already setting it in
> header file.
>
> There is no functional change introduced by this series.
