Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6025520866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lt13RW8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfAOQ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:26:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfAOQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:26:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FGQ4LR058165;
        Tue, 15 Jan 2019 10:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547569564;
        bh=aGKAIOOspV5b57P8sz9CvB1lNOOF6ep691VE0vQeQy0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Lt13RW8YTp4QjKdHpWOXEY9sX3xFa4oxqQT4LX6+ybM+pw2oU1yWVp25MAsSngaFZ
         69DlezvCbcGeDoxdHrnj3mJow8roEJVN33ZhemkI6Qj/RYCNa6/TCVE05dx6jtecOX
         21G4yvmKqoy6N5iLJZwz1hkI90Qe7AncPz3GQVcE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FGQ4a6078537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 10:26:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 10:26:03 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 10:26:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FGQ3LR000947;
        Tue, 15 Jan 2019 10:26:03 -0600
Date:   Tue, 15 Jan 2019 10:26:03 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] usb: musb: Kconfig: Drop dependency on
 MACH_JZ4740 for jz4740
Message-ID: <20190115162603.GB18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190110133700.4471-1-paul@crapouillou.net>
 <20190110133700.4471-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110133700.4471-3-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Jan 10, 2019 at 10:36:59AM -0300, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that

Again, did you mean MACH_JZ4740 instead?

> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> v2: Remove info about adding COMPILE_TEST in commit message, as it was
>     there before
> 
>  drivers/usb/musb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index ad08895e78f9..6f5b0ed6a507 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -111,7 +111,7 @@ config USB_MUSB_UX500
>  config USB_MUSB_JZ4740
>  	tristate "JZ4740"
>  	depends on NOP_USB_XCEIV
> -	depends on MACH_JZ4740 || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
>  	depends on USB_MUSB_GADGET
>  	depends on USB_OTG_BLACKLIST_HUB
  
Regards,
-Bin.
