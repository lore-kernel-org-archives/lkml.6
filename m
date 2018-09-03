Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA18820779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx1NdGFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA18820779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeICOkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeICOkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:40:09 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F2D20779;
        Mon,  3 Sep 2018 10:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535970039;
        bh=Dn9+l6KbxhE0M90zf1+i4klHiji5RlZl1XnhYQuzBsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kx1NdGFseh5AqgBD6XQwiv6Yq54fZPdHIxdJGGk/nqNRK8zroH5Q2KVHiMx8tMtd1
         NdUtvTGR7tXJN+AS8sB4LUYb+9Ohj7NqzTY+HoYrDt1NT6STd0aQOyI5S6bbePLJLk
         xkg0c5UVlWYmeOGFGCj84PrgCQ5D+NAxFrSXQkDg=
Received: by mail-wr1-f43.google.com with SMTP id m27-v6so100699wrf.3;
        Mon, 03 Sep 2018 03:20:38 -0700 (PDT)
X-Gm-Message-State: APzg51CDN4IkTNFqNSO9IPJnCxIq0oL6WCEpvoUiec7AG+sY32unMY94
        DY6CjtiK8d8Bjz2OSCpp7XhWH2cXq6FXCfan/sg=
X-Google-Smtp-Source: ANB0VdZHeQCPOTTVItSXV8DOy+BqecNlNn5sV3jm79BqU7BHfnQNBRna/CgrEcNDbCMyhQVAiiJzgXFo2RnxPW8x63U=
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr1387534wrx.226.1535970037577;
 Mon, 03 Sep 2018 03:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
 <22074e17cb853123f926e909eac4418d88af0b98.1535964281.git.baolin.wang@linaro.org>
In-Reply-To: <22074e17cb853123f926e909eac4418d88af0b98.1535964281.git.baolin.wang@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 3 Sep 2018 12:20:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf+Y+QLVJ+jUBcUFeBsxXQxK62UNQ9P+gFbP3RLCBz+wQ@mail.gmail.com>
Message-ID: <CAJKOXPf+Y+QLVJ+jUBcUFeBsxXQxK62UNQ9P+gFbP3RLCBz+wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] power: supply: Add Spreadtrum SC2731 charger support
To:     baolin.wang@linaro.org
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 at 10:56, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch adds the SC2731 PMIC switch charger support.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Remove some redundant head files.
>  - Add one mutex to make sure getting the charger status is correct.
>  - Fix some coding style issues.
>  - Use standard DT properties.
> ---
>  drivers/power/supply/Kconfig          |    7 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/sc2731_charger.c |  503 +++++++++++++++++++++++++++++++++
>  3 files changed, 511 insertions(+)
>  create mode 100644 drivers/power/supply/sc2731_charger.c

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
