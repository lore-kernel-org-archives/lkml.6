Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeCFOJx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:09:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33319 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeCFOJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:09:50 -0500
X-Google-Smtp-Source: AG47ELuq6ouYBF8mAUEDWY7xy189TRMzv1amxT8hQaShwx1dloDnYqc6F1qOrLnUESnpM772JP2urA==
Date: Tue, 6 Mar 2018 17:09:32 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 19/22] x86/mm: Implement free_encrypt_page()
Message-ID: <20180306140932.bdll5vh6qzyydqg4@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-20-kirill.shutemov@linux.intel.com>
 <a692b2ff-b590-b731-ad14-18238f471a1c@intel.com>
 <20180306085412.vkgheeya24dze53t@node.shutemov.name>
 <64d11e65-76b7-4e70-553c-009263b50a1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d11e65-76b7-4e70-553c-009263b50a1c@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 05:52:44AM -0800, Dave Hansen wrote:
> On 03/06/2018 12:54 AM, Kirill A. Shutemov wrote:
> >> Have you measured how slow this is?
> > No, I have not.
> 
> It would be handy to do this.  I *think* you can do it on normal
> hardware, even if it does not have "real" support for memory encryption.
>  Just don't set the encryption bits in the PTEs but go through all the
> motions of cache flushing.

Yes, allocation/freeing and KeyID interfaces can be tested with MKTME
support in hardware. I did most of my testing this way.

> I think that will help tell us whether this is a really specialized
> thing a la hugetlbfs or whether it's something we really want to support
> as a first-class citizen in the VM.

I will benchmark this. But not right now.

-- 
 Kirill A. Shutemov
