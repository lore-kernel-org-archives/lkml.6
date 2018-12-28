Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCBCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1932186A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bFbDY4Dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeL1WIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:08:38 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36273 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeL1WIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:08:38 -0500
Received: by mail-pg1-f178.google.com with SMTP id n2so10528793pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/RZr6yKgD5TDgCp5y5pBzZyZGSUk4NajVUX5iyfVBI=;
        b=bFbDY4DgTrBcWn2D5V4oIasuGck3WW1c9Snp3ZM3xf3GxJVMjN4sM6ll4PULGItkeE
         lqW5PfRvKOFKeKCi292neg2NxP4aSIAHmi03yEYacfMGsY+fOQLdVvyNLO3kBm+z1biY
         yS0bOqxYunFAI6N3+GAGxOubzzDbA/HCJ8Qsik1vKwyh6P8LULT9Rt3Ti6j72EcZUfhS
         lJXPehbEtCA+1pM5bSmPpkK1E28ujeNMdog2TvTiqT4MSqC+YzvCchJgx8dttqZ1jlB6
         uMfajds/qgPWzo4iz81KrRDN2UAAxZbkf7hFnAHCnv851n42AqDIzaqVi/zCHTeGMQbV
         alpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/RZr6yKgD5TDgCp5y5pBzZyZGSUk4NajVUX5iyfVBI=;
        b=aPDXWIJJI0rn27SEkVGu+Bj26RZ8lYf3K2vHd3UGjdieT/wOFXIymFauTuL4YQG7o6
         VZRwuR//9EWcDGLuAb2GbTT3wHPIWaDuBdn/VE40n1nuBrYc/aQiSS6943EfDMysSre0
         VB1CcTpjxwgPC2xYyf8IFuLV3W+Xja0HdZB6Z3/4Pefqm17eIrIIPJVOdZvzWpEu+V4p
         RdaAlyFeO7e1ZuI+uGYDcKTKzkgMfmeJTmiwJ9ofWVlTE0KQtciQxEsvEHT4OGGzWaMT
         MLwlv1A2V5m3cBvRm5Gs8D33wZlHIW5sHllmsO5qibpOlAdnuT+63/86PuyB3SCXquol
         uKFg==
X-Gm-Message-State: AJcUukcqYiDnxYp1Npe8RmoSFLU25OHIUN3kbE8NeBNysZb+WL7fFASo
        xjAbt5j/LD0cYx3aR4i6DLO4Fw==
X-Google-Smtp-Source: ALg8bN5SZ+dQQgT7HqHEmb9cO7wiEmQH5fKNw73VyINfK3f9qfp0xJcWMcab7RiLyHXZ+JBUTz3qmQ==
X-Received: by 2002:a63:9256:: with SMTP id s22mr27033929pgn.224.1546034917652;
        Fri, 28 Dec 2018 14:08:37 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 5sm72561724pfz.149.2018.12.28.14.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:08:36 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id CD9523000D9; Sat, 29 Dec 2018 01:08:33 +0300 (+03)
Date:   Sat, 29 Dec 2018 01:08:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     syzbot <syzbot+b437b5a429d680cf2217@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, darrick.wong@oracle.com,
        hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
        josef@toxicpanda.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: KASAN: use-after-free Read in filemap_fault
Message-ID: <20181228220833.rinbqizv7h5myxds@kshutemo-mobl1>
References: <000000000000b57d19057e1b383d@google.com>
 <20181228220152.wkeslziuovnunvwk@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228220152.wkeslziuovnunvwk@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 01:01:52AM +0300, Kirill A. Shutemov wrote:
> On Fri, Dec 28, 2018 at 12:51:04PM -0800, syzbot wrote:
> > Allocated by task 8196:
> 
> ...
> 
> > Freed by task 8197:
> 
> Hm. VMA allocated by one process (I don't see threads in the test case)
> gets freed by another one. Looks fishy to me.

Ignore this. I need some to go sleep %)

-- 
 Kirill A. Shutemov
