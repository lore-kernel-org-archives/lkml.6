Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E418C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E1320700
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054279;
	bh=kLqQ7Tvg4EuwbclDTSOsSSs0uH7VsbELQfhCABLQPSs=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=KzVXjiPGuh4NDKNkYpxARZaaLTAytFW9UBGfjC3j9if95y8CmEA/bcT8nVFOQnspE
	 b97OZJjQkotgZN/2Ppun6h1NwP2jKM9w/RbbUua6s6Rt4NIBK5UaAF6gM+3mvBQe6h
	 4rkLT9/n8uZ+RjLzsiFWCNC55OGu24AdrlFZc33I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1320700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeLEX56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbeLEX56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:57:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABB8206B7;
        Wed,  5 Dec 2018 23:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054277;
        bh=kLqQ7Tvg4EuwbclDTSOsSSs0uH7VsbELQfhCABLQPSs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ifXJnVFRTq/MTkbdyxlY608CWW3f7hosOLM56kepAe77bKnNp4u1Xap5PnxeiyrIr
         l1AhgMqE6826OijevgE5VDrGZdTqF6HIYlMa48jARRk5BSBm+EtEZFENiWZbzwmGQ0
         Lq4DGQggv3AaQkpTC0XOQsiHq6IeRhkwDF6CzuU0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203183330.2073-2-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
 <20181203183330.2073-2-bjorn.andersson@linaro.org>
Message-ID: <154405427716.88331.7020427565874111944@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] clk: qcom: gcc-msm8998: Drop hmss_dvm and lpass_at
Date:   Wed, 05 Dec 2018 15:57:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-12-03 10:33:28)
> Disabling gcc_hmss_dvm_bus_clk and gcc_lpass_at_clk causes the board to
> lock up, and by that preventing the kernel to boot without
> clk_ignore_unused.
> =

> gcc_hmss_dvm_bus_clk is marked always-on downstream, but not referenced,
> and gcc_lpass_at_clk isn't mentioned. So let's remove them until they
> are needed by some client.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

