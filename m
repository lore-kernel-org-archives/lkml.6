Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D113A222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oBL95TvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407492AbfBNPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:15:52 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52095 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404080AbfBNPPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/tB5nLNpanCnlsRpO4c+hlftNaV2fOzM0V9IOQQXhKI=; b=oBL95TvL1HNJhv2ok+EDpHYC6v
        KzHV+/vXm2PtZ+wJnZhhb3/TZS0inerdEs3IQuhwE6zPtVLKIA+G0Dll2kEcqWQrDXp2eRPXE2Xg+
        I9vKxIyau49kBtM0maOw8QLexJm+47G0bWt+1Z03EZ67xnRkYaJnehkBH2UCMHCRmVV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guIjk-0002zL-3N; Thu, 14 Feb 2019 16:15:40 +0100
Date:   Thu, 14 Feb 2019 16:15:40 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christophe ROULLIER <christophe.roullier@st.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Peppe CAVALLARO <peppe.cavallaro@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 2/8] net: ethernet: stmmac: update to support all PHY
 config for stm32mp157c.
Message-ID: <20190214151540.GG708@lunn.ch>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-3-git-send-email-christophe.roullier@st.com>
 <20190214134040.GA5699@lunn.ch>
 <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02cd7773-899f-b28a-ff61-849b17cbe82d@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I've misunderstood your question ;-)
> 
> And you spoke about :
> 
> case PHY_INTERFACE_MODE_RGMII:
> case PHY_INTERFACE_MODE_RGMII_ID:
> case PHY_INTERFACE_MODE_RGMII_RXID:
> case PHY_INTERFACE_MODE_RGMII_TXID:
> 
> So in my setup I've only RGMII interface, so I've never tested 3 others 
> interfaces (_ID, _RXID, _TXID).
> 
> So do I need to add cases in my driver ?

Yes. They all indicate the MAC should be using RGMII.

This appears to be an old issue, but now would be a good time to fix
it.

     Andrew
