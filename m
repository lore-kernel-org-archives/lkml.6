Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED22C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317D72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B2DxUZfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317D72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeK3JNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:13:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55069 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbeK3JNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BLs2AjpnrF9i/taalUXXDy5eI4zMuWn7b4uhEfj6IX8=;
        b=B2DxUZfscqrpmQztrEq36jMI7r7ZebqaLC3t4rHaHBP1i0QqvkDJZQf8l/VCd3vlIitUQ00b7iN+yQP1YI97cKfNomZRMWOF1eR2KsZAFKFVqDzIrqgM8SqWs4bjDj6PEdnhUykimRaBgqtsEaOerXbcsHFp39xcFkKfmF90kJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gSURz-0003FN-O5; Thu, 29 Nov 2018 23:06:23 +0100
Date:   Thu, 29 Nov 2018 23:06:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alacn <alacn1@gmail.com>
Cc:     Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mv88e6060: disable hardware level MAC learning
Message-ID: <20181129220623.GC11855@lunn.ch>
References: <CAMbhjvMYV1dWGzPX-RJ9Y8OgjtnQELg-Gkre_Sbib1ffp_nkBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMbhjvMYV1dWGzPX-RJ9Y8OgjtnQELg-Gkre_Sbib1ffp_nkBw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:18:50PM -0200, Alacn wrote:
> >From ecc3afc357aeece71842d2d9e3f7ec63e2b4ab67 Mon Sep 17 00:00:00 2001
> From: Anderson Luiz Alves <alacn1@gmail.com>
> Date: Thu, 29 Nov 2018 19:02:03 -0200
> Subject: [PATCH] mv88e6060: disable hardware level MAC learning
> 
> Disable hardware level MAC learning because it breaks station roaming.
> When enabled it drops all frames that arrive from a MAC address
> that is on a different port at learning table.
> 
> Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Hi Anderson

A few process things.  

In the subject line, you should put v2, since this is the second
version.

Also, in the subject line, indicate which tree it is for. I would say
in this case, it is net, since it is a fix. So the subject should be

[PATCH v2 net] mv88e6060: disable hardware level MAC learning

Under the --- you should indicate what changed between each version.

    Andrew
