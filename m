Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB8BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97CB21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNWX3uWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBGUX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:23:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39241 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfBGUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:23:55 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so3146438itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riL4aeMftZuDVY32mI/ge9A/S6BebOCGCnHi7iOKIiE=;
        b=QNWX3uWEZqSGHcRLpY4B1BGQaviXUBpnwRUuQ7dG4mLUjiiQr9jc4DiGsCJ2LtT/r6
         T3lbX+GvvR9x+4xVwMHc8lgBagTaVZlEKf0LeRQfA3KZE2D7sg9jc6/5h+vyoli+Od3l
         yERijrIkAr2sdIosEjrAqzuBbddsHNI1dppWDWYU6LZeCHAoFeHOBnxNwj2AxIEKyjdS
         WKxnNPx0cMyHaU09M0BYB3is6TtK1xwlGllvoM0JPe4Rdt6fymWp9nugBEdXQMXSVjB+
         dwan7kKpAntN2ivv2Nqb9j2G9BNRv046QHvwqqTa/vFESEk0eM2FjVD8mRqQD6YHbqN2
         4YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riL4aeMftZuDVY32mI/ge9A/S6BebOCGCnHi7iOKIiE=;
        b=S+WTpW9bJBHyIXPeuk3ATMizpN0jGlItRyJf+lRXxgBigzka51q66n4NuUQgFXvfiV
         8laBvatePMjn9kCG/r1RaLBl9QsrMInj2p5xK/W8IbhYmhTd/luLyMrDbPGhKTf188/E
         AbuHFP9GOA+3zF5bMGGQI3DVA0AuIwYzONMkXgmtpwh6+8yW95Tt3+JPAaUAGg8YT+Yw
         XHgjj4iYdUqzcu2mgNmJMztFoZ9b0v6x+EdslAzpcIb+fqSa+n+9/EusJh4RctoKKIeF
         HPVQjDeZelNa39VIEnp2Z7pss6PNoXQ+P6vliBs7HrauI/s0h8yPTSYi5TH1LDihNbqG
         x1iw==
X-Gm-Message-State: AHQUAua+V7dyuGIPui3kxR/TWqjqamD2hdDIAHmYKYBRzju63WFSnPJZ
        AdOj+oUKiBk/cBr/xAyIer8EG0fG1ziXM09yXvxibA==
X-Google-Smtp-Source: AHgI3Iabjx4wq+Co5s+X0CHwdrtDxpzfMrJe50WGxdf3XpiGAUHw3ZZ3/1ISLL179jtUAvmQTT/1XBWgaqUcNcNnPQk=
X-Received: by 2002:a5d:960e:: with SMTP id w14mr8738373iol.86.1549571035185;
 Thu, 07 Feb 2019 12:23:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org> <f5712a48f499d3b2e89f58a43eb30d3dff8b1103.1548981329.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <f5712a48f499d3b2e89f58a43eb30d3dff8b1103.1548981329.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 7 Feb 2019 13:23:44 -0700
Message-ID: <CANLsYkzUwii1NrAPGUr3A-odSLe+L63sDErvRnym0MDg0Hkt0g@mail.gmail.com>
Subject: Re: [PATCHv7 4/6] coresight: etm4x: Add support to enable ETMv4.2
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> SDM845 has ETMv4.2 and can use the existing etm4x driver.
> But the current etm driver checks only for ETMv4.0 and
> errors out for other etm4x versions. This patch adds this
> missing support to enable SoC's with ETMv4x to use same
> driver by checking only the ETM architecture major version
> number.
>
> Without this change, we get below error during etm probe:
>
> / # dmesg | grep etm
> [    6.660093] coresight-etm4x: probe of 7040000.etm failed with error -22
> [    6.666902] coresight-etm4x: probe of 7140000.etm failed with error -22
> [    6.673708] coresight-etm4x: probe of 7240000.etm failed with error -22
> [    6.680511] coresight-etm4x: probe of 7340000.etm failed with error -22
> [    6.687313] coresight-etm4x: probe of 7440000.etm failed with error -22
> [    6.694113] coresight-etm4x: probe of 7540000.etm failed with error -22
> [    6.700914] coresight-etm4x: probe of 7640000.etm failed with error -22
> [    6.707717] coresight-etm4x: probe of 7740000.etm failed with error -22
>
> With this change, etm probe is successful:
>
> / # dmesg | grep etm
> [    6.659198] coresight-etm4x 7040000.etm: CPU0: ETM v4.2 initialized
> [    6.665848] coresight-etm4x 7140000.etm: CPU1: ETM v4.2 initialized
> [    6.672493] coresight-etm4x 7240000.etm: CPU2: ETM v4.2 initialized
> [    6.679129] coresight-etm4x 7340000.etm: CPU3: ETM v4.2 initialized
> [    6.685770] coresight-etm4x 7440000.etm: CPU4: ETM v4.2 initialized
> [    6.692403] coresight-etm4x 7540000.etm: CPU5: ETM v4.2 initialized
> [    6.699024] coresight-etm4x 7640000.etm: CPU6: ETM v4.2 initialized
> [    6.705646] coresight-etm4x 7740000.etm: CPU7: ETM v4.2 initialized
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index dd9b9b5ebb84..08ce37c9475d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -55,7 +55,8 @@ static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>
>  static bool etm4_arch_supported(u8 arch)
>  {
> -       switch (arch) {
> +       /* Mask out the minor version number */
> +       switch (arch & 0xf0) {
>         case ETM_ARCH_V4:
>                 break;
>         default:

Applied.

Thanks,
Mathieu

> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
