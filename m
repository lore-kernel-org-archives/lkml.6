Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3488C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0521476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn//0glV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF0521476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJQCQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeJQCQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:16:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A494B21476;
        Tue, 16 Oct 2018 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539714265;
        bh=CrvtsrtyHjL+o8BlES81EbO15FUlGgYDEcL4qQqMgV8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hn//0glVhx6scJqTG5RLk8WGXHFJaqC0WvusTsbN7kOHnJGBIO7S+pKYBexks5kgN
         UBxM78lP7l9CmfBZ4SZS4uFFrrONhwkFfW/H19OD8IteVnIo38ZSmmDMt7MCj7SSGo
         fYA9lNjuitR/GKnSMP8SKWpZO8UvZh1yDDj1cAI8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181016072209.1011-2-mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <20181016072209.1011-1-mgautam@codeaurora.org>
 <20181016072209.1011-2-mgautam@codeaurora.org>
Message-ID: <153971426509.5275.17692219922820755492@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value
 for SDM845
Date:   Tue, 16 Oct 2018 11:24:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manu Gautam (2018-10-16 00:22:07)
> Tune1 register on sdm845 is used to update HSTX_TRIM with fused
> setting. Enable same by specifying update_tune1_with_efuse flag
> for sdm845, otherwise driver ends up programming tune2 register.
> =

> Fixes: ef17f6e212ca ("phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845")
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

