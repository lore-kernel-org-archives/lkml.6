Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeCWTXF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:23:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:16349 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751983AbeCWTXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:23:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="185454733"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180323180903.33B17168@viggo.jf.intel.com>
 <20180323180911.E43ACAB8@viggo.jf.intel.com>
 <CALvZod6F8x-smAE7sEGfJ3Ds5p6M5Qj6gd-P-VLejuBxfU6niQ@mail.gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linuxram@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
        mpe@ellerman.id.au, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f7897068-18a3-d88b-0458-5dcf05d7ffc2@intel.com>
Date: Fri, 23 Mar 2018 12:23:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6F8x-smAE7sEGfJ3Ds5p6M5Qj6gd-P-VLejuBxfU6niQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 12:15 PM, Shakeel Butt wrote:
>> We had a check for PROT_READ/WRITE, but it did not work
>> for PROT_NONE.  This entirely removes the PROT_* checks,
>> which ensures that PROT_NONE now works.
>>
>> Reported-by: Shakeel Butt <shakeelb@google.com>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Should there be a 'Fixes' tag? Also should this patch go to stable?

There could be, but I'm to lazy to dig up the original commit.  Does it
matter?

And, yes, I think it probably makes sense for -stable.  I'll add that if
I resend this series.
