Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeCQAhd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:37:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42844 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeCQAhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:37:31 -0400
X-Google-Smtp-Source: AG47ELurXs25cj4CqzgyBS+8lAF2l9usdJoktL440oWnxiHIZ7HN6sqYfxkXIQiIEv054h7xnBJ0ZQ==
MIME-Version: 1.0
References: <20180309232543.24636-1-ilina@codeaurora.org> <20180309232543.24636-10-ilina@codeaurora.org>
In-Reply-To: <20180309232543.24636-10-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Sat, 17 Mar 2018 00:36:52 +0000
X-Gmail-Original-Message-ID: <CAE=gft4a3m97MnEH1wZXkrLGcKigvUUeozoP1VdN+dupKzwSmA@mail.gmail.com>
Message-ID: <CAE=gft4a3m97MnEH1wZXkrLGcKigvUUeozoP1VdN+dupKzwSmA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] drivers: qcom: rpmh: add support for batch RPMH request
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

On Fri, Mar 9, 2018 at 3:26 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Platform drivers need make a lot of resource state requests at the same
> time, say, at the start or end of an usecase. It can be quite
> inefficient to send each request separately. Instead they can give the
> RPMH library a batch of requests to be sent and wait on the whole
> transaction to be complete.

> rpmh_write_batch() is a blocking call that can be used to send multiple
> RPMH command sets. Each RPMH command set is set asynchronously and the
> API blocks until all the command sets are complete and receive their
> tx_done callbacks.

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

> Changes in v4:
>          - reorganize rpmh_write_batch()
>          - introduce wait_count here, instead of patch#4
> ---
>   drivers/soc/qcom/rpmh.c | 156
+++++++++++++++++++++++++++++++++++++++++++++++-
>   include/soc/qcom/rpmh.h |   8 +++
>   2 files changed, 162 insertions(+), 2 deletions(-)


Reviewed-by: Evan Green <evgreen@chromium.org>
