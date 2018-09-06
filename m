Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D295206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D295206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIFK6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:58:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbeIFK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:58:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w866NsbV119483
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 02:24:23 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2masq32g6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 02:24:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 6 Sep 2018 07:24:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 07:24:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w866OG1B35127358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 06:24:16 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E4454C058;
        Thu,  6 Sep 2018 09:24:11 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD07C4C040;
        Thu,  6 Sep 2018 09:24:10 +0100 (BST)
Received: from osiris (unknown [9.152.212.24])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Sep 2018 09:24:10 +0100 (BST)
Date:   Thu, 6 Sep 2018 08:24:14 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     schwidefsky@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: remove redundant put_device
References: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <1536214587-32500-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-TM-AS-GCONF: 00
x-cbid: 18090606-4275-0000-0000-000002B60908
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090606-4276-0000-0000-000037BF2614
Message-Id: <20180906062414.GA3598@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:16:27PM +0800, Ding Xiang wrote:
> device_unregister will put device, do not need to do it one more time
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/s390/scsi/zfcp_unit.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
> index 1bf0a09..6b50084 100644
> --- a/drivers/s390/scsi/zfcp_unit.c
> +++ b/drivers/s390/scsi/zfcp_unit.c
> @@ -249,8 +249,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_lun)
>  		scsi_device_put(sdev);
>  	}
> 
> -	put_device(&unit->dev);
> -
>  	device_unregister(&unit->dev);
> 
>  	return 0;

I'm quite sure this change is wrong, since the put_device() here seems to
pair with the get_device() in _zfcp_unit_find(). So we would end up with a
memory leak.

Adding Steffen and Benjamin.

