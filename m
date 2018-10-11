Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309CD20645
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLCkCSPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309CD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJKJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:40:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeJKJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:40:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B28v3N042149;
        Thu, 11 Oct 2018 02:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UJCYkX07PUuyFD34IWSUZ/8vfduJNZtznkb8NwUWPDA=;
 b=oLCkCSPLU7OTQw3KTTtQ2zwte73keR1mbOlTpD6aLwhtdv+NNmPIfkC8FSDEsiaBdCuL
 D5q1svYgTvVBFsYOB1JKS80/rnj5MyIXI6bc9T0FauNLGEWyQItgyaBcmMtPGPt+r5ei
 EYT6Vvs+RvGkJfBGj6CKt6Nn3NUiUKE0PnSHbZpC3mmaO0KsXCsxNfKS7NnmeM46h1sJ
 EbmD8oHSmmK6GTlSyIfY5w/BHzM+QL4T93H+/rG9AQeVayYM8Dno1b+L7SJfAl5C9UcP
 lLvzXPPCiioZj3GakNcXdpUrkkZOniaseTBOvUwyCrkz8DI+QWDBr1enBYkupq5bJ1JI 8w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7jyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:15:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B2F8Dh003177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:15:08 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9B2F67t012658;
        Thu, 11 Oct 2018 02:15:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:15:06 +0000
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] scsi: mptfusion: Remove unnecessary parentheses and simplify null checks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180915063645.31295-1-natechancellor@gmail.com>
        <CAK8P3a3PaWgieA0_HBJJ-FVeBO+iAdN8_kv5YUbpKURJ3gsoaQ@mail.gmail.com>
        <20181002150704.GA444@flashbox>
Date:   Wed, 10 Oct 2018 22:14:58 -0400
In-Reply-To: <20181002150704.GA444@flashbox> (Nathan Chancellor's message of
        "Tue, 2 Oct 2018 08:07:04 -0700")
Message-ID: <yq1o9c12pr1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

>> The exact same code also exists in drivers/scsi/mpt3sas/. I had a similar
>> patch for both drivers, but saw that yours now got merged for fusion.
>> 
>> If you don't mind, could you fix mpt3sas_base.c the same way?
>> 
>>      Arnd
>
> Hi Arnd,
>
> I did sent a patch for this a little bit later:
> https://lore.kernel.org/lkml/20180920201002.23979-1-natechancellor@gmail.com/
>
> I am still waiting for it to be merged.

I generally don't merge patches for drivers that are actively maintained
unless the driver maintainer explicitly acks the change. However, this
was trivial enough. Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
