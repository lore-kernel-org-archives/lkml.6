Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933722AbeEIDtS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:49:18 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53624 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbeEIDtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:49:15 -0400
X-Google-Smtp-Source: AB8JxZpaPLDwAFJlMhtIogWmhZ06wk8hXBqulUao6cjFKqbxJRW+hB5+cNpyvNnk+RZ7vPz6ZuIyll0ay4aECAhMkI0=
MIME-Version: 1.0
In-Reply-To: <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org> <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 9 May 2018 09:19:13 +0530
Message-ID: <CABb+yY2ke__W2ZW4c_Z9CejZzup52ykRDyNecTs0+nkvf5cbNA@mail.gmail.com>
Subject: Re: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB and
 the MAILBOX
To: Leo Yan <leo.yan@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>, Kaihua Zhong <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream"
        <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 8:44 AM, Leo Yan <leo.yan@linaro.org> wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> The current defconfig is inconsistent as it selects the mailbox and
> the clock for the hi6220 and the hi3660 without having their Kconfigs
> making sure the dependencies are correct. It ends up when selecting
> different versions for the kernel (for example when git bisecting)
> those options disappear and they don't get back, leading to unexpected
> behaviors. In our case, the cpufreq driver does no longer work because
> the clock fails to initialize due to the clock stub and the mailbox
> missing.
>
> In order to have the dependencies correctly set when defaulting, let's
> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> automatically") where we select automatically the driver when the
> parent driver is selected. With sensible defaults in place, we can leave
> other choices for EXPERT.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
