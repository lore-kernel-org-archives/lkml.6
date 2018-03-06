Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeCFO6L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:58:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:50405 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753762AbeCFO6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:58:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="35033900"
Date: Tue, 6 Mar 2018 17:58:06 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 21/22] x86/mm: Introduce page_keyid() and
 page_encrypted()
Message-ID: <20180306145806.ejg5kzaqqmncgqi7@black.fi.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-22-kirill.shutemov@linux.intel.com>
 <61041640-435e-1a67-177f-a75791130514@intel.com>
 <20180306085751.tvozsfe6hogh37pd@node.shutemov.name>
 <91d27559-3f28-d53c-9fd9-d16e015a3f59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d27559-3f28-d53c-9fd9-d16e015a3f59@intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 02:56:08PM +0000, Dave Hansen wrote:
> On 03/06/2018 12:57 AM, Kirill A. Shutemov wrote:
> > On Mon, Mar 05, 2018 at 09:08:53AM -0800, Dave Hansen wrote:
> >> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> >>> +static inline bool page_encrypted(struct page *page)
> >>> +{
> >>> +	/* All pages with non-zero KeyID are encrypted */
> >>> +	return page_keyid(page) != 0;
> >>> +}
> >>
> >> Is this true?  I thought there was a KEYID_NO_ENCRYPT "Do not encrypt
> >> memory when this KeyID is in use."  Is that really only limited to key 0.
> > 
> > Well, it depends on what we mean by "encrypted". For memory management
> > pruposes we care if the page is encrypted with KeyID different from
> > default one. All pages with non-default KeyID threated the same by memory
> > management.
> 
> Doesn't it really mean "am I able to use the direct map to get this
> page's contents?"

Yes.

Any proposal for better helper name?

-- 
 Kirill A. Shutemov
