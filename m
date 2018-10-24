Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0703BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4720652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKiFZrBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E4720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJXM6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:58:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:58:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O1Nqj1079773;
        Wed, 24 Oct 2018 01:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=pFCtZRVbQP+0gGVJRlYdvksoX2/l+VekidlcZqwN85o=;
 b=GKiFZrBsauRaIFDMjIspZ8VfwlV7asUJcWFPlH/57tFyuOeoO80n9OEsoc5vTpziWAIg
 uRE+Cw9i5eVf6liaFTWq3MPcS/HicnTBgusKcNRAUjLE+Su4wKapcKvAGG7iCG9hCuUo
 sawhRZyUaR5zlajDqP+GRmifYYG5UToP9ovfOkiWV2QnkK2wajcakR/cJUW3whR7jlSv
 iC7VUMX3WxoKnw4S/oSROJ7iFBpSjafALS68E1tya1+ZBvQEOLyAEhwJ1JQpP2a32wPP
 43O9Yf1BphrAM36MdEsyY176Irrzc6sRDu7GexH7VGEZ8h4+2c1gDre41xXWEFb1UR15 Vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq0mjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 01:29:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9O1T6GT017967
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 01:29:06 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O1T5sj028302;
        Wed, 24 Oct 2018 01:29:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 18:29:05 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-{sas,9xxx}: Use unsigned char for cdb
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181018215541.4768-1-natechancellor@gmail.com>
Date:   Tue, 23 Oct 2018 21:29:03 -0400
In-Reply-To: <20181018215541.4768-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 18 Oct 2018 14:55:41 -0700")
Message-ID: <yq11s8ggmjk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns a few times:
>
> drivers/scsi/3w-sas.c:386:11: warning: implicit conversion from 'int' to
> 'char' changes value from 128 to -128 [-Wconstant-conversion]
>         cdb[4] = TW_ALLOCATION_LENGTH; /* allocation length */
>                ~ ^~~~~~~~~~~~~~~~~~~~
>
> Update cdb's type to unsigned char, which matches the type of the cdb
> member in struct TW_Command_Apache.

Applied to 4.20/scsi-queue. Thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
