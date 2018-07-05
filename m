Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618B424003
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HdHD/xX0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnSkkfP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B424003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbeGERFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:05:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59091 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753549AbeGERFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:05:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C2211219FE;
        Thu,  5 Jul 2018 13:05:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 05 Jul 2018 13:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=q27Jas3YBzyqTsPfykDbGtyMvHBPa2puR7BLeZIrw0A=; b=HdHD/xX0
        NeYfoBio19bXqu1ocUXKFtAgyeNtnBmCQ5bUl6fcxAyX10sphEGfjZMb3u6+rzse
        1U2X8jRWAN5kZiDSxCTHL57IVZRj+i8Mvk2FOJrwAAoUbz63y/v6PfZViI+ODS+J
        bGExmtOIwSXZvohZzWabWLfnZdjMfHW0RBqlXFWDwaaJNZCO8nJgJzwcgRhHcwHN
        gTMtrt5gJ/Ec2E3zr7/WEcOqjpFDAGKo/56HJWXtdIXPACAQzZRvLvLJAUUnhNWG
        OfCMjra28N0dUojw/8pIdQ/F/RbLvwqgiJbHiC30NcTZo2ntR2YGWNtsYWOMatcU
        TCB0ILlAu0/Ubw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=q27Jas3YBzyqTsPfykDbGtyMvHBPa
        2puR7BLeZIrw0A=; b=BnSkkfP//kyEeG3GxQbwt+8qC5zOpJe/QiucZTT3+3BzN
        HdmeQWSedfGo44MSYNuN9ZNjk6Yhmd+8JyQiOOQDKKE9dbnz8j8rCKs6irSQLGOA
        MF+2zGWKTF4z6ffcja81xD5TOaMN4IccrPN9nKchLn7ae/e8hcLjq+tFy3yWv9V+
        WKR9EBguPrFejdKxsACuxiyG8u2k5mXE3EcGZY7gzETaMtv/TcTZdYcvuMEfZACB
        rs2sPn9ZbwgFdemf0Toxp7vOH6ytdLRdP1P8TlDy1Zp0HoDZ83B1eLuGtK0xaa6v
        AuJHF9WcBubNdKl1gIuQM/QWOhiuAC5O3Fvn3zz4Q==
X-ME-Proxy: <xmx:708-W-9ylXoi8Z-aqsjnZX2upqAQUKckiaFI_Vw_GaE8BNijvicoFQ>
    <xmx:708-W7YYDM_D08Ann6bbW04unfxM9NKzd3w1-3f69TiJdVi8UmYHiw>
    <xmx:708-W5BTGXEcZGvh6SUVYyK7d1bwthIIp2oPj4fLX0UhBdn6PPUW2Q>
    <xmx:708-W1TIsP7KavwnLg4MOcROAVM5lCicZpQSRJjGPBuZa5JSr8NQWQ>
    <xmx:708-W0trjwOrYyi_evdsgaN1B-IyenNM2Eh20979MGkwtvJeeAV9vA>
    <xmx:708-W7fvdJuxrUnxzTpZfdfzzHyyx8YOkHS20girGdEvGitICBJ1jQ>
X-ME-Sender: <xms:708-W8ePOSWJ_yuno8zOj4NhwTQ_A8qcvKRuOIu-HvK7FvTCcSV5NA>
Received: from localhost (d57d388d.static.ziggozakelijk.nl [213.125.56.141])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02B3810262;
        Thu,  5 Jul 2018 13:05:50 -0400 (EDT)
Date:   Thu, 5 Jul 2018 19:05:49 +0200
From:   Greg KH <greg@kroah.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     stable@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0
Message-ID: <20180705170549.GF4349@kroah.com>
References: <1528188743-12798-1-git-send-email-narmstrong@baylibre.com>
 <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817c589d-25e4-e2d0-cd46-99a2ae59b014@baylibre.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 10:43:19AM +0200, Neil Armstrong wrote:
> Hi Stable Maintainers,
> 
> On 05/06/2018 10:52, Neil Armstrong wrote:
> > Like LibreTech-CC, the USB0 needs the 5V regulator to be enabled to power the
> > devices on the P212 Reference Design based boards.
> > 
> > Fixes: b9f07cb4f41f ("ARM64: dts: meson-gxl-s905x-p212: enable the USB controller")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> 
> This commit hit Linus master with commit sha d511b3e4087eedbe11c7496c396432b8b7c2d7d9
> Can this fix be applied to 4.17 stable kernel ?

Now applied, thanks.

greg k-h
