Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEDOTe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:19:34 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:40739 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEDOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:19:32 -0400
X-Google-Smtp-Source: AB8JxZo1q+sYdqd+W7jw+5VSjUHPrIt7X3OF6TfC0pRqvkqh0svbrgtcI1In/svBvWWqweyszEEqXw==
Date: Fri, 4 May 2018 22:19:20 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB
 and the MAILBOX
Message-ID: <20180504141920.GA17313@leoy-ThinkPad-X240s>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
 <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 11:14:35AM +0800, Leo Yan wrote:
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
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Jassi,

Could you review and ack for this patch?

Hi Wei,

Stephen has acked this patch and if we can get ack from Jassi, could
you pick up this patch?

I missed my Signed-off-by tag, this might break the chain.
So when you pick up this patch, please add my Signed-off-by tag:

Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo Yan
