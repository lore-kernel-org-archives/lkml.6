Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADF7222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aF6g2rI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfBLTsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:48:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42010 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBLTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:48:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1CJlsKN109549;
        Tue, 12 Feb 2019 13:47:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550000875;
        bh=lGT3oTNW3AknUQjTZqvPbt5L+TaKUoEKiRJzndyCRpQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aF6g2rI3gKjWVs4If+fM7wStQ5rz6FNZQ3YwYZR3BTVHlaRdMMeVQorfS2pZdKt5E
         QO7WaCgQAMKfds19matrhFpTzFDXfUeLTBMQ1WUIkRhGVkM8qp5PRcsGsTUrglcQbk
         qe92eJQaTS1SQaZF2O0sDVXAbHQ21JvadzDoa0Lw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1CJlsLr102609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 13:47:54 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 13:47:54 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 13:47:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1CJls2X006249;
        Tue, 12 Feb 2019 13:47:54 -0600
Date:   Tue, 12 Feb 2019 13:47:54 -0600
From:   Bin Liu <b-liu@ti.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] USB: musb: mark expected switch fall-through
Message-ID: <20190212194754.GA28664@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190212192357.GA15275@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212192357.GA15275@embeddedor>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Feb 12, 2019 at 01:23:57PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/usb/musb/musb_host.c: In function ‘musb_advance_schedule’:
> drivers/usb/musb/musb_host.c:374:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (qh->mux == 1) {
>        ^
> drivers/usb/musb/musb_host.c:383:3: note: here
>    case USB_ENDPOINT_XFER_ISOC:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I've closed my musb tree for v5.1-rc1, if you want to directly pick this
patch, here is my Acked-by, or I will take it for v5.2-rc1.

Acked-by: Bin Liu <b-liu@ti.com>

> ---
>  drivers/usb/musb/musb_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index b59ce9ad14ce..0566d5b6252e 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -378,7 +378,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
>  				qh = first_qh(head);
>  				break;
>  			}
> -			/* else: fall through */
> +			/* fall through */
>  
>  		case USB_ENDPOINT_XFER_ISOC:
>  		case USB_ENDPOINT_XFER_INT:
> -- 
> 2.20.1

Regards,
-Bin.
