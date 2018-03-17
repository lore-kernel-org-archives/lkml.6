Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeCQAhJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:37:09 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35611 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeCQAhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:37:07 -0400
X-Google-Smtp-Source: AG47ELsQHtYugKrXXgXm683cRRx5I9mzaPXkATVrICaUDeRtUpPcTE1NetDGJ1lWAoqtlKSK78bpqw==
MIME-Version: 1.0
References: <20180309232543.24636-1-ilina@codeaurora.org> <20180309232543.24636-8-ilina@codeaurora.org>
In-Reply-To: <20180309232543.24636-8-ilina@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Sat, 17 Mar 2018 00:36:28 +0000
X-Gmail-Original-Message-ID: <CAE=gft6y4yUvjHnSf10+Yt9Sw-bcKdFUWW7zWFRvMgzENe7gUw@mail.gmail.com>
Message-ID: <CAE=gft6y4yUvjHnSf10+Yt9Sw-bcKdFUWW7zWFRvMgzENe7gUw@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
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

> Active state requests are sent immediately to the mailbox controller,
> while sleep and wake state requests are cached in this driver to avoid
> taxing the mailbox controller repeatedly. The cached values will be sent
> to the controller when the rpmh_flush() is called.

> Generally, flushing is a system PM activity and may be called from the
> system PM drivers when the system is entering suspend or deeper sleep
> modes during cpuidle.

> Also allow invalidating the cached requests, so they may be re-populated
> again.

> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

> Changes in v4:
>          - remove locking for ->dirty in invalidate
>          - fix send_single
> Changes in v3:
>          - Remove locking for flush function
>          - Improve comments
> ---
>   drivers/soc/qcom/rpmh.c | 203
+++++++++++++++++++++++++++++++++++++++++++++++-
>   include/soc/qcom/rpmh.h |  10 +++
>   2 files changed, 212 insertions(+), 1 deletion(-)


Reviewed-by: Evan Green <evgreen@chromium.org>
