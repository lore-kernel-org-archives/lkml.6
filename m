Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F9921904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RoKXkbif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfBNEKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:10:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22713 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNEKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:10:33 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214041030epoutp03af2e2f644b844fd5a5d7b3f34510465e~DH5cuU5M81533815338epoutp03c
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:10:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214041030epoutp03af2e2f644b844fd5a5d7b3f34510465e~DH5cuU5M81533815338epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550117430;
        bh=ZbGuR6/w5lCkfriNFmYSFGCRnpZLk+1dAI6VmcVLSNg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RoKXkbifWxGU/6yXFKSFAvyb9lz2LgVbM9i0QoF7mY+covIlUQQXX2mbYBPBjqNu1
         QFi6TezO7l/XZYF90WotR90WFjoN2Y3csbBuYq+aR842h/3mfa3Ok0wVZ6HiNwvtYP
         mcFWdDgv3BJ+XARPw87Qdr0R8HQNdy91CUYMPCgM=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214041028epcas1p37d42350bb673c70748dc9c804ea3efb1~DH5aCaorN2246322463epcas1p3N;
        Thu, 14 Feb 2019 04:10:28 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.E1.04288.33AE46C5; Thu, 14 Feb 2019 13:10:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190214041027epcas1p43dee60ed8d0bb6eae0e01f3ccaa2f4e2~DH5ZU2Trr1212112121epcas1p4N;
        Thu, 14 Feb 2019 04:10:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214041027epsmtrp2493c1bb58190e5224f88d9c848e2df3a~DH5ZTcdn-3076130761epsmtrp2g;
        Thu, 14 Feb 2019 04:10:27 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-33-5c64ea339041
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.4D.03971.33AE46C5; Thu, 14 Feb 2019 13:10:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214041026epsmtip23f0fee63e32b755233b978a8e026f994~DH5ZDTw622279422794epsmtip2D;
        Thu, 14 Feb 2019 04:10:26 +0000 (GMT)
Subject: Re: [PATCH v3 1/7] drivers: devfreq: change deferred work into
 delayed
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <85f58e8e-53f7-c622-59f7-82f7e04ab6ac@samsung.com>
Date:   Thu, 14 Feb 2019 13:10:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550010238-24002-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmrq7Jq5QYg9MmFhtnrGe1mPbpMovF
        sgZVi7NNb9gtbjXIWFzeNYfN4nPvEUaLtUfusltcOrCAyeLzhseMFrcbV7BZ7Ot4wGRx+E07
        qwOvx5p5axg9ZjdcZPFo2XeL3WPhp6+sHgff7WHyeL/vKptH35ZVjB6fN8kFcERl22SkJqak
        Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaykUJaYUwoUCkgs
        LlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM7YNWcje8Fn
        3orznyewNzBu5+5i5OSQEDCR2NIyl72LkYtDSGAHo8SMg2/YIJxPjBKXz01hhHC+ATkTfrLC
        tGxu2Q5mCwnsZZS4facKoug9o8T2p21gCWGBQInp5yEaRATSJN6232UCKWIW+MgosfFAOwtI
        gk1AS2L/ixtsIDa/gKLE1R+PGUFsXgE7ifcvrgHZHBwsAqoSU2amgoRFBSIkDve+gyoRlDg5
        8wnYGE4Bb4nNszeDjWEWEJe49WQ+E4QtL9G8dTYzyF4JgW3sEiuvHmaD+MBF4lHnBKhvhCVe
        Hd/CDmFLSXx+txeqplpi5ckjbBDNHYwSW/ZfgGowlti/dDITyHHMApoS63fpQyzjk3j3tYcV
        JCwhwCvR0SYEUa0scfnBXSYIW1JicXsnG0SJh8Sqm0wTGBVnIflmFpIPZiH5YBbCrgWMLKsY
        xVILinPTU4sNC0yQI3sTIzgta1nsYNxzzucQowAHoxIPb4VQSowQa2JZcWXuIUYJDmYlEV6F
        F0Ah3pTEyqrUovz4otKc1OJDjKbAsJ7ILCWanA/MGXkl8YamRsbGxhYmhmamhoZK4rzrHZxj
        hATSE0tSs1NTC1KLYPqYODilGhj9bp3ZWZFv93n1Gwb9rAJLCd9TWzxOfen4tWCJj+jkb5yb
        dW6K/Au5GvDD/YLM+ncPjD7p39bREzY5lNZr7vf6YhObq8zi6fGtvFHHrzfwn3Vbs+jdj7XL
        dXXeNh7zXTCHz3v+B/41WQcaAhmEf1xSY3Esc3avtpJvD9JezDCn58E1F2vXWyeUWIozEg21
        mIuKEwH1521C4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvK7xq5QYg/mb2C02zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CI4rJJSc3J
        LEst0rdL4MrYNWcje8Fn3orznyewNzBu5+5i5OSQEDCR2NyynbWLkYtDSGA3o8SGTduYIRKS
        EtMuHgWyOYBsYYnDh4tBwkICbxkllt+WBLGFBQIlpp//yQpiiwikSRxquM0OModZ4COjxKFn
        B9ghht4HGrprIRNIFZuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2Eu9fXGMEWcYioCoxZWYqSFhU
        IELi49N9TBAlghInZz5hAbE5BbwlNs/eDDaGWUBd4s+8S8wQtrjErSfzmSBseYnmrbOZJzAK
        z0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREco1qaOxgv
        L4k/xCjAwajEw1shlBIjxJpYVlyZe4hRgoNZSYRX4QVQiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO/TvGORQgLpiSWp2ampBalFMFkmDk6pBkbhc0/+8Hnd8uqzntr4y66qdX+w9boD5Y33p+z/
        Iiu2IbMtOsI6XOf8/p9pluq/FKc761/mvKn498CJu7rtPJGN3guZ719piLGp3PN/KcvW5Wcs
        H702spwT6RXps/pv1YGVYfZf13M8Yzg+JWQX61PJJBP7IF1+Qbv3t63/nO2crbl6o/YV+Vwl
        luKMREMt5qLiRACpsxc3zQIAAA==
X-CMS-MailID: 20190214041027epcas1p43dee60ed8d0bb6eae0e01f3ccaa2f4e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222430eucas1p1ad7992e29d224790c1e20ef7442e62fe@eucas1p1.samsung.com>
        <1550010238-24002-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> This patch changes deferred work to delayed work, which is now not missed
> when timer is put on CPU that entered idle state.
> The devfreq framework governor was not called, thus changing the device's
> frequency did not happen.
> Benchmarks for stressing Dynamic Memory Controller show x2 (in edge cases
> even x5) performance boost with this patch when 'simpleondemand_governor'
> is responsible for monitoring the device load and frequency changes.
> 
> With this patch, the delayed work is done no mater CPUs' idle.
> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
> intervals should benefit from it.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..0c9bff8 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -407,7 +407,7 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);

As I commented, I can't agree that just changing the type of work
from deferrable to delayed for the always periodic timer.

Instead, if devfreq framework supports both deferrable
and delayed work according to selecting the kind of work
by user, I agree.

>  	if (devfreq->profile->polling_ms)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
