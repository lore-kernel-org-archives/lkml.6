Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeDVHqg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 03:46:36 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33777 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDVHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 03:46:34 -0400
X-Google-Smtp-Source: AIpwx4+rvoHtUKrvWo1VJLTLQBK+noCpdWRRZRM9/7zG85DHIphmhYhGLc9O/SHth2tlgiG1xtSAtQ==
Date: Thu, 19 Apr 2018 12:01:19 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, viro@zeniv.linux.org.uk,
        nyc@holomorphy.com, kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-ID: <20180419090119.5p5vos3vm57epr2j@node.shutemov.name>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <2804a1d0-9d68-ac43-3041-9490147b52b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2804a1d0-9d68-ac43-3041-9490147b52b5@oracle.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 01:26:35PM -0700, Mike Kravetz wrote:
> If an application would want to take advantage of this flag for tmpfs, it
> needs to map at a fixed address (MAP_FIXED) for huge page alignment.  So,
> it will need to do one of the 'mmap tricks' to get a mapping at a suitably
> aligned address.  

We don't need MAP_FIXED. We already have all required magic in
shmem_get_unmapped_area().

-- 
 Kirill A. Shutemov
