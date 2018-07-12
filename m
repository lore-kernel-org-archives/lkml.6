Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB036C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8337720842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="J/YS43IG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oG76GqV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8337720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeGLR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:27:17 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46452 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732355AbeGLR1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:27:17 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so16745096vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8ougSqEQQ9mQIzyOlLITGO0cpw5fZh8to3uUbPunYYM=;
        b=J/YS43IG9spCIQUgaoE/2QzjA71wC0ILKabemv7wBORhd26uQkWwCezs3VfVQvnyQ2
         IsyrBUrtmn7uyAWG12TTlNUgJFGqwuwPjk5FFjuzeZCUOySfWCSwdb4riQXv5KA88HvS
         Tg53eLppsJ/Y0SSNT19vjrpss12SJqM8/n5SglbeGRVhHUFoZUJRGS/OBJKEFaM9RYrw
         1IBIQu64tUy2kAnHlx1kknfQugOdPCtIn0+mCu8HbnDnLmOALIlEaXeCvWdqSGPrxqFr
         A/m2Gmvbft0xHNVnATvDrEE25gAUHiAK38EvaLLV7XiCAExmt/kaU6e9k790DA4efpt3
         3gFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8ougSqEQQ9mQIzyOlLITGO0cpw5fZh8to3uUbPunYYM=;
        b=oG76GqV6r7ML+3H24KdDoSu1FzEWS7Qpr9Vt+f/xInpRdLbZjrgik5XRdzcH/x7L49
         jIIdqY4DQSRNa47OSJABylRGuMGWzBtEKwJAzGFsft7gHWE2yeU7P6Uywf5ENthnySW8
         iJWHAmBxAO1NVuQ7KQFPIoZPf1sZKDL/dsrSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8ougSqEQQ9mQIzyOlLITGO0cpw5fZh8to3uUbPunYYM=;
        b=iEJHj177UjsjPvkFrch+MCAKGzD84fZKmOH93VGU9x+4sU+Ta1iGrHdxj7Z4tL5LdU
         fKAqfFwx9RP3K5AOR6t9KUVXIHCh8T0Pm9uAze5y8mUac9hi8ECAelEnsMhx/fs4JYtb
         PnWfsQAqLjjal1SXgN3tsGuo1Fr5atEjbrIWexAY1AvrOOix+bY8MrB50gy6iafNjixm
         BcYrzEQBXMCmz45M2ncQX5irh+BtnvlvcCQeo2lI3v6eTvSYt6aR2dzxigETILxRziZV
         Xs2in8B/qfAUrC15MWZvtOBkhA9IOMaShvsHu3OkM12hB3eFYz6c9nQbIWjJsCgg6+6y
         1jZw==
X-Gm-Message-State: AOUpUlFkz3p4FkmjfzsAgQAzfbymEVPLaoY5gS+qNKNgRrZTSAruHGr1
        T/+7uofck7+3MQPmG+T2sz//NgtYLOjaPRwLqMXyvw==
X-Google-Smtp-Source: AAOMgpfYfmjEmDz3cWoQnl9d1GfEgoQuK/F0NDJ4y4+uFH/mDJzW1T3RfprCAEk/oq3C/V7tlC2MG+fHebPlFyEmmQ4=
X-Received: by 2002:a1f:7c4:: with SMTP id 187-v6mr1752280vkh.60.1531415807949;
 Thu, 12 Jul 2018 10:16:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:16:46
 -0700 (PDT)
In-Reply-To: <34de426540a878bf77a77dd2c42a16678d6545a7.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <34de426540a878bf77a77dd2c42a16678d6545a7.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:16:46 -0700
X-Google-Sender-Auth: 0rZIsRxTDrJquNYZ_sexNBJ9FhA
Message-ID: <CAD=FV=WRvqE5rwwFMPdtFTnSn+zVY6H84eR=En4gfQye-JW=wQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] thermal: tsens: Add generic support for TSENS v2 IP
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses v2 of the TSENS IP block but the get_temp() function appears to
> be identical across v2.x.y in code seen so far. We use the generic
> get_temp() function defined as part of ops_generic_v2.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 5 +++++
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
