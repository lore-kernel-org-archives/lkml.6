Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937129AbeE3GvZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:51:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5931 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935917AbeE3GvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:51:23 -0400
From: Nixiaoming <nixiaoming@huawei.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        "Steve Capper" <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: RE: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Thread-Topic: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Thread-Index: AQHT91VTuQ9u2+btFUCmjZ+Rmfer36RHQZ+AgAACfQCAAI7A8A==
Date: Wed, 30 May 2018 06:51:19 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A672F7A@dggemm507-mbx.china.huawei.com>
References: <20180529133622.26982-1-nixiaoming@huawei.com>
 <20180530055815.GB6463@gmail.com>
 <CAKv+Gu-FvWoDbMV2veh8BzW7ihbvaw-cd+rK5x_TLq0UC99FNg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-FvWoDbMV2veh8BzW7ihbvaw-cd+rK5x_TLq0UC99FNg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4U6ptJx028036

On 30 May 2018 at 2:07PM Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org] wrote:

>On 30 May 2018 at 07:58, Ingo Molnar <mingo@kernel.org> wrote:
>>
>> * nixiaoming <nixiaoming@huawei.com> wrote:
>>
>>> mark_rodata_ro is only called by the function mark_readonly
>>> when CONFIG_STRICT_KERNEL_RWX=y
>>>
>>> if CONFIG_STRICT_KERNEL_RWX is not set
>>> a compile warning may be triggered: unused function
>....
>>
>> NAK, this is very ugly and the changelog doesn't appear to be true: the build
>> warning does not trigger in the default build, correct?
>>
>
>I don't see how the build warning could trigger at all, given that
>mark_rodata_ro() has external linkage.
>

Unable to set CONFIG_STRICT_KERNEL_RWX=n by make menuconfig ARCH=x86_64
the build warning does not trigger in the default build, 
but it should be more appropriate to add CONFIG control to the code.
