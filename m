Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C0C21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uQg42ZAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbfBNELb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:11:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:59884 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731965AbfBNELa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:11:30 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214041128epoutp01ea6f744662ffc7df2271b46696021e13~DH6SNQt_e1638116381epoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:11:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214041128epoutp01ea6f744662ffc7df2271b46696021e13~DH6SNQt_e1638116381epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550117488;
        bh=MuxZhC7o5vJ5qIFiKOH2mJqptN2HjtAouuwFB1n/XsU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uQg42ZAJJZCWLmVUYPfUt30ruzWgHAvlmjw3zVZZOevcHS6Mra7MZenLbFKb+Abey
         r4W2X8zxFczuaTRpWQ/34PIJxo/RB6PCjDYJscAo7XQj+ckYdNPqQwi+WjEHdU22xX
         vomhMl/DUyIwWJY0S3LF5JIujvqCkHj3+CPOp8OY=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214041125epcas1p42d244a90c004316c6e93b9f76a6fd3f1~DH6P_Y-0c2419824198epcas1p48;
        Thu, 14 Feb 2019 04:11:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.B8.04074.D6AE46C5; Thu, 14 Feb 2019 13:11:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190214041125epcas1p3da3208f77dd4cdb7f4bbc6a5b58e28a6~DH6Poh6Lw2246322463epcas1p3h;
        Thu, 14 Feb 2019 04:11:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214041125epsmtrp2d5595981b075aa5520b994672b33963d~DH6PnLPbk3050330503epsmtrp2P;
        Thu, 14 Feb 2019 04:11:25 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-a6-5c64ea6d8ccb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.5D.03971.D6AE46C5; Thu, 14 Feb 2019 13:11:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214041125epsmtip2d8cd50f34283f318c21237860ee7c05d~DH6Pav30V2112721127epsmtip2f;
        Thu, 14 Feb 2019 04:11:25 +0000 (GMT)
Subject: Re: [PATCH v3 2/7] drivers: devfreq: change devfreq workqueue
 mechanism
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <aa254c1d-7e0b-b3d3-be68-669aa234b400@samsung.com>
Date:   Thu, 14 Feb 2019 13:11:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550010238-24002-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmnm7uq5QYg1OrzC02zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CIyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCdsWThWraC
        y7IVR36+ZmpgXCPRxcjJISFgIjG5/y1zFyMXh5DADkaJgxM+MkE4nxgl9vz7xw7hfGOUmNj1
        mQmm5f3pS1Ate4Fankxig3DeM0rcfj4PqIWDQ1ggSOLeJWOQBhGBNIm37XfBxjILfGSU2Hig
        nQUkwSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdxMKu0+wgNouAqsSs/4+ZQWxRgQiJw73voGoE
        JU7OfAI2h1PAW+Ljz01g9cwC4hK3nsxngrDlJZq3zga7VEJgE7vErksvmECOkxBwkXjWbg3x
        jbDEq+Nb2CFsKYnP7/ayQdjVEitPHmGD6O1glNiy/wIrRMJYYv/SyWBzmAU0Jdbv0ofYxSfx
        7msPK8R4XomONiGIamWJyw/uQgNOUmJxeyfUeA+J9c/Ps0xgVJyF5JtZSD6YheSDWQjLFjCy
        rGIUSy0ozk1PLTYsMESO7U2M4NSsZbqDcco5n0OMAhyMSjy8FUIpMUKsiWXFlbmHGCU4mJVE
        eBVeAIV4UxIrq1KL8uOLSnNSiw8xmgIDeyKzlGhyPjBv5JXEG5oaGRsbW5gYmpkaGiqJ8653
        cI4REkhPLEnNTk0tSC2C6WPi4JRqYPStk7yd8NZGrNyxwWjbXK0tZ+6/4heYdlGnJfiQdcPL
        o6drL97neuc9XzV/I4vFfIcTPM9NHDcp1/TntTH2nfyWJ86fm1yhtchpWcv0PVd0rmWnur5Q
        au5NYp/UKsPyZkkIs4Hd5T9x/QIfuHheN/DmvjG5+ZO/MfyZSX+qhHcRd5158Op5SizFGYmG
        WsxFxYkAYKW+qeMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvG7uq5QYg48T5Cw2zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CI4rJJSc3J
        LEst0rdL4MpYsnAtW8Fl2YojP18zNTCukehi5OSQEDCReH/6EnMXIxeHkMBuRomHx6YxQyQk
        JaZdPApkcwDZwhKHDxdD1LxllJjft44FJC4sECRx75IxSLmIQJrEoYbb7CA1zAIfGSUOPTvA
        DtFwn1HiwqEF7CBVbAJaEvtf3GADsfkFFCWu/njMCGLzCthJLOw6DVbDIqAqMev/Y7AjRAUi
        JD4+3ccEUSMocXLmExYQm1PAW+Ljz01g9cwC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUXgW
        kvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4CjV0tzBeHlJ
        /CFGAQ5GJR7eCqGUGCHWxLLiytxDjBIczEoivAovgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwWse9e5u/tzNk1rMLOuuFjjyYfM7fq8lc77aA5Ryp
        Sctt7U9fFI642FfLubDi15ZbhROrg/67LJyckXranLdiasmNHVLVr5xkv1xTZJL1mr1+baGG
        g3KRll31THbTzQLtrAJdjh+O37kaIKhwcqm3aa3vwR4XRZtzH7OPLbudXXUhfv/F//prlFiK
        MxINtZiLihMBEZLfUs4CAAA=
X-CMS-MailID: 20190214041125epcas1p3da3208f77dd4cdb7f4bbc6a5b58e28a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb@eucas1p1.samsung.com>
        <1550010238-24002-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

This patch depends on first patch. Firstly, we need to discuss
the first patch and then I'll review this patch.
[1] [PATCH v3 1/7] drivers: devfreq: change deferred work into delayed

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> There is no need for creating another workqueue in the system,
> the existing one should meet the requirements.
> This patch removes devfreq's custom workqueue and uses system one.
> It switches from queue_delayed_work() to schedule_delayed_work().
> It also does not wake up the system when it enters suspend (this
> functionality stays the same).
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0c9bff8..c200b3c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -31,13 +31,6 @@
>  
>  static struct class *devfreq_class;
>  
> -/*
> - * devfreq core provides delayed work based load monitoring helper
> - * functions. Governors can use these or can implement their own
> - * monitoring mechanism.
> - */
> -static struct workqueue_struct *devfreq_wq;
> -
>  /* The list of all device-devfreq governors */
>  static LIST_HEAD(devfreq_governor_list);
>  /* The list of all device-devfreq */
> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	if (err)
>  		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>  
> -	queue_delayed_work(devfreq_wq, &devfreq->work,
> -				msecs_to_jiffies(devfreq->profile->polling_ms));
> +	schedule_delayed_work(&devfreq->work,
> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
>  }
>  
> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  {
>  	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>  	if (devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
>  EXPORT_SYMBOL(devfreq_monitor_start);
> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>  	if (!delayed_work_pending(&devfreq->work) &&
>  			devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  	devfreq->last_stat_updated = jiffies;
> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  
>  	/* if current delay is zero, start polling with new delay */
>  	if (!cur_delay) {
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  		goto out;
>  	}
> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  		cancel_delayed_work_sync(&devfreq->work);
>  		mutex_lock(&devfreq->lock);
>  		if (!devfreq->stop_polling)
> -			queue_delayed_work(devfreq_wq, &devfreq->work,
> +			schedule_delayed_work(&devfreq->work,
>  			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	}
>  out:
> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>  		return PTR_ERR(devfreq_class);
>  	}
>  
> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
> -	if (!devfreq_wq) {
> -		class_destroy(devfreq_class);
> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
> -		return -ENOMEM;
> -	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
>  	return 0;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
