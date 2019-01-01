Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF182080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sx0yUnZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfAAXYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:24:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60096 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfAAXYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=4I9JtvYdW3ZMyfcKyKXoDYIy9gfsXRolbJq8yVYrck0=;
        b=Sx0yUnZtRbZV0pTN1hwv0480MFVV7Ol5fVLMoArlNSzpAoX9FrV3vUZSf1hXvFLyWpFm9FKKWkcCiA96fBHxhiNyv+ETzuAbwhEHyYhAt3BChLlmxmjdOhdNx2TCIYEOfEAtXL+su3H48ZB1pTK6BaFv8iKQXE1h7JDjNqC2Bdc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1geTOt-00060n-Dv; Wed, 02 Jan 2019 00:24:43 +0100
Date:   Wed, 2 Jan 2019 00:24:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Murali Krishna Policharla <murali.policharla@broadcom.com>
Cc:     davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Message-ID: <20190101232443.GA22737@lunn.ch>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <20190101083450.GA17613@lunn.ch>
 <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ecb54251911d28c50b61299b0f8d3d@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 03:18:51PM +0530, Murali Krishna Policharla wrote:
> Hi Andrew,
>                            Currently net/dsa/slave.c does not have
> ndo_change_mtu function.  But shortly I will be submitting a separate
> patch outside this fix that has ndo_change_mtu function support added to
> DSA switch.  As part of testing the newly added ndo_change_mtu function
> for DSA switch it uncovered that new mtu size is not being updated to
> netdevice structure. This patch fixes this issue and updates  new mtu size
> to  netdevice structure.
> 
> Hope this clarifies, let me know if you need any further information.

Hi Murali

Thanks for the explanation.

However, i looked at the patch you listed as 'fixes'. I don't see what
came before that setting the mtu when an ndo_change_mtu function is
provided. It seems to me, if you provide an ndo_change_mtu, it has to
do the assignment. I don't think you are fixing anything here.

If you do want to move the assignment into the core, please review all
the MAC drivers which implement ndo_change_mtu and remove the
assignment from them.

	   Thanks
		Andrew
