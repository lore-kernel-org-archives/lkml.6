Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35176C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D334D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nt+tZ6V5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AZnuuCKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D334D20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeHAEEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:04:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeHAEEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:04:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E4066074D; Wed,  1 Aug 2018 02:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533090069;
        bh=KB47MhAa5w9y49UD7Xc+yWig1iDOzcTcMdLox7qCnPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nt+tZ6V53koQWTVklEFpuXf7YZ+SiSqM8ncGlqlY4wI3ve9JQXKnu9CthZB9q31Q0
         QfnfPg+YHOH4rW5qBOShZmAl+Y+hrY86rGsFXBb9USQxjCBPf6sjkHYUEBM9l0FuzA
         Eux+Q6EKohyb/lbzDiRtnvueq8XjSulmOnHWE5SI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 130ED60481;
        Wed,  1 Aug 2018 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533090068;
        bh=KB47MhAa5w9y49UD7Xc+yWig1iDOzcTcMdLox7qCnPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AZnuuCKGw6stq5fTIWh04QBsteYerHRpANVbpRq0zM2NqFXDMddPBGewSC2INoSjx
         rAPD2KcSDjUACLCHtT0JP2cXaPPAb3z2IaXW9/5C/h2oCTplBtkn0sBsSnmpbx880h
         GLG0iVi76G4MS9QQTAU+zwWJjB/Q+Df/CzsOgVGE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 10:21:07 +0800
From:   cang@codeaurora.org
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, evgreen@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 0/5] Support for Qualcomm UFS QMP PHY on SDM845
In-Reply-To: <20180731100914.19856-1-cang@codeaurora.org>
References: <20180731100914.19856-1-cang@codeaurora.org>
Message-ID: <1cafb427567bfd6ea8dfd011e4539097@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 18:09, Can Guo wrote:
> This patch series adds support for UFS QMP PHY on SDM845 and the
> compatible string for it. This patch series depends on the current
> proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
> the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
> rebased on updated pipe_clk initialization sequence [3]. This series
> can only be merged once the dependent patches do.
> [1]
> http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
> [2]
> http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
> [3] https://patchwork.kernel.org/patch/10376551/
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
> 
> Can Guo (5):
>   phy: Update PHY power control sequence
>   phy: General struct and field cleanup
>   phy: Add QMP phy based UFS phy support for sdm845
>   scsi: ufs: Power on phy after it is initialized
>   dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 216 
> +++++++++++++++++++--
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
>  drivers/scsi/ufs/ufs-qcom.c                        |   4 +-
>  drivers/scsi/ufs/ufs-qcom.h                        |   1 +
>  5 files changed, 219 insertions(+), 21 deletions(-)
