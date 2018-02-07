Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeBGTbF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:31:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753995AbeBGTbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:31:04 -0500
Subject: Re: [v6,3/3] x86/smpboot: Fix __max_logical_packages estimate
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel <xen-devel@lists.xen.org>
References: <20171114124257.22013-4-prarit@redhat.com>
 <370a7ab2-8f57-b99b-428b-d0b1dfe401e7@invisiblethingslab.com>
 <6fdee802-bf24-7fbb-c95a-a6e0d840fbde@redhat.com>
 <a6bdbf62-3d93-1f5c-6c05-c4c391bc8a9e@invisiblethingslab.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Piotr Luc <piotr.luc@intel.com>, Kan Liang <kan.liang@intel.com>,
        Borislav Petkov <bp@suse.de>, Stephane Eranian <eranian@google.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        He Chen <he.chen@linux.intel.com>,
        Mathias Krause <minipli@googlemail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <02ccc129-83b5-18e9-de5c-b3eff81a8f22@redhat.com>
Date: Wed, 7 Feb 2018 14:31:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <a6bdbf62-3d93-1f5c-6c05-c4c391bc8a9e@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 02:26 PM, Simon Gaiser wrote:
> Prarit Bhargava:
>> On 02/07/2018 01:44 PM, Simon Gaiser wrote:

<snip>

>>> This breaks booting as Xen PV domain for me. The problem seems to be
>>> that native_smp_cpus_done() is never called on a PV domain. So
>>> __max_logical_packages is uninitialized and this leads to a NULL
>>> pointer dereference in coretemp.
>>>
>>
>> I'll see if I can figure out a way to test that.
> 
> Ok, thanks. If you need some logs, or if I should test something just
> ask.
> 

Thanks, I may send you a patch off-list to test.

>> Does 947134d9b00f
>> ("x86/smpboot: Do not use smp_num_siblings in __max_logical_packages
>> calculation") help?
> 
> No.
> 

Yeah, your description was absolutely correct.  native_smp_cpus_done() is only
called for HVM guests and not PV.  I'm going to think about that and send you a
patch in a bit.

P.
