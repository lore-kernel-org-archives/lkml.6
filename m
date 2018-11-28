Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8F22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="caoOofVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeK1ReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeK1ReG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:34:06 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033DC20832;
        Wed, 28 Nov 2018 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543386814;
        bh=jsUpE1/eZaCywvhk6jhysfLOGHKwuEDvwJTTJhOi/7I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=caoOofVj35eG2JRTcMLx1itR44+vLE0lYo7LLsTf6aM9q9MmnKFdU/6SG+1rF7dxY
         nuaBVF44p4wi9jaqlP2sVKNejNFtv4iBoT7DqTYIV0Y6MQzi7bsvP3/PCED7k4GCzd
         UzZ8bWp2UU4otuEXl/CAf490q8EXpX/oWwpTpp1s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181122073043.GN2225@minitux>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181106055013.11271-1-bjorn.andersson@linaro.org>
 <154279089454.88331.1059903104788594574@swboyd.mtv.corp.google.com>
 <20181122073043.GN2225@minitux>
Message-ID: <154338681330.88331.11964099120255315856@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks
Date:   Tue, 27 Nov 2018 22:33:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-21 23:30:43)
> On Wed 21 Nov 01:01 PST 2018, Stephen Boyd wrote:
> =

> > Quoting Bjorn Andersson (2018-11-05 21:50:13)
> > > As of v4.20-rc1 probing the GCC driver on a SDM845 device with the
> > > standard security implementation causes an access violation and an
> > > immediate system restart. Use the protected-clocks property to mark t=
he
> > > offending clocks protected for the MTP, in order to allow it to boot.
> > > =

> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > > =

> > > This depends on the acceptance of
> > > https://lore.kernel.org/lkml/20181105194011.43770-1-swboyd@chromium.o=
rg/
> > =

> > Do you need me to merge this into clk-fixes so that Andy can send this
> > up for v4.20 final? I thought you may have other boot blocking issues so
> > this wouldn't be a critical fix.
> > =

> =

> We resolved the gpio-related issues, so iirc this is the only other item
> preventing the MTP from booting. So yes please.
> =

> Unless you enable USB support, because configuring the first USB
> controller in host currently crashes the device - I've not yet found the
> cause for this though.
> =


Ok let me do the necessary shuffling to get this all lined up for
merging later this week, including this dts patch.

