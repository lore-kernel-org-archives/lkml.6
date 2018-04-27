Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757633AbeD0Icl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:32:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41404 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757536AbeD0Icj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:32:39 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39370077"
Subject: Re: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from being
 accounted"
To: Jan Beulich <JBeulich@suse.com>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>
References: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <12fd36d0-1678-ed57-fec3-c94b430bd23f@cn.fujitsu.com>
Date: Fri, 27 Apr 2018 16:32:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 9B04348AE929.A8F3E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

At 04/27/2018 03:21 PM, Jan Beulich wrote:
> Hello,
> 
> I've just stumbled across this commit, and I'm wondering if that's actually
> correct (I too have at least one system where such IDs are reported in
> MADT): For offline/absent CPUs, the firmware may not know the APIC IDs

The MADT table is not reasonable, the Local APIC entries(xAPIC/x2APIC)
in MADT is not always correct as OS want. So, we should do this sanity
check.

> at the point MADT is built, so I think it is quite reasonable to put ~0 in
> there. The ACPID spec specifically calls out that the IDs must not change
> across sleep states, which implies to me that they may change across an
> offline period of a CPU. IOW I think such entries still need to contribute to
> the count of disabled CPUs.
> 

Aha, there are no CPU devices which will map it's physical ID to the
illegal number 0xffffffff, So it will never be used.

BTW, Limiting the number of the disabled CPUs is also a goal.

Thanks,
	dou

> I notice a similar change has been done for the xAPIC case a while ago
> by you, Thomas.
> 
> Jan
> 
> 
> 
> 
> 
