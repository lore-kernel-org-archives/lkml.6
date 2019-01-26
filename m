Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBCC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D3D2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoTxH4pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfAZUoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:44:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfAZUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HMKgGbqmE4LrfHKnxsFRtesDePD6A4/CfGBReS5ONbY=; b=GoTxH4pTGeAuvuGyygmm015Wl
        Csekj4MC2dXYRTRcuU22qSCq4TqHMXcTlMlBBOMqmwVZ2xc7mEAY5XyjBxh5Dn5zVRZdUwSQjjpla
        Dzv2YTvfJPT+vzG0zPo8YMeUp44Y2upUUIjqzHo6jRR9s8/8DsCsYrWaB5Oay1jy2P87koP4aGhjC
        49PDizhC8/c14h9Qsov6soQi6iVWf8aqQI6sDtk1pin6iSU2htVy31LfTOYXgtUOZfRYSnsbOD9M4
        vbZYBSRNNl/+7znyKHrM4V/6ADHbsGiVqjdou8sc58TtPnrnbinHdsT71LsVxKB/6IpzeVboP+EGz
        D1UvFrzdQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnUo2-00034Q-DB; Sat, 26 Jan 2019 20:43:58 +0000
Date:   Sat, 26 Jan 2019 12:43:55 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: wmi: fix potential null pointer
 dereferences
Message-ID: <20190126204355.GA13882@wrath>
References: <20190122200302.19861-1-2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122200302.19861-1-2pi@mok.nu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:03:01PM +0100, Mattias Jacobsson wrote:
> In the function wmi_dev_match() there are three variables that
> potentially can result in a null pointer dereference. Namely:

Is this something you have observed? This gets called when a new driver
registered for each unassociated device on the bus, so I'm not
immediately seeing how dev or driver would end up being NULL here.

See: Documentation/driver-model/bus.txt

-- 
Darren Hart
VMware Open Source Technology Center
