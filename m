Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF9C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2BA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2BA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLCK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:59:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbeLCK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:59:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3AwkoK098199
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 05:59:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p51xdkp94-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:59:20 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Mon, 3 Dec 2018 10:59:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 10:59:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3AxG9h1442264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 10:59:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A1252050;
        Mon,  3 Dec 2018 10:59:16 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.97.55])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B5325204E;
        Mon,  3 Dec 2018 10:59:16 +0000 (GMT)
Subject: Re: [PATCH] [SCSI] zfcp: NULL check before some freeing functions is
 not needed.
To:     Thomas Meyer <thomas@m3y3r.de>, bblock@linux.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930051-347492467-5-diffsplit-thomas@m3y3r.de>
From:   Steffen Maier <maier@linux.ibm.com>
Date:   Mon, 3 Dec 2018 11:59:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543760930051-347492467-5-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120310-0020-0000-0000-000002F14C8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120310-0021-0000-0000-00002140BD58
Message-Id: <28bf96ec-4dff-29bd-f628-1a30e189aea8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, this was already submitted for v4.12 with
https://www.spinics.net/lists/linux-scsi/msg125190.html
based on
https://www.spinics.net/lists/linux-s390/msg21307.html

Also, previously seen in
https://www.spinics.net/lists/linux-s390/msg22035.html

On 12/02/2018 09:52 PM, Thomas Meyer wrote:
> NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers
>   
>   static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>   {
> -	if (adapter->pool.erp_req)
> -		mempool_destroy(adapter->pool.erp_req);
> -	if (adapter->pool.scsi_req)
> -		mempool_destroy(adapter->pool.scsi_req);
> -	if (adapter->pool.scsi_abort)
> -		mempool_destroy(adapter->pool.scsi_abort);
> -	if (adapter->pool.qtcb_pool)
> -		mempool_destroy(adapter->pool.qtcb_pool);
> -	if (adapter->pool.status_read_req)
> -		mempool_destroy(adapter->pool.status_read_req);
> -	if (adapter->pool.sr_data)
> -		mempool_destroy(adapter->pool.sr_data);
> -	if (adapter->pool.gid_pn)
> -		mempool_destroy(adapter->pool.gid_pn);
> +	mempool_destroy(adapter->pool.erp_req);
> +	mempool_destroy(adapter->pool.scsi_req);
> +	mempool_destroy(adapter->pool.scsi_abort);
> +	mempool_destroy(adapter->pool.qtcb_pool);
> +	mempool_destroy(adapter->pool.status_read_req);
> +	mempool_destroy(adapter->pool.sr_data);
> +	mempool_destroy(adapter->pool.gid_pn);
>   }
>   
>   /**
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

