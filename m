Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933126AbeCFPBS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:01:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51672 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCFPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:01:16 -0500
X-Google-Smtp-Source: AG47ELtswNkXd0twKm1wY0ZRNbPIJkobl4L28tSIX5zaoNK1U/+cuiNw2/Z0Ub8aZHru44HlM97fYg==
Date: Tue, 6 Mar 2018 18:00:59 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 13/22] mm, rmap: Free encrypted pages once mapcount
 drops to zero
Message-ID: <20180306150059.fclktp7qdhy37vyz@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
 <e04536bc-77e9-84d0-3c23-1dfea8542da5@intel.com>
 <20180306082743.2epdfxv4ds7hz7py@node.shutemov.name>
 <d1faf309-837b-d385-4d0a-c840fdab8b36@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1faf309-837b-d385-4d0a-c840fdab8b36@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 06:59:04AM -0800, Dave Hansen wrote:
> On 03/06/2018 12:27 AM, Kirill A. Shutemov wrote:
> > +	anon_vma = page_anon_vma(page);
> > +	if (anon_vma_encrypted(anon_vma)) {
> > +		int keyid = anon_vma_keyid(anon_vma);
> > +		free_encrypt_page(page, keyid, compound_order(page));
> > +	}
> >  }
> 
> So, just double-checking: free_encrypt_page() neither "frees and
> encrypts the page"" nor "free an encrypted page"?
> 
> That seems a bit suboptimal. :)

Yes, I'm bad with words :)

-- 
 Kirill A. Shutemov
