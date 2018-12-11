Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEEDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932882081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7msB7Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932882081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeLKRJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:09:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeLKRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4imnxSX0jp5IGq7MM2uR8TlexlBqxE/SpFdHiSf0ZAw=; b=o7msB7Cj5eOUREjfYNKRf2xl1
        fkSSc4e9rjPOG6cEazGNlBnEysiGnHzUn9vPYJ7SLz89GvfRIs2fyOeyEEFkrf/9jSkjekIMUb8wV
        L4hqMo6LyjV2x4zCc/Q7Dd+BL5XT7v/DRKRxxLsTuRiuHeFhaA3pVuh5A1z36P4Vhyd6/Jfxq5j+u
        qM8I9JTcaty/K+meJE8iSa6pKZSf+SyVJGzflCUA90n70Vg+tAq81S3+uMgtmRY6bMC6QzBua2BkC
        QLbt1suFkn1svEEHABYCo1Y7RNYYGqGhTd+6d0pcBwoQH4bknmBpu83LwnI2Drnqobby9G6vI6A7T
        tlE4n8FSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWlXh-0000dE-OQ; Tue, 11 Dec 2018 17:09:57 +0000
Date:   Tue, 11 Dec 2018 09:09:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Message-ID: <20181211170957.GA335@infradead.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210181315.5023-2-okaya@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> out calls that depend on PCI.

I think you want to skip building at least all of hwpci.c if CONFIG_PCI
is disabled.  Or replace that whole stiking pile of crap with something
resembling C code..
