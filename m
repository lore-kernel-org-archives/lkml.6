Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B715C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E32082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4tgzcGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9E32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJXTk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:40:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXTkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FIlT2ouWp3MJLZFjIEaFAeoB/l+nYuXc7ChT4BCumck=; b=p4tgzcGr2hJGmaSo+kf4ii4uK
        vd9YJHl4PGvU4XNbNUMwK1Rc49hQnfnQJK5anQT+cQOoycYoSc5kthf851MaEHM9YQjIJFcYb3ab+
        FhTruLAP0dsBVK9tg73W2C2HFPtnbRrtCeHhLXFxWyjKO/8XlZiATe9sLchpYhMXZudxAHkQ07MI+
        hjcr///9az+1kWcVAlylDGt9lvZheT5lNqqYdcKkR0G+BDDqlSkq0aSd1+itKsFpaBvhnz1E9Tk43
        xrvcy1K8T9Te8iaac3QOD8MkcH+Kgc5iEDq16OiUneHFrTizsXwphcWkJ8GYZq/hJ3UYfnTRuKSHT
        1puq6oaMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFH5O-0004CJ-65; Wed, 24 Oct 2018 11:12:26 +0000
Date:   Wed, 24 Oct 2018 04:12:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/ldt: Unmap PTEs for the slow before freeing LDT
Message-ID: <20181024111225.GA5807@infradead.org>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
 <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line does not parse..
