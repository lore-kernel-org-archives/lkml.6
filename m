Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeCFO4O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:56:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:20369 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932418AbeCFO4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:56:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="23368215"
Subject: Re: [RFC, PATCH 21/22] x86/mm: Introduce page_keyid() and
 page_encrypted()
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-22-kirill.shutemov@linux.intel.com>
 <61041640-435e-1a67-177f-a75791130514@intel.com>
 <20180306085751.tvozsfe6hogh37pd@node.shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <91d27559-3f28-d53c-9fd9-d16e015a3f59@intel.com>
Date: Tue, 6 Mar 2018 06:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306085751.tvozsfe6hogh37pd@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 12:57 AM, Kirill A. Shutemov wrote:
> On Mon, Mar 05, 2018 at 09:08:53AM -0800, Dave Hansen wrote:
>> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
>>> +static inline bool page_encrypted(struct page *page)
>>> +{
>>> +	/* All pages with non-zero KeyID are encrypted */
>>> +	return page_keyid(page) != 0;
>>> +}
>>
>> Is this true?  I thought there was a KEYID_NO_ENCRYPT "Do not encrypt
>> memory when this KeyID is in use."  Is that really only limited to key 0.
> 
> Well, it depends on what we mean by "encrypted". For memory management
> pruposes we care if the page is encrypted with KeyID different from
> default one. All pages with non-default KeyID threated the same by memory
> management.

Doesn't it really mean "am I able to use the direct map to get this
page's contents?"
