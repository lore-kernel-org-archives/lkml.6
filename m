Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242E9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043120C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FVqidxwT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYjXuG1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D043120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbeGKSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:46:20 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40909 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeGKSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:46:20 -0400
Received: by mail-ua0-f196.google.com with SMTP id p22-v6so6259444uao.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=StsK0y+TXw8SQjoyjXSLxslWcfC7d/glc84kEaJpGJk=;
        b=FVqidxwTdDb+CgUgQOeYKEEMIuFqJrUJr9GxGuFAICLrtjrky/psMR2i1t175Pfoe8
         8DmjTZJGdSmKiocQbUJzq7kmNCoBXE+QWEgvYN6K4b8BWRmLpdCcQ7BVKH8fvLc69xkS
         JNLzECYRQ5f3rbTwqByu3WR/mZDlrmTGPotGg6EKHzppqRPYQB2Meo99nD7N6Gii2gSB
         q/U4peVpNHOJzoVtIf2XqdY6AfFXiW7+u56898q0KqK/l1srBhiNor1+0ojuWlTMKwHu
         5txXcRYa3MV7ejWa5sOH6z7sa0gMYcnGxEtoLhHCYahfh1vzLXkaPlvX5amh7vtIMqOo
         REqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=StsK0y+TXw8SQjoyjXSLxslWcfC7d/glc84kEaJpGJk=;
        b=aYjXuG1JR2LofDbI3FpNmlxLCncApgCUSAcuflV1z2g99p+h411Ze3G4M8rEg42BIM
         55UvW0rddAKZ6U7Ii50HD7Yfx0hSBJaEx0REJ+Ha8OaWc7/L6Eymv8ut7b4OSHw6bGnC
         PqxERqJi4hVIeLybeFOW6Uw+2EuQkB6dzWRTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=StsK0y+TXw8SQjoyjXSLxslWcfC7d/glc84kEaJpGJk=;
        b=jzpHZYWQkcXbKXUCT1pimTZbulllqqTEW5npMSE9KrTCL5HezwK7kvFhDclSxOu4Dz
         YVZSZsSiOsGyrQP0a1E0eepQDGmsOciUen4+Enc3OzUH8CHqK+6gEU/pi5b/4avB9OrN
         ChilLMGc9rWQFuoa/Fb7mT9NqU8c4iPZtQhlTKFjf8d6wUOD2qXEnT9Pjtcvw83uMZ9B
         qePRfj0I5cNItm3sYOIEWtVoTeHRFNUHWkJrAotB9KsTEK/2BfaNRwGzhB4TT7tupGJB
         SzbutL6pDbMJcvWUAlx3ai6Q5RtCBzywz6xUQT4nIQlMFGJfJcNyobSO6YyYglQmowFy
         rX6w==
X-Gm-Message-State: APt69E1v7sVWlIBdpXOHwpqasdpRli29vTnCiGVGeuTI0HekF4UauxDP
        0qHpv7jeWS1uSBD8woUcvzN44nkpu9ra+WyNv281tR5C
X-Google-Smtp-Source: AAOMgpfA5JURnkbajxFzpWUkhrt9RcTj9nq2zTfvwCSXbQgeBMKRjReDTVdFRMALgP7Y9mcDQ7zZegi7aeljFF7IBM8=
X-Received: by 2002:ab0:4946:: with SMTP id a6-v6mr19228675uad.82.1531334443565;
 Wed, 11 Jul 2018 11:40:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:40:42
 -0700 (PDT)
In-Reply-To: <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 11:40:42 -0700
X-Google-Sender-Auth: QhSONF-83OUb4e9ZS7C6jqMkbxk
Message-ID: <CAD=FV=WFEubDtHkL7-8DF6nPuRL4HBHOghc3YekazXUnS6vrBA@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2 IP
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> SDM845 uses v2 of the TSENS IP block but the get_temp() function
> appears to be identical across v2.x.y in code seen so far. We use the
> generic get_temp() function defined as part of ops_generic_v2.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c | 6 +++++-
>  drivers/thermal/qcom/tsens.c    | 3 +++
>  drivers/thermal/qcom/tsens.h    | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 34ba6c7..f40150f 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
>         .get_temp       = get_temp_tsens_v2,
>  };
>
> +const struct tsens_data data_tsens_v2 = {
> +       .ops            = &ops_generic_v2,
> +};
> +
> +/* Kept around for backward compatibility with old msm8996.dtsi */
>  const struct tsens_data data_8996 = {
>         .num_sensors    = 13,
>         .ops            = &ops_generic_v2,
>  };

Something seems fishy here.  You have a ".num_sensors" for sdm8996
hardcoded to 13 but you don't have a ".num_sensors" for your new v2.
Where does num_sensors get set for everyone else?  In patch #3 you
have a new "#qcom,sensors" but:

1. Nothing reads this as far as I can tell, so that means everyone
will end up with 0 sensors.

2. On your 2nd block of sensors in the sdm8996 device tree (see
earlier patch in the series) you try to set qcom,sensors to 8.  ...but
since you still have a compatible of "qcom,msm8996-tsens" you'll get
13.  That seems wrong.  ...or did I miss something?
