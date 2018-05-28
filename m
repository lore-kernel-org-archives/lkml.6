Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeE1F06 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:26:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:55375 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeE1F0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:26:54 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180528052652epoutp033233e242f6b336a8e80ab9a419d6b4f1~yt7VKYGNv2914629146epoutp03R
X-AuditID: b6c32a37-a71ff70000000fec-2e-5b0b93190636
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5B0B9319.9060709@samsung.com>
Date: Mon, 28 May 2018 14:26:49 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 01/11] PM / devfreq: Init user limits from OPP limits,
 not viceversa
In-reply-to: <20180525203043.249193-2-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmnq7UZO5og0trmSz+TjrGbrHp43tW
        i/lHzrFanF12kM2iefF6NouzTW/YLS7vmsNm8bn3CKPF0usXmSw+b3jMaHG7cQWbReveI+wO
        PB5r5q1h9Pj9axKjx+yGiywem1Z1snnsn7uG3aNvyypGj8+b5ALYo1JtMlITU1KLFFLzkvNT
        MvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVVIoS8wpBQoFJBYXK+nb2RTl
        l5akKmTkF5fYKkUbGhrpGRqY6xkZAWnjWCsjU6CShNSMUyv3MhacEqpY3fuVrYFxHX8XIyeH
        hICJRP/nKyxdjFwcQgI7GCVe/HvGCOF8Z5S4tmcCE0zVo7dnmSESuxklPt87yg6S4BUQlPgx
        +R5QOwcHs4C8xJFL2SBhZgFNia2717ND1N9llLj0cQoTRL2WxIxVn8B6WQRUJR6fWskIYrMB
        xfe/uMEGYvMLKEpc/fEYLC4qECGxc/43sHoRgWCJBT/Pg53KLPCVSWLXu/lgRcICURJNvQdY
        QWxOAXOJu9f3sEFc3cwucWOWNshxEgIuEi/niECEhSVeHd/CDhGWlrh01BZkpIRAO6NE+955
        zBDOFEaJc9fvQX1vLPFsYRcTxGd8Eu++9rBCNPNKdLQJQZR4SJztPQH18HZGiemnu1knMMrO
        QgqjWYgwmoUURgsYmVcxiqUWFOempxYbFhjrFSfmFpfmpesl5+duYgSnRy3zHYwbzvkcYhTg
        YFTi4W34zRUtxJpYVlyZe4hRgoNZSYSXSxcoxJuSWFmVWpQfX1Sak1p8iNEUGMQTmaVEk/OB
        qTuvJN7Q1MjY2NjCxNDM1NBQSZy3zfxflJBAemJJanZqakFqEUwfEwenVANjWYMC3yeelZKr
        ar9ckcoTXBuuXaJyyOvg5JLeU/3b/nX3bnsyr35+7f4g1vzgd++STgbZczHVPE7eI7XzZlXo
        7DPW+U/NNLf038gRP9FzZn7wVqH/h6fs6F1gd9x157TFz+acsAufrSl5fqno5J+qE7wuqNku
        vflhSkD6xJta+4Nz+8Miuh79VGIpzkg01GIuKk4EAJUNEQ+lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xgK7kZO5og53/VCz+TjrGbrHp43tW
        i/lHzrFanF12kM2iefF6NouzTW/YLS7vmsNm8bn3CKPF0usXmSw+b3jMaHG7cQWbReveI+wO
        PB5r5q1h9Pj9axKjx+yGiywem1Z1snnsn7uG3aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
        Tq3cy1hwSqhide9XtgbGdfxdjJwcEgImEo/enmUGsYUEdjJKbO9iBbF5BQQlfky+x9LFyMHB
        LCAvceRSNkiYWUBdYtK8RUDlXEDl9xkljq97xQ5RryUxY9UnMJtFQFXi8amVjCA2G1B8/4sb
        bCA2v4CixNUfjxlBZooKREh0n6gECYsIBEt8aO5hA5nJLPCVSeLZ33awe4QFoiSaeg+wQizb
        zihx7lwv2CBOAXOJu9f3sE1gFJiF5NZZCLfOQnLrAkbmVYySqQXFuem5xUYFhnmp5XrFibnF
        pXnpesn5uZsYgRGz7bBW3w7G+0viDzEKcDAq8fA2/OaKFmJNLCuuzD3EKMHBrCTCy6ULFOJN
        SaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFRfOnUmLWnZ54R
        KYjz3bB1Sde2m8+9MwNdeaa/2zznQHm5gNO8kw7JiZyMGfv9ZrcdETyj8TR4wTdLydPmJwzt
        86v0d2elMd60qi3hqzTIO6c9M1KaN7RL/3UPY5RkL89lc14mqROm0/S0WxJmVvxc227+g803
        VeLGPIMJLlmXzt0pZ23b3K7EUpyRaKjFXFScCABIUUuWlAIAAA==
X-CMS-MailID: 20180528052649epcas1p41f9f3c75c5ebc6edd9caf35ab5b639c3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203410epcas1p2fd2a35468b9c37f2c542e499d3ed5a03
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203410epcas1p2fd2a35468b9c37f2c542e499d3ed5a03@epcas1p2.samsung.com>
        <20180525203043.249193-2-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
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

I already replied with my Reviewed-by tag. You are missing my tag.

Again, 
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
