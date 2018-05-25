Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936075AbeEYKSn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:18:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35564 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935965AbeEYKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:18:42 -0400
X-Google-Smtp-Source: AB8JxZpPxmadmD7fVSelJQNS7WHk3MNz59doaRqvT9Cr2CL7yF3wqZP8sx7qYkbErXTIqjTUw5wpDg==
Date: Fri, 25 May 2018 15:48:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: sdhci-*: Don't emit error msg if sdhci_add_host()
 fails
Message-ID: <20180525101839.vfzyhyt5uwduhdcc@vireshk-i7>
References: <20180525151509.0270dbe1@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525151509.0270dbe1@xhacker.debian>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 15:15, Jisheng Zhang wrote:
> I noticed below error msg with sdhci-pxav3 on some berlin platforms:
> 
> [.....] sdhci-pxav3 f7ab0000.sdhci failed to add host
> 
> It is due to getting related vmmc or vqmmc regulator returns
> -EPROBE_DEFER. It doesn't matter at all but it's confusing.
> 
> From another side, if driver probing fails and the error number isn't
> -EPROBE_DEFER, the core will tell us something as below:
> 
> [.....] sdhci-pxav3: probe of f7ab0000.sdhci failed with error -EXX
> 
> So it's not necessary to emit error msg if sdhci_add_host() fails. And
> some other sdhci host drivers also have this issue, let's fix them
> together.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-spear.c    | 4 +---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
