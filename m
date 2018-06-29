Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D23AC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E22794E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4ygtJl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E22794E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934459AbeF2Rgl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbeF2Rgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:36:40 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4ED27946;
        Fri, 29 Jun 2018 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530293799;
        bh=UXQ8QU6ktYJc0figEc4GzYQd84rYBaKWXU8SAj1Y94o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=C4ygtJl3asU0/cLSQS8w/0r37u+tedwzjcJR+6/KKeSNDQU5SWPLBEr1youqUGcSN
         6irPOFsOKIVJxtCr+A/iRh0x/Sf6j+oV6WH8w1XMUQbvm8nTMeiBGQWe2YgF7KhUMb
         wW0eU6yt10V1iAfSsCEf7qki66WsvytvLQI4m6F8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Saravanan Sekar <sravanhome@gmail.com>, afaerber@suse.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180628191805.3722-2-sravanhome@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-2-sravanhome@gmail.com>
Message-ID: <153029379879.143105.2037926027438984922@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] arm64: dts: actions: Enable clock controller for S700
Date:   Fri, 29 Jun 2018 10:36:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravanan Sekar (2018-06-28 12:18:03)
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm6=
4/boot/dts/actions/s700-cubieboard7.dts
> index ef79d7905f44..28f3f4a0f7f0 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/=
actions/s700.dtsi
> index 66dd5309f0a2..3530b705df90 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi

Can the above part be split from the below part? I don't want to merge
dts bits into clk tree, when those should normally go through arm-soc.

> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bi=
ndings/clock/actions,s700-cmu.h
> new file mode 100644

