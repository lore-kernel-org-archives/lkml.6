Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10D820878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10D820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeLFNDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:03:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41822 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbeLFNDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:03:33 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gUtJP-00069e-HA; Thu, 06 Dec 2018 14:03:27 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     agajjar <Akash_Gajjar@mentor.com>
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rockpro64 fix video output chain
Date:   Thu, 06 Dec 2018 14:03:27 +0100
Message-ID: <3141294.pN5WgFrMoD@phil>
In-Reply-To: <09287391-d541-cddb-4168-55ca6fee3f16@mentor.com>
References: <20181201100817.20688-1-oskari@lemmela.net> <20181201100817.20688-3-oskari@lemmela.net> <09287391-d541-cddb-4168-55ca6fee3f16@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Dezember 2018, 14:03:29 CET schrieb agajjar:
> 
> On 12/1/2018 3:38 PM, Oskari Lemmela wrote:
> > Rockpro64 is not able boot if kernel is compiled with
> > CONFIG_DRM_ROCKCHIP=m
> >
> > Enable Rockpro64 board HDMI output to fix issue.
> 
> Hi Oskari,
> 
> Could you please describe this issue in detail.
> 
> I am not able to reproduce this issue if CONFIG_DRM_ROCKCHIP is compile 
> in or as a loadable module at the same time hdmi node is present or not.

I've now simply adjusted the commit message to:
"arm64: dts: rockchip: enable hdmi output on rk3399-rockpro64
    
The rockpro64 does have hdmi support, so add the necessary
devicetree node to enable it."

and applied it for 4.21.

While it still would be good to find out where the issue comes from Oskari
is seeing, the rockpro64 does have hdmi, so we can just enable it ;-)


Heiko


