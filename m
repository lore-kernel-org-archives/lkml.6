Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9078205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUySemwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9078205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966719AbeFSPXr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966225AbeFSPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:23:44 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3186205C9;
        Tue, 19 Jun 2018 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529421824;
        bh=HREzu3Hh2dYbKdsYW3SBmyBixSYsCcDKbnKRmP3DWh0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KUySemwJRv9x06VQL026iwS0LSmXaLW1cOZr0KXb64EViRbMMHynKqpFv+JyQO/7P
         Fl7GELyfTETRMI3tV2VhPw6ievLXMqWJ0F9H9CwZS6RT14SysfaaP0lWPwcHQ0BZaF
         VlouMQiBAqdsFJ+GKeEypy/Wn+bJvENaSyqFVRVE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528885997-10311-1-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1528885997-10311-1-git-send-email-tdas@codeaurora.org>
Message-ID: <152942182329.16708.17615552184746348831@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/2] Add display clock controller driver for SDM845
Date:   Tue, 19 Jun 2018 08:23:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-13 03:33:15)
>  [v2]
>   * Removed unused header file includes.
>   * Moved the frequency table macro to a common file [1].
>   * Move to pll config to probe.
>   * Update SoC name in device tree binding and
>     also update the Kconfig.
> =

> Add support for the display clock controller found on SDM845
> based devices. This would allow display drivers to probe and
> control their clocks.
> =

> The Display clock driver depends on the frequency table macro
> movement to a common file [1].

Please send that patch along with these patches so the dependency is
clear.

> =

>  [1]:  https://lkml.org/lkml/2018/6/13/216
>=20
