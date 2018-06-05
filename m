Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFEGxn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:53:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36328 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeFEGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:53:39 -0400
X-Google-Smtp-Source: ADUXVKJO+KYXBxqaNwQIo/h31JZDVyhbDcBKfx97R9A1ScAiBNe+K3FAYYlWe3foCAIV5E3BJ2RPfw==
Subject: Re: [PATCH V4] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1527241792-5860-1-git-send-email-daniel.lezcano@linaro.org>
 <20180529093148.b2cxb5lwks7ka2tn@vireshk-i7>
 <c7c4143d-77c4-a41b-b770-e5c38e346320@linaro.org>
 <20180605051421.xbpkupxem5movm57@vireshk-i7>
 <898e23f9-7e91-b708-dd06-e3d3056abe61@linaro.org>
 <20180605055334.mnffwgcvca3zzwub@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8d29a3c2-056c-3a70-3ecf-56cdf6e37931@linaro.org>
Date: Tue, 5 Jun 2018 08:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605055334.mnffwgcvca3zzwub@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2018 07:53, Viresh Kumar wrote:
> On 05-06-18, 07:48, Daniel Lezcano wrote:
>> As soon as we reach complete(), no timer can be set because of the
>> condition before.
> 
> Why not ? We aren't using any locks here and it is possible that run_duration_ms
> is set to 0 from idle_injection_stop() only after the first thread has restarted
> the hrtimer. Isn't it ?

If he restarted the timer, complete() won't be called and
idle_injection_stop() will wait until the idle cycle injection is finished.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
