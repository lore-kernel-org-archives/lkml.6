Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935915AbeE3Dbs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:31:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754765AbeE3Dbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:31:45 -0400
From: Nixiaoming <nixiaoming@huawei.com>
To: Will Deacon <will.deacon@arm.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Thread-Topic: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Thread-Index: AQHT91VOSqz8jbk29Ua9aMsejfLmPaRGU1YAgAFJszA=
Date: Wed, 30 May 2018 03:31:38 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A672E03@dggemm507-mbx.china.huawei.com>
References: <20180529133615.26889-1-nixiaoming@huawei.com>
 <20180529154523.GK17159@arm.com>
In-Reply-To: <20180529154523.GK17159@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to set CONFIG_STRICT_KERNEL_RWX=n by make menuconfig ARCH=arm64

When reading the code, I feel it is more appropriate to add macro control here.


-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Tuesday, May 29, 2018 11:45 PM
To: Nixiaoming <nixiaoming@huawei.com>
Cc: catalin.marinas@arm.com; ard.biesheuvel@linaro.org; marc.zyngier@arm.com; james.morse@arm.com; kristina.martsenko@arm.com; steve.capper@arm.com; tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; akpm@linux-foundation.org; vbabka@suse.cz; mhocko@suse.com; dave.hansen@linux.intel.com; dan.j.williams@intel.com; kirill.shutemov@linux.intel.com; zhang.jia@linux.alibaba.com; schwidefsky@de.ibm.com; heiko.carstens@de.ibm.com; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; x86@kernel.org; linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for mark_rodata_ro

On Tue, May 29, 2018 at 09:36:15PM +0800, nixiaoming wrote:
> mark_rodata_ro is only called by the function mark_readonly when
> CONFIG_STRICT_KERNEL_RWX=y,
> if CONFIG_STRICT_KERNEL_RWX is not set
> a compile warning may be triggered: unused function

How are you achieving this configuration? In our Kconfig we select this
unconditionally.

Will
