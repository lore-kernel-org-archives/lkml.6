Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22DC2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfB0Sik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:38:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0Sij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:38:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 157C214010634;
        Wed, 27 Feb 2019 10:38:38 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:38:37 -0800 (PST)
Message-Id: <20190227.103837.668255833945043179.davem@davemloft.net>
To:     steven.price@arm.com
Cc:     linux-mm@kvack.org, luto@kernel.org, ard.biesheuvel@linaro.org,
        arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, mingo@redhat.com, james.morse@arm.com,
        jglisse@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will.deacon@arm.com, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark.Rutland@arm.com, kan.liang@linux.intel.com,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 20/34] sparc: mm: Add p?d_large() definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190227170608.27963-21-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
        <20190227170608.27963-21-steven.price@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Feb 2019 10:38:38 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:54 +0000

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For sparc, we don't support large pages, so add stubs returning 0.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Sparc does support large pages on 64-bit, just not at this level.  It
would be nice if the commit message was made more accurate.  Other than
that:

Acked-by: David S. Miller <davem@davemloft.net>
