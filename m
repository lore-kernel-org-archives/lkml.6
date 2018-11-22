Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F06CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C23D20672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KHErrh6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C23D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeKVNpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:45:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10659 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:45:09 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181122030745epoutp0415c286c736520e2b015465287752ce0b~pU2rP0svY1189311893epoutp04D;
        Thu, 22 Nov 2018 03:07:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181122030745epoutp0415c286c736520e2b015465287752ce0b~pU2rP0svY1189311893epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542856065;
        bh=dE8IcpPGUzouKH83GUKbEi1C67QInl5yE03Mn3g+HP0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=KHErrh6G/Fu725DJ4S7rjxhOYEZjb7ysvbPIO6H7FH1ht5x8M/OVab/1AduLAqg24
         GXI8YGg5m0Sfg57ziHWhwQ3YeFtV2F1nK1KGT0Pv6z9IpPqjMOtVgy7Q3NaMJR0o6D
         +Kn9tWEbrYl2Am1oV2HEKO4p+PynWYtc2jPJxwhs=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122030742epcas1p19b389058b82a86f34b5caabc1a4ece61~pU2oHe1tD0959409594epcas1p1U;
        Thu, 22 Nov 2018 03:07:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.A1.04064.E7D16FB5; Thu, 22 Nov 2018 12:07:42 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181122030741epcas1p42fd082bd926711d0ba2ed259b7eb34e7~pU2nvRMUC2444324443epcas1p4e;
        Thu, 22 Nov 2018 03:07:41 +0000 (GMT)
X-AuditID: b6c32a39-ff9ff70000000fe0-c9-5bf61d7e9307
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.0D.03601.D7D16FB5; Thu, 22 Nov 2018 12:07:41 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK00HU6RCTZZ80@mmp1.samsung.com>; Thu, 22 Nov 2018 12:07:41 +0900 (KST)
Message-id: <5BF61D7D.2090501@samsung.com>
Date:   Thu, 22 Nov 2018 12:07:41 +0900
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
Subject: Re: [PATCH 4/6] devfreq: add devfreq_suspend/resume() functions
In-reply-to: <1542823301-23563-5-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRj23G+IndduyBGc6+62OEjYeum6HZQaE5d5dfwg85NhgjdwpdjP
        9BZkmii4FFh1wuYSsTo3gyTIKnMMcTA+AuuG+2S0gTVbqMYuBuVjtQyKGpltr4v8e98nz/O8
        533OOQyunqUymAqrU3JYRTNHpRLd57K0Oe+tXSzWLrSloqHvs9Cp5pMk+uHUIomO+a6RaH/L
        SQpd+dCCGsPTOBod/Y5GVz+YodHNmseQ50g/hjrDEyQK9H5BofmDPoCaRwcw9K1vkkatN8Yw
        dKu2jUKTl87HPS77SeTq99Go7kSERDPXQ8Qz6UL32W5S8H7pBcLnNWOE0NQYBUJL32+Y0Nl+
        gBIGj3pp4fTX7wvLF2hhaK4PE7rG6wnh4652ILSdiNHCfOfjhav2mvKNklgmOTSStdRWVmEt
        N3C7Xyx5tkS/Xcvn8HloB6exihbJwO0sKMzZVWGOr89pqkRzZRwqFGWZ2/p0vsNW6ZQ0Rpvs
        NHCSvcxsz7NvkUWLXGkt31JqszzJa7W5+jjxDZOxtzkC7PVc9WV/BK8BgUw3SGEguw0e7Ahi
        bpDKqNkzAE5F+0mliQF4OzAB7rO8M610olazZwGcHng1UavYh+HSJyHCDRgGZ9dBn9+UgHE2
        C07dPUwoPpMAfvpzmFD42XCpNpr0IdhN8M6d8aQ/FccHp4JUon6IXQ/Hl8JJPI19DfYcW6QT
        RmvYUQC9PX3Jo+KsC4fLkS4qMXk1K8CJA+sSghR2Nwz1tiYnQ/YfGja6Q/9tsBN+1nKTVOrV
        8PeRLjqhhWwm9J83KPx6AO9O7SeVpgnAyKXTmCLQwV+/cmPKbqvg3MJHpCJWwYY6tUIR4JAv
        hCkJ/QTgvai1Caz1rAjJ839InhUhHQd4O3hEssuWcknm7fqVt9cJkk89O+8MuHCtYBiwDOAe
        VG0uWihWk2KVvM8yDCCDc2tU19vikKpM3PeO5LCVOCrNkjwM9PGMD+EZaaW2+MexOkt4fa5O
        p0Pb+O16nufSVbczjhar2XLRKZkkyS457uswJiWjBoxc9FzZOva88bnYxhtZb+UvaTTB9bG0
        zKK3Z3b8ssey13Tkx4K8uZc0zs2Rno7A8q4/8eU9j266VzTof9e0IeTKnf3b9Wb0D1G18YUN
        5F/fNEyTA09VB3rtr7Avc9R8cHa+9lzVxFVXOhkMV8cMcsOsua7j4vGUBzyHbj2RHXs9VzfC
        EbJR5LNxhyz+CzCxEfkABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RXUhTYRzGeXfO2TnOVm/T8KSlNIhslWl68RJRdlNHIvLCi9QLO+hhmp45
        dvzIoJqJmkoqbeWwskhF8TPXslyaTKdFq+a3kWxSSzKaKYpmEdKmhN09PP8fz/PAn8Jko3gg
        labK4jQqNkMuluC2NRc8dGX3SmK4W3sQWZ7uRx2GdgI961gh0APrewIV1LaL0dsyHlW4vmPI
        bn9MonfX3ST6qN2FqvU9ImR0TRBo1HxPjJZuWgEy2F+KUKvVQaL6yWERmspvFCPHmwFPhm2E
        QIU9VhIVNS8QyD3kxKMDmM4XnQTTUtMCmLvaYZyprFgETG33NxFjbCoRM733W0jmSd01Zm2Q
        ZCw/ukWMabwYZ8pNTYBpbP5JMkvG4NitCZJjKVxGWg6nOXz8giTVbFgA6mL5JdvIAqYFo0Gl
        wIeiYRTd4q4nS4GEksEuQL9adoq9ByncTq/qnHgpoCgMhtDWkfQNuY/W63kvIYPTgH5k5jZo
        Bb2av0h6NQ730vPz48CrxR6/d/bDeuI2uIceX3UBb8wOeJ4ue53nbfWHdkBbyksIL4PBQoz+
        XHTRy/hBhp4oCdlY5qmqmfu1zvjAM7TTXI9XAlj939DqzaHVm0MfAqwJ7OTUAq/khSPqCBWX
        GyawvJCtUoYlZ/JG4Hl1Z7+i/DmYrkvqA5AC8i3S0PjlRBnB5gh5fB+gKUzuLx1q9FjSFDbv
        MqfJTNJkZ3BCHwiicHmAdEo1GC+DSjaLS+c4Naf5dxVRPoFawDffsLH9znqOiInP5cYmew0D
        kZ+UFuWpE+d0iZUxGe7o3OzAO75FCV/G1FF8/4GG38JkQNRK3aykzthhja7qclT9aSiY8yUK
        Q08GD96KU2A9t03xV6OTQ/N1+pnQWMcsFn7aEIPMM62RxFEqDloSyLN47Ncik19b25BuSo4L
        qWyEAtMI7F+BbHUZ5gIAAA==
X-CMS-MailID: 20181122030741epcas1p42fd082bd926711d0ba2ed259b7eb34e7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7@eucas1p1.samsung.com>
        <1542823301-23563-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> This patch adds implementation for global suspend/resume for
> devfreq framework. System suspend will next use these functions.
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
>  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  7 +++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7e09de8..2f4391c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -44,6 +44,9 @@ static LIST_HEAD(devfreq_governor_list);
>  static LIST_HEAD(devfreq_list);
>  static DEFINE_MUTEX(devfreq_list_lock);
>  
> +/* Flag showing state of suspend/resume */
> +static bool devfreq_suspended;

Is it necessary? This patch just saves the 'true' or 'false' to this variable.
And there are no any point to check the value of this variable.
Please remove it.

> +
>  /**
>   * find_device_devfreq() - find devfreq struct using device pointer
>   * @dev:	device pointer used to lookup device devfreq.
> @@ -938,6 +941,52 @@ int devfreq_resume_device(struct devfreq *devfreq)
>  EXPORT_SYMBOL(devfreq_resume_device);
>  
>  /**
> + * devfreq_suspend() - Suspend devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycles for suspending governors
> + * and devices preserving the state for resume. On some platforms the devfreq
> + * device must have precise state (frequency) after resume in order to provide
> + * fully operating setup.
> + */
> +void devfreq_suspend(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_suspend_device(devfreq);
> +		if (ret)
> +			dev_warn(&devfreq->dev, "device suspend failed\n");
> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +
> +	devfreq_suspended = true;

Remove it.

> +}
> +
> +/**
> + * devfreq_resume() - Resume devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycle for resuming governors and
> + * devices that are suspended with devfreq_suspend().
> + */
> +void devfreq_resume(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	devfreq_suspended = false;

Remove it.

> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_resume_device(devfreq);
> +		if (ret)
> +			dev_warn(&devfreq->dev, "device resume failed\n");
> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
>   * devfreq_add_governor() - Add devfreq governor
>   * @governor:	the devfreq governor to be added
>   */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 7fe96f9..4f0fea8 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -202,6 +202,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
>  extern int devfreq_suspend_device(struct devfreq *devfreq);
>  extern int devfreq_resume_device(struct devfreq *devfreq);
>  
> +

Remove the blank line.

> +extern void devfreq_suspend(void);
> +extern void devfreq_resume(void);
> +
>  /**
>   * update_devfreq() - Reevaluate the device and configure frequency
>   * @devfreq:	the devfreq device
> @@ -396,6 +400,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline void devfreq_suspend(void) {}
> +static inline void devfreq_resume(void) {}

You better to move the inline definitions
under 'devfreq_resume_device' inline function.

>  #endif /* CONFIG_PM_DEVFREQ */
>  
>  #endif /* __LINUX_DEVFREQ_H__ */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
