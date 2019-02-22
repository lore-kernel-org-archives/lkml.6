Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723C72075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W381hE87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfBVOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:36:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34698 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBVOg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HM9ZRXd7L+jFt2wsZw8FPz8QutRevtaUYk/5cpMHENw=; b=W381hE87CztjCE5aOh06czmFUu
        N3h92fOpJ57DFe6vouq46Kyif45d39tGJsRsSeVWdFKESwRtVTyCe72ojLqf4b6XndOaNm56R7wfz
        QS6jgWgo7xtH95jgIP56FRJQVY/6yMgpDT6fhY92RmMFEouHrDI4h/tAdtFdSJSxu+ZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxBwY-0007MD-0P; Fri, 22 Feb 2019 15:36:50 +0100
Date:   Fri, 22 Feb 2019 15:36:49 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Himadri Pandya <himadri18.07@gmail.com>, wen.yang99@zte.com.cn
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: add missing of_node_put
Message-ID: <20190222143649.GN5653@lunn.ch>
References: <20190222111818.3888-1-himadri18.07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222111818.3888-1-himadri18.07@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:48:18PM +0530, Himadri Pandya wrote:
> Decrement the reference count on port while returning out of the
> loop. Issue identified by Coccinelle.

You and Wen Yang are both fixing the same issue. Maybe you can
coordinate?

	Andrew
