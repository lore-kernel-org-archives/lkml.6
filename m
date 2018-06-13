Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C14F7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28282208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C858QjuC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSRAYSvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28282208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935187AbeFMR2b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:28:31 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39435 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934951AbeFMR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:28:28 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so2259839uad.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zXxNRtD54zJjhkWwcdbHGfPKSpj3EL3mI9Q+PPUYaoE=;
        b=C858QjuCIG0IT2G4Art490ECaA3CUxmdh6OYj5/5JjQHmy74+s7mKZouteo3PkrtTi
         NnPN3G30u6e8W4iO8T5R+E4kBUZfyA1Uka4pIhFiaR5xBp6FXdUs/ts3REjRjbUKmdLK
         95TY3b1RcNc3G6DLp4uniJl7Dx85IcJnXGTp/7zjbZJdQa2mfDqqAWusYOUpVGEX9bNt
         WZL4PyScuByEHpZoCwREHFlwxDkJX0mv/LPndl9tHer2AaaKcQojSjsEV02CS/MuO/lS
         NS1bavZGbPUG5eMypX8mcPqKkbOY8qXvYdyaADdF8Ehe2gUn4zfaG13We2wRBK5tSoGX
         6AJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zXxNRtD54zJjhkWwcdbHGfPKSpj3EL3mI9Q+PPUYaoE=;
        b=CSRAYSvLxmLnhMdx0T4/yPCXrOiymSf75wYGmXiar1F7Q5gs2HQs8LGHziLNdkMfsM
         L/GtVrDqvQITmb3ZAyy33C0YYPZ+tueoCH7dRBsVwL7t4mbkt2t2Vdd+hvtmei7O/+jt
         JbYQPCRDX0dmZ9v6tqyAvI6rxHEVBQ2BhmvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zXxNRtD54zJjhkWwcdbHGfPKSpj3EL3mI9Q+PPUYaoE=;
        b=PpU8zE7VSd/nTzbTpWbtIQsV1FfszYI7K+VIl202FLTDmo0gHYfpVmhICYHPQ3TUFH
         a/tynkilLG7ZXX0+L2aSTVVO9xOXbO20z59/qseeveb8VDXoaknnRL9qszJf0Q1ew9Jy
         N18kBSCnSUrbhaVXSTYLEYBSdAJN9750sYg2lARVjhldWCAlTvzIuBAmHETC6+N7dpXo
         NKVMDYICUfMaI/PF1EYyhntG0CCS0WLw1Th5hsD3vi29pGSy+YYpSPEO+fS3T3yeCNS0
         3U3oSM5rYo6qQ/oAjL3xvB9QTjAXdxC++TFxptyQd2jc9eXPlBK2jjELUfUF0wCYvk4P
         Kf4g==
X-Gm-Message-State: APt69E0cGLiTMTW3J3lQf/pze0Q1C0dzyPHH2PSmTMeOtXszdOy1JYgF
        aN+YyvrVPRarnqPmwJKcAyKzomnRYnXN7dJeEdxTvA==
X-Google-Smtp-Source: ADUXVKKJRuJEiXlrktX/On6YJqaZQ7FR16/RtOlCqMyhS7oLCO4Ay85HO57LoN0Oc6iDMPZFL3ISEW4nOahgBRL5RRo=
X-Received: by 2002:a9f:3d21:: with SMTP id l33-v6mr3874893uai.135.1528910906720;
 Wed, 13 Jun 2018 10:28:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:28:26
 -0700 (PDT)
In-Reply-To: <1528823348-30532-4-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org> <1528823348-30532-4-git-send-email-kramasub@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jun 2018 10:28:26 -0700
X-Google-Sender-Auth: XmYfRwYzx3e5xIn0itIeUkRpkuc
Message-ID: <CAD=FV=Uv6t0aqbpFojgg6Y1EGc1VA0aRsPMqhThJEok6PK0P2w@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: sdm845: Add serial console support
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        Evan Green <evgreen@chromium.org>, acourbot@chromium.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:09 AM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
>
> Add the qup uart node and geni se instance needed to
> support the serial console on the MTP.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 41 +++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)

I've posted <https://patchwork.kernel.org/patch/10462687/> which
already includes these nodes plus ones for other QUP peripherals.
Please feel free to comment on that patch.  A few notes about that
patch compared to this one:

1. Label is uart9, not uart2.  No idea where the 2 came from.

2. No sleep pinconf states.  For SPI they were definitely causing
problems.  When I looked deeper into it it became unclear to me what
the point of all this remuxing is.  Right now you are selecting the
"sleep" state in the geni code for runtime PM but nothing (yet) is
actually power gating the QUPs, so the pinmux isn't doing a whole lot.
Even if you power gate the QUPs there shouldn't be any reason (that
I'm aware of) to remux.

-Doug
