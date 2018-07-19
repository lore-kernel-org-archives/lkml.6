Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6B205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NB7ZxnPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbeGSQUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:20:53 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34216 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbeGSQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:20:52 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6JFb7ua099312;
        Thu, 19 Jul 2018 10:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532014627;
        bh=qLs5H+V5lzXJqHTDURgJR5YjnJ/WqxI/TVZ18ZhX9VM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NB7ZxnPjkQsf7AV1nl0Gy5Iulzk+FPVtyphkoMjpqy5vRcJlD9BoadOxIi1W8FLAT
         VmP/EJsCI0J6hWdkh6F+k4ATxh4rxf4bFk5W9iTwOgMbOfnmwg9oGCe38396uKwgkh
         m0ZBRKdFLqT8qcuX9tQ+4We6XZ513TTPSdTWZ5Dc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JFb77h026955;
        Thu, 19 Jul 2018 10:37:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 19
 Jul 2018 10:37:06 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 19 Jul 2018 10:37:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6JFb6Tl025937;
        Thu, 19 Jul 2018 10:37:06 -0500
Date:   Thu, 19 Jul 2018 10:37:06 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Call musb_platform_exit from musb_stop
Message-ID: <20180719153706.GD3949@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719101038.9465-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180719101038.9465-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 19, 2018 at 03:40:38PM +0530, Jagan Teki wrote:
> musb stop is musb core call during unregister or shutting down
> gadget or host musb. For graceful exit add musb_platform_exit
> on musb_stop so-that it can exit the musb platform driver as well.

Thanks for the patch. but musb_stop() is called in the .udc_stop() and
host .stop() hooks, which can stop (and restart) at any time by the udc
or host core, not really during unregister. musb_platform_init() is not
called in .udc_start() and .start() hooks, so we shouldn't add
musb_platform_exit() in musb_stop().

Regards,
-Bin.
