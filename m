Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A44C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3055E20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ReOfllBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3055E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbeGXH7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:59:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wzFYLLIK20uwzQlvnCvMmcl3H+ef47eCkKr5jtAVOFw=; b=ReOfllBkYYCLRenJoa0vZgXYr
        4xwjV168gpZqyTrfouKFy8AsLQeiSDRGb5V8vyA/C1R4pTaqDBWwVABcQk0HYfwS77CUkrGiZc5ST
        ylS85VzfjqsJAlZjI9pi7EE+O8BMrvWOcHjkMD2KqRltB+1M1wAZA85d63WJ1TsMsQBVvgmkccVVJ
        csJr/HufMKBwN/eRZ7aZuFI8qkDxRNnMz64rjLfTiviyz8uIvw/9dbjKi81OiDN98NeZq0T03662L
        wVe5DuckFBgCSCcQwXmeiN7bKSmiyiBoprFjuRiIEDZ+U8Ji6Er1eB+yyI52+AGNTuwNxu+W2MPyD
        zxsh9r96g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhrD4-0007I6-T9; Tue, 24 Jul 2018 06:54:14 +0000
Date:   Mon, 23 Jul 2018 23:54:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180724065414.GA27298@infradead.org>
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724001310.7671.41243.stgit@gimli.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As all NVMe devices make use of this standard interface and the NVMe
> specification also requires PCIe FLR support, we can apply this quirk
> to all devices with matching class code.

But not all NVMe devices require this quirk.  So please only quirk
devices that actually require it.
