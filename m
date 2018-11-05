Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82D204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C82D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeKEP0i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:26:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729163AbeKEP0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:26:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA564ARw073918
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 01:08:37 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2njed3bqq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:08:37 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Mon, 5 Nov 2018 06:08:35 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Nov 2018 06:08:32 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA568Vrd8388954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 06:08:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6EA3A404D;
        Mon,  5 Nov 2018 06:08:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AAA6A4051;
        Mon,  5 Nov 2018 06:08:31 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.56.134])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Nov 2018 06:08:31 +0000 (GMT)
Date:   Mon, 5 Nov 2018 07:08:29 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] s390: numa: Export __node_distance
In-Reply-To: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
References: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18110506-0020-0000-0000-000002DFD64B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110506-0021-0000-0000-0000212F4227
Message-Id: <20181105070829.74d7a4bf@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811050055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Nov 2018 13:28:06 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> __node_distance is used by nvme, resulting in:
> 
> ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
> 
> when trying to build nvme as module.
> 
> Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I thought I had seen that patch already, but I don't find it anywhere.
> Maybe that was for another architecture. My apologies for the noise if it
> is already queued.
> 
>  arch/s390/numa/numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
> index ae0d9e889534..d31bde0870d8 100644
> --- a/arch/s390/numa/numa.c
> +++ b/arch/s390/numa/numa.c
> @@ -53,6 +53,7 @@ int __node_distance(int a, int b)
>  {
>  	return mode->distance ? mode->distance(a, b) : 0;
>  }
> +EXPORT_SYMBOL(__node_distance);
> 
>  int numa_debug_enabled;
> 

That one is already queued. I'll do the __no_kasan_or_inline
change that Linus requested and then send a please pull.
Should be upstream in a few days.

For reference:

https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-linus&id=a541f0ebcc08ed8bc0cc492eec9a86cb280a9f24

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

