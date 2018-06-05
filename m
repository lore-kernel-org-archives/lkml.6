Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeFEKFb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:05:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34610 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeFEKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:05:29 -0400
X-Google-Smtp-Source: ADUXVKK2DS0hHVQj2C/uqUF5/I12MbGm/PSs7F/WZE2yhXd3vwDrpaHyTMkm7U+mH61bX59XQAqBvg==
Date: Tue, 5 Jun 2018 15:35:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
Subject: Re: [PATCH V4] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180605100525.ti7mhufbnmtok5p3@vireshk-i7>
References: <1527241792-5860-1-git-send-email-daniel.lezcano@linaro.org>
 <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
 <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
 <20180605051421.xbpkupxem5movm57@vireshk-i7>
 <898e23f9-7e91-b708-dd06-e3d3056abe61@linaro.org>
 <20180605055334.mnffwgcvca3zzwub@vireshk-i7>
 <8d29a3c2-056c-3a70-3ecf-56cdf6e37931@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d29a3c2-056c-3a70-3ecf-56cdf6e37931@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 08:53, Daniel Lezcano wrote:
> On 05/06/2018 07:53, Viresh Kumar wrote:
> > On 05-06-18, 07:48, Daniel Lezcano wrote:
> >> As soon as we reach complete(), no timer can be set because of the
> >> condition before.
> > 
> > Why not ? We aren't using any locks here and it is possible that run_duration_ms
> > is set to 0 from idle_injection_stop() only after the first thread has restarted
> > the hrtimer. Isn't it ?
> 
> If he restarted the timer, complete() won't be called and
> idle_injection_stop() will wait until the idle cycle injection is finished.

Obviously I missed that return statement within the conditional block :)

-- 
viresh
