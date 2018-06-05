Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeFEFxj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:53:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39695 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeFEFxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:53:37 -0400
X-Google-Smtp-Source: ADUXVKLmkWOzvsRaqzF7EC8UJhklTtn6xC12XkiHDGOfiJHorZyiAgdx5YNxCtplNI4tpIgmd/Wm4w==
Date: Tue, 5 Jun 2018 11:23:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V4] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180605055334.mnffwgcvca3zzwub@vireshk-i7>
References: <1527241792-5860-1-git-send-email-daniel.lezcano@linaro.org>
 <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
 <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
 <20180605051421.xbpkupxem5movm57@vireshk-i7>
 <898e23f9-7e91-b708-dd06-e3d3056abe61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898e23f9-7e91-b708-dd06-e3d3056abe61@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 07:48, Daniel Lezcano wrote:
> As soon as we reach complete(), no timer can be set because of the
> condition before.

Why not ? We aren't using any locks here and it is possible that run_duration_ms
is set to 0 from idle_injection_stop() only after the first thread has restarted
the hrtimer. Isn't it ?

-- 
viresh
