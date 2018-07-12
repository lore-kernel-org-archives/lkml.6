Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01DFC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE872086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ll3oO4gC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ekX7xACT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE872086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbeGLRZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:25:01 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42672 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeGLRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:25:01 -0400
Received: by mail-ua0-f193.google.com with SMTP id x18-v6so18893935uaj.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6QnmvKBptGa3JHubY9IquB532uhl2eHzuUn9DRyHzsk=;
        b=Ll3oO4gCmNtWpkcKE1VNDWQD8EjktsYPW09qeZ6IVbHYMxT4eYQa1qI19Un+3uY8zy
         L0owZRd9aLvryNIAl9nBceip5BCHIEQPpYYHzYdlobIOvNIMHaLcWPc8oEvn/k8vi0uq
         04c5YVrfqyQa+Cdm6fmkfnvUjWS9k8cHKRv9nYZcSW97hoBz8aJpMwXFgQVUQJtKlLL4
         zxbzmxb0IEaHgJuZBy0H8/vvtF2DW4af1WGt/NgVCwpQk+ZmYBf7u+DRmngBdjuy71kD
         E5FXJJQkDJI3XXPZbQSpPET10/nEmofuMlWC+8jP0xyA28bIZsrFx9dOJnkiN1FezgyF
         ksgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6QnmvKBptGa3JHubY9IquB532uhl2eHzuUn9DRyHzsk=;
        b=ekX7xACTGpkW0sWslNisCVXSkQ4iXX0drtHx1pflmfaJJJyen9huTk7D7AAvbww6Rj
         OxF8PsDldpjzhwP5/uGFWXS3Vk0CxpWKiASqgXU8kJHkO+7h6b19657NKviHlWvX/+5C
         XdLSeA9SuzuveygTa6JvqbI1z/6AOGxIcXPK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6QnmvKBptGa3JHubY9IquB532uhl2eHzuUn9DRyHzsk=;
        b=dymx3gHFGoY1uASvqZAjOB3VKrqA7V5x4deYTDqVQ8a3DLHAGImUJLP7o3f8iVL7aW
         841t9nxfs0qD8MorpwjjHzD/tPlZMNb8ujUcW2hS/KBU2ECxJg7UgixJkLAkOjaR8msN
         5tdNXBEceoZbLMpiGgNWCRzs97ro8UrJ/KcUG7qSqlBFERqbsfrZabzw9dLFF2vyjXEr
         ZWfbyskhh3dPW6QfnSCW5plhxJnnqOM9pFtY6yNPOfQALkUb0vNNYnXolBMSN7fcckBZ
         N5gdcj8xgeW31QZ4aStExdPLxq85iSxEDjfwu4kvTgs8a08+8zz/2VQJUPq3XQzFWFYL
         b0fA==
X-Gm-Message-State: AOUpUlHXfxxpO0KBkiCJvqDsiFcbOP1J2NR6oydtaNU/y10UsQkQHouf
        N8HW+g4fwr9m9YhbngWxdlBxFUcRuB2Pr6nqg3IRGX7VAUA=
X-Google-Smtp-Source: AAOMgpcjiKpBN7w9MeqEPDKHoibMMYYKQp1mUCOXV2N7IRiinSKZzM86uFRjswuWVsmOW2ge2DkoT5uIDDbr/SIA0X0=
X-Received: by 2002:ab0:11dd:: with SMTP id q29-v6mr1970311uac.191.1531415672724;
 Thu, 12 Jul 2018 10:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:14:32
 -0700 (PDT)
In-Reply-To: <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org> <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Jul 2018 10:14:32 -0700
X-Google-Sender-Auth: m_1zTIss_S3E0WQwIeVZodduUbE
Message-ID: <CAD=FV=W-7CfChV0wn29uR-OH7mH65kmO=0yQUWUbksmb6qL=GQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
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
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We also split up the regmap address space into two, for the TM and SROT
> registers. This was required to deal with different address offsets for the
> TM and SROT registers across different SoC families.
>
> 8996 has two TSENS IP blocks, initialise the second one too.
>
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
