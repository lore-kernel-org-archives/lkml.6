Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeEVN6H convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:58:07 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:48485 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbeEVN6B (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Tue, 22 May 2018 09:58:01 -0400
Message-Id: <5B0421E502000078001C4B91@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 22 May 2018 07:57:57 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <brgerst@gmail.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] xen/PVH: Set up GS segment for stack canary
References: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
 <20180522035445.16911-2-boris.ostrovsky@oracle.com>
 <CAMzpN2iMrEqee+8yGP_qk-qAuXf+_o6vrOUSDTvX=8JAUDT5Fg@mail.gmail.com>
In-Reply-To: <CAMzpN2iMrEqee+8yGP_qk-qAuXf+_o6vrOUSDTvX=8JAUDT5Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 22.05.18 at 15:45, <brgerst@gmail.com> wrote:
> On Mon, May 21, 2018 at 11:54 PM, Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:
>> @@ -98,6 +101,12 @@ ENTRY(pvh_start_xen)
>>         /* 64-bit entry point. */
>>         .code64
>>  1:
>> +       /* Set base address in stack canary descriptor. */
>> +       mov $MSR_GS_BASE,%ecx
>> +       mov $canary, %rax
>> +       cdq
>> +       wrmsr
> 
> CDQ only sign-extends EAX to RAX.  What you really want is to move the
> high 32-bits to EDX (or zero EDX if we can guarantee it is loaded
> below 4G).

What you describe is CDQE (AT&T name: CLTD); CDQ (AT&T: CLTQ)
sign-extends EAX to EDX:EAX.

Jan
