Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDPPjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:39:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:49811 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeDPPjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:39:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="43713380"
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in
 map_ldt_struct()
To: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
 <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <07e2c23e-10b7-b03f-5706-3d4b910537ba@linux.intel.com>
Date: Mon, 16 Apr 2018 08:39:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2018 08:16 AM, Andy Lutomirski wrote:
> On Mon, Apr 16, 2018 at 2:43 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> From: Joerg Roedel <jroedel@suse.de>
>>
>> The |= operator will let us end up with an invalid PTE. Use
>> the correct &= instead.
> D'oh!  Looks good.

Yes, agreed.  Thanks for finding that, Joerg!
