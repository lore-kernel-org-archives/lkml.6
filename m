Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF7B2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVk09lg4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVk09lg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF7B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeLEHCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:02:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:02:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D206360B7F; Wed,  5 Dec 2018 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993331;
        bh=21Xttrj99Oxbg2rASzj1UD+gR3498gxNUeLvKS/2w7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aVk09lg4gr38Gm7Ls55/CTqKRaylAiu+QQWs2P1f7qGZE+bOCcfblV+zQIDNGXsI4
         ROHhmO+M4FYvncKsem3s59MCbZJUdemcQMEPVGw2QphmMi6Kir5B7yV9r9lnAIQ5py
         NDyC7qb7plUcfxq6f90rdexy8ut7WQcX4kZE9lAs=
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D77B607B5;
        Wed,  5 Dec 2018 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543993331;
        bh=21Xttrj99Oxbg2rASzj1UD+gR3498gxNUeLvKS/2w7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aVk09lg4gr38Gm7Ls55/CTqKRaylAiu+QQWs2P1f7qGZE+bOCcfblV+zQIDNGXsI4
         ROHhmO+M4FYvncKsem3s59MCbZJUdemcQMEPVGw2QphmMi6Kir5B7yV9r9lnAIQ5py
         NDyC7qb7plUcfxq6f90rdexy8ut7WQcX4kZE9lAs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D77B607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f177.google.com with SMTP id z16so21151574qtq.4;
        Tue, 04 Dec 2018 23:02:11 -0800 (PST)
X-Gm-Message-State: AA+aEWa23pBdQKu06a4QsexRG0+2UryV10bLwzXG4GPDzF4w/u9nWjvv
        UHhOij1Wby4SjHvr4W+Y2UMFgno9peuWLGUufjs=
X-Google-Smtp-Source: AFSGD/WtKAk49RWawlVV4teV76nfmjHqo1IIwfZl10lCKm5kusA65R5JMiLYJ8oF0LEtM3SrFcH5f3/JQk3oHo0xAy4=
X-Received: by 2002:a0c:f053:: with SMTP id b19mr22686772qvl.29.1543993330365;
 Tue, 04 Dec 2018 23:02:10 -0800 (PST)
MIME-Version: 1.0
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 5 Dec 2018 12:31:57 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH9sz3NsejvxLdgAy+E-6Rff9RDA74EtnSidWOuZN=q9w@mail.gmail.com>
Message-ID: <CAFp+6iH9sz3NsejvxLdgAy+E-6Rff9RDA74EtnSidWOuZN=q9w@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] Support for Qualcomm UFS QMP PHY on SDM845
To:     Can Guo <cang@codeaurora.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>, kishon <kishon@ti.com>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:07 AM Can Guo <cang@codeaurora.org> wrote:
>
> This patch series adds support for UFS QMP PHY on SDM845 and the
> compatible string for it. This patch series depends on the current
> proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
> the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
> rebased on updated pipe_clk initialization sequence [3]. This series
> can only be merged once the dependent patches do.
> [1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
> [2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
> [3] https://patchwork.kernel.org/patch/10376551/

Besides my comment for PATCH 4/6, I have already reviewed the entire series,
and it looks good.
If adding new bindings for sdm845 needs a further review, can you separate out
just the phy patches from this series (patch 1, 2, 3 & 6), and re-send them.
We can ask Kishon if he can pull them in for this merge window.
Thanks.

best regards
Vivek

>
> Changes since v9:
> - Incorporated review comments from Rob.
>
> Changes since v8:
> - Add one new change to support ufs core reset.
> - Incorporated review comments from Evan, Vivek.
>
> Changes since v7:
> - Add one new change to update UFS PHY power on sequence
> - Incorporated review comments from Evan, Vivek and Manu.
>
> Changes since v6:
> - Add one new change to clean up some structs and field
> - Updates the PHY power control sequence.
> - Incorporated review comments from Vivek and Manu.
>
> Changes since v5:
> - Updates the PHY power control sequence.
> - Updates UFS PHY power on condition check.
>
> Changes since v4:
> - Adds 'ref_aux' clock back to SDM845 UFS PHY clock list.
> - Power on PHY before serdes configuration starts.
> - Updates the UFS PHY initialization sequence.
> - Updates a few UFS PHY registers.
> - Incorporated review comments from Vivek and Manu.
>
> Changes since v3:
> - Incorporated review comments from Vivek and Rob.
>
> Changes since v2:
> - Incorporated review comments from Vivek and Rob.
> - Remove "ref_aux" from sdm845 ufs phy clock list structure.
>
> Changes since v1:
> - Incorporated review comments from Vivek and Manu.
> - Update the commit title of patch 2.
>
> Can Guo (5):
>   phy: Update PHY power control sequence
>   phy: General struct and field cleanup
>   phy: Add QMP phy based UFS phy support for sdm845
>   scsi: ufs: Power on phy after it is initialized
>   dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845
>
> Dov Levenglick (1):
>   scsi: ufs: Add core reset support
>
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 216 +++++++++++++++++++--
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
>  drivers/scsi/ufs/ufs-qcom.c                        |  34 +++-
>  drivers/scsi/ufs/ufs-qcom.h                        |   1 +
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   |  22 +++
>  drivers/scsi/ufs/ufshcd.c                          |  13 ++
>  drivers/scsi/ufs/ufshcd.h                          |  12 ++
>  8 files changed, 296 insertions(+), 21 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
