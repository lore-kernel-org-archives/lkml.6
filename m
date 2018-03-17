Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCQAgh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:36:37 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:44207 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeCQAgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:36:35 -0400
X-Google-Smtp-Source: AG47ELvRUICxcqaHgsMRvui99W//fySFUtwCiVqn1CIvXOci5OItmyirQ32jx0FOkjTiMyYBBWo8JA==
MIME-Version: 1.0
References: <20180309232543.24636-1-ilina@codeaurora.org> <20180309232543.24636-6-ilina@codeaurora.org>
In-Reply-To: <20180309232543.24636-6-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Sat, 17 Mar 2018 00:35:55 +0000
X-Gmail-Original-Message-ID: <CAE=gft4YRzsG4w2oTFwSbxXtO4mNFo+SzntJo9ZP8Mm_N2Z6fg@mail.gmail.com>
Message-ID: <CAE=gft4YRzsG4w2oTFwSbxXtO4mNFo+SzntJo9ZP8Mm_N2Z6fg@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 3:27 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Sleep and wake requests are sent when the application processor
> subsystem of the SoC is entering deep sleep states like in suspend.
> These requests help lower the system power requirements when the
> resources are not in use.

> Sleep and wake requests are written to the TCS slots but are not
> triggered at the time of writing. The TCS are triggered by the firmware
> after the last of the CPUs has executed its WFI. Since these requests
> may come in different batches of requests, it is the job of this
> controller driver to find and arrange the requests into the available
> TCSes.

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>    drivers/soc/qcom/rpmh-internal.h |   9 ++-
>    drivers/soc/qcom/rpmh-rsc.c      | 120
+++++++++++++++++++++++++++++++++++++++
>    2 files changed, 128 insertions(+), 1 deletion(-)


Reviewed-by: Evan Green <evgreen@chromium.org>
