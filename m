Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE174C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B114920878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="adV6u1hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B114920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbeLEOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:24:22 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35916 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:24:21 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so7147821uap.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrSj5QZACEI8rT+gxNR6ik8qNB7Ns//P0lH37hTthyY=;
        b=adV6u1hO7vT7wulnHN84oHB7CUrV1XpAnLJ1zMHzv/91mC+fHUcN4aQufJp85Rzt6i
         +u/YgI9BkYDfrKqOeAIo6zafSyUpisf7V25z+u2BLqQVjTf6vbe0zOGGbHYnXcZP7be+
         rZVxmNU8RkgTqi3nQ+jMz3/BRpGyBdOopJGbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrSj5QZACEI8rT+gxNR6ik8qNB7Ns//P0lH37hTthyY=;
        b=qNawL8zNwIKOuBtzhmYFYXIfCN6btIlquTY4e2QRW5RpltMnILfd+qcTAZoV53Kv9u
         s8wN2kLspH3Xtb8DrZkwhnGQhiO1lBLTlOfIxnmJBJ3L6Ai/4XkQinX4+nnVLsugBIhe
         0WT9xEz1KkFVUnkyN311b7Rv3f1eDSVdNYe7KEhZ88edN3INKF20y+1udAJA/D6FC1PY
         ji/u+Y6m77/jdYJpibMozOOTr7qOkH1txkZtixPMtOyfNWoXWjVAhc5/93lppD/cpD38
         buCRs7xOLtOmoLjdA7kC8yGum9I1YU+/YKzLRtXZ/93+jJdNBnXCJGHfxA5gN+2bTb8F
         5FRA==
X-Gm-Message-State: AA+aEWavbP+1BEnA0pXU30quD8KYRZOVpOFshhG0aBjCBNPNJT6MR1dN
        rrk/SoKwX6Ht437+J6yKaWZAYT4+9X/sILbDnw1UFQ==
X-Google-Smtp-Source: AFSGD/VzwTyyGOJvT5uc4ZZcuq4eT7iSPv6Zvq4YTIcz9KoOxwvWQDw65qx6flawk4VipLm1friaErSBADlZFENjouY=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr10462348uad.119.1544019860257;
 Wed, 05 Dec 2018 06:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20181121103357.3448-1-faiz_abbas@ti.com>
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Dec 2018 15:23:44 +0100
Message-ID: <CAPDyKFq0o9U0HZU8zfDRna5JNjNXiz+OQPKizui3bu3QuR7SZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 at 11:31, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches fix tuning related errors in the
> sdhci-omap driver.
>
> v2:
> Added Fixes and stable tags for patch 1.
> Re-enable DCRC in patch 1 only if it was enabled before
> Squashed patches 2 & 3
>
> Faiz Abbas (3):
>   mmc: sdhci-omap: Fix DCRC error handling during tuning
>   mmc: sdhci-omap: Add platform specific reset callback
>   mmc: sdhci-omap: Remove redundant structure assignments
>
>  drivers/mmc/host/sdhci-omap.c | 36 ++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> --
> 2.19.1
>

Sorry for the delay!

Picked patch 1/3 for fixes, patch 2/3 and 3/3 for next, thanks!

Kind regards
Uffe
