Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFEF208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fVwFHXTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFEF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeIYD1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:27:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36897 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeIYD1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:27:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id n11-v6so11447832wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+JzskV5OtzOG0m1p4s2/K6OdbQFGlvwNJc0p9Vcg3Ug=;
        b=fVwFHXTn9yPZU7Lmid16eukQPQe8o3I4e4Z2KYtpDm7xbaPe6w4rGMhikgUL3dCJy9
         JfHFNHUl0e7C08c1pyf/V9iHbsx445uaMEA6jgKYeRzpkV/uLeruMl7rqsVCrJaN7yFI
         30vec1xFmYxUWF9OK3b1cChuZLLAL/G6BZH1JKXP8uDlx1e6rMc1iYRCLw8R9uSObJ7y
         2haDxgqo4ZhHG+diiEwhM7HXguaC07wO4y9iexYu97bCTn2SbVJ+FHW3z85glSQBggNB
         sk21uxYbXmTLZMOKVtt0b+aLWg/ttga2HL4BMxRyy8ZkZOOLYQsP2KdALm/b6GesMV/w
         xD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JzskV5OtzOG0m1p4s2/K6OdbQFGlvwNJc0p9Vcg3Ug=;
        b=JUO6spR26usiKaU322l5EiN04UZgn5HPqCR6xRmSVVhnOx7e0KXnTLZ7ZbTSALuBxN
         uQm6ZbCaR33mUlNTWjWKfw7STykhRaKilTzAu+uXaLAQ1KLTxB/LEL8JkEdVRKOFOR5o
         aQ0mi1CmCnwcwglBlzFEY9OyCCq0F6lpQqaDHh3SIGVunlAkW0H096nyI3VunZ+/VppY
         w2I/sRPqnOeseFQPmNTTp3YwO911lM84hggLEEQJSZDJtOY33tNx98yyzqf5oS9rCO/u
         7fUqW0C8B9AyAD3jIpeZ/o4Utv3kE6lUlZQZv4IRpPVDo9Dwf50GvbpbIeI16m6AhXiF
         GRhQ==
X-Gm-Message-State: ABuFfojoZFFHfP26sDUAdkb+IwICwCnIZi5imKejbjiqKDYiIK5hsYxJ
        Nbnm68bOTO4YsodC0J0L42Y9ZQ==
X-Google-Smtp-Source: ACcGV603ma3ne8uiBM/UOo4OdFYZ05vCpYuWnMPjdx+OyPQwgWHHJlP+jBCHV5FAZR/F92fUnEyQWA==
X-Received: by 2002:a1c:b743:: with SMTP id h64-v6mr162457wmf.26.1537824169383;
        Mon, 24 Sep 2018 14:22:49 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([178.121.218.92])
        by smtp.gmail.com with ESMTPSA id 88-v6sm248737wrf.95.2018.09.24.14.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:22:48 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 40B7E3005E0; Tue, 25 Sep 2018 00:22:47 +0300 (+03)
Date:   Tue, 25 Sep 2018 00:22:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix COW faults after mlock()
Message-ID: <20180924212246.vmmsmgd5qw6xkfwh@kshutemo-mobl1>
References: <20180924130852.12996-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924130852.12996-1-ynorov@caviumnetworks.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:08:52PM +0300, Yury Norov wrote:
> After mlock() on newly mmap()ed shared memory I observe page faults.
> 
> The problem is that populate_vma_page_range() doesn't set FOLL_WRITE
> flag for writable shared memory in mlock() path, arguing that like:
> /*
>  * We want to touch writable mappings with a write fault in order
>  * to break COW, except for shared mappings because these don't COW
>  * and we would not want to dirty them for nothing.
>  */
> 
> But they are actually COWed. The most straightforward way to avoid it
> is to set FOLL_WRITE flag for shared mappings as well as for private ones.

Huh? How do shared mapping get CoWed?

In this context CoW means to create a private copy of the  page for the
process. It only makes sense for private mappings as all pages in shared
mappings do not belong to the process.

Shared mappings will still get faults, but a bit later -- after the page
is written back to disc, the page get clear and write protected to catch
the next write access.

Noticeable exception is tmpfs/shmem. These pages do not belong to normal
write back process. But the code path is used for other filesystems as
well.

Therefore, NAK. You only create unneeded write back traffic.

-- 
 Kirill A. Shutemov
