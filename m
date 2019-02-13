Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B79C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96DC222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550045358;
	bh=sYfMb5+c51psX83M+ww7Lx0i0nq4IfU9ZwrVxETWG7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ff+tlcbSw886DOuuNZe5v9uEXKAvqTXxl77qKUxbwKqbSQC2X8gJLnKL0sC9yszft
	 GDEiW5umRJH21W/YSBATL2b4eN6DJEEZOQx9Lz5Chi15PL8wqh1Qg3EjnI3IbdKYdn
	 ymm5xMHz9Xw1e8eVacri2+04AZh46puPKY0w4IqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390535AbfBMIJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbfBMIJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:09:17 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17759222C2;
        Wed, 13 Feb 2019 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550045356;
        bh=sYfMb5+c51psX83M+ww7Lx0i0nq4IfU9ZwrVxETWG7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yjRe+Iqy6qEBN/EhS82f9xs4TbxjjeHkS+SaLxVOP+b4OJGGW2z/mSKBw4ugsV6Yv
         6kTIkHMX2DSLSJbSnlYj302vQCZg76Ep7d6mDpyOS3BeeGJ+sMxfpB23oNAAeW2vHg
         T2/fUkR529m5i/CE3sGUIdooaxWWYMhw0VFCGL68=
Received: by mail-lj1-f172.google.com with SMTP id j13-v6so1213209ljc.2;
        Wed, 13 Feb 2019 00:09:16 -0800 (PST)
X-Gm-Message-State: AHQUAuaNzm6/S00+eypf1/CekqlTO3+C1h42sQ4AJvEFVfos64oYYyys
        tQnwxgODE/RXvMCxvSA9voNAFfdwzF5mVjPrYJg=
X-Google-Smtp-Source: AHgI3IZs7tZABUpW7omWNEauy/RZC9tkXwkj8CPk9rKFrV8z+qZjBSXK5kzlOKpNmxeLMOE41ZjyTcj2RxWsfRfZcVE=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr4876820lja.184.1550045354296;
 Wed, 13 Feb 2019 00:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20190212214639.9613-1-stuart.menefy@mathembedded.com>
In-Reply-To: <20190212214639.9613-1-stuart.menefy@mathembedded.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 13 Feb 2019 09:09:03 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdjeTOPrMK2+ZzMRCPLVotg-NKsefxkjkWUfeCnwaWpmQ@mail.gmail.com>
Message-ID: <CAJKOXPdjeTOPrMK2+ZzMRCPLVotg-NKsefxkjkWUfeCnwaWpmQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: sec: Add support for the RTC on S2MPA01
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 22:46, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> The RTC portion of the S2MPA01 appears to have the same
> register layout as the S2MPS14.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> ---
>  drivers/mfd/sec-core.c | 2 ++
>  drivers/mfd/sec-irq.c  | 3 +++
>  2 files changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
