Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A607CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4713B214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zdpSY9HA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4713B214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeJQJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:39:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:39:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H1jm38136719;
        Wed, 17 Oct 2018 01:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=janNET1TN2IMuMtbP7PzYTM6j+s19aeT3gMeaU/12hw=;
 b=zdpSY9HAuwQE0ONyYWeVnYTeZNeZAQNuMTBQ5afeKSHjrkba69hGboheLndHUey7351+
 tpQxuCZ2BIjFha3K3xM0HHLZU71eEpd4q2LlB0R4gtpPOHDLtEwCb37HT1PNBJfC6qkF
 dN+ve61YmRHYGw75+Abt+0SCctd9tQAv4ShCYfuPZ8X+IR+kDsxNiUOoOXVl4JPzxmIz
 GW876TA1nWO6rOps6lnJy29SAdQ2k5cBno+FJKnEkLp7aWievyvo51oeUcf4QGn6aq6F
 HQRYHnddJMG7E9U74mQbkvNTdQGYqPxFWxDOVZ05+Mr0Vwy7xOtVrzYT+N4Zuk+vUVzZ /g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n39brbyfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:45:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1jkWV012337
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:45:47 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1jjjR002476;
        Wed, 17 Oct 2018 01:45:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 18:45:45 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] scsi: bfa: Avoid implicit enum conversion in bfad_im_post_vendor_event
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180926045435.9213-1-natechancellor@gmail.com>
        <20180927235651.27151-1-natechancellor@gmail.com>
Date:   Tue, 16 Oct 2018 21:45:42 -0400
In-Reply-To: <20180927235651.27151-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 27 Sep 2018 16:56:52 -0700")
Message-ID: <yq1a7ndpcqh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=526
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/scsi/bfa/bfa_fcs_lport.c:379:26: warning: implicit conversion
> from enumeration type 'enum bfa_lport_aen_event' to different
> enumeration type 'enum bfa_ioc_aen_event' [-Wenum-conversion]
>                                   BFA_AEN_CAT_LPORT, event);
>                                                      ^~~~~

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
