Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8446AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433F020834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="U2PN8Wzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nK5yQpHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433F020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbeK2XhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:37:01 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59683 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbeK2XhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:37:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 51ECE2236B;
        Thu, 29 Nov 2018 07:31:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Nov 2018 07:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=q+/tkUZiL962Qa7ZJ48EJcQYGdD
        jLTeI4EFXp9QH1GI=; b=U2PN8WzgAGadKg1Rhqkym7WN9HbTa0GCxiQcCvs0Jkh
        X0Qp85aJKRwtHhSvq8JvzMy/AJJn5bj64zME2COx9zohqllRIvpCl2AVWeIGKTeD
        nI1kbdP7nzUfArUC3geAvkaBMOZS8Glly8d8KdCqqbGAPyIoaPQOWxijbZIoEupM
        uoKnaEpfhdLm+MwRB4AZ8kMZdXZkJJHcuWSOiMEYPEiWLrW5NEeRV8nebW1y/XSd
        1RM2BCjD5/HYIEtKuZ60/Yf4gedddZliehg7523X2sfpjhl/4uq3gMzJAYbUes1Q
        qpjeDKykU6D6OG6C6iontUFHQojtRFkclMvN2K8mk1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=q+/tkU
        ZiL962Qa7ZJ48EJcQYGdDjLTeI4EFXp9QH1GI=; b=nK5yQpHYjWYUUDhWKNFCYL
        Oxz2Gk2uT5mY3WtJGMpArlhXwzFclnREmdBkm8zEICj7SXC49NqCwlZ+L8MjmRo+
        ObwNFfQQauvlDX6uaV9uBy5Rxlq0ERkeWeOruStVOU5rHMci0dLdW8C72Tce3ZEQ
        CykIxKSgUFewo/P64kN4v6ss37fb6ehC9V6xNUugr2bGtQPrgUOj1QTyMkPHw/0l
        SC51iMYzLI/jQlCgG4TdV4gKhQd3pYm9uDhl5MhG6MptcKHtIk1zyDPf2VWRMtjI
        Ay9s2YDqZT83tRbVmGYYNrJ+M3Mi3XqIcIxRvRd63QRUnheqnmtXr4TWQj1MIzlQ
        ==
X-ME-Sender: <xms:Mtz_W2_Y2Vb7njETJB0JMmD0sjG9A3iBq_dVkP3EtyjdXOgtuc74iQ>
X-ME-Proxy: <xmx:Mtz_W34q3-43cUrRdFUan8nasEJcUrz-e5CWuEBEU6Xzq8FeENm_0g>
    <xmx:Mtz_W1mZyRdiwjmFLpudeQ9KkvznAT4LRMbBV0DCSBJ9J5M-X6Xhfw>
    <xmx:Mtz_W-bVLcADts1NrjOYeFj650OByPpSLmWNgeMIJ7k4Dmt2UkES_A>
    <xmx:Mtz_W0qvGnO3FtGUpYhDUfX4M6vMRFMboSiZDvcdPt7fv5B0l_MPhA>
    <xmx:Mtz_Wwf7M0SXpnIAq9DHx9UvvSknQ2aBndhdtq08MrdcR-bw6xrbRQ>
    <xmx:M9z_W-Vlx74rBquoxwpFoKn5DiV6L5v5Cmxl0HUXG-D_4e4W1-VQIw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B1D21040B;
        Thu, 29 Nov 2018 07:31:46 -0500 (EST)
Date:   Thu, 29 Nov 2018 13:31:45 +0100
From:   Greg KH <greg@kroah.com>
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181129123145.GG3149@kroah.com>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
 <20181108001751.GA8097@sasha-vm>
 <20181108110127.GA8415@harukaze>
 <20181108154904.GD8097@sasha-vm>
 <20181109113159.GA22785@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109113159.GA22785@harukaze>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 12:31:59PM +0100, Paolo Pisati wrote:
> On Thu, Nov 08, 2018 at 10:49:04AM -0500, Sasha Levin wrote:
> > 
> > Can you confirm it actually works on 4.4?
> 
> Yes, built and tested on 4.4.y:
> 
> Tested-by: Paolo Pisati <p.pisati@gmail.com>

Now queued up, thanks.

greg k-h
