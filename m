Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeEBPHc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:07:32 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:49861 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBPH3 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Wed, 2 May 2018 11:07:29 -0400
Message-Id: <5AE9D42C02000078001C030D@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 09:07:24 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "Roger Pau Monne" <roger.pau@citrix.com>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 4/4] xen/PVH: Remove reserved entry in
 PVH GDT
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-5-boris.ostrovsky@oracle.com>
 <20180501080009.wnjmno5pietptixo@MacBook-Pro-de-Roger.local>
 <5a357f3d-b66e-ca55-0601-18a89b549f4a@oracle.com>
 <5AE9764D02000078001C00BE@prv1-mh.provo.novell.com>
 <ee05bb34-7671-3069-3eb0-f794a2dc68a4@oracle.com>
In-Reply-To: <ee05bb34-7671-3069-3eb0-f794a2dc68a4@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 02.05.18 at 17:06, <boris.ostrovsky@oracle.com> wrote:
> On 05/02/2018 04:26 AM, Jan Beulich wrote:
>>>>> On 01.05.18 at 14:34, <boris.ostrovsky@oracle.com> wrote:
>>> On 05/01/2018 04:00 AM, Roger Pau Monné wrote:
>>>> On Mon, Apr 30, 2018 at 12:23:39PM -0400, Boris Ostrovsky wrote:
>>>>> And without it we can't use _BOOT_XX macros any longer so define new ones.
>>>> Not being that familiar with Linux internals I'm not sure I see the
>>>> benefit of this. Isn't there a risk that some other code is going to
>>>> use the __BOOT_XX defines?
>>> The startup code we are jumping to loads their own GDT and I don't see 
>>> any explicit references to segments.
>> No explicit references to segments isn't enough: You also need to make
>> sure no exceptions at all can occur while loaded selectors and GDT are
>> out of sync - in particular NMI might be of concern here (this isn't PV
>> after all, where not having a callback registered effectively masks NMI).
> 
> How would keeping __BOOT_XX selectors help with NMI? We don't have
> anything set up for NMI handling anyway yet, this is all done in x86
> startup code later.

Oh, you're right - there's no IDT either, so an NMI would yield a triple fault
anyway.

Jan
