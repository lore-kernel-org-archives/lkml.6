Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeE1FgO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:36:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61087 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeE1FgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:36:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180528053609epoutp037ff736876c5f81d083f171cbe0a5e04f~yuDbzmwwY0476804768epoutp03Q
X-AuditID: b6c32a38-bd9359c0000010f7-5d-5b0b954731d3
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5B0B9546.7070101@samsung.com>
Date: Mon, 28 May 2018 14:36:06 +0900
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
Subject: Re: [PATCH 04/11] PM / devfreq: Remove redundant frequency
 adjustment from governors
In-reply-to: <20180525203043.249193-5-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObvbvVfb7LjMDka1Lhload7N6Sk0gqIGBUkmhFbrppfNxx7s
        zugBMXtorgdWFmSPKb1kScrItKxGtlYEM7XM6CGUEGVlhdmTHne7Sv11vuf7+/zg+/vxown1
        YTKBLrY6eYeVK2PIaPnlW0lpKcuOTChI6/ujwb8OBSns+/RBgT2BLgUOnbtJ4p2nm0kc2vGO
        wg+uniDxyP4AwGf7e2R4pGUQ4KcVjSTefT1ALVIamk41AcPPH4eA4birR27weatJg/9kE2U4
        cMkLDCO+6TlUPp9l5rki3qHhrYW2omKrKZtZnmtcbNRnpLEp7HycyWisnIXPZpasyElZWlwm
        JmU0m7iyctHK4QSBmbcwy2Erd/Ias01wZjMFLKtNZdMyU7Va8dWtW6DVi8gG3jx65a7C3hm7
        2e3vAS5wJsYNomgE09Gzz6NyN4im1bAdoK62EBEuqOFXgNyNs8ahQKiblKAWEXrXLAsXVDAW
        fTs8IHbTNAFnoEBvadgmYBJq7WimJP45QF+87jE+GQX9t8mwlsNEFNz1KOKTou9//TjiT4Qz
        Ud+3QRDWk+EadMXzhQrrOJiL6r/fjyQl4KgMXR32RKBJ0IhCvwYiOgpmopEGbyQpgjspdPFp
        r0IaYQl639Ytl/QkNHTnEhVOjeBU1Hs7W+KrAKq6foqQPrXimP0DMqlBh141SCMQMAYNj+5T
        SM0qtKdSLSEGtK+hY2zkNoB6K1/Ka8C0uv+2VPdvS3X/bakeEF4Qz9sFi4kXWHt6qsBZhHKr
        KbXQZvGByEEm43ZwrWtFJ4A0YJQq18/oArWC2yRssXQCRBNMnCo6RbRURdyWrbzDZnSUl/FC
        J9CLSz5IJEwutInnbXUaWb1Wp9PhdDZDz7LMFFVl5u98NTRxTr6U5+28Y7xPRkcluEDVsToq
        78KTC7hkTnzWkILIv7HqzdaNeUo91d5IrXzhao0dOmOs91Tg5poPR+hEu7Ihv2Jt6/KDU9y+
        qabqBatWny8KvvGXfh/+cSL4APbH9NcOdN8r+W0+mrxw/eWOvrdNSzvY43Fzq2XKjxNqH7oq
        wR/P4MW87RnbNs421US17WXkgpljkwmHwP0Fb4DYPaYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xoK77VO5ogwtbhSz+TjrGbrHp43tW
        i/lHzrFanF12kM2iefF6NouzTW/YLS7vmsNm8bn3CKPF0usXmSw+b3jMaHG7cQWbReveI+wO
        PB5r5q1h9Pj9axKjx+yGiywem1Z1snnsn7uG3aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
        vu48wVpwSLCia/9FxgbGJXxdjJwcEgImEkfOXmDrYuTiEBJYxyhxbOk5FpAEr4CgxI/J94Bs
        Dg5mAXmJI5eyQcLMAuoSk+YtYoaov88osfXUM0aIei2JY/uPsoHYLAKqEsdarjGB2GxA8f0v
        boDF+QUUJa7+eMwIMlNUIEKi+0QlSFhEIFjiQ3MP2A3MAl+ZJJ79bWcGSQgLxEu0zH/JCmIL
        CWxnlDi6RgHE5hQwl/i8cBXbBEaBWUhOnYVw6iwkpy5gZF7FKJlaUJybnltsVGCYl1quV5yY
        W1yal66XnJ+7iREYMdsOa/XtYLy/JP4QowAHoxIPb8Nvrmgh1sSy4srcQ4wSHMxKIrxcukAh
        3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGNu87kq62PKt
        3tm/Z51h3nr3V9N+Hp26/lPRmpXWDzp8fT5M4H+25mt8YnfEp232OuLTw/wNTtpd9W/lmSb0
        lGX999nbehKkVU3P7773USfFubL2nEbV4yAxi5uz6m/a66vyzuy9vJrfneOzXonPBrnW+U+S
        Y/6/Wx90eIGyuvQ1saDMlZ7nzZVYijMSDbWYi4oTAWIkci6UAgAA
X-CMS-MailID: 20180528053607epcas1p4c69b17413f78614d6187257f11e87b3a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203333epcas1p230489fbae43296516f3febb327dcdeca
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203333epcas1p230489fbae43296516f3febb327dcdeca@epcas1p2.samsung.com>
        <20180525203043.249193-5-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> The userspace and simpleondemand governor determine a target frequency and
> then adjust it according to the df->min/max_freq limits that might have
> been set by user space. This adjustment is redundant, it is done in
> update_devfreq() for any governor, right after returning from
> governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_simpleondemand.c |  5 -----
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  2 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 278964783fa6..3da7554b4837 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -84,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>  	*freq = (unsigned long) b;
>  
> -	if (df->min_freq && *freq < df->min_freq)
> -		*freq = df->min_freq;
> -	if (df->max_freq && *freq > df->max_freq)
> -		*freq = df->max_freq;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 080607c3f34d..378d84c011df 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->data;
>  
> -	if (data->valid) {
> -		unsigned long adjusted_freq = data->user_frequency;
> -
> -		if (df->max_freq && adjusted_freq > df->max_freq)
> -			adjusted_freq = df->max_freq;
> -
> -		if (df->min_freq && adjusted_freq < df->min_freq)
> -			adjusted_freq = df->min_freq;
> -
> -		*freq = adjusted_freq;
> -	} else {
> +	if (data->valid)
> +		*freq = data->user_frequency;
> +	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> -	}
> +
>  	return 0;
>  }
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
