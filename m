Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280ED20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IotMuSXr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IotMuSXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280ED20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeH3OqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:46:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58014 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeH3OqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:46:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 848D4606FC; Thu, 30 Aug 2018 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535625876;
        bh=deYTnQDyciVjSagtNf9CCYXyBPKuFJgXtbpZbHoB7zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IotMuSXrMIqW2AAlTJfteiMa5xQa9FTq9VV9E9L4Pm1Cx7CwrU18RwS3c/1p2LcnC
         Et8UwIQSweo/gW7KAcD9BYGKdoQXW47SRU5YtGoBAPmwOQt4ZcY+XE3ncHdZ4guwn2
         l6axSgRIsx61qGsWHwYZOrqLTfKKE26ctzmYXo+Y=
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1180B60600;
        Thu, 30 Aug 2018 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535625876;
        bh=deYTnQDyciVjSagtNf9CCYXyBPKuFJgXtbpZbHoB7zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IotMuSXrMIqW2AAlTJfteiMa5xQa9FTq9VV9E9L4Pm1Cx7CwrU18RwS3c/1p2LcnC
         Et8UwIQSweo/gW7KAcD9BYGKdoQXW47SRU5YtGoBAPmwOQt4ZcY+XE3ncHdZ4guwn2
         l6axSgRIsx61qGsWHwYZOrqLTfKKE26ctzmYXo+Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1180B60600
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f178.google.com with SMTP id d4-v6so9145617qtn.13;
        Thu, 30 Aug 2018 03:44:36 -0700 (PDT)
X-Gm-Message-State: APzg51CWuph+MBE4gRkNXw2CDbCMHDiVsss8yJKztFVZrJ3j/Ul2ZYt3
        E+HhSZtW5BuZuebDphneyV3inXzxCV/19nFzIXo=
X-Google-Smtp-Source: ANB0VdYxVcvNFONs2Kbxg3esl0t5mpbaua78sDl5RWoCxpPEwtjbPN1KKGcSC9xETXl7tZ3oGor2hzIauDNF0D75Jao=
X-Received: by 2002:ac8:4596:: with SMTP id l22-v6mr11369696qtn.184.1535625875329;
 Thu, 30 Aug 2018 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180731100914.19856-1-cang@codeaurora.org> <20180830061604.GM2523@minitux>
In-Reply-To: <20180830061604.GM2523@minitux>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 30 Aug 2018 16:14:22 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGDvt9UX8y7HCwC+QdTdyCLxuj5pNWbbttJAHGEPW+tyw@mail.gmail.com>
Message-ID: <CAFp+6iGDvt9UX8y7HCwC+QdTdyCLxuj5pNWbbttJAHGEPW+tyw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support for Qualcomm UFS QMP PHY on SDM845
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon <kishon@ti.com>, "robh+dt" <robh+dt@kernel.org>,
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

On Thu, Aug 30, 2018 at 11:46 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 31 Jul 03:09 PDT 2018, Can Guo wrote:
>
> > This patch series adds support for UFS QMP PHY on SDM845 and the
> > compatible string for it. This patch series depends on the current
> > proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
> > the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
> > rebased on updated pipe_clk initialization sequence [3]. This series
> > can only be merged once the dependent patches do.
> > [1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
> > [2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
> > [3] https://patchwork.kernel.org/patch/10376551/
> >
>
> Hi Can,
>
> We still have the issue that the older non-QMP phy driver takes a direct
> call to ufs_qcom_phy_set_tx_lane_enable(), which means that pointing
> UFSHCD to this phy implementation results in a kernel panic.

Hi Bjorn,

I have a series that removes couple of these function calls -
ufs_qcom_phy_set_tx_lane_enable(), and
ufs_qcom_phy_save_controller_version() from ufs-qcom, and
make phy-qcom-ufs-qmp-20nm as broken.
I can post it out if that sounds okay.

Best regards
Vivek

[snip]


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
