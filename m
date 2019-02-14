Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD1218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AAqBWSkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407049AbfBNNaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:30:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36243 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407036AbfBNNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:30:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so3088103pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cD8gOqInkhDXw2CiDZ0G3aAu7ObyRZomWCuhX6uppCY=;
        b=AAqBWSkzqbVNJ1NwR/lYh74r3OF7SADwVijueSwhv3pgXkJocI84Eg/PvjryagJ1Be
         Mp+DDGujpphUExEXT8wa264ko9phe+Xh2x/qeyOKZYywFpPBFJalsOvwpIFJf8QvCD+l
         rXNyN9CVyu9cIgKcgg931ZBrKFfAoFqJfAS/mkSnD+1nk3OWYjoKsIcqSOum/wOXngAw
         w9Obx4wIrgsr6cuYDKYwznchICuloxA0CLPEO+sVGn3doOBvaXoESv0sCz6adPpJJICn
         X+zEJ/lM+WTpDUvysNb/EpdBke7AXzosr+F2r5PmlSRWaLAelHT7MBAH55zTzBFxA5ob
         4jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cD8gOqInkhDXw2CiDZ0G3aAu7ObyRZomWCuhX6uppCY=;
        b=Q5AsPmsiRkT27Jzk1GzHSy3t0zUa5t/+v0kHL3es9SJEoLkm2d+dHHKiY6TQJqcOzC
         MIvnSLmqmjDnXche8icatqcFa7oXdLUIngAhkSMx86Q6YhxdquPX5juGVoxb3yOWo1y4
         cmkiOKCJbNLhW71C33z+laAqVLHrJ3a76ZkGuqK90m4orySJslUilFQ2TS2sSnIuERWz
         8sLVwAi9pil3D2ElGvHN3NFA88bnOQUXng9li+UWeBWDlo+qoM1VNxeN7PLx9VbXS28n
         vBGnhvBumMOywqZVB435P+vEBwm80wNfF4urDqHtL1VEjMFmLzN5Xr5VStsUEpe50CQc
         OIUg==
X-Gm-Message-State: AHQUAuZMy1H7mLb/FqVGYJKP5w3TFdgSsB01CFTHYzXtYOlDaAcwr0j3
        fbawft19VypofVnOYOxci8T7Qg==
X-Google-Smtp-Source: AHgI3Ib8FcTyXhejuuqak93lu0VkvS65lcJUVtOIXNavlw5FG8HPeLMO12TkhRcqS2v6FeG68QNZWw==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr3818511pgb.56.1550151008763;
        Thu, 14 Feb 2019 05:30:08 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id h128sm2825694pgc.15.2019.02.14.05.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:30:07 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1A1473008A8; Thu, 14 Feb 2019 16:30:04 +0300 (+03)
Date:   Thu, 14 Feb 2019 16:30:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] page cache: Store only head pages in i_pages
Message-ID: <20190214133004.js7s42igiqc5pgwf@kshutemo-mobl1>
References: <20190212183454.26062-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212183454.26062-1-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:34:54AM -0800, Matthew Wilcox wrote:
> Transparent Huge Pages are currently stored in i_pages as pointers to
> consecutive subpages.  This patch changes that to storing consecutive
> pointers to the head page in preparation for storing huge pages more
> efficiently in i_pages.
> 
> Large parts of this are "inspired" by Kirill's patch
> https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

I believe I found few missing pieces:

 - page_cache_delete_batch() will blow up on

			VM_BUG_ON_PAGE(page->index + HPAGE_PMD_NR - tail_pages
					!= pvec->pages[i]->index, page);

 - migrate_page_move_mapping() has to be converted too.

The rest *looks* fine to me. But it needs a lot of testing.

-- 
 Kirill A. Shutemov
