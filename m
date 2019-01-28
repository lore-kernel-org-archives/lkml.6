Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3CC282CA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86E72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 01:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rmgl+jQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1BR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 20:17:26 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:28729 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfA1BR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 20:17:26 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190128011722epoutp03094e0f58413dc04139b2bdfef4d47542~93kbUjf0E3276332763epoutp032
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:17:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190128011722epoutp03094e0f58413dc04139b2bdfef4d47542~93kbUjf0E3276332763epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548638242;
        bh=4dbqkuLrD2qHSkeaEY04pic09bbzd11BSwqiPHnj55I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rmgl+jQy/CG+wORrKFC6/4lWN2+/pP1TWMi0oNBBpz+0gMJmi4XOReybhP+gjjLCq
         AF4JIWFun6nQdurWXfP/Qal1PUtUM4Vhuj5bf3lGwe954wiCUNfmaAz/+UDmT3oY5w
         nTBlrlcKPcKcmypHNj3slXtHdK7Qf8n9TT9o0zuc=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190128011718epcas1p19fabc8f3192c0326b535cccd6c8918e5~93kXTtCk92826028260epcas1p1n;
        Mon, 28 Jan 2019 01:17:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.B7.04288.E185E4C5; Mon, 28 Jan 2019 10:17:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190128011717epcas1p4640a89c2f5414bb5f0122f4143a39fcc~93kWt-3v92854728547epcas1p4U;
        Mon, 28 Jan 2019 01:17:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128011717epsmtrp1523b13c4365d333646f768a1b43fa8c5~93kWoRhKW1607716077epsmtrp1b;
        Mon, 28 Jan 2019 01:17:17 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-33-5c4e581eb770
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.3A.03971.D185E4C5; Mon, 28 Jan 2019 10:17:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128011717epsmtip178dba79fcf4c82620e56d08a2ac4e7ff~93kWYOUOy1072510725epsmtip1c;
        Mon, 28 Jan 2019 01:17:17 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9fbfc35c-9448-f1ae-6e47-7d5f6bba22de@samsung.com>
Date:   Mon, 28 Jan 2019 10:17:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125135403.10228-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3d3u7szVdWadpHRd6YeCHzddXSMlVGKRhVA/RIR1cTcV99W9
        UyqjLEPLSo3MdGlKMiqjlh+VhTVyM5EoF/apiUaiZWFQKUVEbbuL/Pc8z/scznnOewhMdQMP
        JwpNVo43sQYKD5LedkXHxkZk78hNmD0XxnQ0OGTM0NBNOTNStooZvteEM99OuxHTMPRAwnx0
        /0DMdfeYnBk9cgXfrNCOvD2s7Ww/gWsfzvZKtNXd7Uj7rTMiS5ZTtKmAY/Ucr+ZMeWZ9oSk/
        hdq2U5eu06xPoGPpZGYDpTaxRi6FysjMit1SaPCOQ6lLWEOxV8piBYGKT93Em4utnLrALFhT
        KM6iN1iSLXECaxSKTflxeWbjRjohYZ3Ga9xdVNDROCG1/FHuq3uUUobuLq5CCgLIJHA5KqRV
        KIhQkT0I3n1qwkTyFYGzuTZA5hG01XfJ/pWcn/HIxYf7CFob6nGRfEEw3/UY87lCyQyoqXzq
        dy0jqxFcs7tlPoKREwha3nokPhdOxoDzw2vch5eSa+DFj/fIh5VkKniOTXk9BCEl18LVU/t8
        chiZDa7TswFLCAw2Tkp9WOG1N35/6R8PI1fAyGSLRMSRUH7rgj8DkL9wqB13ScUMGXBptF8i
        4lCYGeiWizgcPtZUBHApXB1042LxcQTdTk9gAYngtJ/1D4eR0eC4Fy82WwKzc6dkPhlIJRyv
        UInuKBieGAu0WgltlSdwEWthuusVVovW2BbEsS2IYFsQwfa/WSuStqPlnEUw5nMCbUla+N2d
        yH+rMUwP6n2a2YdIAlHByuzf23NVMrZE2G/sQ0Bg1DKl9o5XUurZ/Qc43qzjiw2c0Ic03mWf
        wcLD8szeyzdZdbRmXWJiIpNEr9fQNLVC6dicnqsi81krV8RxFo7/VychFOFlKH3XytWpaS7l
        5QcDe8c7arZafjdHRqWeXPS6egs/2ubo74maPpqd+ZyX27e2p6vtdeVvdvQFfY1bpAv+M37o
        IUwmV/XWeT4HzR1UlOpawzIrIzZOmYTSZ09CnWkhRcNMWo7+2uTPkplgzZ09ejkTHRl50W69
        UfPCVn+mXHtOPlVKSYUClo7BeIH9C+TIHTDBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnK5shF+MwdKJChYbZ6xntTh/fgO7
        xa0GGYvLu+awWXzuPcJoMeP8PiaLl0d+MFqsPXKX3eJ24wo2B06PW3fqPTat6mTzOPhuD5NH
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZWyc+YCl4D9vxZRjtg2MO7m7GDk5JARMJKa/usAO
        YgsJ7GaUeL9NFCIuKTHt4lHmLkYOIFtY4vDhYoiSt4wS+zexgdjCAi4S/e3ngFq5OEQE+hgl
        Xn5dwwTiMAs8YpR4ceAMmCMkMJFRomvNXbAWNgEtif0vboDZ/AKKEld/PGYEsXkF7CQutDxj
        AtnGIqAqsbKnAiQsKhAh8fHpPiaIEkGJkzOfsIDYnEDlM79cYwWxmQXUJf7Mu8QMYYtL3Hoy
        nwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6
        yfm5mxjBsaWluYPx8pL4Q4wCHIxKPLwb/vvGCLEmlhVX5h5ilOBgVhLh9dgOFOJNSaysSi3K
        jy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoHRKMP6wKOLnQ9zZzac2a2x
        fV/D9KDvQq6uIewsqxUeFzKtuPE72FthoV34TZOuJ84sF98kWm4RvHL6cFyHnvFnU5tmv6Ox
        j1uemMyuP79S0mdj3ZI3/nc2SZ398rUn8k3WhCTbi+L790+a8NzFQdXdYotP7uulb6PfKS/7
        /+r7pmMyy7z/icz3VWIpzkg01GIuKk4EAD2m98ypAgAA
X-CMS-MailID: 20190128011717epcas1p4640a89c2f5414bb5f0122f4143a39fcc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
        <20190125135403.10228-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 1. 25. 오후 10:54, Marek Szyprowski wrote:
> This way devfreq core ensures that all its devices will be set to safe
> operation points before reboot operation. There are board on which some
> aggressive power saving operation points are behind the capabilities of
> the bootloader to properly reset the hardware and boot the board. This
> way one can avoid board crash early after reboot.
> 
> Similar pattern is used in CPUfreq subsystem.
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..f6aba8344c56 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/devfreq.h>
>  #include <linux/workqueue.h>
>  #include <linux/platform_device.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
> @@ -1422,6 +1423,10 @@ static struct attribute *devfreq_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>  
> +static struct syscore_ops devfreq_syscore_ops = {
> +	.shutdown = devfreq_suspend,
> +};
> +
>  static int __init devfreq_init(void)
>  {
>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
> @@ -1438,6 +1443,8 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	register_syscore_ops(&devfreq_syscore_ops);
> +
>  	return 0;
>  }
>  subsys_initcall(devfreq_init);
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
