Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94526C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfAPVql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:46:41 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:51284 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfAPVqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:46:40 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1B9584BABE;
        Wed, 16 Jan 2019 22:46:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id JoVaH_P6vLlp; Wed, 16 Jan 2019 22:46:37 +0100 (CET)
Subject: Re: [PATCH 2/3] net: dsa: lantiq_gswip: fix OF child-node lookups
To:     Johan Hovold <johan@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-3-johan@kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <97b4da00-2aef-fbb1-2336-15a9399aff7b@hauke-m.de>
Date:   Wed, 16 Jan 2019 22:46:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190116102335.30433-3-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:23 AM, Johan Hovold wrote:
> Use the new of_get_compatible_child() helper to look up child nodes to
> avoid ever matching non-child nodes elsewhere in the tree.
> 
> Also fix up the related struct device_node leaks.
> 
> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Cc: stable <stable@vger.kernel.org>	# 4.20
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  drivers/net/dsa/lantiq_gswip.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
