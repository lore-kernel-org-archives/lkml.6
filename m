Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDGM45 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 08:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbeDGM4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 08:56:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F13217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To: Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>, Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
 <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
Message-ID: <152310581432.180276.1794734900981310994@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB and the
 MAILBOX
Date: Sat, 07 Apr 2018 05:56:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leo Yan (2018-04-03 20:14:35)
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
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

Although I wonder why it can't be split up?
