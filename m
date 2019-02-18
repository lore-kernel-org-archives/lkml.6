Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3352CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4B218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EchuLGh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBRFgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:36:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30701 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfBRFgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:36:47 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190218053642epoutp017248e736c6cb5d4b51ce6d1ed0147203~EXp1-55kt0381803818epoutp01d
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190218053642epoutp017248e736c6cb5d4b51ce6d1ed0147203~EXp1-55kt0381803818epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550468202;
        bh=pT7r93x8NOS0V+1AX3aAlXFD9FZIViA0ImorjW4h91g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EchuLGh+1rGBwOcgsIFv3Uz5rA0eoLRg/TNmQAtcTlShZBg8Fglsm40u/oYSfr7K3
         XddSEMiLV0dBS62gKoCEzfKkceWA53O3KjeOHGOHrECcjFvs4Z+iohT/G2RSwGxLgj
         yINt2mUJH4x5TPyOdLgBSz/w/W/Byf2YQ/0/GpxQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190218053639epcas1p1dbb3da50081d4a07a347c323522293cd~EXpzezAAI0901809018epcas1p1-;
        Mon, 18 Feb 2019 05:36:39 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.5D.04074.7644A6C5; Mon, 18 Feb 2019 14:36:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190218053639epcas1p47275220703fd351b7ed30c311c474e22~EXpzKcjOr0130001300epcas1p4r;
        Mon, 18 Feb 2019 05:36:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190218053639epsmtrp25e7ac7b6e4d7c2f3f5cc9afe8a4ebf03~EXpzJK5_g2423724237epsmtrp28;
        Mon, 18 Feb 2019 05:36:39 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-a3-5c6a4467ae6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.96.03971.7644A6C5; Mon, 18 Feb 2019 14:36:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190218053638epsmtip290a703178da3a6c2ecdd6bb3823e8e59~EXpy7QlGA3020630206epsmtip2a;
        Mon, 18 Feb 2019 05:36:38 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] drivers: devfreq: add tracing for scheduling
 work
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0c03a781-5a81-46ab-9e92-9534e72c4201@samsung.com>
Date:   Mon, 18 Feb 2019 14:36:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550235913-5189-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmvm66S1aMwfJLshYbZ6xntTjb9Ibd
        4laDjMXlXXPYLD73HmG0WHvkLrvFpQMLmCw+b3jMaHG7cQWbxb6OB0wWh9+0szpwe8xuuMji
        0bLvFrvHwXd7mDze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyMzru3mAuaOSsuLFpOmsD40r2LkZODgkBE4kb
        bZOAbC4OIYEdjBJ3V+5ng3A+MUpM37+GFcL5xigxZVUDE0zLld2XmCESexklHl1sZIJw3jNK
        vPs6B2ywsIC/xJSZTWC2iECaxNv2u2BFzAIHgDpWrgBLsAloSex/cYMNxOYXUJS4+uMxI4jN
        K2AnsXj/aqA4BweLgKrEkpMxIGFRgQiJw73voEoEJU7OfMICYnMKeEl8fXIezGYWEJe49WQ+
        E4QtL9G8dTbYpRIC/ewSj2++BpspIeAi0bU7BeIbYYlXx7dAA0NK4vO7vWwQdrXEypNH2CB6
        Oxgltuy/wAqRMJbYv3QyE8gcZgFNifW79CF28QH93sMKMZ5XoqNNCKJaWeLyg7vQgJOUWNze
        CTXeQ+L38Qb2CYyKs5B8MwvJB7OQfDALYdkCRpZVjGKpBcW56anFhgWGyLG9iRGcdLVMdzBO
        OedziFGAg1GJh/dDWWaMEGtiWXFl7iFGCQ5mJRHeXY5ZMUK8KYmVValF+fFFpTmpxYcYTYFh
        PZFZSjQ5H5gR8kriDU2NjI2NLUwMzUwNDZXEedc7OMcICaQnlqRmp6YWpBbB9DFxcEo1MPYH
        /DgrtHXVii2JCo8XevoXVouwC76/OcPM+MaVhU90u5mPG1x3uSt688LKb69FsiUzxBcf2Skq
        6bdzudNmYcfrThZHLCP//7ts7/Wdaa2bQMSty4LFzbtqQ5Tb6hMro6/v6xGu63r0RHupIv82
        6/8mXBs+BAcIlojZKp2ZbDq/f5LHQZkvHUosxRmJhlrMRcWJAAVhic/QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG66S1aMQddmTouNM9azWpxtesNu
        catBxuLyrjlsFp97jzBarD1yl93i0oEFTBafNzxmtLjduILNYl/HAyaLw2/aWR24PWY3XGTx
        aNl3i93j4Ls9TB7v911l8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mjrs3mAsaOStubJrO
        2sC4kr2LkZNDQsBE4sruS8wgtpDAbkaJNwecIOKSEtMuHgWKcwDZwhKHDxd3MXIBlbxllFj3
        ZilYr7CAr8TuPffBbBGBNIlDDbfBbGaBA4wSzTd9IBruMkpsefyFESTBJqAlsf/FDTYQm19A
        UeLqj8dgcV4BO4nF+1ezgSxjEVCVWHIyBiQsKhAh8fHpPiaIEkGJkzOfsIDYnAJeEl+fnGeB
        2KUu8WcexP3MAuISt57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZw7Glp7mC8vCT+EKMAB6MSD++HsswYIdbEsuLK3EOMEhzM
        SiK8uxyzYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg
        bNPu3fLfZGfU7RkXI4JkOC69tpz9QUreR7Fdd33dWwbW3benSQls+jPR0flK0UqvwztWLP33
        d5vZ+tuVO92nW1vMEbtqIXDR+sKJXqXq13NfFgqc1kvlzZ795O4CZs3ksvNiRYICxoeK5lUp
        H4h27VX9mx64IvVM/+RNu47H1DDGTV5/0X2PsBJLcUaioRZzUXEiALiMLNK5AgAA
X-CMS-MailID: 20190218053639epcas1p47275220703fd351b7ed30c311c474e22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p297d048d01902e2bb88e6db158d53fd88@eucas1p2.samsung.com>
        <1550235913-5189-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 15. 오후 10:05, Lukasz Luba wrote:
> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..660365a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  static struct class *devfreq_class;
>  
>  /*
> @@ -394,6 +397,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	queue_delayed_work(devfreq_wq, &devfreq->work,
>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(devfreq);
>  }
>  
>  /**
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
