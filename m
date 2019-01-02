Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D98C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62721871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FBEa43m6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IC3u7jYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfABGxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:53:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55832 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfABGxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:53:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2075460722; Wed,  2 Jan 2019 06:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546412019;
        bh=LdY8Ra5M7gO19CjvFD2Lx40hX8syi3I8rI81KrSAHgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FBEa43m6eog9vD7gzyAiozOyVgngUF99Hyeahk3N9hpzNCn2wycBkTxgw/QGRSAjV
         Q4dGUemAkyUZ8gxHO0EC2ldmnMntrJwZfHGr1YuwHos7jxXEMUzuvR6T1vNT65A5un
         UpSN+6dzzZ6g8xPqWStSRpYPr7NwXpqYG4B0dEpA=
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07F5B607B9;
        Wed,  2 Jan 2019 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546412018;
        bh=LdY8Ra5M7gO19CjvFD2Lx40hX8syi3I8rI81KrSAHgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IC3u7jYSagRZa6Bi22Q30XL6zrtemV5+9eur0T2B9jHLAdBovEmNhh5bk6JjCXDS1
         RWrffTvwrq7hFk9IkX1vEOJkamtvbXPaErJIN6/wJ7IizKNG0jK8/R6PRAyO+VV7Io
         EoM3xLjgA9NvRcQ4Tjb2S52bBmZX1R646BFJ9KUo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07F5B607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f182.google.com with SMTP id 68so17391795qke.9;
        Tue, 01 Jan 2019 22:53:37 -0800 (PST)
X-Gm-Message-State: AJcUukenEguY/Ch44QBXeF8fFUBglzS8fi04iZx9DbTj+1PXvuBJUTSy
        /4sOijiqHul6jew0k/e+jsISoigGgodT1/1K1pg=
X-Google-Smtp-Source: ALg8bN42KqejsMQ47DfzPkofUzxAsLoJgrlstrf4IWNQKNxQk91B3SQs1pRIBwp5B/A2wJUlnbAK6z8UUxepjXQEuiE=
X-Received: by 2002:ae9:ed13:: with SMTP id c19mr20952149qkg.85.1546412017258;
 Tue, 01 Jan 2019 22:53:37 -0800 (PST)
MIME-Version: 1.0
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
In-Reply-To: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 2 Jan 2019 12:23:25 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHTCXutb2x+-11Skz=8159t9v=_POaLuoYpt3NsWuwe3A@mail.gmail.com>
Message-ID: <CAFp+6iHTCXutb2x+-11Skz=8159t9v=_POaLuoYpt3NsWuwe3A@mail.gmail.com>
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 9:43 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> The private copy of readl_poll_timeout is no longer needed.
> Use the implementation in iopoll.h instead.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> index 681644e43248..f798fb64de94 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> @@ -23,24 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -
> -#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> -({ \
> -       ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> -       might_sleep_if(timeout_us); \
> -       for (;;) { \
> -               (val) = readl(addr); \
> -               if (cond) \
> -                       break; \
> -               if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> -                       (val) = readl(addr); \
> -                       break; \
> -               } \
> -               if (sleep_us) \
> -                       usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> -       } \
> -       (cond) ? 0 : -ETIMEDOUT; \
> -})
> +#include <linux/iopoll.h>
>
>  #define UFS_QCOM_PHY_CAL_ENTRY(reg, val)       \
>         {                               \
> --
> 2.17.1

Thanks for the patch. LGTM.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
