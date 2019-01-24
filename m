Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE071C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A29621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7Pk+ZWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfAXIn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:43:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43910 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfAXIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:43:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so4182939oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTskM60ct9OaKWRHfD9bQXC/c6IOu3hQVhjrboXkAds=;
        b=G7Pk+ZWdly4jXZf29hzOv3gBxZaMrFZYDAf9bSyetkSOztlMxJWageeEhYIRxiqOTS
         cMSJUoYmyA3RCZ1j56sNYABJWZjOmkM5QTUH0CTeQPMJmrvVLmboOol4MHn46CycEgON
         Rj6BZsXNAtzKfKSmxC3UAIQOqwYbEAgu3sdSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTskM60ct9OaKWRHfD9bQXC/c6IOu3hQVhjrboXkAds=;
        b=M+d20p4ZkQz79rylJbK+vwmv9XdH9Zf932TWjl7fkdqclAXM8aQ8n845GzARPs+/O3
         5Dy9oM6rm2es7TJJj+qfJfFcEA+/ROgtS5xEOFSpTPIOrtPyioIh7CcMI4VXlojBmYvr
         kLYZeVBf+qHXXdO6HZReICfj5Quh/x9dxm9SQAqasOEuooZ1Q34AOEqJKRwbQam7sono
         7ZcAnKljEw2a6a9V2BraYldoqpa+kwGvuY/qkFdAuqb7z+FMTO7Mx4DgVPZZtLJ3Fe/R
         BwX3L/wcPAuZx3MfqWZ8Vtql7wnGEAlere/V0OiKP0fWZY6yLM/PSzlEI2dzC7PwEP63
         bm/Q==
X-Gm-Message-State: AJcUukfg3xLMYfbVBEbdVEQd8aA2bX85y4sGiJGqZ/IMKFq5uxXAeit/
        7Y3M2bQ7uDzoCN+0hy1EMMU1GkuDl1U=
X-Google-Smtp-Source: ALg8bN5gCIR2iOqTqBwsjvzSBdCSW8wkp73Mol3pKjNMjoRgwQcxdXZAubF8Twh6ZGZgkN8xA9fV4g==
X-Received: by 2002:aca:adcd:: with SMTP id w196mr561199oie.353.1548319406955;
        Thu, 24 Jan 2019 00:43:26 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id u65sm10072558oib.5.2019.01.24.00.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:43:26 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id c206so4241770oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:43:25 -0800 (PST)
X-Received: by 2002:aca:61c3:: with SMTP id v186mr577220oib.350.1548319405604;
 Thu, 24 Jan 2019 00:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 24 Jan 2019 17:43:13 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVOPmRhhM=J-RqLOpc+mDbnxYdCMO3mqQfgN-F3b=kBCw@mail.gmail.com>
Message-ID: <CAPBb6MVOPmRhhM=J-RqLOpc+mDbnxYdCMO3mqQfgN-F3b=kBCw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Venus stateful Codec API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Fri, Jan 18, 2019 at 1:20 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hello,
>
> This aims to make Venus decoder compliant with stateful Codec API [1].
> The patches 1-9 are preparation for the cherry on the cake patch 10
> which implements the decoder state machine similar to the one in the
> stateful codec API documentation.

Thanks *a lot* for this series! I am still stress-testing it against
the Chromium decoder tests, but so far it has been rock-solid. I have
a few inline comments on some patches ; I will also want to review the
state machine more thoroughly after refreshing my mind on Tomasz doc,
but this looks pretty promising already.

Cheers,
Alex.

>
> There few things which are still TODO:
>  - V4L2_DEC_CMD_START implementation as per decoder documentation.
>  - Dynamic resolution change V4L2_BUF_FLAG_LAST for the last buffer
>    before the resolution change.
>
> The patches are tested with chromium VDA unittests at [2].
>
> Note that the patchset depends on Venus various fixes at [3].
>
> Comments are welcome!
>
> regards,
> Stan
>
> [1] https://patchwork.kernel.org/patch/10652199/
> [2] https://chromium.googlesource.com/chromium/src/+/lkgr/docs/media/gpu/vdatest_usage.md
> [3] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1894510.html
>
> Stanimir Varbanov (10):
>   venus: hfi_cmds: add more not-implemented properties
>   venus: helpers: fix dynamic buffer mode for v4
>   venus: helpers: export few helper functions
>   venus: hfi: add type argument to hfi flush function
>   venus: hfi: export few HFI functions
>   venus: hfi: return an error if session_init is already called
>   venus: helpers: add three more helper functions
>   venus: vdec_ctrls: get real minimum buffers for capture
>   venus: vdec: allow bigger sizeimage set by clients
>   venus: dec: make decoder compliant with stateful codec API
>
>  drivers/media/platform/qcom/venus/core.h      |  20 +-
>  drivers/media/platform/qcom/venus/helpers.c   | 141 +++++-
>  drivers/media/platform/qcom/venus/helpers.h   |  14 +
>  drivers/media/platform/qcom/venus/hfi.c       |  11 +-
>  drivers/media/platform/qcom/venus/hfi.h       |   2 +-
>  drivers/media/platform/qcom/venus/hfi_cmds.c  |   2 +
>  drivers/media/platform/qcom/venus/vdec.c      | 467 ++++++++++++++----
>  .../media/platform/qcom/venus/vdec_ctrls.c    |   7 +-
>  8 files changed, 535 insertions(+), 129 deletions(-)
>
> --
> 2.17.1
>
