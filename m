Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76325208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S045EwCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76325208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbeHAKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:17:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:51357 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbeHAKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:17:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180801083247epoutp04d8c47297bcf48634c0411035790da8ba~GtZNg3m7L1803318033epoutp043;
        Wed,  1 Aug 2018 08:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180801083247epoutp04d8c47297bcf48634c0411035790da8ba~GtZNg3m7L1803318033epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533112367;
        bh=21NTEC72XCQKFqcck5LhuVKk6QB7/G3hOr2KWD5Rvi8=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=S045EwCSvzW/iFmQ9fFeCqYFU545C9lYXGE4Y1GHp+nfqBFGqKgOW1N2SJy7N2ir2
         NFKAZAEi6EVJu0x05XKTcCQsRkbU6MU7wRMxXVdant7JNGVdXCjXqGSk6n2Jcsfkx0
         VtXbK0EC6hQTt010K6NfBreE9gyAj8bIKN+lv4vg=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180801083245epcas1p331ba7a8c11c809117986bfb85510b6cf~GtZLFhr-d2987829878epcas1p3K;
        Wed,  1 Aug 2018 08:32:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.95.04144.C20716B5; Wed,  1 Aug 2018 17:32:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180801083244epcas1p1e8a3146203aaaf1b067827fb631c77d4~GtZKyJ2oR3220132201epcas1p1p;
        Wed,  1 Aug 2018 08:32:44 +0000 (GMT)
X-AuditID: b6c32a39-bb5ff70000001030-bd-5b61702c88ba
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id CA.C2.03704.C20716B5; Wed,  1 Aug
        2018 17:32:44 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCR001VAX2KTLA0@mmp2.samsung.com>; Wed, 01 Aug 2018 17:32:44 +0900 (KST)
Message-id: <5B61702C.4090702@samsung.com>
Date:   Wed, 01 Aug 2018 17:32:44 +0900
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
Subject: Re: [PATCH v5 06/12] PM / devfreq: Make update_devfreq() public
In-reply-to: <20180703234705.227473-7-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxje6b299+LWcbmgnrCxsZssmSQt3JbC0VFjNrPcZMSQ8cfZLOUO
        joVAP+xtzRj7wfC70ekwm5GiwFTimi5qV7FODYKl+FmFCurEmagzKmZflcEgJrb3zuiv87zv
        eZ437/PkHIbgzlD5TIPTiz1OqYmn5pF9Zxbp9Xq3ZC2Z/B6gp+1xGu26lyRR+O8/tagrltCi
        S70DFArdHARo3b5DFLrU9phGt6eGAEr+0kmh1LYYQAeujWhQ6vBdgG5+fZBC56+lKHTxwqgW
        bTgVo9GRKXEZJ4b2hoA4N9sOxEDrCClGb+0HYji4hRInxk9SYv+eEC1ePdumFSNjm0jxm0gQ
        iKnwW1WvrsIV9Viqw55C7Kx11TU47Rb+42rbhzZzWYmgFxajcr7QKTmwhV9eWaX/qKEpbY0v
        XCs1+dKtKkmW+eKlFR6Xz4sL612y18JbBcFoEErKDUZj+jR9tsRoTlNqcH1i/zHSfZv7ovf0
        ZaoVRLP9IIuBbClsG9lA+sE8hmOjACb3Pfm/mE4XwQvUc9bTyLBGvTgM4JR/VrnQsTlwZudv
        aQXDEOzbMDbamGkT7CJ49MQhWuXfAnDM36tV+UWwf/dZIoNJ9l3YHU3SGUxl+g+uKzOz2Xfg
        2MxdkMHz2ZXweNe/CiePrYbd/11WtiPYSRL2rJ9ThuayIuw7NaEMzWLL4XRwp0KCbIKG9ycS
        ynaQXQ7/6TOqbnLho+EIrbbfgKNDFpW+CcAnD9Zp1WIHgH+d/1mjCkzwfo9fo1p7Hf4xtVWr
        inVw80ZOhSIMXEGq4WMADnRupHeAgo6XMup4kVHHSxl1AyIIFmC37LBjWXCbDbLkkH1Ou6HW
        5QgD5QEXLY6CeKJyELAM4F/TuZtrrJxWWis3OwYBZAg+T1fxps3K6eqk5i+xx2Xz+JqwPAjM
        6Yi/JfLn17rS38HptQlmo8lkQqVCmVkQ+IU644pqK8faJS9uxNiNPc91GiYrvxUMR53BXQXC
        DY/xk+8ufrX9x9VDgeNkdupxzfT4vc9bOl0tOf6HAc37q8/FocXqwr6DR0tKHaGf4o3v5Z5Y
        Nle7tZULRuvuxCIaQ3HxZOUA3r5k9Gq8QT4dnh3/QLCfawn8uvJAz+6F63NmjnRl5/3+SjDZ
        tqr/hzJ6TfmNT9t90QKelOsloYjwyNIzTAnBxtYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t9jQV2dgsRog+3PtS3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXFu
        yXaWgvtCFcsOnGdrYNzB38XIySEhYCLxd8txpi5GLg4hgXWMEpu7tjGBJHgFBCV+TL7H0sXI
        wcEsIC9x5FI2SJhZQF1i0rxFzBD19xkldq3ZzQpRryWxf+YJZhCbRUBVYsGOy+wgNhtI/MUN
        NhCbX0BR4uqPx4wgM0UFIiS6T1SChEUEgiU+NPewgcxkFnjLIrH0239GkISwgIfEtr13oJZt
        Z5S4dfsf2CBOAXOJ76sms0xgFJiF5NZZCLfOQnLrAkbmVYySqQXFuem5xUYFhnmp5XrFibnF
        pXnpesn5uZsYgVG57bBW3w7G+0viDzEKcDAq8fCeqE6IFmJNLCuuzD3EKMHBrCTCayMTHy3E
        m5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDo1fWTlXJxYcl
        z/dt/jWt/3PmTNFfTVF5b26cMzo+XXOD9xUef1dGd7M3Eia3Ju1XnFictk1i66bQYNu1jYvZ
        Zp6dH5lkX/NVL6bIoYwpO7pD0flyU8K8idUKr1smnf7cbXGoUnzCuconCpPOigXtWd6fWZuc
        aB7T/Ue19NqeFXOEhepW2R5hUmIpzkg01GIuKk4EAClvOgzGAgAA
X-CMS-MailID: 20180801083244epcas1p1e8a3146203aaaf1b067827fb631c77d4
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703234938epcas3p188a1f1bc1ba7eb819ba690485c850c79
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234938epcas3p188a1f1bc1ba7eb819ba690485c850c79@epcas3p1.samsung.com>
        <20180703234705.227473-7-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Currently update_devfreq() is only visible to devfreq governors outside
> of devfreq.c. Make it public to allow drivers that adjust devfreq policies
> to cause a re-evaluation of the frequency after a policy change.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> --
> Changes in v5:
> - none
> 
> Changed in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - added 'Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>' tag
> ---
>  drivers/devfreq/governor.h | 3 ---
>  include/linux/devfreq.h    | 8 ++++++++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index b81700244ce3..f53339ca610f 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,9 +57,6 @@ struct devfreq_governor {
>  				unsigned int event, void *data);
>  };
>  
> -/* Caution: devfreq->lock must be locked before calling update_devfreq */
> -extern int update_devfreq(struct devfreq *devfreq);
> -
>  extern void devfreq_monitor_start(struct devfreq *devfreq);
>  extern void devfreq_monitor_stop(struct devfreq *devfreq);
>  extern void devfreq_monitor_suspend(struct devfreq *devfreq);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 7c8dce96db73..c4f84a769cb5 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -222,6 +222,14 @@ extern void devm_devfreq_remove_device(struct device *dev,
>  extern int devfreq_suspend_device(struct devfreq *devfreq);
>  extern int devfreq_resume_device(struct devfreq *devfreq);
>  
> +/**
> + * update_devfreq() - Reevaluate the device and configure frequency
> + * @devfreq:	the devfreq device
> + *
> + * Note: devfreq->lock must be held
> + */
> +extern int update_devfreq(struct devfreq *devfreq);
> +
>  /* Helper functions for devfreq user device driver with OPP. */
>  extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq, u32 flags);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
