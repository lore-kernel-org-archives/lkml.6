Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6370821919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfBHVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:19:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfBHVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:19:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id a15so3034453qkc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 13:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cKmjErimzmWpabXtTC+WS2JZ+dXRUa+xsrzHrEVg9Kg=;
        b=WAe5TZd+N0OFJlvjI91aPTzKjZcMEE45palHLWdi0/qTjMRT1VuzxWb68XVbPzBOUr
         zimAT393hndv+hDiIifmwksOBX7vvcu2xAEWefAif/DZKlK+Du62czrSkko9OYUPY5u/
         /J+QSUzy03yat7YCHO5zN0oY56qxfVtSSdmguCEEzqyJERBpWazY/SOigR9tNhrm0JzD
         3jhrH9AaZQX7/iruqr01jTKyp+BIDZuxKHMJLfFhyBRN2uKZEpn63+kRR+vKaebnoS8r
         KvJL5avS8O1kAAsClZoXCA/NACiYhkoMl3AjSvGgR1PzkX2gIThjNION5bnzFtEBJgOx
         sj5A==
X-Gm-Message-State: AHQUAuZgNbBdq+bBdRJ9DIIdKAiDpwzqdM+GBOLQzAWU62Xyb4w0ECPP
        ++kseoWUqeH8BALzBAdUR7d24g==
X-Google-Smtp-Source: AHgI3IbbYz/LfKL5grS+HxNlQZWnNUdZmTef7mqIfjOLCZ1rb2rrm0AsmqpcDhbSFNCUtaWQWu1ZJg==
X-Received: by 2002:a37:4c93:: with SMTP id z141mr17714635qka.27.1549660750556;
        Fri, 08 Feb 2019 13:19:10 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id p10sm3373159qtc.6.2019.02.08.13.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 13:19:09 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:19:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
Message-ID: <20190208161820-mutt-send-email-mst@kernel.org>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190208181246.GF11096@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208181246.GF11096@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:12:47PM +0200, Mike Rapoport wrote:
> On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> > Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> > architectures, it probably makes sense to de-duplicate these
> > and put them into a common header.
> 
> I like the idea, but it seems there are more asm/mman.h users than just mpx
> and drm.
> 
> Any reason only those were updated to include linux/mman.h?


They are all .c files. So since they keep building I know
nothing else will break. Fixing them would be an unrelated
cleanup.



>  
> > Please review and consider merging though the generic tree.
> > 
> > Build tested on x86 only. Has been in linux-next for a while now.
> > 
> > Michael S. Tsirkin (3):
> >   x86/mpx: tweak header name
> >   drm: tweak header name
> >   arch: move common mmap flags to linux/mman.h
> > 
> >  arch/alpha/include/uapi/asm/mman.h     | 4 +---
> >  arch/mips/include/uapi/asm/mman.h      | 4 +---
> >  arch/parisc/include/uapi/asm/mman.h    | 4 +---
> >  arch/x86/mm/mpx.c                      | 2 +-
> >  arch/xtensa/include/uapi/asm/mman.h    | 4 +---
> >  include/drm/drmP.h                     | 3 +--
> >  include/uapi/asm-generic/mman-common.h | 4 +---
> >  include/uapi/linux/mman.h              | 4 ++++
> >  8 files changed, 11 insertions(+), 18 deletions(-)
> > 
> > -- 
> > MST
> > 
> 
> -- 
> Sincerely yours,
> Mike.
