Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAC20645
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvYLGFVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADAC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeK2LTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:19:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2LTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/tLFbISmxWBmC3TgjCp1z4n+RwvtnNEvvGnjho+0Ky8=; b=YvYLGFVllIpSh8tptrBpv+n4d
        aFFJ8e+s5IUrnfgzM01lEgLgq+O8vtDmwxPjMbsP6eDtd1E7VeKZt9H3POmVMTd9Z2qxJ7TXKQaMT
        9phUls7UPhKCn2bBxtCRs2PBnzW+AZtlvzVRkxmRS5sCNAo4D6+Z6HN5M87DLZX/sJiSDSVCzfvZT
        38WoWEDXXbgT+NSDJjQB6VHR+UUArOwaaV3bcHOD/2IoYUr4JdO6JzyZO/5CUgWOhIEwK9gDH/CuD
        dC6rC6p7UdcwCL2tqVeZqoL4W2/Dg5aORi083a8Ih721QO2dkcGviVSu1oqyBDMBVlX5fu9DZJN2C
        Uy+JJbO0A==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gS9zS-0004If-KS; Thu, 29 Nov 2018 00:15:34 +0000
Date:   Wed, 28 Nov 2018 16:15:33 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Mark expected switch
 fall-throughs
Message-ID: <20181129001533.GA2468@fedora.eng.vmware.com>
References: <20180705203807.GA10327@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705203807.GA10327@embeddedor.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:38:07PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I've applied this patch, but not the acer or sony fall through patches
due to the pending questions there. Happy to revisit those as needed,
but closing these out of the patch queue.

> ---
>  drivers/platform/x86/dell-laptop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index f1fa861..1938f11 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -1565,8 +1565,10 @@ static ssize_t kbd_led_timeout_store(struct device *dev,
>  		switch (unit) {
>  		case KBD_TIMEOUT_DAYS:
>  			value *= 24;
> +			/* fall through */
>  		case KBD_TIMEOUT_HOURS:
>  			value *= 60;
> +			/* fall through */
>  		case KBD_TIMEOUT_MINUTES:
>  			value *= 60;
>  			unit = KBD_TIMEOUT_SECONDS;
> -- 
> 2.7.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
