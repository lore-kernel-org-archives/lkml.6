Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCMPJv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:09:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:10506 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbeCMPJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:09:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="34630726"
Subject: Re: [tip:x86/mm] x86/tme: Detect if TME and MKTME is activated by
 BIOS
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@linux.intel.com>
References: <20180305162610.37510-3-kirill.shutemov@linux.intel.com>
 <tip-cb06d8e3d020c30fe10ae711c925a5319ab82c88@git.kernel.org>
 <1520907122.6421.8.camel@linux.intel.com>
 <20180313124956.z426zmsr4xl6zomx@node.shutemov.name>
Cc: peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, linux-tip-commits@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <7b0ef81b-c46b-5fa2-6a69-c008310b2e94@intel.com>
Date: Tue, 13 Mar 2018 08:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313124956.z426zmsr4xl6zomx@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 05:49 AM, Kirill A. Shutemov wrote:
> On Tue, Mar 13, 2018 at 03:12:02PM +1300, Kai Huang wrote:
>> It seems setup_pku() will call get_cpu_cap to restore c->x86_phys_bits
>> later? In which case I think you need to change setup_pku as well.
> Thanks for catching this.
> 
> I think setup_pku() shouldn't call get_cpu_cap().

I think if you want to make it illegal to call get_cpu_cap() twice, you
should enforce that.
