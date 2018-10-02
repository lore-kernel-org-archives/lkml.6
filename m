Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95274C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CE52089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CE52089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJBO4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:56:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40028 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJBO4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:56:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id e9-v6so1001946qtp.7;
        Tue, 02 Oct 2018 01:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mT+3H/5cOx+gRz/rR+wePpHE76zRUvu68dktGi2xSLE=;
        b=dy9dfJjbvpPvZVsl9zoZsXlqKk2K0vH4VyZtapLRWPAw+wu99vcla+rgxC6DgHdFxD
         CIaDocZyXBdNKZMcDszHrIQmFom3a+RWrFp9jNKPDS+W2+O5JtVC/898dDouj8VKKEbi
         NxTeslHNvKK1z1iDRnZyAuT444/DLhRjnNuSDNpcn3W5e5n3RgvQtemHb47hzXEB0prg
         6BnvQN7JZf+yCXMU/VZhFes7GqHLPHJDjPqKuwWaacLr7tiRm22snvAAII3ixr7U2BFE
         fl9Hf0temPEcmRDeoX+sDnVOg58L0GAauK8o/3B58hHPT7CG7aEy4D8IVkOELjrsb7vG
         FTFw==
X-Gm-Message-State: ABuFfojzL49qwDH309gdeEDHl1BLj3jxAOHAF4pWBcJGtuzqYrKsPZQo
        w8x1sv5B7FjDHqfkoE5R6D16awJrxbQTyjHAyqs=
X-Google-Smtp-Source: ACcGV62KLo2FUVrZB20pvygk6UZ4yaJc0boHb9NXhmDkUChc3eFdkJt+S6MK10Cq2AQIy9Sp1rGgOo42K8askaQOr/s=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr11718740qtp.213.1538468077757;
 Tue, 02 Oct 2018 01:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org> <1538332682-12018-4-git-send-email-andy.gross@linaro.org>
In-Reply-To: <1538332682-12018-4-git-send-email-andy.gross@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 10:14:21 +0200
Message-ID: <CAK8P3a29NY9S6qS7i2SiN-PfFC=QY5j22=Hicp-fCA5YV2hD=Q@mail.gmail.com>
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.20
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.20
>
> for you to fetch changes up to 579fde69dc1467a033ff44ced75ff368b9d3d072:
>
>   Merge branch 'drivers-for-4.20' into drivers-for-4.20-final (2018-09-30 12:44:33 -0500)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.20
>
> * Refactor of SCM compatibles and clock requirements
> * SMEM cleanup
> * Add LLCC EDAC driver
> * Fixes for GENI clocks and macros
> * Fix includes for llcc-slice and smem
> * String overflow fixes for APR and wcnss_ctrl
> * Fixup for COMPILE_TEST of qcom driver Kconfigs
> * Cleanup of Kconfig depends of rpmh, smd_rpm, smsm, and smp2p
> * Add SCM dependencies to SPM and rmtfs-mem

Pulled into next/drivers, thanks!

        Arnd
