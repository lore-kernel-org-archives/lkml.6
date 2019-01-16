Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C38206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lCtFDLWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393853AbfAPPFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:05:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45334 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbfAPPFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dTCZFyvU1/DMPRSAvo+8DayBYK2ETex4IgL9iJfcLDc=;
        b=lCtFDLWr/mjbQv5l/IDhWwnSsWEGrsvwqJ2UG5/oVgB7ZtINt4HN2lmLmGcKn7Bdz5lmAmkiiPQWSR8j5kBJ/hy77FPab2sn/o8aSk3KJjRunwnzsU6FhV44MjDlpLNa13XZEtW7wcvYfeWImUuHL0fCW4spIKJKmJ69IZKDHSk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjmkY-0007VC-Ek; Wed, 16 Jan 2019 16:05:02 +0100
Date:   Wed, 16 Jan 2019 16:05:02 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: realtek-smi: fix OF child-node lookup
Message-ID: <20190116150502.GH25731@lunn.ch>
References: <20190116102708.30608-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116102708.30608-1-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:27:08AM +0100, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to look up child nodes to
> avoid ever matching non-child nodes elsewhere in the tree.
> 
> Also fix up the related struct device_node leaks.
> 
> Fixes: d8652956cf37 ("net: dsa: realtek-smi: Add Realtek SMI driver")
> Cc: stable <stable@vger.kernel.org>     # 4.19: 36156f9241cb0
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
