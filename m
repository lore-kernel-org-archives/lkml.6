Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C489AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711BA20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwZlijqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711BA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbeGaSjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbeGaSjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:39:48 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359BB20870;
        Tue, 31 Jul 2018 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533056316;
        bh=S33vyEWRALX1ysP+AmT5joQGFHXrTZUHUgwOAQraPiA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IwZlijqfYqt2Dv2SaRLL/Ny/zWWPYJg/IPNxRogwHH71DSwfwdWaS4Pv5a5ngcafN
         oKvu2YZg3V985N/Be1SRklsiUhVHpBqPv8IDY0Wr86ditDmf2Z7vv4fov+tNVGDkkN
         Ad1q0KZovx+WiRpSeiPQjGwo7+stlF9g2SM688NY=
Received: by mail-wr1-f41.google.com with SMTP id j5-v6so17424880wrr.8;
        Tue, 31 Jul 2018 09:58:36 -0700 (PDT)
X-Gm-Message-State: AOUpUlHnkBKsBoY0t7Uy7ZfTCo2Qevz5u1hTyutY+4GQFu5MV3FxZJzf
        HuO5onGE2r1FGmATUn7KBE6eqWaPJnHqexDRw+M=
X-Google-Smtp-Source: AAOMgpecvUfZFrz0J+wKSrNPRY1yE9DMR/PEdJM+iCY2QiHpz3UVI3TKODwuvkgNYFnDvtVLPepsjqGXztL1J1p0IxQ=
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr23041074wra.9.1533056314757;
 Tue, 31 Jul 2018 09:58:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 09:58:34
 -0700 (PDT)
In-Reply-To: <20180731164316.32696-3-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-3-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 18:58:34 +0200
X-Gmail-Original-Message-ID: <CAJKOXPemYmGykswET2C-v7A-edb4zODq7XRJUL-qkKFf1tvvMg@mail.gmail.com>
Message-ID: <CAJKOXPemYmGykswET2C-v7A-edb4zODq7XRJUL-qkKFf1tvvMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: bq25890_charger.c: Remove unused table entries
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> There are a few table entries that aren't used. Drop them.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
