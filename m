Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeB1K6T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:58:19 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36663 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeB1K6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:58:16 -0500
X-Google-Smtp-Source: AH8x224hIfE6WhZgVASypC1MOgsteIzeSRhHoPozDJAFpCs8EGM3AJ+LoqeQOcBDIRSSoVNIJ10C/A==
Date: Wed, 28 Feb 2018 13:58:04 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/vm: Update max va test to check for high
 address return.
Message-ID: <20180228105804.2uhjcfxu6zebkixh@node.shutemov.name>
References: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 09:28:30AM +0530, Aneesh Kumar K.V wrote:
> mmap(-1,..) is expected to search from max supported VA top down. It should find
> an address above ADDR_SWITCH_HINT. Explicitly check for this.

Hm. I don't think this correct. -1 means the application supports any
address, not restricted to 47-bit address space. It doesn't mean the
application *require* the address to be above 47-bit.

At least on x86, -1 just shift upper boundary of address range where we
can look for unmapped area.

-- 
 Kirill A. Shutemov
