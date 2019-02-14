Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66395C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED05721904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QRmkjPRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395526AbfBNEvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:51:12 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:25145 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfBNEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:51:12 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214045104epoutp014d9e03cd6f0326cca9562faccb33aa5a~DIc3h9hOG2073320733epoutp01x
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214045104epoutp014d9e03cd6f0326cca9562faccb33aa5a~DIc3h9hOG2073320733epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550119864;
        bh=WwlPP+uha89mjgbDz3FYItABszGc4i53vj5fAxCyhuw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QRmkjPRDdaxSXkw0PRZJsqpM7CQOJEotzGTtKZklricI+rpnAS6Zsc2sHvt3WTJO3
         nVKGhoSpNxTBB2xHGB/r6tOWvPNvDzLLOoV7lB2+c25erD8KzwUpvMF6LqreHMDngM
         vGrmKBVm5NsGPXiBYabG98u2tnPXJNX/feyueELA=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214045101epcas1p498761b02ed188625cedebf8219ace338~DIc0R7E-R1128211282epcas1p4Q;
        Thu, 14 Feb 2019 04:51:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.A1.04074.5B3F46C5; Thu, 14 Feb 2019 13:51:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190214045100epcas1p1c2ec93cf55d7bce0a830102b71292cc6~DIczz4M421782917829epcas1p1z;
        Thu, 14 Feb 2019 04:51:00 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214045100epsmtrp29f6067faeac56907393ffd54dce234d5~DIczyWhAg1201112011epsmtrp2A;
        Thu, 14 Feb 2019 04:51:00 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-56-5c64f3b55ea9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.EC.03601.4B3F46C5; Thu, 14 Feb 2019 13:51:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214045100epsmtip2f6f826bfcea8922c398207cc68801aaf~DIczm8Xhr0586005860epsmtip2r;
        Thu, 14 Feb 2019 04:51:00 +0000 (GMT)
Subject: Re: [PATCH v3 4/7] include: devfreq: add polling_idle_ms to
 'profile'
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b956e581-0753-6257-279b-a4c8218c2651@samsung.com>
Date:   Thu, 14 Feb 2019 13:51:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmnu7WzykxBtO+C1hsnLGe1WLap8ss
        FssaVC3ONr1ht7jVIGNxedccNovPvUcYLdYeuctucenAAiaLzxseM1rcblzBZrGv4wGTxeE3
        7awOvB5r5q1h9JjdcJHFo2XfLXaPhZ++snocfLeHyeP9vqtsHn1bVjF6fN4kF8ARlW2TkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SxkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE749V+p4KP
        ghUTP1xmbmBczNfFyMkhIWAicenhJMYuRi4OIYEdjBIX7zayQjifGCVenf0J5XxjlPj9cRsT
        TMv7W2/ZQGwhgb1ALQ1ZEPZ7RonFJ01AbGGBAIn+1s/sILaIQJrE2/a7TCCDmAU+MkpsPNDO
        ApJgE9CS2P/iBtggfgFFias/HjOC2LwCdhJLX/wEW8YioCrx7cIhVhBbVCBC4nDvO6gaQYmT
        M58AzeHg4BTwljg9WwIkzCwgLnHryXwmCFteonnrbGaQvRICm9glrm/+wQLxgIvEkfsXGCFs
        YYlXx7ewQ9hSEp/f7WWDsKslVp48wgbR3MEosWX/BVaIhLHE/qWTmUAWMwtoSqzfpQ+xjE/i
        3dceVpCwhACvREebEES1ssTlB3eh4SYpsbi9kw2ixEOiYUnABEbFWUiemYXkg1lIPpiFsGsB
        I8sqRrHUguLc9NRiwwJD5KjexAhOylqmOxinnPM5xCjAwajEw1shlBIjxJpYVlyZe4hRgoNZ
        SYRX8SNQiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucDM0ZeSbyhqZGxsbGFiaGZqaGhkjjv
        egfnGCGB9MSS1OzU1ILUIpg+Jg5OqQZGUYkfNxpnyXnLWc5wvR5wkUegrVU+xSGj9n+++Jsn
        Sazzbqv5bKldsP+NkOCR9we877+PEX7F8eMhy8u//MHL01iSt/18Z1bgqF//yvRS+53PnVd6
        exv6VXr3qy/g3bVH5OLCnR+zt526Jfpl57djx981HZY7eVe7RN6YY2ndvziuN3I8ZqaHlViK
        MxINtZiLihMBSAI+T+ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvO6WzykxBnPXG1psnLGe1WLap8ss
        FssaVC3ONr1ht7jVIGNxedccNovPvUcYLdYeuctucenAAiaLzxseM1rcblzBZrGv4wGTxeE3
        7awOvB5r5q1h9JjdcJHFo2XfLXaPhZ++snocfLeHyeP9vqtsHn1bVjF6fN4kF8ARxWWTkpqT
        WZZapG+XwJXxar9TwUfBiokfLjM3MC7m62Lk5JAQMJF4f+stWxcjF4eQwG5GiWm7PzFDJCQl
        pl08CmRzANnCEocPF0PUvGWU2NfxghGkRljAT+Lz8Q4mEFtEIE3iUMNtdpAiZoGPjBKHnh1g
        h+i4zyixbsdWsKlsAloS+1/cYAOx+QUUJa7+eAw2iVfATmLpi59gk1gEVCW+XTjECmKLCkRI
        fHy6jwmiRlDi5MwnLCAXcQp4S5yeLQESZhZQl/gz7xIzhC0ucevJfCYIW16ieets5gmMwrOQ
        dM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx6iW1g7GEyfi
        DzEKcDAq8fAqCKTECLEmlhVX5h5ilOBgVhLhVfwIFOJNSaysSi3Kjy8qzUktPsQozcGiJM4r
        n38sUkggPbEkNTs1tSC1CCbLxMEp1cA466Dbp+iHTwo4NQ96rJttwHrNwCHYMXCe8H6R4w9W
        iEtzCpasbvvfEfrx35dK6eqDIgtlbn8w3qJTnrugl6FhTvueSVanHzczBe6M/Pm1WWpar3Rr
        2LvS7FAT1xx5p51P0gUsdqfv2nhw3oSlu98xfWdU/f/z+91L6Q3H/6RNn659Pje618lViaU4
        I9FQi7moOBEAOW1v0s0CAAA=
X-CMS-MailID: 20190214045100epcas1p1c2ec93cf55d7bce0a830102b71292cc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222434eucas1p134dcdce827df19704c698fd6452b0a06
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222434eucas1p134dcdce827df19704c698fd6452b0a06@eucas1p1.samsung.com>
        <1550010238-24002-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

If the user can select the type of work in accordance with
their choice, either deferrable work or delayed work
for periodic without stop on idle state,
I think that the existing polling_ms is enough.

Because, user determine to use the 'delayed work' for periodic timer,
user can change the polling_ms through already provided sysfs interface
according to multiple situation.

In fact,
If the user want to use the periodic timer without stop on idle state
instead of deferrable work, it means that the user always want to
monitor/check the current load/status of device at the correct interval
and then changing the frequency without any latency.

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> Add needed fields to support new state: idle, where different polling
> interval is in use. It provides better control of the devfreq device
> and lower the power consumption when the device is not busy.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/linux/devfreq.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74..5140970 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -72,6 +72,11 @@ struct devfreq_dev_status {
>   * @initial_freq:	The operating frequency when devfreq_add_device() is
>   *			called.
>   * @polling_ms:		The polling interval in ms. 0 disables polling.
> + * @polling_idle_ms:	The polling interval in 'idle state' in ms.
> + *			When the device is running at lowest frequency and has
> + *			low-load, it is considered as in 'idle state'.
> + *			Thus, longer polling interval is used for the device
> + *			to save some power.
>   * @target:		The device should set its operating frequency at
>   *			freq or lowest-upper-than-freq value. If freq is
>   *			higher than any operable frequency, set maximum.
> @@ -98,6 +103,7 @@ struct devfreq_dev_status {
>  struct devfreq_dev_profile {
>  	unsigned long initial_freq;
>  	unsigned int polling_ms;
> +	unsigned int polling_idle_ms;
>  
>  	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>  	int (*get_dev_status)(struct device *dev,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
