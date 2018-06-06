Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K5SLNhlnGFvOZAAAmS7hNA
	; Wed, 06 Jun 2018 22:58:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F299B608BA; Wed,  6 Jun 2018 22:58:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2XcBnY2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWXK0bMg"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6DE5D607E4;
	Wed,  6 Jun 2018 22:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DE5D607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeFFW6c (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:58:32 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46216 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeFFW63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:58:29 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so4829316vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Kx6h6ws3N7QXDTR2Nk8etFBlorZDMxBP7LfhDUvdFgw=;
        b=Y2XcBnY2Izk6UfH68Q0XdONAFZ5fGbJiIF7qE+21XvNo5CsoaCWCRDT5tzN2QJXmc9
         2Pt5z8iof+fE9qFxS4Qncz0GS2Xo0KBY4e5O8ErTRRuLMi/4g3gsUQPI+hUV2Nq/jHoP
         fZNSvFKF9pYfCMKoiqcGS34h3rSPA/H0N0a04vhLaK3Xp6A+Zfa1/b3EDW5DinGkbyrj
         EeDIkGqGP91M0GplCImT5uAz1aEUhhhSv9KgoTUfVbBJBIFuiuME3EwkR21n6bXBIRZN
         sxcsFpNtxoUlTr3TUZi7djeeoI0zq5qox1by06WXEghzEazfCViHJTR/kpWlEDYPQhyN
         RevA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Kx6h6ws3N7QXDTR2Nk8etFBlorZDMxBP7LfhDUvdFgw=;
        b=cWXK0bMgQ6I5ugASIH28JK3aIbHLne3j9fwYnL2ClHr23nFpM0Val88hKrwX4XXpbe
         +pmJ8tPvgjHlIqmNT/Hv2hxV+G1omxYx65MxIFYkYdXDuKHffo6BdA8WFzZVuQ/m8ImW
         VvBUaMJEpnpHdr3Z7WOxMg83RaPSkmLnjQc50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Kx6h6ws3N7QXDTR2Nk8etFBlorZDMxBP7LfhDUvdFgw=;
        b=f/cFhXFyaDQQhpf5UoJjoJGStaLi/BZ6hze2rZmp7Ne9nKiXowbbR0j2hl46xKluZ+
         Az/1kROnKDvbOQHoNQEj8Ip8rKRopymKiUd6ZYc6XSB5Z1JO+qjeEIz6B82KC6IXK2Ob
         GezmQ2EUK65lHoFKno10cOZaszLsTWviHoaENFIS99RKr6lYWDPnUtwHDASBFo2zOtHS
         4EQbedmGCWYXkNPFVDL+0rY5A+3hEsH3ugpIPGpRY4hAmLcqNsnRbSXPTGuAssF0bSuz
         Y/1qy6b4uwAR0uBnM5TvQgTGPaTd0WBzqfkbcM/zhlVwR5ESREbMtkXus1e6X2p+8Le+
         LEEQ==
X-Gm-Message-State: APt69E0c7jEuNkKTFJ13/sEssbXTucRpzLq5WOj8CMd7S2ms3usT4e3D
        BmbuCLDYx43oTjMHpwpa+pwcrXhJ3fHr9uJ9lmctjw==
X-Google-Smtp-Source: ADUXVKLYdOnRRdIVtKY2P7euYkPsEjJCROn92A3c1XXeBFrLIC920Y2/lyPKZ3Prr9LMlnTg7BwmnJHo4FGrmDkoERI=
X-Received: by 2002:a1f:3a15:: with SMTP id h21-v6mr3234993vka.93.1528325908212;
 Wed, 06 Jun 2018 15:58:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 15:58:27 -0700 (PDT)
In-Reply-To: <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org> <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Jun 2018 15:58:27 -0700
X-Google-Sender-Auth: 0ReGBmJnIRAH_Gom7XSDn9PlzmI
Message-ID: <CAD=FV=V7ZywhYeVw91QaPuvDTWDW=Fp7nVxOCiKUdev=uwL+fg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 4, 2018 at 12:15 PM, David Collins <collinsd@codeaurora.org> wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
>
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 767 ++++++++++++++++++++++++++++++++
>  3 files changed, 777 insertions(+)

Assuming Mark is OK with this, it looks good to me now.  My previous
feedback is resolved and I'm OK with the hardcoded current loads in
the driver for now until we come up with something better.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: Presumably this can't actually land anywhere :( until the RPMh
patchset lands somewhere and that's still sitting in limbo waiting for
Qualcomm to spin the patches.  Presumably once RPMh lands someone will
need to put it somewhere that can be pulled into the relevant trees so
we don't need to wait for a whole merge window...


-Doug
