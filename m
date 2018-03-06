Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeCFNwr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:52:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:18094 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeCFNwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:52:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="35016997"
Subject: Re: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
 <a692b2ff-b590-b731-ad14-18238f471a1c@intel.com>
 <20180306085412.vkgheeya24dze53t@node.shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <64d11e65-76b7-4e70-553c-009263b50a1c@intel.com>
Date: Tue, 6 Mar 2018 05:52:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306085412.vkgheeya24dze53t@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 12:54 AM, Kirill A. Shutemov wrote:
>> Have you measured how slow this is?
> No, I have not.

It would be handy to do this.  I *think* you can do it on normal
hardware, even if it does not have "real" support for memory encryption.
 Just don't set the encryption bits in the PTEs but go through all the
motions of cache flushing.

I think that will help tell us whether this is a really specialized
thing a la hugetlbfs or whether it's something we really want to support
as a first-class citizen in the VM.
