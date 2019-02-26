Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D25C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC82213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0n0AELs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfBZIW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:22:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34650 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBZIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:22:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so12879313wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 00:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E/toKm2W67VquwuiRmXhzHDGgAg8j43i0iV4VaXFbXk=;
        b=g0n0AELsoQq9+AiH/6fKbg55T6lHhv0vjXDGdrlhzr+qCl9st9984CC065qWS9nRd2
         8+E1I53W7CQwxldX9xpxTx+Qcr8r2MN1b9u63ckiogmKIMGW8BgZlzRG/80YDQFyYucD
         50vZp8TBmxM9CJJRQwrShnHiGRYgKxioky4h0sQm+l90P6yAhQ8og8jxJt/wboa0st+g
         qPJIslJiZGRnsAG6XRfVrIqy4ixyccwPs2xM/sfDtwy3cRZhmmSUCmkOjaz9neZWqFVr
         jm/yhaI7eo95gCSpOJzTzveEogXEAW6V779BgJdHiR505UJ2gif7B2D6TuShOMn5qyBS
         H1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E/toKm2W67VquwuiRmXhzHDGgAg8j43i0iV4VaXFbXk=;
        b=sfMkXIofqiSdrcl/BJ3x7OVrfLR6ZnIvI2gk02EnceEGOm8Ia0VO93ycOtVQmNFmpU
         3bILJKI170b3UO2H8hgnr79X8VeLUwulk+JmrkCwFYK/52RuwxLsFql+Pvq1eFR/QQH+
         wffn0kGHbLrLv+XD548eRnOmKtIjtTtGrT7D670S/MjmkQLOGHfP/km1L7JwNNlu3A68
         2vD7rz+vgfs6h/ga9+7MLmV6fmLsxFNukfz1yXTzAzDJVBNOLkvGsiogyDcbRQs++qML
         BMq0+5f4jVLgsYLOXwu4hx5peIta61R05oeKS8uCf4R7quEzs/nyMt9a0tequFjrRkPo
         c2dQ==
X-Gm-Message-State: AHQUAuYufYsG2kgK+ltAg/VnvsHC/TQL0k1QpY+1ZbdUUZwUyF/MvfSU
        NLnc7n+6edBB/xi/FLNDfwfNew==
X-Google-Smtp-Source: AHgI3IaXlJ9u9gUWRaytfB3+DLkn6nmvt30Iub3Q3XRQSQ3AYM6Rh/FK8WvPHCY3KYaUdraB8drkXQ==
X-Received: by 2002:a5d:668e:: with SMTP id l14mr7560048wru.198.1551169373731;
        Tue, 26 Feb 2019 00:22:53 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id w10sm15296930wru.5.2019.02.26.00.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 00:22:53 -0800 (PST)
Date:   Tue, 26 Feb 2019 08:22:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] UFS on APQ8098/MSM8998t
Message-ID: <20190226082251.GI4118@dell>
References: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43768d77-80b7-9cdc-b6e0-08ec4a026c21@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Marc Gonzalez wrote:

> Hello,
> 
> This series adds support for the UFS host controller on APQ8098/MSM8998-based boards.
> 
> This should be the final rev ;-)
> 
> Differences between v4 and v5:
> - Drop patches that have already been accepted or spun off
> 
> Differences between v3 and v4:
> - Rebase on top of -next
> - Pick up Douglas Anderson's UFSHC doc fix
> - Document 8998 UFSHC binding
> - Improve UFS PHY binding doc
> - Put the UFS DT patch at the end of the series
> 
> Difference between v2 and v3:
> - Add qcom,msm8998-qmp-ufs-phy compat string and match it in the PHY driver
> - Drop vdd-hba-fixed-regulator
> - Write the reg addresses with full 32-bit width
> - Set regulator-allow-set-load only on the 3 rails used by UFS.
> - Revert the patch introducing ufshcd_set_vccq_rail_unused
> 
> Difference between v1 and v2:
> - New patch to add 'regulator-allow-set-load' prop to all vreg nodes
> - Rename rpmcc node to 'clock-controller' + Add Review tags
> - Drop UFS pinctrl gymnastics (not required, probably left enabled in bootloader)
> - Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
> - Fix sizes of ufsphy register areas based on Jeffrey's feedback
> - Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + reboot
> 
> 
> Marc Gonzalez (3):
>   dt-bindings: ufs: Add msm8998 compatible string
>   arm64: dts: qcom: msm8998: Allow UFSHC driver to set-load
>   arm64: dts: qcom: msm8998: Add UFS nodes
> 
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  1 +
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 +++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         | 65 +++++++++++++++++++
>  3 files changed, 88 insertions(+)

I assume these are the same patches we've been using in our tree.

If so:

  Tested-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
