Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5434C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7821020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UVYcThD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7821020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbeKVNf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:35:27 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:61459 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeKVNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:35:26 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181122025805epoutp044f97043982b1e46205dbfc642d0d8623~pUuPTR7bw0352603526epoutp041;
        Thu, 22 Nov 2018 02:58:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181122025805epoutp044f97043982b1e46205dbfc642d0d8623~pUuPTR7bw0352603526epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542855485;
        bh=WB87N4xyS+s3GSFzGd7A24F5JQcrk7gzdDMPVy8pC50=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=UVYcThD/Q4GuUT1ZPBeFlEra/JJTmNZszArqcbaxXemLPnfQ01OV6VE4KPxnPMI5A
         pyXzJx6lJRsIHyHcc8XEC5X/U4ogjEhFVHW6H/+GXmZRmCN6OEwPdeWufDZjGNasDL
         ZkBCupPugolJnYCFsrzKNU1s5ud5/K+0cRVXYs7E=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181122025803epcas1p3f9a7b483a7b30177f2191573089be2b7~pUuNJuN5F3008030080epcas1p3V;
        Thu, 22 Nov 2018 02:58:03 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.CD.04058.B3B16FB5; Thu, 22 Nov 2018 11:58:03 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122025802epcas1p1b8e1fe27259178e71112b95bc5427dd5~pUuMjRjMp1819618196epcas1p1U;
        Thu, 22 Nov 2018 02:58:02 +0000 (GMT)
X-AuditID: b6c32a35-e37ff70000000fda-5e-5bf61b3ba2fb
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.EC.03601.A3B16FB5; Thu, 22 Nov 2018 11:58:02 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK009W8QWQQE80@mmp1.samsung.com>; Thu, 22 Nov 2018 11:58:02 +0900 (KST)
Message-id: <5BF61B3A.9050402@samsung.com>
Date:   Thu, 22 Nov 2018 11:58:02 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzOe9frHcS6W0V9Kdtk55YIGa5HLXtx1rnMLJegsZnL/GBZd4EL
        YD/Xa80kWVZmhMmUD3VGQOYIM2vaOqRU0FHngDKjDotMHDJhceiGlSFRvtwWtx6nGf89vyfP
        88v7PO/7Urh6XKmhimwuwWnjLYwyUdHalabNeDVlOlf7cDAZdZxKQ81HmgjU1jxNoGORywTa
        3dikRD9+ZkWVI3dxFI2eJFHPJ2MkGvQ8g2oPncVQcOQagX769qgSPdgfAehI9DsMnYgMkej4
        z1cw9EuJV4mGLnbHd1zqI9CesxESlfonCDTWO6xYt5RrbW8luMAXAcDVea4ouKrK+4BrDN/B
        uKBvr5I7Vx8guZavPuYe/UByHeNhjAv1lym4ipAPcF7/DMk9CD5nXLjdvKZQ4PMFZ6pgy7Pn
        F9kKDEzOZtMbJn2Wls1gs9ErTKqNtwoGZv0GY8abRZZ4fCZ1J29xxykjL4rMy2vXOO1ul5Ba
        aBddBkZw5Fsc2Y6VIm8V3baClXl262pWq83Ux4XvmwtbfGW4YzT5w4bxv4AHeJLKQQIF6VXw
        9m8XQDlIpNT0aQBvRO8q5GEGwM/r/Ionqm+8tzAJq+l2AAcvsBJW0U/D2YPDcQ1F4fQyGOkz
        SzROp8HRyQOP9wwB6GurwGV9Ouyf6SIlrKBfhH/sC81hZZw/NzqglPBT9POwf3YESHgxvRWe
        OTZNSouS6CiAgTNhTBpweg8OH02E5hyL6HegNzxLSqdIoHPg0cbVkgbSD0nYE6vD5ATrof/6
        PSDjRTB2PjSnh3QK7Os2yPoyACdHdxPyUAXgxMWWx2Yd/L2hHJOzLYTjU/sI2ayCn5aqZQkH
        u656SDnyrwDurz6OV4Fna+e1VPt/S7XzWvoS4D6wRHCI1gJBZB3s/OsLgrm3nq4/DQ5d3tAJ
        aAowC1Qrtk3lqgl+p7jL2gkghTNJql5vnFLl87uKBafd5HRbBLET6OMlV+OaxXn2+M+xuUys
        PlOn06FVbJaeZZmlqlua+lw1XcC7BLMgOATnEx9GJWg8YPmOseTye1m9r8VyyJp1VxOLzx9o
        +kC7uWHvndipjTmVf2te8pmyK+5/rRgoMRc3B9qWDN+8vaU5POm+SXJvvzA95fzz3caNEzeu
        BxN7llFrS7edqE8RUHWWwfheX+alHW8dXpH577Xq7gX1HTpywF9jbG/wJRzcdPijf8Ze/76z
        xlgSYxRiIc+m406R/w+M5c8YAQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAV0r6W/RBq+a9C0ObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJWxeVU7c8ELyYqF734xNjA2iHQx
        cnJICJhIrFvxhKmLkYtDSGAno8SJ4ztYQBK8AoISPybfA7I5OJgF5CWOXMqGMNUlpkzJhSi/
        zyhxdv9EZohyLYmr3w+zg9gsAqoSz3u2gNlsQPH9L26wgdj8AooSV388ZgSZIyoQIdF9ohJk
        jojAeUaJg32drCA1zAKtzBKP2rJAbGGBMImunr/scMtmLfjECtLMKeAtMWex1QRGgVlILp2F
        cOkshEsXMDKvYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIjOtth7X6djDeXxJ/iFGA
        g1GJh1cj8mu0EGtiWXFl7iFGCQ5mJRHeCyuAQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2L
        FBJITyxJzU5NLUgtgskycXBKNTA23Xt9mD3U5l3TDtEeRS7dSxcKmj9rh2UVeBc5JnTd4pRf
        UHtdtWEtzw5r0cPme/3U1287Odkv+d/tywYnprIcUfBf0ie5KfPOS+ek+ohZDDdO/ljavW/v
        73nCPf8Y4m96vZvgs+KK7IWX+tvtTrvlq4ZKdf0vO1iXdVd7TsrdfGmhKE5D5WdKLMUZiYZa
        zEXFiQAtI73s5wIAAA==
X-CMS-MailID: 20181122025802epcas1p1b8e1fe27259178e71112b95bc5427dd5
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> The patch adds support for handling suspend/resume process.
> It uses atomic variables to make sure no race condition
> affects the process.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

Please remove the duplicate information about patch history.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index cf9c643..7e09de8 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>   */
>  int devfreq_suspend_device(struct devfreq *devfreq)
>  {
> -	if (!devfreq)
> -		return -EINVAL;
> +        int ret;

Move 'ret' definition under 'if (devfreq->suspend_freq) {'
because 'ret' is used if suspend_freq isn't zero.

> +        unsigned long prev_freq;
> +        u32 flags = 0;
> +
> +        if (!devfreq)
> +                return -EINVAL;
> +
> +        if (devfreq->governor) {
> +		ret = devfreq->governor->event_handler(devfreq,
> +					DEVFREQ_GOV_SUSPEND, NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	if (!devfreq->governor)
> -		return 0;
> +	if (devfreq->suspend_freq) {
> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
> +			return 0;
>  
> -	return devfreq->governor->event_handler(devfreq,
> -				DEVFREQ_GOV_SUSPEND, NULL);
> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
> +					 &prev_freq, flags);

Remove the 'prev_freq' parameter.

> +		if (ret)
> +			return ret;
> +
> +		devfreq->resume_freq = prev_freq;

As I commented on patch2, if devfreq_set_taget save the current frequency
to 'devfreq->resume_freq', this line is not needed.


> +	}
> +
> +        return 0;
>  }
>  EXPORT_SYMBOL(devfreq_suspend_device);
>  
> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>   */
>  int devfreq_resume_device(struct devfreq *devfreq)
>  {
> +        int ret;

Move 'ret' definition under 'if (devfreq->suspend_freq) {'
because 'ret' is used if suspend_freq isn't zero.

> +        unsigned long prev_freq;

Remove prev_freq variable which is not used on this function.
After calling devfreq_set_target, prev_freq is not used.

> +        u32 flags = 0;
> +
>  	if (!devfreq)
>  		return -EINVAL;
>  
> +	if (devfreq->suspend_freq) {
> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
> +			return 0;
> +
> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
> +					 &prev_freq, flags);

Remove the 'prev_freq' parameter.

> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (!devfreq->governor)
>  		return 0;
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
