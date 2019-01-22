Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75475C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C8120856
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b2o9Cg3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfAVTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:04:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43726 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfAVTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:04:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so12204133pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :references:subject:from:message-id:cc:date;
        bh=1430ryyH8ftf37ivOWfxzd7tRXPSdNdok9e9SW9Cz4U=;
        b=b2o9Cg3sDbqTJFblRSyjw9Scda59tDKa96b1dh6R7HJ80HKhG/7m7vLGw1h54SF9o3
         n1ZswMYdXq/rTexVfZpdWmdtEnjc+u99wzG97zr/6rX+TTXmTSjy4v76F+cI/tzMIIYz
         GpQWCAlYuI77VLZ3eN4RM7VhPlr5zXKtikz+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:references:subject:from:message-id:cc:date;
        bh=1430ryyH8ftf37ivOWfxzd7tRXPSdNdok9e9SW9Cz4U=;
        b=OczEAm4kVYUL92/oS9D3BOKAZBtPdM+pfyqEd7eMR0SkHRDy/cIiLx5EOEkC38utjJ
         aLFSQd7nrXLM3gvF0/uhYSRhUtApBptP8sob+s7pIOb4ri9EtjdtEwZg+OVOHfPNxXAS
         raRtRgj8sJGhLgccEu6snxZ0jSyGwEUSTjAdVnA2srv6DZ46Jdh9Ysm385y8LFTIy9CD
         hkPv8ckLVLoYWvfTVaLA0dICBldaQm3QHKPSokkPwZwQrLKLBD+8U/mbTXOJZdTBkHLV
         utO6f0ZvNUJxmKdhbm0Zclgg6LiRM5yH2cMwVP29VGhx2S2cK0LlewJkJ4wGvD7xHysg
         YtFQ==
X-Gm-Message-State: AJcUukdfR5z6qYFhutbo6YUbESp94ellhsVQkIW5q4rYoXt1Y2EqYPfU
        318z5OUaSDg5OlVBfBvGx3Xu2A==
X-Google-Smtp-Source: ALg8bN6k5XEybICRkSa96zR+pcTfcOW/amwxTq0dTFbukvo1BqnRGg3xFiRwjne5fTwn8jXACh4Zig==
X-Received: by 2002:a63:990a:: with SMTP id d10mr33180022pge.279.1548183859553;
        Tue, 22 Jan 2019 11:04:19 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l5sm27095849pgu.86.2019.01.22.11.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:04:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
In-Reply-To: <20190122055112.30943-5-bjorn.andersson@linaro.org>
User-Agent: alot/0.8
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-5-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 04/10] dt-bindings: soc: qcom: Add AOSS QMP binding
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154818385792.20280.7601798748317142776@swboyd.mtv.corp.google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 11:04:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-21 21:51:06)
> Add binding for the QMP based side-channel communication mechanism to
> the AOSS, which is used to control resources not exposed through the
> RPMh interface.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>=20
> Changes since v2:
> - Update indentation of example
> - Add colling device subnodes to the description
>=20
>  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 75 +++++++++++++++++++
>  include/dt-bindings/power/qcom-aoss-qmp.h     | 15 ++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-=
qmp.txt
>  create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
>=20
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt=
 b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> new file mode 100644
> index 000000000000..881dc8c7907a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> @@ -0,0 +1,75 @@
> +Qualcomm Always-On Subsystem side channel binding
> +
> +This binding describes the hardware component responsible for side chann=
el
> +requests to the always-on subsystem (AOSS), used for certain power manag=
ement
> +requests that is not handled by the standard RPMh interface. Each client=
 in the
> +SoC has it's own block of message RAM and IRQ for communication with the=
 AOSS.
> +The protocol used to communicate in the message RAM is known as QMP.

Just curious if QMP is "Qualcomm Messaging Protocol"? I don't think it's
ever spelled out in this patchset.


