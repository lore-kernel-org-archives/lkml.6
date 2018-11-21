Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8792146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zRIIp+px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8792146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeKUTfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbeKUTfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:35:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB5C2146F;
        Wed, 21 Nov 2018 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542790895;
        bh=p4gx/SKzdUJv+rmEqiT1Ym9QOzUIDi2n6RUnzo0QlnY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=zRIIp+pxfkEGB4xJgL+xkeQoMC4+lsIDJtIN5cOMjhxe55tf4iQzQ1BHc1cKmOvHa
         +klQ0hSOXXwCZeb9N++ay0tee52pD3M7TuypS8tVPGeq4jtrVZIUQhvw8WkT/W5lAP
         f2fhnatOtCbPA620XH13/5JzMGhG/DPR8rHmp5C8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181106055013.11271-1-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181106055013.11271-1-bjorn.andersson@linaro.org>
Message-ID: <154279089454.88331.1059903104788594574@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks
Date:   Wed, 21 Nov 2018 01:01:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-05 21:50:13)
> As of v4.20-rc1 probing the GCC driver on a SDM845 device with the
> standard security implementation causes an access violation and an
> immediate system restart. Use the protected-clocks property to mark the
> offending clocks protected for the MTP, in order to allow it to boot.
> =

> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> =

> This depends on the acceptance of
> https://lore.kernel.org/lkml/20181105194011.43770-1-swboyd@chromium.org/

Do you need me to merge this into clk-fixes so that Andy can send this
up for v4.20 final? I thought you may have other boot blocking issues so
this wouldn't be a critical fix.

