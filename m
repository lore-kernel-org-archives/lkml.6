Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FDC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgvUIy3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E44E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeJLIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:10:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:10:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9C0cWZP095381;
        Fri, 12 Oct 2018 00:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=YvKTL36BwyF3A+qG19PHPF/PqpqWHz+zi5NIm8oHZzE=;
 b=OgvUIy3pc0eLKiz5TTKWt0WyqOix6GoA3iI/KhlzwMVJuG7+TB2/Qut/cP6hu4SvStEk
 /tlKJU6U2B1U+O1RKhK/ewGim0TwnrSHXqmAkD+kpt8lh348MGb0nxiqGHAT2T8ynLoA
 2SSkYybUzz924Kkf7IzYdLkVhcePZI91FgXKM6xVt1l8plIb7SqFn1jQVhNmrMeJPFPd
 8yOfVGL3qSBo78uyBS29toLDElb1YJmsrxp9EztjSqWb3FZbjs1aT1TfFGEMxVXrJkyQ
 V6NUbLIry+Pm/sGvJ58saC2FFYPWC01whRuzAJlxtFAvjEY+4QgWQZwzHbADIbs5yCzt 6A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mxnprffhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 00:41:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9C0f8wZ015526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 00:41:08 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9C0f7f8027455;
        Fri, 12 Oct 2018 00:41:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Oct 2018 00:41:06 +0000
To:     Joe Perches <joe@perches.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Neaten logging uses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1537183087.git.joe@perches.com>
        <yq1d0sh459q.fsf@oracle.com>
        <64a18d4b6390e0c7011f440a5f1970371ce43dec.camel@perches.com>
        <yq1efcw12xm.fsf@oracle.com>
        <e606c5059731c3deafa5b839ab6859f22a957eb0.camel@perches.com>
Date:   Thu, 11 Oct 2018 20:41:04 -0400
In-Reply-To: <e606c5059731c3deafa5b839ab6859f22a957eb0.camel@perches.com> (Joe
        Perches's message of "Thu, 11 Oct 2018 17:01:39 -0700")
Message-ID: <yq1a7nk0zfj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=578
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe,

> Via what tree?  It doesn't seem directly pulled.

Stephen pulls both my for-next and my fixes branches.

-- 
Martin K. Petersen	Oracle Linux Engineering
