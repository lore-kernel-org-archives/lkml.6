Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2ADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C922243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjA7GrJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C922243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeKMA5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:57:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeKMA5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:57:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id u5-v6so4449977wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n63f8denTxvYwZNI1QpVNFX8XMbGJOdaPMvS/XxnFI0=;
        b=PjA7GrJijnsBXU14/mvFj69ZY2U97ADEp0JvHUQvEnrYCrdn7T28KmlP2QtDQnbQ2D
         bdxpToIRJj+WID0qnFULqb14hF7C1f63Xex8ArXxtxqrXN9kICUbzN9Je2TLB2GniZYm
         Bvs62WJantjZSd9+jemcvYe/uYSD4/lOS2+/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n63f8denTxvYwZNI1QpVNFX8XMbGJOdaPMvS/XxnFI0=;
        b=TskIWi5D7gLtQNEchgZUuNApQvDBzb05yjhqbJa38qk8KF/hoBs3/zafYj5l3pxxNf
         i1mXizVs8RridsijUjFQBDfIKvaz8iMmZw6/miO9rpXOOISRE2YsDgrL8fxOO3je6fZ4
         J0G/Kro3Uh0kdszKHM+1D6b1ImNliHD5nXy4TxKyFgwtt/ON8PWEIk8QIDjxF2tyWcYP
         FaGPGJBo2aAtcgqRzBIT0M2Y9WJnmg1e1ITxRh1Gq3rj+GhpCel++Nrl0SipbbPdBuGA
         XqCFfF5fe4NdywJ775cdicLUh27AalSPqmqmL/4OV3mRRux/jrTA+7SwfLmIc66WhTee
         XGyQ==
X-Gm-Message-State: AGRZ1gIVeP3KXU2wB2MACfhv+VQBKVpOvvLWU08xXQHSXObVP2l4AM4E
        mVrn9z+PS22jztEVs9T1V0exlQ==
X-Google-Smtp-Source: AJdET5eJbLLBklHpo393PstE6oedX/YnxdI/ihaUUO7rr9pREsDo17RivsL+ej10Xp9eLslMko2j2Q==
X-Received: by 2002:adf:d090:: with SMTP id y16-v6mr1293944wrh.314.1542035051755;
        Mon, 12 Nov 2018 07:04:11 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm26912846wrq.4.2018.11.12.07.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:04:10 -0800 (PST)
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20181022144901.113852-1-tfiga@chromium.org>
 <20181022144901.113852-2-tfiga@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <95f49917-5051-4604-63ea-ba3966d5179e@linaro.org>
Date:   Mon, 12 Nov 2018 17:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022144901.113852-2-tfiga@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 10/22/18 5:48 PM, Tomasz Figa wrote:
> Due to complexity of the video decoding process, the V4L2 drivers of
> stateful decoder hardware require specific sequences of V4L2 API calls
> to be followed. These include capability enumeration, initialization,
> decoding, seek, pause, dynamic resolution change, drain and end of
> stream.
> 
> Specifics of the above have been discussed during Media Workshops at
> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
> originated at those events was later implemented by the drivers we already
> have merged in mainline, such as s5p-mfc or coda.
> 
> The only thing missing was the real specification included as a part of
> Linux Media documentation. Fix it now and document the decoder part of
> the Codec API.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  Documentation/media/uapi/v4l/dev-decoder.rst  | 1082 +++++++++++++++++
>  Documentation/media/uapi/v4l/devices.rst      |    1 +
>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst  |    5 +
>  Documentation/media/uapi/v4l/v4l2.rst         |   10 +-
>  .../media/uapi/v4l/vidioc-decoder-cmd.rst     |   40 +-
>  Documentation/media/uapi/v4l/vidioc-g-fmt.rst |   14 +
>  6 files changed, 1137 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/media/uapi/v4l/dev-decoder.rst
> 
> diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
> new file mode 100644
> index 000000000000..09c7a6621b8e
> --- /dev/null
> +++ b/Documentation/media/uapi/v4l/dev-decoder.rst


> +State machine
> +=============
> +
> +.. kernel-render:: DOT
> +   :alt: DOT digraph of decoder state machine
> +   :caption: Decoder state machine
> +
> +   digraph decoder_state_machine {
> +       node [shape = doublecircle, label="Decoding"] Decoding;
> +
> +       node [shape = circle, label="Initialization"] Initialization;
> +       node [shape = circle, label="Capture\nsetup"] CaptureSetup;
> +       node [shape = circle, label="Dynamic\nresolution\nchange"] ResChange;
> +       node [shape = circle, label="Stopped"] Stopped;
> +       node [shape = circle, label="Drain"] Drain;
> +       node [shape = circle, label="Seek"] Seek;
> +       node [shape = circle, label="End of stream"] EoS;
> +
> +       node [shape = point]; qi
> +       qi -> Initialization [ label = "open()" ];
> +
> +       Initialization -> CaptureSetup [ label = "CAPTURE\nformat\nestablished" ];
> +
> +       CaptureSetup -> Stopped [ label = "CAPTURE\nbuffers\nready" ];
> +
> +       Decoding -> ResChange [ label = "Stream\nresolution\nchange" ];
> +       Decoding -> Drain [ label = "V4L2_DEC_CMD_STOP" ];
> +       Decoding -> EoS [ label = "EoS mark\nin the stream" ];
> +       Decoding -> Seek [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
> +       Decoding -> Stopped [ label = "VIDIOC_STREAMOFF(CAPTURE)" ];
> +       Decoding -> Decoding;
> +
> +       ResChange -> CaptureSetup [ label = "CAPTURE\nformat\nestablished" ];
> +       ResChange -> Seek [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
> +
> +       EoS -> Drain [ label = "Implicit\ndrain" ];
> +
> +       Drain -> Stopped [ label = "All CAPTURE\nbuffers dequeued\nor\nVIDIOC_STREAMOFF(CAPTURE)" ];
> +       Drain -> Seek [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
> +
> +       Seek -> Decoding [ label = "VIDIOC_STREAMON(OUTPUT)" ];
> +       Seek -> Initialization [ label = "VIDIOC_REQBUFS(OUTPUT, 0)" ];

Shouldn't this be [ label = "VIDIOC_STREAMOFF(CAPTURE)" ], for me it is
looks more natural for v4l2?

For example I want to exit immediately from decoding state with calls to
streamoff(OUTPUT) and streamoff(CAPTURE). This could be when you press
ctrl-c while playing video, in this case I don't expect EoS nor buffers
draining.

> +
> +       Stopped -> Decoding [ label = "V4L2_DEC_CMD_START\nor\nVIDIOC_STREAMON(CAPTURE)" ];
> +       Stopped -> Seek [ label = "VIDIOC_STREAMOFF(OUTPUT)" ];
> +   }
> +


-- 
regards,
Stan
