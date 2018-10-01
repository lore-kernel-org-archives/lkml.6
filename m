Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF80C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A36E204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A36E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeJAWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:37:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47101 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:37:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id q2-v6so10221765lfc.13;
        Mon, 01 Oct 2018 08:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPI48qCUXlLguAW9/A/LLFt+DG6kpapp1I9UrMhVSoo=;
        b=BLs9u6YU2E88QtDDRx05uke1yjHUeFvR3nGGeg1zKoj5p9TvlaxWYzRmq6K9kHG4N9
         6Y+M46CYEJsnlYbm1F5DiiSZoskqwqlmDJR4BY4MDRHxbswGz1OiMqHnkA03TT8bMDMb
         NXqAlxm+FHOwxFNdenpzr7MJshdvQ2Mjk550+jQGfvkUHHu9z1DWYaZ11xf7jRxNyY5s
         q++6Ra/RGzpfeeYNG18GYcj37pfnqxkDkHIJhM3H90NKsAGkuRuPVZKwtb0c6L/jYfIv
         zr2Ump6mjyyZilUr7Kyg9wZNkrkGQPcYfV/PxtaN1Q4w54WwfeO39dTE9ZOaNSkAAQCa
         6RlA==
X-Gm-Message-State: ABuFfohC16e/7ES5CBfjCPViC7i/QPlVcyrIY7OqGOC55UNtOcRC4hlu
        4GGdJ7Hd0l2+DGiKszSFuCMpKQ4eOBXwNNs95i8=
X-Google-Smtp-Source: ACcGV62MJ2tkk9HLhwVxyqFnikffWqJ7L9vTGug6ibfQLEfaqAhuoLWnMMst/AEHncfz7qO/kfUkNRfAgEu6hxo0zJk=
X-Received: by 2002:a19:7391:: with SMTP id h17-v6mr6314886lfk.140.1538409562601;
 Mon, 01 Oct 2018 08:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org> <1538332682-12018-3-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1538332682-12018-3-git-send-email-andy.gross@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 17:59:06 +0200
Message-ID: <CAK8P3a2q3mL=rgdgM7f9ay1hYv7K_jFDDS8GKRtckcOEh1SW3w@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Defconfig updates for 4.20
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-defconfig-for-4.20
>
> for you to fetch changes up to 54c2678cd198f61555796bbda5e1727e6e1858f1:
>
>   ARM: qcom_defconfig: Enable MAILBOX (2018-09-13 15:39:19 -0500)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based defconfig Updates for v4.20
>
> * Enable MAILBOX
>
Pulled into next/defconfig, thanks!

     Arnd
