Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E810C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCBD2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550755365;
	bh=7PJV0VHQXp6lWtaFhm3IRNi9Q9sL29KGsRRjhinjuLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iEI0yz6rJ9ld/G2S1X4WEzKRvUJ172eDW6KQBNlRf1G9KNfJJ7BXLKmplT05bHmSq
	 kbF1ijwNHO7XZ9ffijTpOCscCv/Hd9GHT4xXJfsWYveEqHccy8m0m6y2p+u4MgnYoy
	 UFLmoN0zZ4vertoskV6oMMkalnMWfV0xppB8R9QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfBUNWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfBUNWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:22:43 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB9C2084F;
        Thu, 21 Feb 2019 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550755362;
        bh=7PJV0VHQXp6lWtaFhm3IRNi9Q9sL29KGsRRjhinjuLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4J9f2V26R5+1x3g7LH0S1/D6kf7yAy/DIwNiCARtEIECFKah6D7R9DkKB5DZcNKt
         S8Y1T7ElZa7wR/MDgCmOkFYdUHnpxkBqIeC78DASv5mKmID34gU1Li20zRtDGYeB2Q
         WS9xMnk46qeb3ftb8jbtGcOFdD3J1RP9lLm/pesY=
Received: by mail-lf1-f48.google.com with SMTP id z15so4059195lff.4;
        Thu, 21 Feb 2019 05:22:42 -0800 (PST)
X-Gm-Message-State: AHQUAuatnBiRfPJ91E/nhHkSlAZ2meGXpzVHh8nWcQNeSzBj5GpmObMW
        Iuf1PZXZOEN5cH3H65apr0EyMLMfxAbhj6PVu3Q=
X-Google-Smtp-Source: AHgI3IZASA6If+ei0/5ZV7KxZ7Xsr5YSWmCCtdeuHuTSqT0HXfY3ejuaxWlImnytBljnJAXbDH39R8f4nRbHq9lCDDU=
X-Received: by 2002:a19:e347:: with SMTP id c7mr14124140lfk.137.1550755360314;
 Thu, 21 Feb 2019 05:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20190221131722.12278-1-axel.lin@ingics.com>
In-Reply-To: <20190221131722.12278-1-axel.lin@ingics.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Feb 2019 14:22:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcfm6Ee0stF1dz0CawNN9Z4UY64Cfaqy-p28+V6e_QTpQ@mail.gmail.com>
Message-ID: <CAJKOXPcfm6Ee0stF1dz0CawNN9Z4UY64Cfaqy-p28+V6e_QTpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: s5m8767: Constify s5m8767_opmode_reg
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 at 14:17, Axel Lin <axel.lin@ingics.com> wrote:
>
> The s5m8767_opmode_reg should never change, make it const.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/s5m8767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
