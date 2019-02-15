Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9914F21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XTFU7r7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbfBOAdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:33:15 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27733 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbfBOAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:33:14 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190215003310epoutp0258b3ca45e5bbf3ac3992f489c54682e2~DYk9xjJWj2990129901epoutp02T
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:33:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190215003310epoutp0258b3ca45e5bbf3ac3992f489c54682e2~DYk9xjJWj2990129901epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550190790;
        bh=PnJpE8QBDLjXj0qm53JFUkrsLsCqJpm0hZoNoI7mkaI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XTFU7r7WS3qQR231UK89pwO0oGTFOeCIA1Cv0qsCpSrEzsXB8/K9ju6226IdaGpBN
         uV4YHUKLtdlNCeQwFWHWeIsAV0oo4VGMuqaITeBK1+g6WSIEoHUIw03jOtJySfRelY
         b5f4B0IE20KSqheqOvtnj81r61sKyjmlqx+gwEc0=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215003306epcas1p2d8168c5abf3e2189d0ebd29c319b715b~DYk6K-Tmd0252202522epcas1p2t;
        Fri, 15 Feb 2019 00:33:06 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.08.04173.2C8066C5; Fri, 15 Feb 2019 09:33:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190215003305epcas1p4a3f3e26d705bd532313cf3224a853650~DYk5ejhUd2165121651epcas1p4O;
        Fri, 15 Feb 2019 00:33:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215003305epsmtrp1edb8a5b097c6715f2391afa04e7eb546~DYk5dUxy10992909929epsmtrp1L;
        Fri, 15 Feb 2019 00:33:05 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-7e-5c6608c2c659
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.3E.03601.1C8066C5; Fri, 15 Feb 2019 09:33:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190215003305epsmtip16eadad3570d8143e29a6f1e108239299~DYk5PEy0a0494104941epsmtip1E;
        Fri, 15 Feb 2019 00:33:05 +0000 (GMT)
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1671c5fa-5414-8a83-b372-99f7f057a2ac@samsung.com>
Date:   Fri, 15 Feb 2019 09:33:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215001947.GF117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmnu4hjrQYg//7uSyeHdW2aJm1iMXi
        bNMbdotbDTIWl3fNYbP43HuE0aLzyywga8NjRovbjSvYLH7umsfiwOUxu+Eii8fOWXfZPXqb
        37F5HHy3h8mjb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyV
        FPISc1NtlVx8AnTdMnOADlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW6BUn
        5haX5qXrJefnWhkaGBiZAhUmZGcsWDKfraBfvaLj5E22BsYp8l2MHBwSAiYSeydmdDFycQgJ
        7GCUODhzFRuE84lRovdHKxOE841RYteLE0AZTrCOo/ufskIk9jJKbG7awAjhvGeUmHH3BBNI
        lbBAmMT7j1vAOkQENCSe/D4PVsQs8IVJYlPbX7AiNgEtif0vboAV8QsoSlz98ZgRxOYVsJNY
        MucDWJxFQFVi36+fYPWiAhESh3vfQdUISpyc+YQFxOYUMJTomdIDVs8sIC5x68l8JghbXqJ5
        62xmkMUSAs3sEkePrmKC+MFFYuaXFywQtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/
        wAqRMJbYv3QyEyj4mAU0Jdbv0odYxifx7msPKyRUeSU62oQgqpUlLj+4C7VWUmJxeyc0GD0k
        Nv89yjaBUXEWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwAg5ujcxglOtltkOxkXnfA4x
        CnAwKvHwrshIjRFiTSwrrsw9xCjBwawkwtvKnhYjxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVE
        k/OBeSCvJN7Q1MjY2NjCxNDM1NBQSZx3vYNzjJBAemJJanZqakFqEUwfEwenVANj/vTjj13f
        vlZ9fIV3xR4H3Zoc9T8M3Oxx14XU/lzak//VyJrz8lbt3WlZG/8FlV65dlt3X9a/vO/LT/7W
        cTncvrV723rhxL7elFyxbXvVOmfNj8gzyNTTlBX9LhSUsermtXa3aM6GZ2nOTnu1WIRNpZ1K
        mn5ZdAXm3QhXWZdo039X9ElHxFolluKMREMt5qLiRAB77C9DywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWy7bCSnO5BjrQYg5bVIhbPjmpbtMxaxGJx
        tukNu8WtBhmLy7vmsFl87j3CaNH5ZRaQteExo8XtxhVsFj93zWNx4PKY3XCRxWPnrLvsHr3N
        79g8Dr7bw+TRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGQuWzGcr6Fev6Dh5k62BcYp8FyMn
        h4SAicTR/U9Zuxi5OIQEdjNK9L1vZIFISEpMu3iUuYuRA8gWljh8uBii5i2jxNcPe5hAaoQF
        wiTef9zCBmKLCGhIPPl9nhHEZhb4xiQx/XUoREMjs0RbD8RQNgEtif0vboA18AsoSlz98Ris
        gVfATmLJnA9gcRYBVYl9v36CLRAViJD4+HQfE0SNoMTJmU/A5nAKGEr0TOlhg1imLvFn3iVm
        CFtc4taT+UwQtrxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwykst1ytO
        zC0uzUvXS87P3cQIjjktrR2MJ07EH2IU4GBU4uENTEuNEWJNLCuuzD3EKMHBrCTCe/0hUIg3
        JbGyKrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANjKe9irRtO3Fen
        H+A75vp3sfavB//YlD6VhpktuLzk4y4xG5047kAuJ+HXX58/9f78dELYlDsfE0XD3rFfWHTk
        6K2uV2/DZ98Tk5DR0rvwK0DjzAwW/TWiK387C5wTXcEzedLcKy1BPtcVE08eCKyv/DxLKXTh
        37J7LD62+mfVfjyWOyWTsXFTmBJLcUaioRZzUXEiADawkXS1AgAA
X-CMS-MailID: 20190215003305epcas1p4a3f3e26d705bd532313cf3224a853650
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190214192933epcas5p204c34010accb5e63480abd3ca34991eb
References: <20190214013042.254790-1-mka@chromium.org>
        <20190214013042.254790-5-mka@chromium.org>
        <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
        <CGME20190214192933epcas5p204c34010accb5e63480abd3ca34991eb@epcas5p2.samsung.com>
        <20190214192855.GD117604@google.com>
        <b28e763d-c3c9-0673-6216-f67561112b60@samsung.com>
        <20190215001947.GF117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 19. 2. 15. 오전 9:19, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> On Fri, Feb 15, 2019 at 08:42:30AM +0900, Chanwoo Choi wrote:
>> Hi Matthias,
>>
>> On 19. 2. 15. 오전 4:28, Matthias Kaehlcke wrote:
>>> Hi Chanwoo,
>>>
>>> On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
>>>> Hi Matthias,
>>>>
>>>> As I commented on the first patch, it is not possible to call some codes
>>>> according to the intention of each governor between 'devfreq_moniotr_*()'
>>>> and some codes which are executed before or after 'devfreq_moniotr_*()'
>>>>
>>>> For example, if some governor requires the following sequence,
>>>> after this patch, it is not possible.
>>>>
>>>> case DEVFREQ_GOV_xxx:
>>>>         /* execute some code before devfreq_monitor_xxx() */
>>>>         devfreq_monitor_xxx()
>>>>         /* execute some code after devfreq_monitor_xxx() */
>>>
>>> As for the suspend/resume case I agree that the patch introduces this
>>> limitation, but I'm not convinced that this is an actual problem.
>>>
>>> For governor_start(): why can't the governor execute the code
>>> before polling started, does it make any difference to the governor
>>> that a work is scheduled?
>>
>> The some governors might want to do something before starting
>> the work and do something after work started. I think that
>> the existing style is more flexible.
> 
> Could you provide a practical example that answers my question above:
> 
> "why can't the governor execute the code before polling started, does
> it make any difference to the governor that a work is scheduled?"

Actually, as for now, I don't know the correct practice and now.
I want to say that the existing style is more flexible for the
new governor in the future. If there are no any special benefits,
I think we don't need to harm the flexibility.

> 
>> And,
>> It has one more problem when changing the governor on the fly
>> from simple_ondemand to other governors like performance,
>> powersave and so on.
>>
>> Even if other governors don't need to monitor the utilization,
>> the work timer will be executed continually because the devfreq
>> device has the polling_ms value. It is not necessary
>> of the other governors such as performance, powersave.
>>
>> It means that only specific governor like simple_ondemand
>> have to call the devfreq_monitor_start() by itself
>> instead of calling it on devfreq core.
> 
> yes, I noticed that too, it can be easily fixed with a flag in the
> governor.

Right, If we add some codes like flag, it is easy.
Actually, it is just difference how to support them.

I think that the existing style has not any problem and is not
complicated to develop the new governor. If there are no
some benefits, IMO, we better to keep the flexibility.
It can give the flexibility to the developer of governor.

> 
>>> For governor_stop(): why would the governor require polling to be
>>> active during stop? If it needs update_devfreq() to run (called by
>>> devfreq_monitor()) it can call it directly, instead of waiting for the
>>> monitor to run at some later time.
>>
>> As I knew, if the current governors are performance/powersave/
>> userspace, the monitoring is already stopped and not used.
>> Because they don't need to handle the codes related to the work
>> like queue_delayed_work(), cancel_delayed_work_sync().
>>
>> And,
>> In case of the existing style for calling devfreq_monitor_*(),
>> other governors like performance/powersave/userspace/passice
>> don't need to call the devfreq_monitor_stop() because they
>> didn't use the work timer.
> 
> As per above, the governor could have a flag indicating that it
> doesn't need load monitoring.

About this, I commented above. Pleas check it.

> 
> I think it should be avoided to expect the governors to do the right
> thing if certain actions are mandatory and common for all governors
> (unless the feature in question is not used). It should be handled in
> the core code, unless there are good reasons not to do this.

I agree to distinguish for common code and specific code depends on governor.
But, it is harm for the flexibility. We know that there are no problem
after applying this patchset. But, as I commented, I'm not sure that
it is meaningful to harm the flexibility.

> 
> With thispatch set the amount of code remains essentially the same,
> and no new code needs to be added for governors that don't do anything
> special in start/stop/suspend/resume.
> 
> TBH I think probably the entire event handler multiplexing should go
> away and be changed to a struct devfreq_ops with optional callbacks
> for start, stop, suspend, resume and update interval. As far as I can
> tell the multiplexing isn't needed and separate ops would result in
> cleaner code, in both the devfreq core and the governors.
> 
> Cheers
> 
> Matthias
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
