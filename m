Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E53C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8931A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtRVKonJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8931A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeK3UfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3UfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:35:01 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E61A020863;
        Fri, 30 Nov 2018 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543569981;
        bh=wMvXu0Zt5EsV5KTkoYdcXeI3wIa9DPhJCb1R+p4sVY4=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=CtRVKonJw/sfkGo8tZMWHp/DdNUWXK8uYnW2SVewv/woSr/pQ8iEZZYcqQw+4M1uR
         wgj8cTXh/jlmF05QKHhiShS0x19q+LZUIdW8vSI9vmOW8132SRRFgW99i8TLEEKhDn
         q5REh32Ts5SdFC435ZznFVRZtZnEvn4WXX3FzXCc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181123101132.6be3829c@xps13>
Cc:     kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
Message-ID: <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date:   Fri, 30 Nov 2018 01:26:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-11-23 01:11:32)
> Would you agree with me adding dummy functions in the #else section
> like:
> =

> static inline void __clk_device_link(struct device *consumer, struct clk =
*clk)
> {
>        return;
> }
> =

> static inline void __clk_device_unlink(struct clk *clk)
> {
>        return;
> }
> =

> Do you want me to also declare these functions in the #if section
> (with the external keyword) to balance the above declarations?

Why can't we do the linking in __clk_get() and __clk_put()?

