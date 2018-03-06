Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeCFIhB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:37:01 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38477 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeCFIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:36:58 -0500
X-Google-Smtp-Source: AG47ELvzDe2GDp+t/bWKUibSTohO+ZKXyMz1PAtWGTFRHcWXpjOYWzZ41zjhCsNCH2294M1Yrh3cjA==
Date: Tue, 6 Mar 2018 11:36:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC, PATCH 18/22] x86/mm: Handle allocation of encrypted pages
Message-ID: <20180306083642.yrhbcuz7fgwhmlix@node.shutemov.name>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
 <20180305162610.37510-19-kirill.shutemov@linux.intel.com>
 <6551765a-5926-8445-d867-8f7c6bf343b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6551765a-5926-8445-d867-8f7c6bf343b4@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:07:55AM -0800, Dave Hansen wrote:
> On 03/05/2018 08:26 AM, Kirill A. Shutemov wrote:
> > kmap_atomic_keyid() would map the page with the specified KeyID.
> > For now it's dummy implementation that would be replaced later.
> 
> I think you need to explain the tradeoffs here.  We could just change
> the linear map around, but you don't.  Why?

I don't think we settled on implementation by this point: kmap() is only
interface and doesn't imply what it acctually does. I *can* change linear
mapping if we would chose so.

I will explain the kmap() implementation in patches that would implement
it.

-- 
 Kirill A. Shutemov
