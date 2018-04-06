Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeDFLGo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:06:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36532 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeDFLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:06:43 -0400
X-Google-Smtp-Source: AIpwx4+VuJxI26EkjlIMJ3tbLNDDxn/m55DfWh1BgIQ563w7iwX4RT4Os8W0u/+WD0F/L43d6igFxw==
Date: Fri, 6 Apr 2018 14:05:57 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>, dave.hansen@intel.com
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v3 0/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-ID: <20180406110557.xg2edtjgzmsdksry@node.shutemov.name>
References: <20180228032657.32385-1-bhe@redhat.com>
 <20180405150842.350e4febc06a813138f00416@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405150842.350e4febc06a813138f00416@linux-foundation.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 03:08:42PM -0700, Andrew Morton wrote:
> On Wed, 28 Feb 2018 11:26:53 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > This is v3 post. V1 can be found here:
> > https://www.spinics.net/lists/linux-mm/msg144486.html
> > 
> > In sparse_init(), two temporary pointer arrays, usemap_map and map_map
> > are allocated with the size of NR_MEM_SECTIONS. They are used to store
> > each memory section's usemap and mem map if marked as present. In
> > 5-level paging mode, this will cost 512M memory though they will be
> > released at the end of sparse_init(). System with few memory, like
> > kdump kernel which usually only has about 256M, will fail to boot
> > because of allocation failure if CONFIG_X86_5LEVEL=y.
> > 
> > In this patchset, optimize the memmap allocation code to only use
> > usemap_map and map_map with the size of nr_present_sections. This
> > makes kdump kernel boot up with normal crashkernel='' setting when
> > CONFIG_X86_5LEVEL=y.
> 
> This patchset could do with some more review, please?

I don't really understand sparsemem good enough to comment on the
patchset.

Dave, could you review this?

-- 
 Kirill A. Shutemov
