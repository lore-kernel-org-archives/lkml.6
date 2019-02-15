Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E2AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA75A218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="38dXmw7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395043AbfBOOFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:05:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53723 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390795AbfBOOFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=thdUPo4zX9wl0DMrtO2WDehLw6+GetMtGuwsHb4zQM8=; b=38dXmw7AxPsmuDYVJH8wtdqfGv
        G+fWhxYgcNyGBIprhhO/C7M+nEqikHEUMYHIPZWZRaESRruxHWgcBXNgIeoySa9raXDooAvCHvC2i
        Ul/6+Aylwo0eRwvr76p+Ev/Ue7DbX3zHfGS+v3IoxKTnPyiF6bq3VO0xaU6NibC8DhiA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gue7F-0005oa-IC; Fri, 15 Feb 2019 15:05:21 +0100
Date:   Fri, 15 Feb 2019 15:05:21 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rundong Ge <rdong.ge@gmail.com>
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Implement flow_dissect callback for tag_dsa.
Message-ID: <20190215140521.GK5699@lunn.ch>
References: <20190215082253.2682-1-rdong.ge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215082253.2682-1-rdong.ge@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:22:53AM +0000, Rundong Ge wrote:
> RPS not work for DSA devices since the 'skb_get_hash'
> will always get the invalid hash for dsa tagged packets.
> 
> "[PATCH] tag_mtk: add flow_dissect callback to the ops struct"
> introduced the flow_dissect callback to get the right hash for
> MTK tagged packet. And tag_dsa also needs to implement
> the callback.

Hi Rundong

This looks good. Do you have any sort of numbers to show the
performance improvements?

Could you make a similar change to tag_edsa.c? It uses an 8 byte
header.

Thanks
	Andrew
