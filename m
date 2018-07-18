Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8504EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182062084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f+Xijjm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182062084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeGRVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:17:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39040 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbeGRVRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=IUs606JAsNMhvhxVnjVwOI3pEUbTc/VmyN0eIVTn58M=;
        b=f+Xijjm92mMKa5crdJkn6trP1qZKLl6dVBSbZD5ZrJC+n2siGlO0cmxemqYbxpa3sAPkn2X1TnlCN1R2FZD1Ale9a6doCwVYGvvQITMvgVW9O9X5cuwpvQwRdq9N2jhkri3s9uOStS4wSEPorB5sqh7HleNZfJQdybUeHb7Z4fo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fftCP-0005u0-RC; Wed, 18 Jul 2018 22:37:25 +0200
Date:   Wed, 18 Jul 2018 22:37:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.mesoraca16@gmail.com,
        f.fainelli@gmail.com, David.Laight@aculab.com
Subject: Re: [PATCH v2] net: dsa: Remove VLA usage
Message-ID: <20180718203725.GD20228@lunn.ch>
References: <20180717041034.GA37382@beast>
 <20180719.053333.396851874410198344.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719.053333.396851874410198344.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:33:33AM +0900, David Miller wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Mon, 16 Jul 2018 21:10:34 -0700
> 
> > From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> > 
> > We avoid 2 VLAs by using a pre-allocated field in dsa_switch. We also
> > try to avoid dynamic allocation whenever possible (when using fewer than
> > bits-per-long ports, which is the common case).
> > 
> > Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> > Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
> > Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> > [kees: tweak commit subject and message slightly]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Florian and Andrew, please review.

Last time there was some discussion of just always allocating it to
make the code simpler. But the extra complexity is O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
