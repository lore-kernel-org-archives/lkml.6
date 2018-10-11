Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15302098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sAMMTo4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15302098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeJKXfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:35:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54660 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJKXfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:35:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BG7l6w062955;
        Thu, 11 Oct 2018 11:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539274067;
        bh=soCZcXWAQ+ioM7HzQ/67P/SIFq2VrGUw4mMHbwgjMQ4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sAMMTo4CTfzkca2NBu+5sqFra49n/VFbf9980yC+tirRrW1S9HHekobkjLRQ226Oz
         Gppp98N1oR+CRR8ta2DE8DfqBadU8wOM2qqXbITf+G4mhNokVozdyaDcOerfj1UlLY
         ukQxQl1FBgUTTV2pUK45GRaVJOE6ZL+GtCSA8CYc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BG7lYJ015334;
        Thu, 11 Oct 2018 11:07:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 11:07:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 11:07:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BG7k4d020445;
        Thu, 11 Oct 2018 11:07:46 -0500
Date:   Thu, 11 Oct 2018 11:07:46 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
CC:     <laurent.pinchart@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <stern@rowland.harvard.edu>, <rogerq@ti.com>
Subject: Re: [PATCH 5/6] usb: musb: gadget: implement send_response
Message-ID: <20181011160746.GA8763@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
 <20181010024903.1633-6-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181010024903.1633-6-paul.elder@ideasonboard.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 09, 2018 at 10:49:02PM -0400, Paul Elder wrote:
> This patch implements a mechanism to signal the MUSB driver to reply to
> a control OUT request with STALL or ACK.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The patch looks good to me, here is my Acked-by:

Acked-by: Bin Liu <b-liu@ti.com>

but I am unable to test this patch set - the current Greg's usb-next
tree gives deadlock error between composite_disconnect() and
usb_function_deactivate() when loading g_webcam.ko on BeagleboneBlack.
The error happens before applying this patch set.

Regards,
-Bin.
