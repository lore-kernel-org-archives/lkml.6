Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E75B2795E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ixhZvj4W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oe0Z8+Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E75B2795E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967091AbeF1WxC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:53:02 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40025 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965236AbeF1Ww7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:52:59 -0400
Received: by mail-ua0-f193.google.com with SMTP id j17-v6so4611442uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EOX0k6Ix6BS6Cg4nJ9Y1P44i0hKigEfUM9TTZqjWAdI=;
        b=ixhZvj4WlUAMHA27CFru4fa94xBeSIkhkdJUpQXPJYJUSqQKNSK4hVc3EoEVenpL69
         mB7XcEZnNVgHDUhHAM2xSwOEj68AA2pY48OnbKuB5H9+OqtceGWnzkW/rG5jy99wiihN
         ElQruhOHCtxjRz/bCKbu1g3CvoH93DdYWG1zAnbTI8UOuWtw2he5dp77ii9v+06qMABP
         ZEbGuHuWAfMX+0+1YNvgJj/PQKda54RGLRJVb8ZR/jNA/SHnKl3O02M/7wW7cQninsT4
         LEE96qytUfPsW0AuuheSG8wJKXOoBVmxYOgaGAAzlCARQ/UoUn60W9Ds7vFH0+MPaZ4W
         fPjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EOX0k6Ix6BS6Cg4nJ9Y1P44i0hKigEfUM9TTZqjWAdI=;
        b=oe0Z8+PdE6Je6+R0GvbDqpVyUnYMdDrtU+lmDIy3DcO6vyHHnA0LTa0MUIEZ9vHUw7
         39GsKS08UKZwNH+Y5eQZhziwrIyKXn2q/WArfgPdoKG+A3ksw17N2+9uH/t9C030QcER
         ftmX3MNFIlpgLVCid95K6QMeI2Kh6MZ2E6H8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EOX0k6Ix6BS6Cg4nJ9Y1P44i0hKigEfUM9TTZqjWAdI=;
        b=JgRwYs5Bbq9gVe2pp1pjb+GRDjEl25OrldLgRe5U2+vtI0Z2X71vLKL3dqPHpuEycP
         WKVsQ6G2CXNK2D6yOu6q9Rn3BOpHvQsHGQkjL9tyJUayhyS7utmAInZf5YLiX2tJUmrR
         n7X8GqqjIYPDo7gSTbpiU+QXM3klRwfAhMlhGJKAYQIR4Au5omE/xRNxq4M0H7/TkZ5R
         jlMn47i3LqTUAuAFtCzKGuUkiOOkbAVNJhX7bvqVYdIjrrlQF9g5m4zjZ3G/z7mZa7ZQ
         20ckMD7ii6hzJVOelwpAKfFp0zzD0C0vfg+dpygV4XU+2pKCRNNMJIcVfHMDxr9JgE5F
         5aHQ==
X-Gm-Message-State: APt69E1dCDJr7KS1i2iAllZViLh6FF6yeA+lO4Q0LUzYdG/IOqYEeaJR
        8a0O0jiiiFDoe1u1iec+R1/Yxb8+Q2MK7RU7MSi4FA==
X-Google-Smtp-Source: AAOMgpcXlgfMN6cNeWfoEkIZMfeLz4kJaA/QdkMkj4lV7J/3JXNOEW3UJYRjlSFG8bznKmwW9WzTCawn+wOUMLcneLk=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr7747340uaz.82.1530226378084;
 Thu, 28 Jun 2018 15:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 15:52:57
 -0700 (PDT)
In-Reply-To: <20180628210915.160893-1-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jun 2018 15:52:57 -0700
X-Google-Sender-Auth: HDD-UbGwTMZmvYWfGyiUcvKnQzE
Message-ID: <CAD=FV=UPCgEvN1F5jFhLxq=KrH2_BwEG=ZRX3npy_EPLZ_V0hA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add thermal-zones node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The node is empty for now. It is needed to allow other DT snippets
> to add thermal zone entries.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Sorry if you received this twice, lists were missing in cc in the first attempt ...
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 00722b533a92..968390fb0933 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent = <&intc>;
> @@ -1087,4 +1088,7 @@
>                         };
>                 };
>         };
> +
> +       thermal_zones: thermal-zones {
> +       };

Others can feel free to disagree, but IMO ${SUBJECT} patch is not
needed.  Instead patch #3 in your series should just define a
"thermal-zones" node at the root level.  The "thermal-zones" node is a
well-defined node with a well-defined node name and location (see the
"thermal.txt" binding).  If the SoC has a "thermal-zones" node and so
does the PMIC then they'll just be merged.


-Doug
