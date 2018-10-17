Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A775ECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD470208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KI3uKj3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD470208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJRHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:40:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41470 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeJRHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:40:26 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6450B113F;
        Thu, 18 Oct 2018 01:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539819739;
        bh=zY3LNPcRV+PrbhusAwTJIRfdZxqO6BpcyK/ef7xTL2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KI3uKj3dtUDuRqs7J5KcDMKJNl/Pt9REA02BYoTkdjtrl1C/BBouASfdEsjw1nKH3
         hqlJ1litkxqjq3TIiWndAztrhbvzrjk5efyT2To85iN6e8EuLWhez+CaxNDZG2MlwO
         n9EihkHZfx9QdIMu3sw8tcPKyyHy8ToSRlBdIWi4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bin Liu <b-liu@ti.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com
Subject: Re: [PATCH 0/6] usb: gadget: add mechanism to asynchronously validate data stage of ctrl out request
Date:   Thu, 18 Oct 2018 02:42:29 +0300
Message-ID: <1944130.9sTDClXDAS@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181011193142.GC8763@uda0271908>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com> <20181011193142.GC8763@uda0271908>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Thursday, 11 October 2018 22:31:42 EEST Bin Liu wrote:
> On Tue, Oct 09, 2018 at 10:48:57PM -0400, Paul Elder wrote:
> > This patch series adds a mechanism to allow asynchronously validating
> > the data stage of a control out request, and for stalling or suceeding
> > the request accordingly. This mechanism is implemented for MUSB, and is
> > used by UVC. At the same time, UVC packages the setup stage and data
> 
> Why is this for MUSB only? Other UDC such as DWC3 doesn't need this?

Unfortunately, the asynchronous control request data stage validation 
mechanism must be implemented by every UDC. This patch series only addresses 
MUSB as this is Paul's main test platform. Once the core patches get reviewed 
and the API accepted (possibly in a modified form), we plan to update the DWC2 
and DWC3.

-- 
Regards,

Laurent Pinchart



