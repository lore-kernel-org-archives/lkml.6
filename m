Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D801FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992A820842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ey8Me8rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfBLLDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:03:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52469 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBLLDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:03:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212110345euoutp020e038ef295e14c772d703f6f06694f03~CmPsLoHvU2621826218euoutp02S
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:03:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212110345euoutp020e038ef295e14c772d703f6f06694f03~CmPsLoHvU2621826218euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549969425;
        bh=W7fezuUdMLLcualb6sPJSO3hftCmW70fCu9s2FXmSAI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ey8Me8rj2TBgoATMc8rQctnTi2sv+CmA1SUtZPg6PKtwwVJ8ymhRPwTGKRJzZCyZa
         o6rr7nGYgVsrWdDwEDYMmkFAlA2lO9sCZkurAZewU7hEINMcs06mT32CmVW2JRuhcR
         oRpQcyRdCK2NexrAPpeBZAQHtElErh8q/nZbe26U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212110345eucas1p228c227dab559365648920bd92e958aba~CmPrrwCeq1510315103eucas1p2a;
        Tue, 12 Feb 2019 11:03:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 63.2D.04294.018A26C5; Tue, 12
        Feb 2019 11:03:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212110344eucas1p18e6c73c6452c8d44f5cffbab92cce194~CmPq6mv1y2071520715eucas1p1D;
        Tue, 12 Feb 2019 11:03:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212110344eusmtrp2f1a713274a72d423e0f79e833d5307da~CmPqrZXpe0674106741eusmtrp2E;
        Tue, 12 Feb 2019 11:03:44 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-f9-5c62a8105627
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.4F.04128.018A26C5; Tue, 12
        Feb 2019 11:03:44 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212110343eusmtip245a2f341f29a0a0115368e50396d5dcc~CmPqHrrK91759617596eusmtip2g;
        Tue, 12 Feb 2019 11:03:43 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] drivers: devfreq: change deferred work into
 delayed
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f87887b9-13cd-43a5-8d1f-740a90118152@partner.samsung.com>
Date:   Tue, 12 Feb 2019 12:03:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211213602.GQ117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7oCK5JiDP78tLbYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vF+8nFDjwe
        a+atYfSY3XCRxWPBplKPhZ++snr0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxpX/R9kKbghU
        LLu4iK2B8RxvFyMnh4SAicSUj21sXYxcHEICKxglNs66wwjhfGGUmPl6IxOE85lRYuuis0ww
        Lf33X7JDJJYzStz60cIK4bxllLj4upMVpEpYIFBi08X3LCC2iICGxJPf58HmMgvMZJJ43PUT
        aCMHB5uAnsSOVYUgNbwCbhLT5j1gBwmzCKhK9D10BAmLCkRIHO59xwhRIihxcuYTsJGcAoYS
        u/t2soHYzALiEreezGeCsOUltr+dwwyySkLgHrvEzv0nwWZKCLhIHDrGB/GAsMSr41vYIWwZ
        if8750M9VixxtmMVG4RdI9F+cgdUjbXE4eMXWUHGMAtoSqzfpQ8RdpQ4t6mdDWI6n8SNt4IQ
        F/BJTNo2nRkizCvR0SYEUa0hsaXnAtQiMYnla6axT2BUmoXkr1lIfpmF5JdZCHsXMLKsYhRP
        LS3OTU8tNspLLdcrTswtLs1L10vOz93ECExap/8d/7KDcdefpEOMAhyMSjy8FfmJMUKsiWXF
        lbmHGCU4mJVEeOOWJsUI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoE
        k2Xi4JRqYKwKNY556Z/w5VJI1++ESM855uej+nTkrlyvjPfdcKRfPqjUor89KpnvUOT+as7D
        /wLCT0o0B5xptHnV7Fd5/vPDdCcFfsnw2R3CXbE9cWraE5n9xLeZnxLqNGTeNGnNogkHu99u
        D9Pgmm35fUEm6yG7sDkR65N81gRFHzv86e33/UeEtQx5lViKMxINtZiLihMBR4+lflYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7oCK5JiDB6fZbbYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vF+8nFDjwe
        a+atYfSY3XCRxWPBplKPhZ++snr0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
        npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpX/R9kKbghULLu4iK2B8RxvFyMnh4SAiUT/
        /ZfsXYxcHEICSxklXm44zwKREJOYtG87O4QtLPHnWhcbRNFrRonNH18zgiSEBQIlNl18D9Yg
        IqAh8eT3eUaQImaBmUwSrUvOQY1tYZJ4vnMLaxcjBwebgJ7EjlWFIA28Am4S0+Y9YAcJswio
        SvQ9dAQJiwpESHx8uo8JokRQ4uTMJ2DzOQUMJXb37WQDsZkFzCTmbX7IDGGLS9x6Mp8JwpaX
        2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjddux
        n1t2MHa9Cz7EKMDBqMTDq5CbGCPEmlhWXJl7iFGCg1lJhDduaVKMEG9KYmVValF+fFFpTmrx
        IUZToN8mMkuJJucD00heSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5O
        qQbGbT1e96YtfsrS+HfV5FkBLt8lZG+mZBREsBlGSncKhhjNNextZUlt2vup119ay4Yx3vCV
        +87vtkFKpQ/aZvx8sL7DtNLo64cfr6wvV7Q7rIi86a01Z876mYYGFaG+8lsK1qz7r7bxRZZU
        p76ECcfC2xmudSbRb0r21Yg9Caz7GuC9abbjajMlluKMREMt5qLiRABEHWb56wIAAA==
X-CMS-MailID: 20190212110344eucas1p18e6c73c6452c8d44f5cffbab92cce194
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153037eucas1p20b80e44795e3599dabd9c2fc0291c063@eucas1p2.samsung.com>
        <1549899005-7760-3-git-send-email-l.luba@partner.samsung.com>
        <20190211213602.GQ117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/11/19 10:36 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Mon, Feb 11, 2019 at 04:30:05PM +0100, Lukasz Luba wrote:
>> This patch changes deferred work to delayed work, which is now not missed
>> when timer is put on CPU that entered idle state.
>> The devfreq framework governor was not called, thus changing the device's
>> frequency did not happen.
>> Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
>> even x5) performance boost with this patch when 'simpleondemand_governor'
>> is responsible for monitoring the device load and frequency changes.
>>
>> With this patch, the delayed work is done no mater CPUs' idle.
>> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
>> intervals should benefit from it.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 882e717..c200b3c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
>>    */
>>   void devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>   	if (devfreq->profile->polling_ms)
>>   		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
> 
> I'd suggest to swap the order of the patches in this series.
> 
> Why, you may ask, if the end product is the same? This patch ([2/2])
> fixes an actual problem, while IIUC [1/2] is just an improvement, the
> fix doesn't really depend on it. If -stable wants to integrate the
> fix, they also need to pick the improvement (or resolve a conflict),
> which might not be desired.
Good point, I will reorder them.
> 
> Otherwise this looks sane to me:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
>
Thank you for the review.

Regards,
Lukasz
