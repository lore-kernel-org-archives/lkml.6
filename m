Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3DCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152D32089B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHqfnMGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152D32089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbeGZR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:58:08 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36829 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbeGZR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:58:08 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so891524ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Pbzvirt74+CocRnPvyDxieVSgr06qHyxp3sIpx6ZmkU=;
        b=QHqfnMGl7NwuJ2KyUI87PEfIFKGwLkG3Rmnpzpw2QRqotlIVG6UkU/w12ABpqgeS0z
         JuelfRcIRGiGiEuG3cTXe/F/rADH7XwO1GCSnXWu9vAnUi8YRMODR09wb0R7Xx+r05Fz
         6asOnUwv6MQ6RvJY73Xlb1hTxUqNMxdpqn1qB+uhdfR1Q0MraM1fkOyqy1ZFIGHAbfNu
         cQ+7ji6np1R2LBiMCcCQdYAiMGqTbynZbJbllSQaI8tRIFaxtSb9cAp/OkzmS4Mw2ikO
         O3lSGag5GUQaxR/nNpCgVmBOlCtxgWiyK7FU4ZFxUUY35we9VN5Ac4GkO4zkABZUgA6Z
         N1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Pbzvirt74+CocRnPvyDxieVSgr06qHyxp3sIpx6ZmkU=;
        b=pl0g1zuhJhB0TBWWjWYEpi/wtKFvRwPucG3k9iLeNpCx8e2lJKBdTJuEOLsseIQoTE
         FYty/awZYWrSu7i0mtvwqIVilGnIHONCjPkPgkKiz4eXvR0ORbcJsFRDNEhjGP2DZntR
         DJbSZ7oyvkDgJ5mlQQ2+GBV2wZ4gE3vsgm0vAnYPUCy6LVNHJLimh2cY+s6eKLecGZ+8
         ub6qDo4QihBF1D1XWHHoGt5x7Z2Bs8MmukOSLyvGro9t/Ck3QkJQf5I0IIccYkwZvhfX
         fpsIn0fqEzFiXEFjIyx8FWnceJJjVkltJl744JNMYv92GlOIuscOdH6Lt+GG6jXRbaYZ
         l7HA==
X-Gm-Message-State: AOUpUlFwphLS+h1qVTgA4fMEBGa9wJsRjs7fXHREw2Ku7gY/KJB4glNb
        dVl8QEzUwP/epf6YepVekA9eFg==
X-Google-Smtp-Source: AAOMgpe+bw28tj0oBZpzBy2TzRlOr3EyrBO15vUVXYo6znk3m5cctYyh1Ks6o1H289W5jal6U+UUmQ==
X-Received: by 2002:a5b:786:: with SMTP id b6-v6mr1548927ybq.160.1532623229802;
        Thu, 26 Jul 2018 09:40:29 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d6-v6sm756243ywa.85.2018.07.26.09.40.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 09:40:28 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:40:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <20180726143353.GA27612@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.1807260936040.1101@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org> <alpine.LSU.2.11.1807221856350.5536@eggly.anvils> <20180723140150.GA31843@bombadil.infradead.org> <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
 <20180723203628.GA18236@bombadil.infradead.org> <alpine.LSU.2.11.1807231531240.2545@eggly.anvils> <20180723225454.GC18236@bombadil.infradead.org> <alpine.LSU.2.11.1807240121590.1105@eggly.anvils> <alpine.LSU.2.11.1807252334420.1212@eggly.anvils>
 <20180726143353.GA27612@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018, Matthew Wilcox wrote:
> On Wed, Jul 25, 2018 at 11:53:15PM -0700, Hugh Dickins wrote:
> 
> and fixing the bug differently ;-)  But many thanks for spotting it!

I thought you might :)

> 
> I'll look into the next bug you reported ...

No need: that idea now works a lot better when I use the initialized
"start", instead of the uninitialized "index".

Hugh

--- mmotm/mm/khugepaged.c	2018-07-20 17:54:41.978805312 -0700
+++ linux/mm/khugepaged.c	2018-07-26 09:20:22.416949014 -0700
@@ -1352,6 +1352,7 @@ static void collapse_shmem(struct mm_str
 			goto out;
 	} while (1);
 
+	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
 		struct page *page = xas_next(&xas);
 
