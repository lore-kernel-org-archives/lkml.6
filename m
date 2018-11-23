Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0Bd+Pc4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4BC20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409481AbeKWVbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:31:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390156AbeKWVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:31:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so10502596plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yCDzkkUxDhsOcjlmanwy5kH29tqxHEELZlMxWQkLNkI=;
        b=0Bd+Pc4TxmVh9GydW5lFeJb4aCr0AqloP7Cki0891V9f9h36TnDR2S4R8UYtBRzzDn
         IryYOOha0ZQ5JXs3ejczRflGLN8i6Ny8pTXlxTkeRBiLNDqFc5WHp4jY5aAZ+6Emy+RD
         0P0gcnucsLxd3FfPgdnbFVS7RORD+jIuf/uBe5gLQEJlw3KGMiLEbteuqRSQ6yzCaVPQ
         kUg5I5sO14GMymw94qOJWESeJik+v0P6kttKBc0e4f5FxFUAdwX1zBYkXUt0vsdobYSm
         qdIfxfpjsL3FdMT3GAOgV2Cqg27FoDO8nuWlWeI4NE5R4imokPyjj1IVh02hsWyK6El4
         MdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCDzkkUxDhsOcjlmanwy5kH29tqxHEELZlMxWQkLNkI=;
        b=gW3QLCaQDfLUSpJnl7JCaMmkQVWwQVGssDFf+3dx9MJimABol73JPiNyQFOEhJB8JP
         wonRYnbD98sMlMc8rGX4meshZ2RlrmTwf5FkyLoed0K9e1jze22Ey7mnwIXrTlgTRe5n
         MU4uGl96ltZrIFcpxwPXu9IznwWXfZUGL2je/cYfOwixUZITNcs41tS7ubVSBrdnwcxv
         ZLEBKxh0s2Av+CGgO6inP6ofr6Jc4vaTtWD6f+aKPjEV3qyvOwriJrLKodKwt0M1fGTd
         BHXpbBTXn9I9CsJPfbsKGpDUl2sdtMNVX2FeWB/VdcujoPUaMcpd7FpI3joD2NJN1Bwm
         9+Bg==
X-Gm-Message-State: AA+aEWacCjFtUV/209zmKFKwq/tOF7N9qxAc8a2yAY2sI/jCWV5H4w4F
        M46A1z/oXBF1UgwbEsvTcdKJ5A==
X-Google-Smtp-Source: AFSGD/VctfVnfQsSEsCBQXJk78IlFyRIi5A/3BaLVibMWQNrYKSXljLjkuzfkmAhjnbqfLSDz4YgTw==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr14777303plq.195.1542970056790;
        Fri, 23 Nov 2018 02:47:36 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id f22-v6sm67172651pff.29.2018.11.23.02.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 02:47:36 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 83F813001AF; Fri, 23 Nov 2018 13:47:32 +0300 (+03)
Date:   Fri, 23 Nov 2018 13:47:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/2] mm: Remove redundant test from find_get_pages_contig
Message-ID: <20181123104732.gvhdqyddbsiq3i42@kshutemo-mobl1>
References: <20181122213224.12793-1-willy@infradead.org>
 <20181122213224.12793-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122213224.12793-2-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:32:23PM -0800, Matthew Wilcox wrote:
> After we establish a reference on the page, we check the pointer continues
> to be in the correct position in i_pages.  There's no need to check the
> page->mapping or page->index afterwards; if those can change after we've
> got the reference, they can change after we return the page to the caller.

Hm. IIRC, page->mapping can be set to NULL due truncation, but what about
index? When it can be changed? Truncation doesn't touch it.

-- 
 Kirill A. Shutemov
