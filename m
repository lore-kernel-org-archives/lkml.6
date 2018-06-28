Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1826DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB01F2733E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="pa26JtXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB01F2733E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935234AbeF1MRB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:17:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53712 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935191AbeF1MQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:16:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A42B525B7A3;
        Thu, 28 Jun 2018 22:16:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1530188217; bh=J1tMWF14rOeZkCwb5gn9CM99V4NWkN7EMitOgYIdPVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pa26JtXU8P9IayymbnGBZ0Qj2fTnUgAJXjMQXnJo4Z+TOqXYrUYG0vNpraOD40eu4
         4SGZ04GrkcOxqBReDhuligip8JjFxPFsmBfuXTGp2oo+hSYxpatDXjnhHEBtrzDfK+
         2ETPWfXEjkgyY0O3whCbcEcCI4tO7AtLHf1Ut8yE=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 96E63940760; Thu, 28 Jun 2018 14:16:55 +0200 (CEST)
Date:   Thu, 28 Jun 2018 14:16:55 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Message-ID: <20180628121655.bvawikztkd2qiefl@verge.net.au>
References: <1530173842-56851-1-git-send-email-michel.pollet@bp.renesas.com>
 <1530173842-56851-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530173842-56851-3-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:17:13AM +0100, Michel Pollet wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> equires a special enable method to get it started.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
