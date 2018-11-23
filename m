Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC57C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEF620861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ILpd2c1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEF620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409537AbeKWVkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:40:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34436 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409278AbeKWVkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:40:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so10512568plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6qonCTkzBQK4cOvzBOuh9ggDqkZ8MLO+RjDax7u/Sj0=;
        b=ILpd2c1MfwgVXBMeTLFCl2sLE9dm6mEwsKJy+Z5yyA6BZS1b8Pb7SUk0FIlRMID50P
         e5+N0wM9BNvuBTp3A3k1UlLdTxmov/0TaDdz21kqPcF8SD3wk/3wBp9U1Qv4Z7RzoCVV
         95FNQFOKpE5+9cOlGRmmRq5wa5s85WX1A8lj9zPc0Grkf+HyPJyJ/t8GR4VYlAs/QYJU
         wbxWRq53xGeyihdKa7jiHTWgqTCaQB8/LeG8uuyDZWtmUWmFzACr4pOLsckAcsTfGqSi
         fVD1NcM0vTgjbPp1vKkTADC85r8qobXaPSBHw3xP09/8enpTeXTgoPE6sLKvfLI365AV
         BGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6qonCTkzBQK4cOvzBOuh9ggDqkZ8MLO+RjDax7u/Sj0=;
        b=I+5friu47RMa/ayJhG/6ZwQqMysco3hG6cd+XT79oBJMLMNqV5QemZpjTrg+Bk+Ig4
         qG/rA9axzgG20ounkOyQjuPXGr4FHFPhibS488q41pXjYQSaUJURHBcMpm3LTOX3xfvR
         pwxK6nMovSZ71EnuwwSPhJO83ra9cyX7O1mPI2qAq8+ixxihJ8hZO8nwV0SsDPdLslmV
         1eo9Q6HTfYbkmsC9l1N8iQ2kR5JGlHBADlsq1AzvCbZfVnhxS4VpxxeRlKhvLMu+VvRo
         d52m+UNSo/+qY/I+75S6a2n/wBmfTC4xLYyHIW/LQdBe3jjUmOBv421AWEWWz12K/kDl
         SdZg==
X-Gm-Message-State: AA+aEWbLXkXrqvpNwOsyHPFtdjaHhx1ZPEqKcW/L6FzEm1MI3w0GhZZa
        59ewYBO22RNdtOEnZHd1ygxOXA==
X-Google-Smtp-Source: AFSGD/VPi+VaRiS+VL5iWJpsfsuZqDEDw4i06uYodlC0oszhxBMo5bQEwijTGt2/0E5sEgwPMqblXw==
X-Received: by 2002:a17:902:7e44:: with SMTP id a4mr15166932pln.338.1542970608763;
        Fri, 23 Nov 2018 02:56:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id k15sm7195065pfb.147.2018.11.23.02.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 02:56:47 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5BEA73001AF; Fri, 23 Nov 2018 13:56:44 +0300 (+03)
Date:   Fri, 23 Nov 2018 13:56:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/2] page cache: Store only head pages in i_pages
Message-ID: <20181123105643.fxqk7l57rdurdubx@kshutemo-mobl1>
References: <20181122213224.12793-1-willy@infradead.org>
 <20181122213224.12793-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122213224.12793-3-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:32:24PM -0800, Matthew Wilcox wrote:
> Transparent Huge Pages are currently stored in i_pages as pointers to
> consecutive subpages.  This patch changes that to storing consecutive
> pointers to the head page in preparation for storing huge pages more
> efficiently in i_pages.

I probably miss something, I don't see how it wouldn't break
split_huge_page().

I don't see what would replace head pages in i_pages with
formerly-tail-pages?

Hm?

-- 
 Kirill A. Shutemov
