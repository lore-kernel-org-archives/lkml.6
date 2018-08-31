Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2FBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C4E20839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9OHSWKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C4E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeHaFMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHaFMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:12:52 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9EA20837;
        Fri, 31 Aug 2018 01:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535677679;
        bh=yJtePR/B1CVlZZOVfPBgIGpej1ujyK8XZB3WrqKluU0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=O9OHSWKLGLCm66A93KHHYBjtnXf6RnfvEI3g8EOOBcbgdSzWW4+5jzaUkgpYhbbKI
         JHmAVeVaLz5RnV5XmnOWGJZYtUuIcDROBt1a/Ge1sjgiDtZjvqSuuOqizE0yvDyXsf
         ggkGl0zujg0kaqnxhoTEOH5rBOV86XaBqlAUO8Zc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180829231505.22660-1-bjorn.andersson@linaro.org>
Cc:     Sricharan R <sricharan@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
Message-ID: <153567767852.93865.5427679731919930718@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/3] firmware: qcom: scm: Improve clock handling
Date:   Thu, 30 Aug 2018 18:07:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-08-29 16:15:02)
> We're currently facing the issue that every new platform requires the add=
ition
> of a compatible to the DT binding as well as the driver.
> =

> The DT binding patch to allow us to use qcom,scm for all these new platfo=
rms
> that doesn't require any clocks and the driver is reworked to make the qc=
om,scm
> still pick up specified clocks in this case but won't require them.
> =

> This makes it possible to add new platforms by simply add the new compati=
ble to
> the list in the DT binding, but no changes needs to be done in the driver.
> Which is what is done in patch 3.
> =


I still think it may be even simpler to move to the "get all the clks"
API and then stop caring completely. Any reason to not do that?

