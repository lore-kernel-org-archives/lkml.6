Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD09C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2AA23CAC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uEOKH3qS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2AA23CAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeGDFam (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:30:42 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60041 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932270AbeGDFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:30:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180704053037epoutp04c2dc54b64e3be779576de112935d3b7d~_E2KC3T1P2663126631epoutp04f;
        Wed,  4 Jul 2018 05:30:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180704053037epoutp04c2dc54b64e3be779576de112935d3b7d~_E2KC3T1P2663126631epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530682237;
        bh=0zfqUDPasGKo58KipvIjwtClT70iyOXRlWdIM6wfU/0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=uEOKH3qSFbwzZLY86lj+Eb9QlYwYmxA09vDnDPjWCToVFhTQAo/izCeOxh2KIWYA8
         50mSFe41LIXXUeodA34Vc/QvxZWleWvMSOvTyOEmL/eJoRZm+06PRRFoDJZT2DY85Y
         KMUNpFrjRT3AhZlYxHjjHwbjQMsp9Z4vtz9RMmJY=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704053034epcas1p13d1b6019a1ebb7363dbaa9eed093e362~_E2HZv3oC2004520045epcas1p1s;
        Wed,  4 Jul 2018 05:30:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.9F.04203.A7B5C3B5; Wed,  4 Jul 2018 14:30:34 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180704053033epcas1p2d843a74995846838cf572eae85ceade2~_E2HBsLYO1438614386epcas1p2L;
        Wed,  4 Jul 2018 05:30:33 +0000 (GMT)
X-AuditID: b6c32a39-24dff7000000106b-1b-5b3c5b7ad524
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 5E.D5.03915.97B5C3B5; Wed,  4 Jul
        2018 14:30:33 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00E6RTYWRFB0@mmp2.samsung.com>; Wed, 04 Jul 2018 14:30:33 +0900 (KST)
Message-id: <5B3C5B78.6020401@samsung.com>
Date:   Wed, 04 Jul 2018 14:30:32 +0900
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
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
In-reply-to: <20180703234705.227473-8-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjO6f3oRVc9u6KesSjdXRqFhMptLRw3MMThvGb8YCPZFm8M3MAJ
        JfYr97YE/MX8mEqGcSwTAhsfm9sIaQQBkU0mkxVxdrBIqbAwWQxmYR9xMxXUGYlt78z8dZ73
        eZ/n5H2fnMNRfIhN46o8fqJ6FJfArqIHv8+wZh2U8+Ts9jYeP268YsRNtyM07rv7N4PbQ5MM
        nvjyMouDc6MAH/68h8UTh/4y4l+XxgCOfPMJi2MNIYC/mLluwLHeBYDn3uti8bWZGIt/DE8x
        +Oi3ISM+tyQV8FKwLQikR/82Aqm17jotDd08A6S+7hOs9MuNYVYa+TRolKavHmKkgegxWjo5
        0A2kWN/m4tX7SJ6TKBVENRNPubeiylOZL7xRUvpaqSMnW8wSd+BcwexR3CRfKCwqznq9yhVf
        TTBXK65AnCpWNE3YtjNP9Qb8xOz0av58QRZFm1XMzrXabPHTvv8VmyMuKSPOxYZB2je2pmb6
        Vg9dB6Kr60EKh+B2NBQ+R9eDVRwPhwAKxe5QenEfoJZIP/VUtXB55r9GL0BzE9FkwwSfRw8+
        mo/bOY6C6Sg0dSBBUzADnb/YY0xgHt4E6FYTrcsz0fzSStJKQwu6tBw2JDAb50cWZ9kEXgtf
        QtEHCyCB18N30dfty8l7UmEJ6nj4U3JSCv5Jo84jj5hEYx0sQLOXxpOiFJiLmo58xSZECE4a
        0cLJe7S+QSHq+u4+o+N16I/xAWNiaARfRFNj+br+GED3Fg8zenEKoH+u9Rt0gx391llv0Fdb
        g+4sfcDoZhM6/j6vSyQ0O9LA6gldAKg53E+fAptangmp5f+QWp4JqQNQ3WAD8WnuSqKJPodV
        U9xawFNpLfe6+0DyBWfuGAJXJotGAeSA8JypK/CqzDNKtVbrHgWIo4RU04lteTJvqlBqDxLV
        W6oGXEQbBY54yB9SaevLvfH/4PGXig6b3W7H28UchygKG001P0OZh5WKnxwgxEfUpz4Dl5JW
        B85ccM1vOut7p3fLy7k3zNn7XcvhH7isx6erM8fkrXIOduxtvVr9WZGzWTkeio3s2ZDRu3l3
        Oruidu7aGt013mZx7D0/v7v9LX4wOMDahvvLQpbu22XTv28k7kisUUmtXyxBkS1urXBnxwsf
        r1jUu+lnT0/VtDa/uVa2DL9d8LBWoDWnImZSqqY8AXHV2S3XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t9jQd3KaJtog40nDSz+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlfGi
        dxtLwVG+iisP17M0MF7l7mLk5JAQMJF4fPA6cxcjF4eQwDpGiRUr+5hBErwCghI/Jt9j6WLk
        4GAWkJc4cikbJMwsoC4xad4iqPr7jBIX3z5lh6jXkrj39R9YL4uAqsS+b6eZQGw2oPj+FzfY
        QGx+AUWJqz8eM4LMFBWIkOg+UQkSFhEIlvjQ3MMGMpNZ4C2LxNJv/xlBEsICDhI39h1nh1i2
        nVHiyM97YAs4BcwlprcsZ5vAKDALya2zEG6dheTWBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OL
        S/PS9ZLzczcxAqNy22Gtvh2M95fEH2IU4GBU4uFdUWodLcSaWFZcmXuIUYKDWUmEt1PfJlqI
        NyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGxtQPvmm3ZJ+L
        ZLd9sU05fOTqWkPOTbI/02TF7i2p+DSpIkPATyLxq0jal1UF+gJKj5ie6bzI3Wm2LF/shKDP
        QssDk3X+LddKibuoerOOfY1J89Pa0KBzObPlemyZSlUvLHzcJ26+/P/lXTPW28edErRZNDdT
        JvAXqzRLiM7utXonN615efqwoRJLcUaioRZzUXEiAHguvDDGAgAA
X-CMS-MailID: 20180704053033epcas1p2d843a74995846838cf572eae85ceade2
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
        <20180703234705.227473-8-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't see any framework which exporting the class instance.
It is very dangerous. Unknown device drivers is able to reset
the 'devfreq_class' instance. I can't agree this approach.

Regards,
Chanwoo Choi


On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> Exporting the device class allows other parts of the kernel to enumerate
> the devfreq devices and receive notification when a devfreq device is
> added or removed.
> 
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
> - patch added to series
> ---
>  drivers/devfreq/devfreq.c | 3 ++-
>  include/linux/devfreq.h   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4cbaa7ad1972..38b90b64fc6e 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -31,7 +31,8 @@
>  #define MAX(a,b)	((a > b) ? a : b)
>  #define MIN(a,b)	((a < b) ? a : b)
>  
> -static struct class *devfreq_class;
> +struct class *devfreq_class;
> +EXPORT_SYMBOL_GPL(devfreq_class);
>  
>  /*
>   * devfreq core provides delayed work based load monitoring helper
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index c4f84a769cb5..964e064a951f 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -206,6 +206,8 @@ struct devfreq_freqs {
>  };
>  
>  #if defined(CONFIG_PM_DEVFREQ)
> +extern struct class *devfreq_class;
> +
>  extern struct devfreq *devfreq_add_device(struct device *dev,
>  				  struct devfreq_dev_profile *profile,
>  				  const char *governor_name,
> 

