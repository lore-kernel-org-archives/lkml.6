Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D13EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD46E2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="plmStVxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD46E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeKETs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:48:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:57804 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKETs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:48:58 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25A90562;
        Mon,  5 Nov 2018 11:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541413795;
        bh=wJRSZv4ADH8ew7ojXWqxYKyyJTdF9BL4Dy20G5Y0Vk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plmStVxZrWgpCgkC9ABj494FPD4Lt84Rz4dEP3HATB0wj/SShATSeYlXWRS4qOO/G
         pc/lA9BjkdL1cxjz4twVfAS9UV/tAL1MjzORAUBpv6MpEk2Wylwl1rVqqFjKvX7o12
         +6IXL8mUuxYg/Jj2CkJnMBWfmKY+5jaBRMiJufrk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>
Subject: Re: [PATCH v6 0/6] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Mon, 05 Nov 2018 12:30:05 +0200
Message-ID: <3056496.a8qoricJmv@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
References: <1539034953-11274-1-git-send-email-dkos@cadence.com> <CY1PR0701MB166434BBB71DB76593E0F513CDCA0@CY1PR0701MB1664.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damian,

On Monday, 5 November 2018 11:44:53 EET Damian Kos wrote:
> Hi Guys,
> 
> I'm wondering if this time patch is so good that there're no change
> requests, or is it so bad that it was rejected without a comment : )
> Please let me know if this patch is being in review or was rejected and, if
> so, what needs to be changed. 

I unfortunately don't have time to review your series for the time being. 
Hopefully someone else will have a better review bandwidth :-) Sorry about 
that.

-- 
Regards,

Laurent Pinchart



