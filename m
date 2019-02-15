Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372FD222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbfBOUqQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:46:16 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfBOUqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:46:16 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gukN2-00032O-N0; Fri, 15 Feb 2019 21:46:04 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     agajjar <Akash_Gajjar@mentor.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Levin Du <djw@t-chip.com.cn>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: rockchip: rockpro64 dts remove unused node
Date:   Fri, 15 Feb 2019 21:46:03 +0100
Message-ID: <7155828.jr86DZMtXN@diego>
In-Reply-To: <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com> <4653141.o6ZdamfZ6d@diego> <ac22440d-3b64-1cf2-205c-52ea7c1c23f9@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Februar 2019, 13:08:16 CET schrieb agajjar:
> On 2/15/2019 2:48 PM, Heiko Stübner wrote:
> > Am Mittwoch, 13. Februar 2019, 18:06:38 CET schrieb Akash Gajjar:
> >> lcd panel pinmux and vcc1v8_s3 regulator is redundant and has a no
> >> impact,
> >> so removing it.
> >> 
> >> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> Hi Heiko,
> 
> > vcc1v8_s3 is actually also a emmc supply, so I'd like to keep it around
> > for completenes sake.
> 
> Emmc module is supplied by PMIC vcc3v3_s3 (SWITCH_REG1) and vcc_1v8
> (DCD_REG4).
> 
> So I believe removing vcc1v8_s3 has no impact on emmc supply line.

looking at the rockpro64 schematics page 10, I see vcca1v8_s3 linked
to the emmc_vdd_1v8 input and obviously also as reference for the saradc.

So I think we really could keep it around, so that the power-tree resembles
the schematics more.


