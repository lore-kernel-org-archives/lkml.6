Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB310ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7995220C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ObciQMbn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GFHC5irC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7995220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeIXOPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:15:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeIXOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:15:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 067CC6029D; Mon, 24 Sep 2018 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537776881;
        bh=+WqDyUwuz7WgEay2BVBtBmUt9e7wL7pEUSHZaHA25H8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ObciQMbn8HlVKp8jZy4p5vdTfXofGwt/fW2p7OCWDpQI37/iko8CIJcXBT0O1do1y
         sygX88wwaWCIYKRtF6p0/eql+5sP5gLj/Yc7QgWu1nZ3NF0An16PS4yfbfu8RAayRP
         6Dox1Z7y96WWhwA1mSiMyc8kP3m5R05rj9rKq5mA=
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C286605FD;
        Mon, 24 Sep 2018 08:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537776880;
        bh=+WqDyUwuz7WgEay2BVBtBmUt9e7wL7pEUSHZaHA25H8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GFHC5irCPQcSb/vFlrLxQZR/PUGB6miaoui9PkoHyeseDhQjB1sVAvIxa/fdkzKWm
         yfwdY/ysin2D553JAQa0QKDz9rF+grlu5F5rEORmIOOmNJAMHeGAC9zbUwE66v5Ajm
         HUMi+UaMz0CH8Hf6KGm93Rm5d8R2EYBTmdvBCJbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C286605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f181.google.com with SMTP id c25-v6so2790304qtp.6;
        Mon, 24 Sep 2018 01:14:40 -0700 (PDT)
X-Gm-Message-State: ABuFfogRrKXvrp+rGJGfikF4jkOqmM1QOrQurHMPz+yf2ynOq8f0hFlK
        HH1vJ7mygoAcPHlFa0FzO+NdYegbFpL4Df6bW4k=
X-Google-Smtp-Source: ACcGV61MZqXSEDG34IbBJKros0KW1GZsrwq9fI+WwHptqJ7uL3EgmeTrq9epJmttt4I6tPFi2L+UV/49w8DLt2uCiXY=
X-Received: by 2002:ac8:218d:: with SMTP id 13-v6mr6973903qty.122.1537776879701;
 Mon, 24 Sep 2018 01:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
In-Reply-To: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 24 Sep 2018 13:44:26 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHooVy=NrRSWLBAxR7YHmTGQ5EyvHuCFNqOtUbrm0WvQg@mail.gmail.com>
Message-ID: <CAFp+6iHooVy=NrRSWLBAxR7YHmTGQ5EyvHuCFNqOtUbrm0WvQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] scsi: ufs-qcom: Remove all direct calls to qcom-ufs phy
To:     kishon <kishon@ti.com>, jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Subhash Jadavani <subhashj@codeaurora.org>
Cc:     evgreen@chromium.org, linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Sep 4, 2018 at 3:47 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Cleaning up the ufs-qcom host further to remove all direct calls
> into qcom-ufs driver.
> Only phy-qcom-ufs-qmp-20nm phy handles these direct calls from ufs host
> and this phy is not used in any supported qcom platform in current kernel.
> So, while we free up the host from all the ufs_qcom_phy_*() API calls
> we should declare 20nm phy as broken.
> For this we fork out couple of configs from PHY_QCOM_UFS -
> PHY_QCOM_UFS_14NM and PHY_QCOM_UFS_20NM out of which we declare
> PHY_QCOM_UFS_20NM as 'broken'.
>
> This series helps in a clean use of ufs phy support for sdm845
> and further SoCs that will also use phy-qcom-qmp phy driver.

Gentle ping, any inputs on this series?

Thanks
Vivek

>
> Vivek Gautam (3):
>   phy: qcom-ufs: Remove stale methods that handle ref clk
>   scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
>   phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as Broken
>
>  drivers/phy/qualcomm/Kconfig          | 17 ++++++++++++
>  drivers/phy/qualcomm/Makefile         |  4 +--
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h |  2 +-
>  drivers/phy/qualcomm/phy-qcom-ufs.c   | 50 -----------------------------------
>  drivers/scsi/ufs/ufs-qcom.c           | 28 +-------------------
>  drivers/scsi/ufs/ufs-qcom.h           |  5 ----
>  include/linux/phy/phy-qcom-ufs.h      | 38 --------------------------
>  7 files changed, 21 insertions(+), 123 deletions(-)
>  delete mode 100644 include/linux/phy/phy-qcom-ufs.h
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
