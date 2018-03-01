Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032787AbeCAQTT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:19:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032539AbeCAQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:19:18 -0500
Subject: Re: [PATCH v3] net: iucv: Free memory obtained by kzalloc
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jwi@linux.vnet.ibm.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
References: <1519903917-11575-1-git-send-email-arvind.yadav.cs@gmail.com>
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 17:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519903917-11575-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030116-0008-0000-0000-000004D686F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030116-0009-0000-0000-00001E698C3D
Message-Id: <6335d05c-f87e-d5b5-f86b-2255ab0191b8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 12:31 PM, Arvind Yadav wrote:
> Free memory by calling put_device(), if afiucv_iucv_init is not
> successful.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>              Calling put_device() before kfree().
> changes in v3:
>              No need to call kfree(). So removed kfree().
> 
>  net/iucv/af_iucv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 1e8cc7b..9e2643a 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
>  	af_iucv_dev->driver = &af_iucv_driver;
>  	err = device_register(af_iucv_dev);
>  	if (err)
> -		goto out_driver;
> +		goto out_iucv_dev;
>  	return 0;
> 
> +out_iucv_dev:
> +	put_device(af_iucv_dev);
>  out_driver:
>  	driver_unregister(&af_iucv_driver);
>  out_iucv:
> 

Thanks Arvind, I have added this patch version to our local repository; it will be part of a
coming patch submission to Dave Miller.

Regards, Ursula
