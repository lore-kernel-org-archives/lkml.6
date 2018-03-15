Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCORcC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:32:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:39465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeCORb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:31:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,311,1517904000";
   d="scan'208";a="42350261"
Subject: Re: [PATCH v3] x86: treat pkey-0 special
To: Ram Pai <linuxram@us.ibm.com>
References: <1521061214-22385-1-git-send-email-linuxram@us.ibm.com>
 <alpine.DEB.2.21.1803151039430.1525@nanos.tec.linutronix.de>
 <f5ef79ef-122a-e0a3-9b8e-d49c33f4a417@intel.com>
 <20180315172129.GD1060@ram.oc3035372033.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com,
        Ulrich.Weigand@de.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2bf8e659-5a8d-a2d5-ea52-e4d395ea2201@intel.com>
Date: Thu, 15 Mar 2018 10:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315172129.GD1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 10:21 AM, Ram Pai wrote:
> On Thu, Mar 15, 2018 at 08:55:31AM -0700, Dave Hansen wrote:
>> On 03/15/2018 02:46 AM, Thomas Gleixner wrote:
>>>> +	if (!pkey || !mm_pkey_is_allocated(mm, pkey))
>>> Why this extra check? mm_pkey_is_allocated(mm, 0) should not return true
>>> ever. If it does, then this wants to be fixed.
>> I was thinking that we _do_ actually want it to seem allocated.  It just
>> get "allocated" implicitly when an mm is created.  I think that will
>> simplify the code if we avoid treating it specially in as many places as
>> possible.
> I think, the logic that makes pkey-0 special must to go
> in arch-neutral code.   How about checking for pkey-0 in sys_pkey_free()
> itself?

This is for protection against shooting yourself in the foot?  Yes, that
can go in sys_pkey_free().

Does this need manpage and/or selftests updates?
