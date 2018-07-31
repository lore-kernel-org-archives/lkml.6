Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A4208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbYIxVjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2A4208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeGaNod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:44:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731272AbeGaNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=35UC22Qf1bVFqde/kuy9JANvy0ja3rv6CmjqXcPL7Nk=; b=cbYIxVjzICmQjSqef3G/5f2dh
        wUfL7NhF3MjG1zFVnrBAjEAGVbB+0LucXv7rJuwtI+xClIn0LhrvZFOPofpdnXIlBF0xil/+8gFXb
        t3R+JzTBrj+oDZf8AtiTiLz093eqO4XTkxtHz4++Liofo6wqrUg8NmW4Ur0+5TrZlrEUZJ2a8feV5
        P7D/UMZm+53MuOKXP1xC5CWy7DdQIk0bJNLbEmbNJWln2M3wbTtDDIVIrZxOIyJYFnTuB7i+8Mys3
        aCRYYaunwLF0e1NmAS/tkTXgXIvXQ0gkw+3uTJyQqk2o/48O9GFebhCYlfJ3Y5kDJc5jxm3oX/R5M
        4Ryiuf5tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkTO8-0001zI-90; Tue, 31 Jul 2018 12:04:28 +0000
Date:   Tue, 31 Jul 2018 05:04:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
Message-ID: <20180731120428.GA5696@infradead.org>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730225035.28365-6-acolin@isi.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index afe350e5e3d9..602a61324890 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/rapidio/Kconfig"

Please include this from drivers/Kconfig instead of enabling it
for a completely random set of architectures.
