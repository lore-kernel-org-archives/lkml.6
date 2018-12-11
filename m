Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923372082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kJGKA+kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923372082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeLKN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:58:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49936 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeLKN6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:58:39 -0500
Received: from zn.tnic (p200300EC2BCD2B00BD72DD1FE93D9839.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:bd72:dd1f:e93d:9839])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B3191EC0946;
        Tue, 11 Dec 2018 14:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544536717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=goJssSLCimgqFCRCgvF9SpXpez3VqFgvaSE/3l3Zy8w=;
        b=kJGKA+kn7nBhZr3HsUTXX4iD6eg1XhEjevgD0dnc1oMKEkAVlZSVjoEkwy2uHcXfm13hur
        tMzUtMHuVxKQ1V9ii488ISeNbPH6nXRBi5AC2w9bEcYWQv4vSqRZlR3xuXR5VEM5y8KqfI
        rMqvukm7IXbB5ta4asjRmbSN+0P5AAI=
Date:   Tue, 11 Dec 2018 14:58:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH -next] i5000_edac: remove set but not used variables
 'maxdimmperch, maxch, channel_count'
Message-ID: <20181211135829.GF27375@zn.tnic>
References: <20181211095207.25936-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211095207.25936-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:52:07PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/edac/i5000_edac.c: In function 'i5000_get_mc_regs':
> drivers/edac/i5000_edac.c:1138:6: warning:
>  variable 'maxdimmperch' set but not used [-Wunused-but-set-variable]
> 
> drivers/edac/i5000_edac.c:1137:6: warning:
>  variable 'maxch' set but not used [-Wunused-but-set-variable]
> 
> drivers/edac/i5000_edac.c: In function 'i5000_init_csrows':
> drivers/edac/i5000_edac.c:1256:13: warning:
>  variable 'channel_count' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in
> commit eb60705ac5a9 ("drivers/edac: new intel 5000 MC driver")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/edac/i5000_edac.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
