Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeBAVqf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 16:46:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40103 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeBAVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 16:46:28 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180201214626epoutp01a0cb98001852108577911f52917c0543~PUdfakmOg0983909839epoutp01K
X-AuditID: b6c32a37-44bff70000001029-89-5a738ab12a26
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A738AB1.1090606@samsung.com>
Date: Fri, 02 Feb 2018 06:46:25 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: int3496: process id-pin first so that we start
 with the right status
In-reply-to: <20180125193919.1084-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmge7GruIog3vPbCzeHJ/OZHF51xw2
        i9uNK9gcmD3e77vK5tG3ZRWjx+dNcgHMUak2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2StGGhkZ6
        hgbmekZGRnomxrFWRqZAJQmpGacPhBf84ql4sPIhYwPjKa4uRg4OCQETiTlbNbsYuTiEBHYw
        SjQv+MoM4XxnlFjwbx8LTNHkp+kQ8d2MEjN+/wKKc3LwCghK/Jh8D6yGWUBe4silbJAws4Cm
        xNbd69kh6u8xSqx6ewqqXkti59+3zCA2i4CqxJULa5hAbDag+P4XN9hAbH4BRYmrPx4zgtii
        AhESO+d/YwexRQSCJG58X8EKsUBB4te9TWC2sECyRN/zdWwgN3AKWEjMuacCsldCYAmbxLl/
        l8HmSAi4SEyd8R/KFpZ4dXwLO8Rf0hKXjtpC1LczSrTvnccM4UxhlDh3/R4TRIOxxLOFXUwQ
        i/kk3n3tYYVo5pXoaBOCKPGQODJ5HguE7Sjxfc0aRojnuxklVnR8YZrAKDcLKbxmIcJrFlJ4
        LWBkXsUollpQnJueWmxYYKxXnJhbXJqXrpecn7uJEZyutMx3MG4453OIUYCDUYmHN0G2OEqI
        NbGsuDL3EKMEB7OSCO+bfUVRQrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmErzSuINTSwN
        TMyMgGnL0tBQSZw3IMAlSkggPbEkNTs1tSC1CKaPiYNTqoFRYP6pkwGr79fGerRlcm/7F57E
        vMiDnf+KofQ1xb+JiU1zmzYtlpriWbPvq1x2cflyi3ffU7xEzfITrE+UF1xx7NLa5feWZV7n
        F5WZigyiTmXi08XEVp+TNvONKd/0RnurbHPTDMtVC5Ilp0/4lPhjt+P6/yp3Tzs2b+H9aOOv
        01F/g+mXgbwSS3FGoqEWc1FxIgCIBA1mbQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t9jAd2NXcVRBr3XRSzeHJ/OZHF51xw2
        i9uNK9gcmD3e77vK5tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZpw+EF/ziqXiw8iFjA+Mp
        ri5GDg4JAROJyU/Tuxi5OIQEdjJKbLp7gLmLkZODV0BQ4sfkeywgNcwC8hJHLmWDhJkF1CUm
        zVvEDFH/gFHi2cUz7BD1WhI7/74F62URUJW4cmENE4jNBhTf/+IGG4jNL6AocfXHY0aQmaIC
        ERLdJypBwiICARI/T/WzQ8xXkPh1bxMriC0skCzR93wdG8SuXkaJbR+uMYP0cgpYSMy5pzKB
        UWAWkktnIVw6C8mlCxiZVzFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBAbqtsNafTsY
        7y+JP8QowMGoxMObIFscJcSaWFZcmXuIUYKDWUmE982+oigh3pTEyqrUovz4otKc1OJDjNIc
        LErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGC2vvUjc0r7o1e73mqqL9y3bNvNYlWbpL59H
        j9Q6DFOmRrl+SNpr/nrh+ivXn01meaCfOaObqVC6aebSefsTL9j7pRyJ1/60aXnmzs+cZTdU
        OK6WCB9o0+MQKk5ds+D+2wJbDpvt9e2rd7odL5mQuTfr0b6f19tUbS3rrnx/dF7kaFbHi2/s
        uw8osRRnJBpqMRcVJwIAfs0Kk1ACAAA=
X-CMS-MailID: 20180201214625epcas1p48f86496067dcacd57c1757319b5362b7
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180125193930epcas1p15288db5193038561d6061fcaa2a802bb
X-RootMTR: 20180125193930epcas1p15288db5193038561d6061fcaa2a802bb
References: <CGME20180125193930epcas1p15288db5193038561d6061fcaa2a802bb@epcas1p1.samsung.com>
        <20180125193919.1084-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 01월 26일 04:39, Hans de Goede wrote:
> Some other drivers may be waiting for our extcon to show-up (exiting their
> probe methods with -EPROBE_DEFER until we show up).
> 
> These drivers will typically get the cable state directly after getting
> the extcon, this commit changes the int3496 code to process the id-pin
> before registering the extcon, so that other drivers see the correct state
> right away.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index c8691b5a9cb0..b23ee9d993a3 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -131,6 +131,10 @@ static int int3496_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->gpio_usb_mux))
>  		dev_info(dev, "can't request USB MUX GPIO\n");
>  
> +	/* process id-pin first so that we start with the right status */
> +	queue_delayed_work(system_wq, &data->work, 0);
> +	flush_delayed_work(&data->work);
> +
>  	/* register extcon device */
>  	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>  	if (IS_ERR(data->edev))
> @@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* queue initial processing of id-pin */
> -	queue_delayed_work(system_wq, &data->work, 0);
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
