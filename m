Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D65C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48320666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NV/Vv8oK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A48320666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLCJqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:46:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeLCJqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:46:23 -0500
Received: by mail-io1-f65.google.com with SMTP id f10so4078011iop.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX/oVY2dCQZV9wB0dqBOQ1Y9CXOpcurqPsBoTPeFU9A=;
        b=NV/Vv8oKkJbOGgncyncAly3ZM3ixLFbHtO2wBAZNJkiKfS8NNSJAvawVnaWZpaAEQX
         Z+nP1lQurEARSabZUKSz6zimgjAtIyFt7dzvJqI3yoO5fcSD/Plmpi4q0nBrbAsbclPM
         991fESTLZzEnNM73/aDK8+3eUSVLjuuFKrel4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX/oVY2dCQZV9wB0dqBOQ1Y9CXOpcurqPsBoTPeFU9A=;
        b=DB+g53wpQ1eNZRg/V3DVRDDxySEqLIaWyfwmRbL5804uXvjlKzaniuWCKrq3uG8tjv
         MEJ0Up/ubjqWPzQebXxFmLxMeT/AI36SQwTbzHbNxF5tvGLyjjLMGqHXLLEVbahIfOgi
         FpL1McMAwZFXtxS0pPukl4pG2+9YWcxaLjGVfKX0IRuDBtpSrhVL2bfWRlxeQYvDEIgo
         oXqe2v2Db3L4Br6kensfBDYEYG+0r/l5H4KbJ9X5cV9yF68h1bM4d9iNJyBcPFKKnBVA
         P7Cc/WD1ljTRhGZ3Hfm+0fsEBXIFQMow1HezyCItWAZA77M8fvzzYrrkIltkUaaJR+3Q
         YU3g==
X-Gm-Message-State: AA+aEWZ9vbMENHodbaVwd5RRotD6dyFZg0zm05+WWRGSe2RaCmez8jU/
        0MZjZVWay3t5H3PRl1IPI/KikuMg6DBSGLwKtYmSiA==
X-Google-Smtp-Source: AFSGD/VvDosaN9x1V3PzhUddlNU+hYmKF3M8EwPXRb7DRfo05o2o5+fTkBK3IDds4HzoEe/vUi7ncvBlKICaEGvRjME=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr13372052iou.252.1543830365247;
 Mon, 03 Dec 2018 01:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20181130075849.16941-1-wens@csie.org> <20181130075849.16941-5-wens@csie.org>
In-Reply-To: <20181130075849.16941-5-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 3 Dec 2018 15:15:54 +0530
Message-ID: <CAMty3ZB6p8Uv7abMC8jDHHYwdAeuBen2GPjOhN=wEL7+=DDt3g@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: sunxi: h3-h5: Add pinmux setting for CSI
 MCLK on PE1
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 1:28 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Some camera modules have the SoC feeding a master clock to the sensor
> instead of having a standalone crystal. This clock signal is generated
> from the clock control unit and output from the CSI MCLK function of
> pin PE1.
>
> Add a pinmux setting for it for camera sensors to reference.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

On Fri, Nov 30, 2018 at 1:29 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The CSI controller found on the H3 (and H5) is a reduced version of the
> one found on the A31. It only has 1 channel, instead of 4 channels for
> time-multiplexed BT.656. Since the H3 is a reduced version, it cannot
> "fallback" to a compatible that implements more features than it
> supports.
>
> Drop the A31 fallback compatible.
>
> Fixes: f89120b6f554 ("ARM: dts: sun8i: Add the H3/H5 CSI controller")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
