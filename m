Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8C0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E2D2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E2D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbeGSPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:24:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731782AbeGSPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:24:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JEci25005490
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:41:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kav2uhjxk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 10:41:04 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 19 Jul 2018 15:41:01 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Jul 2018 15:40:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6JEevp246006382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jul 2018 14:40:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3125A4055;
        Thu, 19 Jul 2018 17:41:14 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10F0CA4040;
        Thu, 19 Jul 2018 17:41:14 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.146])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Jul 2018 17:41:13 +0100 (BST)
Subject: Re: [PATCH] s390/ap_bus: replace PTR_RET with PTR_ERR_OR_ZERO
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719044205.GA24764@embeddedor.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 19 Jul 2018 16:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719044205.GA24764@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071914-0012-0000-0000-0000028C2C7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071914-0013-0000-0000-000020BDF62C
Message-Id: <9b1b260f-0caa-a199-3d22-a4c1d62e89f2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807190157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2018 06:42, Gustavo A. R. Silva wrote:
> PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> index c0a6723..bf27fc4 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -474,7 +474,7 @@ static int ap_poll_thread_start(void)
>  		return 0;
>  	mutex_lock(&ap_poll_thread_mutex);
>  	ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
> -	rc = PTR_RET(ap_poll_kthread);
> +	rc = PTR_ERR_OR_ZERO(ap_poll_kthread);
>  	if (rc)
>  		ap_poll_kthread = NULL;
>  	mutex_unlock(&ap_poll_thread_mutex);
> @@ -1242,7 +1242,7 @@ static int __init ap_module_init(void)
>  
>  	/* Create /sys/devices/ap. */
>  	ap_root_device = root_device_register("ap");
> -	rc = PTR_RET(ap_root_device);
> +	rc = PTR_ERR_OR_ZERO(ap_root_device);
>  	if (rc)
>  		goto out_bus;
>  

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>


