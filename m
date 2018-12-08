Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E1DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7A320892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544239533;
	bh=9CL3+NIgUCLEWzVfWvxiWpfYi6dy7IyGUrgBpxtXApc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFNlqPr41cX2zsJLn8hKWRRRZqebZIoY6GryD/dvWqzAwowDjNU88ULo6aJpnZ66H
	 kCfhqxL782j+3Hqcf3lNXhW73OYrS9sQAl6wcb50fYekAT/dgw4UrkQI//VvWnIvcy
	 S0kdE5QbLzgphaFZkf0cLgEyjOOA6NkDDavkO7Xc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7A320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLHDZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeLHDZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 22:25:32 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA3520837;
        Sat,  8 Dec 2018 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544239531;
        bh=9CL3+NIgUCLEWzVfWvxiWpfYi6dy7IyGUrgBpxtXApc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReWlemMV7xomzTAg0x/FoGGJNCKnXDx1tctmSGxtGDZl1VkTXD9B9BEbzXo4A3IB1
         iOUXdMfd0uENGDZu7LDjZh8iVj87JQAGiC2BSj9KDXbzjHxMIqzhljJm4CYi48oiO/
         baz2UNkhjYd0mjV0PE858IKdDEzHtNl9TmeBUC+k=
Date:   Sat, 8 Dec 2018 11:24:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Chris.Healy@zii.aero,
        festevam@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
Message-ID: <20181208032444.GP3987@dragon>
References: <20181204151702.8514-1-jonathan@marek.ca>
 <20181204151702.8514-4-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204151702.8514-4-jonathan@marek.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:17:00AM -0500, Jonathan Marek wrote:
> This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
> supported by the freedreno driver.
> 
> The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
> driver to identify the smaller 128KiB GMEM size.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Applied, thanks.
