Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753184AbeCFISZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:18:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38681 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCFISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:18:23 -0500
X-Google-Smtp-Source: AG47ELtWolFhDx0AuPhWlA/u+3BvyAabqpfSX8NGHJzLMSm2juXzoizH8jdPXT0aFM5SkaMM8O+Fxg==
Date: Tue, 6 Mar 2018 11:18:07 +0300
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
Message-ID: <20180306081807.f3ohd7fg6jpohg4h@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-14-kirill.shutemov@linux.intel.com>
 <eb2cc1cf-1be1-4535-f71b-fa33272a6f71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2cc1cf-1be1-4535-f71b-fa33272a6f71@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:12:15AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> >  extern void prep_encrypt_page(struct page *page, gfp_t gfp, unsigned int order);
> > +extern void free_encrypt_page(struct page *page, int keyid, unsigned int order);
> 
> The grammar here is weird, I think.
> 
> Why not free_encrypted_page()?

Okay, I'll fix this.

-- 
 Kirill A. Shutemov
