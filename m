Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7067D20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PdSrMnAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7067D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGLIm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:42:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17308 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeGLIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:42:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180712083423epoutp029168de45434d31804ea5484349551851~Akg5YZoUH1006010060epoutp029;
        Thu, 12 Jul 2018 08:34:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180712083423epoutp029168de45434d31804ea5484349551851~Akg5YZoUH1006010060epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531384463;
        bh=d2AwYDX4uCIynnMeTuOuU99/dudszRLPtl3Lx0FD8i4=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=PdSrMnAxLUBBD3qI/oF2Iwi1VuVhewaaJwD+CpzR/o9RzWUnyJVKbzNSrq5ZWsbva
         SrYdAJH0W/4VvO5tnuWkubZNvITQHFxjX6puo9/lsWtbFBLeWl7dLUI+MOk9z6beQ5
         1Mqbrf6Br14A9QMUe0TR0yuPd9OKP7nxS93JIUhU=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180712083421epcas1p41c35cc890a2582e1ad60da886c4f8267~Akg3LcOo11622316223epcas1p4W;
        Thu, 12 Jul 2018 08:34:21 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.C0.04186.D82174B5; Thu, 12 Jul 2018 17:34:21 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20180712083420epcas2p4efb7608b228781e340c0a24ad8a975d1~Akg2v_XXa0344203442epcas2p42;
        Thu, 12 Jul 2018 08:34:20 +0000 (GMT)
X-AuditID: b6c32a47-9c7ff7000000105a-5a-5b47128d7c06
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.1D.04192.C82174B5; Thu, 12 Jul 2018 17:34:20 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00BBMVT8BV50@mmp1.samsung.com>; Thu, 12 Jul 2018 17:34:20 +0900 (KST)
Subject: Re: [PATCH v5 02/12] PM / devfreq: Fix handling of min/max_freq ==
 0
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-id: <fd7e9774-bf19-e6eb-c095-c453d534e479@samsung.com>
Date:   Thu, 12 Jul 2018 17:34:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <20180706163624.GE129942@google.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmqW6vkHu0wbZzPBZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM77PusBUcE++4vvP02wNjFskuxg5OSQE
        TCSWfX7A2sXIxSEksINR4mj7JGaQhJDAd0aJX11GMEWTVn1mhCjazSgx9f8ONpAEr4CgxI/J
        91hAbGYBTYkXXyaxQBTdZZTYf20rE0hCWMBfYur074wgtoiAhsST3+fBJjELTGOV6J72H2wS
        m4CWxP4XN8BsfgFFias/HjNCbLCTmHDrF9ggFgFVicYV/8C2iQpESDQ9/8nexcjBwSlgKHH1
        dBrEEeISza03oQ6Slzh45TnYQRICt9glPk75xgbxjovEpq6lULawxKvjW9ghbGmJZ6s2MkI0
        tDNKfHnRzArhTGCU+HBqMxNElbHEs4VdTBAr+CQ6Dv8Fu0JCgFeio00IosRD4sSsDWyQoPjL
        KNHwrJ9lAqPcLKQgm4UUZLOQXD4LyeULGFlWMYqlFhTnpqcWGxUY6xUn5haX5qXrJefnbmIE
        p20t9x2M2875HGIU4GBU4uHl4HaLFmJNLCuuzD3EKMHBrCTCe2kKUIg3JbGyKrUoP76oNCe1
        +BCjKTAwJzJLiSbnA3NKXkm8oamRsbGxham5pbGBpZI477HTrtFCAumJJanZqakFqUUwfUwc
        nFINjM1O1TWhexevfHt3674kjd8p4oecHiYv2tHxuXvlZs7ydy5r2UJsM7p2NKl36ypP2f90
        6pnpr2J2cR+YdOBV+fVitnLlpdKpMsvdCi5NLm3YfeCrD+tkFUvbRztvJblIKOvoTUpUn/Zn
        ypIL/xjfxR3PP7ZJTObkt4XqGb+u+r2pXNWXKiWRfE6JpTgj0VCLuag4EQCKWpOQ8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t9jAd0eIfdogykfNSz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlfF9
        1gWmgnvyFd9/nmZrYNwi2cXIySEhYCIxadVnRhBbSGAno8SaL3IgNq+AoMSPyfdYuhg5OJgF
        1CWmTMntYuQCKrnPKNF5fCIzSI2wgK/E3YNnWEFsEQENiSe/z4PNYRaYwSqx8UIMRMNfRomZ
        c5eAFbEJaEnsf3GDDcTmF1CUuPrjMSPEMjuJCbd+MYHYLAKqEo0r/rGA2KICERL3zn9iAzmC
        U8BQ4urpNIj54hLNrTdZIGx5iYNXnrNMYBScheTsWQhnz0LSMQtJxwJGllWMkqkFxbnpucVG
        BUZ5qeV6xYm5xaV56XrJ+bmbGIERvO2wVv8OxsdL4g8xCnAwKvHwbuBwixZiTSwrrsw9xCjB
        wawkwntpClCINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD
        4/oa5vDmtgNvawuXzWlzV/rK6afxXjJT236LmmKkX9XGJ245qRPWJsh1xGRJLRV4XeksltKe
        fsj2TueJ4neqx3jTZ7Auv7H6T7LXYbN21/6Ju4T7rrcYJ6Zlf5sbW/9seUjnsluTWN6ts3b9
        L2WUes4msFRZzPKYkPrLQ2xBS9+YNJ5fr2GgxFKckWioxVxUnAgA0zVD2NwCAAA=
X-CMS-MailID: 20180712083420epcas2p4efb7608b228781e340c0a24ad8a975d1
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b@epcas3p3.samsung.com>
        <20180703234705.227473-3-mka@chromium.org> <5B3C2EEF.4080309@samsung.com>
        <20180706163624.GE129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 07일 01:36, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Wed, Jul 04, 2018 at 11:20:31AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
>>> devfreq device") initializes df->min/max_freq with the min/max OPP when
>>> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
>>> available min/max frequency") adds df->scaling_min/max_freq and the
>>> following to the frequency adjustment code:
>>>
>>>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>
>>> With the current handling of min/max_freq this is incorrect:
>>>
>>> Even though df->max_freq is now initialized to a value != 0 user space
>>> can still set it to 0, in this case max_freq would be 0 instead of
>>> df->scaling_max_freq as intended. In consequence the frequency adjustment
>>> is not performed:
>>>
>>>   if (max_freq && freq > max_freq) {
>>> 	freq = max_freq;
>>>
>>> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
>>> when the user passes a value of 0. This also prevents df->max_freq from
>>> being set below the min OPP when df->min_freq is 0, and similar for
>>> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
>>> checks for this case can be removed.
>>>
>>> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>> Changes in v5:
>>> - none
>>>
>>> Changes in v4:
>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>
>>> Changes in v3:
>>> - none
>>>
>>> Changes in v2:
>>> - handle freq tables sorted in ascending and descending order in
>>>   min/max_freq_store()
>>> - use same order for conditional statements in min/max_freq_store()
>>> ---
>>>  drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
>>>  1 file changed, 30 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 0057ef5b0a98..6f604f8b2b81 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>>>  
>>> -	if (min_freq && freq < min_freq) {
>>> +	if (freq < min_freq) {
>>>  		freq = min_freq;
>>>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>>>  	}
>>> -	if (max_freq && freq > max_freq) {
>>> +	if (freq > max_freq) {
>>>  		freq = max_freq;
>>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>  	}
>>> @@ -1122,18 +1122,27 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  {
>>>  	struct devfreq *df = to_devfreq(dev);
>>>  	unsigned long value;
>>> +	unsigned long *freq_table;
>>
>> You can move 'freq_table' under 'else' statement.
> 
> Will do
> 
>>>  	int ret;
>>> -	unsigned long max;
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&df->lock);
>>> -	max = df->max_freq;
>>> -	if (value && max && value > max) {
>>> -		ret = -EINVAL;
>>> -		goto unlock;
>>> +
>>> +	if (value) {
>>> +		if (value > df->max_freq) {
>>> +			ret = -EINVAL;
>>> +			goto unlock;
>>> +		}
>>> +	} else {
>>> +		freq_table = df->profile->freq_table;
>>> +		/* typical order is ascending, some drivers use descending */
>>
>> You better to explain what is doing of following code.
>> How about modifying it as following?
>>
>> 		/* Get minimum frequency according to sorting way */
> 
> Ok, will slightly modify it to 'sorting order' if you don't mind.

I don't mind of 'soring order'. Thanks.

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
