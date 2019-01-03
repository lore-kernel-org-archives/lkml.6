Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E68C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2D2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qmz/bc6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfACINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:13:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfACINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RurjrjBy7qOyhean6UqRYs1Y65cOy3gjdVkZKnkmc4I=; b=Qmz/bc6U6WTG1lo5t5TSPDM8G
        FhIJjIBoGGa8Ki0H8gbgoPaX0Afl+bdTJBWEBg7ntdT8V3dnkYdeV+S4wzDADC99fyDD1mT6duQX9
        Fv3RJHfqJJYhxRK1ZYi7lG2FksSV50MaWCPENMkaFoSiMsOZC6b9Gqme88/msFr6/cheWUUFpU5n1
        IGmJFrLzLzA+uWrDq6azus3q+zikq+Bgj7NrMu+tQ0/ORolLdJY7Hib2AQcXCaW2fnc052HWRMBIT
        xYsxM+381jp4C/9upvFzxSBXqAUZInwD8qZcr0QJGmRDNt8qT4k27URoyU4ELAWKSXD02sBUqZ9ZH
        MIpUUlr/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gey7u-0001kH-74; Thu, 03 Jan 2019 08:13:14 +0000
Date:   Thu, 3 Jan 2019 00:13:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     huhai <huhai@kylinos.cn>
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuyun01@kylinos.cn
Subject: Re: [PATCH] arm64/lib: add accelerated do_csum for arm64
Message-ID: <20190103081314.GA31320@infradead.org>
References: <20181228073739.13169-1-huhai@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228073739.13169-1-huhai@kylinos.cn>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/arm64/lib/checksum.c b/arch/arm64/lib/checksum.c
> new file mode 100644
> index 000000000000..6931ef13ef87
> --- /dev/null
> +++ b/arch/arm64/lib/checksum.c
> @@ -0,0 +1,144 @@
> +/*
> + * arch/arm64/lib/checksum.c
> + *

No need to mention the file name.  On the other hand it really should
have a SPDX tag, and preferably a copyright notice.
