Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEQBIE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:08:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19015 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeEQBIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:08:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180517010759epoutp03b5203d7a0b6c233ee3ae2c197a78cb9c~vSTJzLZYu1266412664epoutp03Q
X-AuditID: b6c32a45-8f3ff70000001020-59-5afcd5ed11f4
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFCD5EC.5080200@samsung.com>
Date: Thu, 17 May 2018 10:07:56 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Init user limits from OPP limits, not
 viceversa
In-reply-to: <20180516225709.153138-1-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmme7bq3+iDHbckLTY9PE9q8XZZQfZ
        LM42vWG3uLxrDpvF594jjBafNzxmtLjduILNgd1jdsNFFo++LasYPT5vkgtgjkq1yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyAtLGsVZGpkAlCakZH0/dYCp4IV5x5Fp5A+NN
        4S5GTg4JAROJV7fOMYPYQgI7GCXuP9TvYuQCsr8zSjz/9ZMJpujRkveMEIndjBL3+j8ygiR4
        BQQlfky+x9LFyMHBLCAvceRSNkiYWUBTYuvu9ewQ9XcZJV6cPcAKUa8l8X3FPDCbRUBVYvfB
        X2Cb2YDi+1/cYAOx+QUUJa7+eAw2X1QgQmLn/G/sIPNFBOokVnypB5nJLNDPKLGxcRHYHGGB
        EIn+bw/BDuUUMJdYs/kR2GIJgQNsEhc79jKCNEsIuEgcvWkB8YywxKvjW9ghbGmJZ6s2MkLU
        tzNKtO+dxwzhTGGUOHf9HtT7xhLPFnYxQbzGJ9Fx+C87xFBeiY42IYgSD4kXU/dClTtKPJ3Q
        xALxfRejxKGWX+wTGOVmIQXYLESAzUIKsAWMzKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3
        MYJTm5brDsYZ53wOMQpwMCrx8ArY/YkSYk0sK67MPcQowcGsJMIr1A0U4k1JrKxKLcqPLyrN
        SS0+xGgKDO+JzFKiyfnAtJtXEm9oamRsbGxham5pbGCpJM67RulrlJBAemJJanZqakFqEUwf
        EwenVAPjraIudn8T+8kyTBuuTz1dtS2k72Rxe3Yeu6P93UiTTS7+j18W/VRe4+X+ZZv+30k6
        p18XGxqeLy6KVRNNbKqNSgo1MdLk2rHP/Hy+qtr8HZW+yzRqfCMfBO/7Va06bbtL4YM7aq3n
        5L7ufH3X8epU97cZSrt7ClsWT96ZHPXC84PEAsutdc5KLMUZiYZazEXFiQDp96eSgwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jAd23V/9EGaw7x2ax6eN7Vouzyw6y
        WZxtesNucXnXHDaLz71HGC0+b3jMaHG7cQWbA7vH7IaLLB59W1YxenzeJBfAHMVlk5Kak1mW
        WqRvl8CV8fHUDaaCF+IVR66VNzDeFO5i5OSQEDCReLTkPWMXIxeHkMBORom2G5+ZQRK8AoIS
        PybfY+li5OBgFpCXOHIpGyTMLKAuMWneImaI+vuMEi8+zoCq15L4vmIeK4jNIqAqsfvgL7A4
        G1B8/4sbbCA2v4CixNUfjxlBZooKREh0n6gEmSMi0MAo0fhqNhuIwywwkVHi6qp7YIOEBUIk
        Nn+EOEhIoIdRonVJGIjNKWAusWbzI/YJjAKzkNw6C+HWWUhuXcDIvIpRMrWgODc9t9iowCgv
        tVyvODG3uDQvXS85P3cTIzCstx3W6t/B+HhJ/CFGAQ5GJR5eAbs/UUKsiWXFlbmHGCU4mJVE
        eIW6gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYdwiE
        iu0ynRmvseLt5a0eGuuYZp4NnOXQPumMIpv954c9WZV31i7ayPfW8n+E/7wnzhxOb4x9jn/a
        vfy+wP2Jgn4bE0LfX/TNMHtzxrtnSuCbhadDPdN9O36LdP8WZvy7Xq3DaUfl9luPP9lJr2V+
        Wf1r0uZCd9mmCEeeKQc+dIddSmLrmy3GosRSnJFoqMVcVJwIADuZNt9nAgAA
X-CMS-MailID: 20180517010757epcas2p30c01d2ac5e4a4a72fccec0f06a4e13a1
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c
X-RootMTR: 20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c
References: <CGME20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c@epcas5p1.samsung.com>
        <20180516225709.153138-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 17일 07:57, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> the devfreq device") introduced the initialization of the user
> limits min/max_freq from the lowest/highest available OPPs. Later
> commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> frequency") added scaling_min/max_freq, which actually represent
> the frequencies of the lowest/highest available OPP. scaling_min/
> max_freq are initialized with the values from min/max_freq, which
> is totally correct in the context, but a bit awkward to read.
> 
> Swap the initialization and assign scaling_min/max_freq with the
> OPP freqs and then the user limts min/max_freq with scaling_min/
> max_freq.
> 
> Needless to say that this change is a NOP, intended to improve
> readability.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Additional context: I'm considering to introduce the concept of
> a devfreq policy, which would probably move min/max_freq inside
> of a struct policy, this would make the initialization even
> more awkward to read. If this moves forward I might also propose
> to rename scaling_min/max_freq to something like min/max_opp_freq
> to avoid confusion with the frequencies in the policy (cpufreq uses
> scaling_min/max_freq for the sysfs attributes of the policy
> limits).
> 
>  drivers/devfreq/devfreq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..0057ef5b0a98 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> -	devfreq->min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->min_freq) {
> +	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> +	if (!devfreq->scaling_min_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_min_freq = devfreq->min_freq;
> +	devfreq->min_freq = devfreq->scaling_min_freq;
>  
> -	devfreq->max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->max_freq) {
> +	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> +	if (!devfreq->scaling_max_freq) {
>  		mutex_unlock(&devfreq->lock);
>  		err = -EINVAL;
>  		goto err_dev;
>  	}
> -	devfreq->scaling_max_freq = devfreq->max_freq;
> +	devfreq->max_freq = devfreq->scaling_max_freq;
>  
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
> 

This patch just clean-up codes related to min/max_freq and scaling_min/max_freq.
It seems be good.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

But, I don't want to change the name from 'scaling_min/max_freq'
to 'min/max_opp_freq'. You can check the meaning of variables
in comment of struct devfreq.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
