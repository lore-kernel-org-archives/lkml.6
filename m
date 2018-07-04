Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5668EC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07548247AB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pT4NNQbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07548247AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933055AbeGDCUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:20:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12804 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932786AbeGDCUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:20:38 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180704022036epoutp0333daae05d80d9d9b469952b540b07af6~_CQQCc9ut2296322963epoutp03i;
        Wed,  4 Jul 2018 02:20:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180704022036epoutp0333daae05d80d9d9b469952b540b07af6~_CQQCc9ut2296322963epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530670836;
        bh=GSbK/eA0fcPuyibR+Ymx63AiDDd9+hhcHpJjOk57piY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=pT4NNQbvK7N8sc6EHgrxGEgs3PggPzeAj6Bc6x0XomVFXBelPGZNJ/bSOafABzv5v
         6PX430tufJCoUNCbfuaD0iNy8OrNHyWzoS/ZKuiIxOcPWk20uH1v/6gG1sGZ0Dn2cB
         13a3XBz8Gqkrwa9c9od1j18PNLfeUZU2P+cfBdqw=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180704022033epcas1p25a70c994216129acb15f7de9b0e5a961~_CQNTVqMm0243902439epcas1p2C;
        Wed,  4 Jul 2018 02:20:33 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.E9.04186.1FE2C3B5; Wed,  4 Jul 2018 11:20:33 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20180704022032epcas2p4e5efbe864e17e3a11cd5230f027bd37a~_CQNCvsIn0852608526epcas2p4q;
        Wed,  4 Jul 2018 02:20:32 +0000 (GMT)
X-AuditID: b6c32a48-2fdff7000000105a-02-5b3c2ef10078
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A9.50.04192.0FE2C3B5; Wed,  4 Jul
        2018 11:20:32 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00IXRL68CZ10@mmp2.samsung.com>; Wed, 04 Jul 2018 11:20:32 +0900 (KST)
Message-id: <5B3C2EEF.4080309@samsung.com>
Date:   Wed, 04 Jul 2018 11:20:31 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 02/12] PM / devfreq: Fix handling of min/max_freq ==
 0
In-reply-to: <20180703234705.227473-3-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxze6X2WrXJWcJ6wTOtNdJGFQltrDw4Wl+FyE0lGNFvmmqW7gZtC
        6IP0tipbsjCYkzWbIj7QMhA37VglApUJezBmKRtBRZGJLAILaoyvRDtggka3e3tj5l/nO9/v
        +/3O+b6cwxL6fjqDLfP4RZ9HcHF0Cnmyf5U1K2HMs+f0xlLwo/rfGNxwbZTE0cRdCh+KD1P4
        bPgUjdsuxwCu+aadxmer7zD4r7kBgEd//IrGM1/GAT56aUSDZzquAnz5k1YaD12aofGZ0xco
        vL03zuDOOX6dnm9rbgP8wwf1gG+sGiH5nskjgI9GPqf5ibGfab6vqY3h/xispviuiztIfmdX
        BPAz0aVFz74n5pWKQonoM4ieYm9JmceZz23Y5HjDYV2TY8oy5WIbZ/AIbjGfKygsynqzzCVb
        4wxbBFdApooESeKyX8vzeQN+0VDqlfz5nN1kMhtNOTaj2SyvlvfXmq2y5AOxdP8UU3Fv5bbh
        8wtUFTi+NAi0LIKr0UjdGaBgPewBqCW8SMX3Abpy7ZUnmhMT54kgSJH5DoCOdx9hlIIOPo/m
        90yRQcCyBFyG4hfKFZqAq9D3P7Uzqn4SoKaWQY2qz0QD0ZtJTMIVaHaokVQwLfN9N8ZpBafC
        5eji/NXkhRbDd9EPh/5JnpUON6GWhXOkMpSAt0l0+NOHlFJIg2+hfQ33kw1aaEMnj53WKCIE
        hxn07alxSrVQgGqq95AqTkO3fu9iVPwiuh7pBGrDDoBmb9RQ6qYOoHtDJzSqyoKuHw5qVHOL
        UG3/I0bxjKAO1X6mVyU8Ggx10KrnboD69ieIOvBS6KmYQv/HFHoqphZARMALYoXkdoqSuWK1
        URLcUsDjNBZ73VGQfMCZfA/4dbgwBiALuOd0rYFX7XpK2CJVumMAsQSXrpt6IFO6EqHyQ9Hn
        dfgCLlGKAauc8m4iY3GxV/4OHr/DZDVbLBZsteVacnK5JTrwJ7TroVPwi+WiWCH6nvRpWG1G
        FahcODY98fW61o9duyfXLHc6Ig2bt3cQudvsN23x/DRveeddQ8HmO4m18w21nZXpo83Z9Ss+
        wo+nNzyj6VnCvP5LeHplrft2SuEY42aJL17undM2Hhh/e+Dv77a2hyH571j5+ubUvb0b/X1b
        U9/RZkfHjcGmx4lzB7PC8b15oVlhVzdHSqWCKZPwScJ/A0YEE9YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t9jQd0PejbRBi1PjSz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlTHt
        HnvBB7WKcxd+sjYwrpPrYuTkkBAwkdh85wJzFyMXh5DAOkaJI/3PmEASvAKCEj8m32PpYuTg
        YBaQlzhyKRskzCygLjFp3iKo+vuMEovn3WWFqNeSOLrpJVgvi4CqxJdTs1lAbDag+P4XN9hA
        bH4BRYmrPx4zgswUFYiQ6D5RCRIWEQiW+NDcwwYyk1ngLYvE0m//GUESwgK+EncPnmGFWLad
        UeLfiWtgQzkFzCW2rT7NNIFRYBaSW2ch3DoLya0LGJlXMUqmFhTnpucWGxUY5aWW6xUn5haX
        5qXrJefnbmIExuS2w1r9OxgfL4k/xCjAwajEw7ui1DpaiDWxrLgy9xCjBAezkgjvvV9AId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYzuKauuvOGYHamt
        57y7V3BN1Q3nSxO/F4Qpvv3ZKb97oYhFqc7bN/7vvi7OPbxiysrSxkk2N+yXBxZJ7d/5/sgM
        1zNbpJpvpVWKb817tyh7o/1d3qkbju1a8Jl33cW6v2/WXzv6zKnh2KIXE2MsPasPvvt/4nfX
        z+Rz2wMLo3+UTZif1x706tq5XiWW4oxEQy3mouJEANu1Ze/FAgAA
X-CMS-MailID: 20180704022032epcas2p4e5efbe864e17e3a11cd5230f027bd37a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b@epcas3p3.samsung.com>
        <20180703234705.227473-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - handle freq tables sorted in ascending and descending order in
>   min/max_freq_store()
> - use same order for conditional statements in min/max_freq_store()
> ---
>  drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0057ef5b0a98..6f604f8b2b81 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>  
> -	if (min_freq && freq < min_freq) {
> +	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> -	if (max_freq && freq > max_freq) {
> +	if (freq > max_freq) {
>  		freq = max_freq;
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
> @@ -1122,18 +1122,27 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
> +	unsigned long *freq_table;

You can move 'freq_table' under 'else' statement.

>  	int ret;
> -	unsigned long max;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	max = df->max_freq;
> -	if (value && max && value > max) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (value) {
> +		if (value > df->max_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +	} else {
> +		freq_table = df->profile->freq_table;
> +		/* typical order is ascending, some drivers use descending */

You better to explain what is doing of following code.
How about modifying it as following?

		/* Get minimum frequency according to sorting way */

> +		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> +			value = freq_table[0];
> +		else
> +			value = freq_table[df->profile->max_state - 1];
>  	}
>  
>  	df->min_freq = value;
> @@ -1157,18 +1166,27 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  {
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
> +	unsigned long *freq_table;

ditto. You can move 'freq_table' under 'else' statement.

>  	int ret;
> -	unsigned long min;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	min = df->min_freq;
> -	if (value && min && value < min) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (value) {
> +		if (value < df->min_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +	} else {
> +		freq_table = df->profile->freq_table;
> +		/* typical order is ascending, some drivers use descending */

ditto.
		/* Get maximum frequency according to sorting way */

> +		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> +			value = freq_table[df->profile->max_state - 1];
> +		else
> +			value = freq_table[0];
>  	}
>  
>  	df->max_freq = value;
> 

If you agree my comment and modify this patch according to my comment,
feel free to add my review tag.
- Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
