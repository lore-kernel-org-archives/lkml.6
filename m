Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeCFI6J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:58:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55915 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:58:08 -0500
X-Google-Smtp-Source: AG47ELux6K1gHtFzo8pJHG/ac322dr55gaJy3kPdd+a8jy77kDRgkZHowqTfD3jZju4y5kNGWl1g4w==
Date: Tue, 6 Mar 2018 11:57:51 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 21/22] x86/mm: Introduce page_keyid() and
 page_encrypted()
Message-ID: <20180306085751.tvozsfe6hogh37pd@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-22-kirill.shutemov@linux.intel.com>
 <61041640-435e-1a67-177f-a75791130514@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61041640-435e-1a67-177f-a75791130514@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:08:53AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > +static inline bool page_encrypted(struct page *page)
> > +{
> > +	/* All pages with non-zero KeyID are encrypted */
> > +	return page_keyid(page) != 0;
> > +}
> 
> Is this true?  I thought there was a KEYID_NO_ENCRYPT "Do not encrypt
> memory when this KeyID is in use."  Is that really only limited to key 0.

Well, it depends on what we mean by "encrypted". For memory management
pruposes we care if the page is encrypted with KeyID different from
default one. All pages with non-default KeyID threated the same by memory
management.

So far we don't have users for the interface. We may reconsider
the meaning once we get users.

-- 
 Kirill A. Shutemov
