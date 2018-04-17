Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeDQAJI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 20:09:08 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33688 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDQAJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 20:09:06 -0400
X-Google-Smtp-Source: AIpwx48Df8AwgSbE1YSlI2Ae6KOxO9G3Jp7Qyc/j4wsdPddPiUoQ6/+SPiL/LEBbUwAE47KHWZBzJA==
MIME-Version: 1.0
References: <20180412224111.35216-1-swboyd@chromium.org>
In-Reply-To: <20180412224111.35216-1-swboyd@chromium.org>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 17 Apr 2018 00:08:27 +0000
X-Gmail-Original-Message-ID: <CAE=gft5Wo0JDk0+yN4LuEg-=xXXPecKxF8if9ksAXZrh+08QLA@mail.gmail.com>
Message-ID: <CAE=gft5Wo0JDk0+yN4LuEg-=xXXPecKxF8if9ksAXZrh+08QLA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: Make endian-agnostic
To: swboyd@chromium.org
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        msivasub@codeaurora.org, Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 3:41 PM Stephen Boyd <swboyd@chromium.org> wrote:

> This driver deals with memory that is stored in little-endian format.
> Update the structures with the proper little-endian types and then
> do the proper conversions when reading the fields. Note that we compare
> the ids with a memcmp() because we already pad out the string 'id' field
> to exactly 8 bytes with the strncpy() onto the stack.

> Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

> Changes from inline patch:
>   * Fixed magic
>   * Made function for memcmp()
>   *

>   drivers/soc/qcom/cmd-db.c | 116 +++++++++++++++++++++-----------------
>   1 file changed, 65 insertions(+), 51 deletions(-)

> Sent by a computer through tubes


Reviewed-by: Evan Green <evgreen@chromium.org>
