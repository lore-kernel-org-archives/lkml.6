Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F74C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76CB20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76CB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJBQNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:13:06 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44111 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJBQNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:13:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so670873qka.11;
        Tue, 02 Oct 2018 02:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNJtHsatHLng2sza8sxQicd5lxE0prVEfw0SywAFfew=;
        b=plaH5FWYwx5UIpR8hEIMWRI07zsBOg4fc7BDzw64W4B9k6L0nulwBY4hXbEl6RKFmh
         dM8UT62Vexa0Dha5YogtkgVBqBy0Zlqa+eNGZ5vqP1TgCY+a/IW1OazWAh/W8+Be8IAg
         4SvIaKMXMGLxx2RQKnwhPZMwiSGCiUTWoyskkBEP2bsp9xN4yyT8Dn/ByfEjUgZ33U8s
         WYWlbu4Stg/RKuwrzEFYrFd6knWUQZrdPD2Z6tmsEoSMA6AnlVbnUgqGGsAQWegZzKlA
         8TsI4NIHePfJchPDhmVOcbUEF/7DrzfC+XpqiKzQxLS7bL/oXamfCBGgqkCgqb+sMbOQ
         l7mg==
X-Gm-Message-State: ABuFfoilvYm+jhKXI8yLsvb1Rq7QRTsYXe6HzeWFP5evnvaHgPyd5IjX
        T032o6aoXlaIo8TnzS3OTzHuBHlciKfhtStOv/E=
X-Google-Smtp-Source: ACcGV60FpEhftiO1kpS1umppte3KAk8460NkHJuFn2PwAF2ZM3ynMMaGyDEFHgA4NA9oJVx1HnxYrPN8ljIkK6dDfT0=
X-Received: by 2002:a37:38b:: with SMTP id 133-v6mr11489533qkd.173.1538472645992;
 Tue, 02 Oct 2018 02:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org> <1538332682-12018-2-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1538332682-12018-2-git-send-email-andy.gross@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 11:30:29 +0200
Message-ID: <CAK8P3a1UyHEATAhg_AP2oK8vkVHx+VKGX9aFBmRzzLpZECjxnA@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm ARM64 DT updates for 4.20
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm-soc <arm@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 8:38 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.20
>
> for you to fetch changes up to 6db0483cf622fc690e32e0804f8b86061f13962a:
>
>   Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'" (2018-09-30 12:59:52 -0500)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.20
>
> * Update Coresight for MSM8916
> * Switch to use mailbox for smp2p and smd on MSM8996
> * Add dispcc, dsp, USB, regulator, and other nodes for SDM845
> * Drop model/compatible from MSM8916 and MSM8996
> * Add compat for db820c
> * Add MSM8998 SoC and board support along with associated nodes
> * Add RESIN/PON for Qualcomm PM8916 and PM8994

Pulled into next/dt, thanks.

There is a small chance that the two reverts end up causing more
problems than they help: they might conflict with the patches merged
into the iio branch, or they could end up being applied on top of
the iio branch and revert the changes during the release. I think
it will be fine, but it's obviously better to avoid this.

      Arnd
