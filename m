Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E77CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B735220880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fiEYVbYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B735220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH2CAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:00:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ykauCEnmgHn9V7h6zt9X7VR9etLxJIaA2xor1W/yVZM=; b=fiEYVbYQcPWVE6emWOUdF1k4r
        v41frzLJYBb34LdLPaO5ksq7x0f4T1styUXZeWORpqar3IT8lVjDO/lYmCIVmEe9+SjaM+ST7R9RX
        T/+VHTiBjhb0/T1PkgpC7hMFPKmrE68MsJwSw6sOa7baJ22dFlAXxN8cBJYdjCVB9zm/fe6xtl+iB
        QfMVrxcTCHoJVU1YB9KLCVVD2EIuClTm5on1wVEn1IThQX92fRCA7a6MxV/86tQGEhzd5ZH7AdU1+
        wcdQk4o/SxiOjkgqhxBU5aBVcgztgrjSXlcQVG/7oKkJpFE1/xHhWW+TmeP4Qt67KP9JU9MftD0+e
        3/0K+vw7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fum7v-0007V6-7L; Tue, 28 Aug 2018 22:06:19 +0000
Date:   Tue, 28 Aug 2018 15:06:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, corbet@lwn.net,
        akpm@linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document/gpu: Use new vm_fault_t type
Message-ID: <20180828220618.GB11400@bombadil.infradead.org>
References: <20180828171443.GA3854@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828171443.GA3854@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:44:43PM +0530, Souptick Joarder wrote:
> We have introduce a new return type vm_fault_t for
> fault handler. Update the document for the same.

Have you built the documentation and checked the html looks better with
the changed spacing?  rst can be a bit weird about some of these things.

