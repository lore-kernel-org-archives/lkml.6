Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C1C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F001220C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bRRv9Qzj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XF1kMWmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F001220C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbeGKSmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:42:44 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33673 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbeGKSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:42:44 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so9946507uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xqZ2dSxzOUMe1Bz8rDCrWpiBkj9Gp8F7NFF29IVWX7g=;
        b=bRRv9QzjWxQ/SbRqtVqlhQXVFbAr3YsdGN5Xo1vBz44ApT98128QxnMAwG06a57D4k
         UPxrIN/N1Aj7cuBelHKsRSQz0r4P2wC3cdCHAaiJz5wwmXofZofedo8rAzbhteXJvSBn
         Cqp+zL11JGXiGPrFtmsXfyLAV2HyXa/5yXbv1GDgvaYDAx3BHELWLVg6rmAam5qcMpC+
         88bv5YPSv0JuRzUdqLDiTcQ4giGELmc16ljUAv879OHfGWeBwerKRynWSxJVY1PU3Rpm
         jYaPJOce9GS7bDkEeqktakBeEnYeYyJ39L/svnHQ0K8k/yJR5lu4kpv/5KZgVSA91Laz
         OHuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xqZ2dSxzOUMe1Bz8rDCrWpiBkj9Gp8F7NFF29IVWX7g=;
        b=XF1kMWmolw88q2HpGsX0eE6/FHTpHVXFPyg0VAQNxi1/ILiVCQS1S3rpV4I8vYZbi9
         DVpBvmVBnYI+a1CA4GOSbPSo2MCucchEghYNYXbrYcL2W4VDNanvRYG204+dfdCwSNGH
         aimQa7m7eFudaGbHKyypcMzB3x8r6b7o+xDcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xqZ2dSxzOUMe1Bz8rDCrWpiBkj9Gp8F7NFF29IVWX7g=;
        b=boGDFR5L7TK2ZM0Ku2ib+kwiC50NQXhxILNNpcV8F+ae9jmZWLIfPNigFQUngmYkjD
         68iLR7L6DdCYScneVusZYhLaH9ZKi9AaW81XxBEM9aP1nZD5lGTbfFVeQMPgjAjfYDU1
         e/DdSn5TmfFRG+aIPBGiOdSJslm4QXLJBrj1BiY/trOjrG7ICQsFMNj2GIYOz2+knPaD
         NNCJrrNbf6La0SzHwnH7K1zoW+OoQJdqF639yDMh5ZAhTZUXWRvgD1GakJVjZN3noLKV
         pIngRqOtXQjnCPeRa676oTeyFlS4WywvHjlLC4ny8WXimMXK6JtQLrjor0I6Xnv16f7+
         U73g==
X-Gm-Message-State: APt69E2yiJqHHYF13hc9IYul5TwOVey6TvVCR4APPJxQG769dH1mZRbW
        aXJxEo3M58UswHHaq8BE0Umdpw7gGwOYhoW5O3Kuzg==
X-Google-Smtp-Source: AAOMgpdxGIkpgf9M6Ne6rIKELyKakOZgAWs1pCLpCHtVpsMOHwfU0jiv1iXGdONnIwCuiuLSFKcM9DrRiem70iv2DXQ=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr19222243uad.82.1531334228082;
 Wed, 11 Jul 2018 11:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:37:07
 -0700 (PDT)
In-Reply-To: <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 11:37:07 -0700
X-Google-Sender-Auth: Jc_rxfarNehnjvDkxnRDB0NaV-M
Message-ID: <CAD=FV=UGjf+qSfzYbQ1OEydEWJH2e8vhNiOPAytPH_rnkabq3Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] thermal: tsens: Add support to split up register
 address space into two
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
> SoCs these were contiguous, leading to DTs mapping them as one register
> address space of size 0x2000. In newer SoCs, these two banks are not
> contiguous anymore.
>
> Fixing old DTs to split the address space into allows us to have cleaner
> common code e.g. get_temp() that is shared across new and old platforms.

This makes it sound like old DTs won't be supported anymore.  ...but
the code says otherwise.  I'd just remove the above paragraph.


> @@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
>  int __init init_common(struct tsens_device *tmdev)
>  {
>         void __iomem *base;
> +       struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>
> +       if (!op)
> +               return -EINVAL;
>         base = of_iomap(tmdev->dev->of_node, 0);
>         if (!base)
>                 return -EINVAL;
>
> +       if (op->num_resources > 1) {

Maybe add a comment here that says that we don't actually map the SROT
yet because you don't read anything from there?  I kept getting
confused about how this patch could possibly work with no code to map
SROT...

> +               tmdev->tm_offset = 0;
> +       } else {
> +               /* old DTs where SROT and TM were in a contiguous 2K block */
> +               tmdev->tm_offset = 0x1000;

This patch without patch #4 will break compatibility.  You should
squash part of patch #4 into this one, specifically:

-#define STATUS_OFFSET 0x10a0
-#define LAST_TEMP_MASK 0xfff
+#define STATUS_OFFSET 0xa0
+#define LAST_TEMP_MASK 0xfff

Without that you break bisect-ability and also confuse anyone trying
to look at this patch.

-Doug
