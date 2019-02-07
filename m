Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D765CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421421872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaIUrpTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfBGRGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:06:36 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40165 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfBGRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:06:35 -0500
Received: by mail-vk1-f194.google.com with SMTP id v70so137683vkv.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNu3eDgy3bRGyE1H97kpUSLRr9SUCp+FnqhdYfyDr/g=;
        b=ZaIUrpTBfoKsDD64nCPoMRr7fXNhGIsDwHSHjH70ZvG/xspGEZkZ95sLvlvI7wrchq
         R16YsRPZGsQg619mFMZtid5ntZSufx+6ZZ2D++WXo3UZXVBMF4oKxWrDEkFWonlbHEOn
         oXTZ4eWK/t+/7wIWLJAgYMgExxGqv+mcJt+cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNu3eDgy3bRGyE1H97kpUSLRr9SUCp+FnqhdYfyDr/g=;
        b=JGdyKKC+YX8KYHc/Ai0Ukr6bZcfF7zw9QzQYcQrEKi2v1gb3/xWiZJAjMS3/gxTe43
         PH6SZ2lt71NOvQx7p4c8W7OdGnncn9was5xcudx4Ymi1pSKRwiF0MoemRzXtjHb4C+80
         mKR91n808HeN0DWHpVc7iHVvLCFRNwTaQEh1UOoCaPkEMJTbN1WJqH/27ZbfEB38qx1V
         JFDBiw/37/njafM+mqLeIGXJe/3NLp8hfWKT2IKZ+xHuQq3gwn09CsZYbX7vavME9HRt
         JYDTlTksikQ/VfYTXwAUZb+hUUU0m5KZUXv2AB3SwTuGreaDPaIe75Ie6gVjXn1m+5Im
         DjeQ==
X-Gm-Message-State: AHQUAuaVNDmkqNYAdsaeF3VbKXqiAbiVRclayAy9AOlWsVKGcosSqQwv
        i5e8sGbylIlPZWu8WZiIY0OrWfuBE/8=
X-Google-Smtp-Source: AHgI3IYJZh4M8eTfJ5lgAhKRHJEGD5BPi/fUgFH8UABoGvj65mb+W93nhJkYmscd8mVoC2r1ckFqnw==
X-Received: by 2002:a1f:834f:: with SMTP id f76mr7031261vkd.25.1549559194306;
        Thu, 07 Feb 2019 09:06:34 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 67sm3230759vko.0.2019.02.07.09.06.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:06:34 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id r127so147511vkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:06:33 -0800 (PST)
X-Received: by 2002:a1f:e807:: with SMTP id f7mr6758385vkh.16.1549559192689;
 Thu, 07 Feb 2019 09:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20190208004721.129a9eb7@canb.auug.org.au>
In-Reply-To: <20190208004721.129a9eb7@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Feb 2019 09:06:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U07_E6O96o4KrJGPaKvE4aSGb9OT6kCy7x40Q_-kGGOA@mail.gmail.com>
Message-ID: <CAD=FV=U07_E6O96o4KrJGPaKvE4aSGb9OT6kCy7x40Q_-kGGOA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 7, 2019 at 5:47 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Andy,
>
> In commit
>
>   761f63b2ff21 ("arm64: dts: sdm845: Add clocks and iommus to WCN3990 WLAN node")
>
> Fixes tag
>
>   Fixes: be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module device node")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Did you mean:
>
>   022bccb840b7 ("arm64: dts: sdm845: Add WCN3990 WLAN module device node")

+Bjorn

Looks like someone reorganized and/or rebased the tree after I sent
out my fix.  When I check locally I have the old commit still and the
new:

commit be7019103469e6ccb997f932d3e0dce0141a0eda
Author:     Govind Singh <govinds@codeaurora.org>
AuthorDate: Mon Nov 5 18:38:37 2018 +0530
Commit:     Bjorn Andersson <bjorn.andersson@linaro.org>
CommitDate: Wed Jan 16 14:13:41 2019 -0800

    dts: arm64/sdm845: Add WCN3990 WLAN module device node

    Add device node for the ath10k SNOC platform driver probe
    and add resources required for WCN3990 on SDM845 soc.

    Reviewed-by: Brian Norris <briannorris@chromium.org>
    Tested-by: Brian Norris <briannorris@chromium.org>
    Signed-off-by: Govind Singh <govinds@codeaurora.org>
    Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---

commit 022bccb840b7ff9c64a70e81ac017d4d10bb8a9c
Author:     Govind Singh <govinds@codeaurora.org>
AuthorDate: Mon Nov 5 18:38:37 2018 +0530
Commit:     Andy Gross <andy.gross@linaro.org>
CommitDate: Thu Jan 24 22:19:20 2019 -0600

    arm64: dts: sdm845: Add WCN3990 WLAN module device node

    Add device node for the ath10k SNOC platform driver probe
    and add resources required for WCN3990 on SDM845 soc.

    Reviewed-by: Brian Norris <briannorris@chromium.org>
    Tested-by: Brian Norris <briannorris@chromium.org>
    Signed-off-by: Govind Singh <govinds@codeaurora.org>
    Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
    Signed-off-by: Andy Gross <andy.gross@linaro.org>
