Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbeFEEJA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:09:00 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34760 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbeFEEI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:08:58 -0400
X-Google-Smtp-Source: ADUXVKKaXRHUIxUTFNDXEvu/9MN3tXBw+8cjtJ8GlAegPCzBsH24LR1lN6XZIR6cWNj5BcAAioAK5g==
MIME-Version: 1.0
References: <1527884768-22392-1-git-send-email-vgarodia@codeaurora.org>
 <1527884768-22392-6-git-send-email-vgarodia@codeaurora.org>
 <CAAFQd5D39CkA=GucUs7YOHwsdj0gbk55BiY_gSvArY_RH4uDkg@mail.gmail.com> <2cf4f7e8-f9e6-d62b-45a8-2c348af4aafe@linaro.org>
In-Reply-To: <2cf4f7e8-f9e6-d62b-45a8-2c348af4aafe@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 5 Jun 2018 13:08:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BFq+pdEpBmpw5QsO+m+fsAhexhqA_uJg1G39Mpv5E3HQ@mail.gmail.com>
Message-ID: <CAAFQd5BFq+pdEpBmpw5QsO+m+fsAhexhqA_uJg1G39Mpv5E3HQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] venus: register separate driver for firmware device
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: vgarodia@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        andy.gross@linaro.org, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 10:56 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Tomasz,
>
> On 06/04/2018 04:18 PM, Tomasz Figa wrote:
> > Hi Vikash,
> >
> > On Sat, Jun 2, 2018 at 5:27 AM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> >> +static int __init venus_init(void)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret = platform_driver_register(&qcom_video_firmware_driver);
> >> +       if (ret)
> >> +               return ret;
> >
> > Do we really need this firmware driver? As far as I can see, the
> > approach used here should work even without any driver bound to the
> > firmware device.
>
> We need device/driver bind because we need to call dma_configure() which
> internally doing iommus sID parsing.

I can see some drivers calling of_dma_configure() directly:
https://elixir.bootlin.com/linux/latest/ident/of_dma_configure

I'm not sure if it's more elegant, but should at least require less code.

By the way, can we really assume that probe of firmware platform
device really completes before we call venus_boot()?

Best regards,
Tomasz
