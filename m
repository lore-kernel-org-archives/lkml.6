Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeE3LLe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:11:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45825 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753136AbeE3LK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:10:56 -0400
X-Google-Smtp-Source: ADUXVKKT4vDTIr8SL13WkQXaxsWCs8Df+nKo6JN2TR2rQ2ZFjcn++l/zCmXdSld8jdH312jS9oss0HLl/AIohOHf0mk=
MIME-Version: 1.0
In-Reply-To: <1527667007-48226-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1527319008-66663-1-git-send-email-kevin.wangtao@hisilicon.com> <1527667007-48226-1-git-send-email-kevin.wangtao@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 May 2018 13:10:55 +0200
X-Google-Sender-Auth: 7Dn1OOzi135WxAnvk38n8_AhIDw
Message-ID: <CAJZ5v0ggrH1H=BV8GvBujggT_C+Dc-9dw9-PZD3pkQySPPeRfg@mail.gmail.com>
Subject: Re: [PATCH V3] cpufreq: reinitialize new policy min/max when writing scaling_(max|min)_freq
To: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 9:56 AM, Kevin Wangtao
<kevin.wangtao@hisilicon.com> wrote:
> consider such situation, current user_policy.min is 1000000,
> current user_policy.max is 1200000, in cpufreq_set_policy,
> other driver may update policy.min to 1200000, policy.max to
> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
> then user_policy.min will be 1300000, and user_policy.max is
> still 1200000, because the input value is checked with policy.max
> not user_policy.max. if we get all related cpus offline and
> online again, it will cause cpufreq_init_policy fail because
> user_policy.min is higher than user_policy.max.
>
> The solution is when user space tries to write scaling_(max|min)_freq,
> the min/max of new_policy should be reinitialized with min/max
> of user_policy, like what cpufreq_update_policy does.
>
> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>

I've applied the v2 with modified subject and changelog and with the
ACK from Viresh.

Thanks!
