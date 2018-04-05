Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeDEWIp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:08:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeDEWIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:08:44 -0400
Date: Thu, 5 Apr 2018 15:08:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v3 0/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
Message-Id: <20180405150842.350e4febc06a813138f00416@linux-foundation.org>
In-Reply-To: <20180228032657.32385-1-bhe@redhat.com>
References: <20180228032657.32385-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 11:26:53 +0800 Baoquan He <bhe@redhat.com> wrote:

> This is v3 post. V1 can be found here:
> https://www.spinics.net/lists/linux-mm/msg144486.html
> 
> In sparse_init(), two temporary pointer arrays, usemap_map and map_map
> are allocated with the size of NR_MEM_SECTIONS. They are used to store
> each memory section's usemap and mem map if marked as present. In
> 5-level paging mode, this will cost 512M memory though they will be
> released at the end of sparse_init(). System with few memory, like
> kdump kernel which usually only has about 256M, will fail to boot
> because of allocation failure if CONFIG_X86_5LEVEL=y.
> 
> In this patchset, optimize the memmap allocation code to only use
> usemap_map and map_map with the size of nr_present_sections. This
> makes kdump kernel boot up with normal crashkernel='' setting when
> CONFIG_X86_5LEVEL=y.

This patchset could do with some more review, please?
