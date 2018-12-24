Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B99222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeLXMP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:15:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbeLXMPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:15:25 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBOCFKIt144016
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:15:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pjwg13vnt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:15:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 24 Dec 2018 12:14:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Dec 2018 12:14:22 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBOCEL0n8520050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Dec 2018 12:14:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A59A4055;
        Mon, 24 Dec 2018 12:14:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C018A404D;
        Mon, 24 Dec 2018 12:14:20 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Dec 2018 12:14:20 +0000 (GMT)
Date:   Mon, 24 Dec 2018 14:14:18 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "huang.zijiang" <huang.zijiang@zte.com.cn>
Cc:     akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, sfr@canb.auug.org.au, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] firmware/memmap:Modify memblock_alloc to
 memblock_alloc_nopanic
References: <1545640882-42009-1-git-send-email-huang.zijiang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545640882-42009-1-git-send-email-huang.zijiang@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18122412-0008-0000-0000-000002A59BC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122412-0009-0000-0000-000022104583
Message-Id: <20181224121417.GB2070@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=705 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 04:41:22PM +0800, huang.zijiang wrote:
> From: "huang.zijiang" <huang.zijiang@zte.com.cn>
> 
> memblock_alloc never returns NULL because panic never returns
> 
> Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  drivers/firmware/memmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
> index d168c87..ec4fd25 100644
> --- a/drivers/firmware/memmap.c
> +++ b/drivers/firmware/memmap.c
> @@ -333,7 +333,7 @@ int __init firmware_map_add_early(u64 start, u64 end, const char *type)
>  {
>  	struct firmware_map_entry *entry;
> 
> -	entry = memblock_alloc(sizeof(struct firmware_map_entry),
> +	entry = memblock_alloc_nopanic(sizeof(struct firmware_map_entry),
>  			       SMP_CACHE_BYTES);
>  	if (WARN_ON(!entry))
>  		return -ENOMEM;
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.

