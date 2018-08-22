Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38968C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31FF208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31FF208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeHVRou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:44:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbeHVRot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:44:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MEJ97U145881
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:19:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m16gx80hw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:19:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <hwippel@linux.ibm.com>;
        Wed, 22 Aug 2018 15:19:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 15:19:39 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MEJcvP40828968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 14:19:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1FAF4C04E;
        Wed, 22 Aug 2018 17:19:39 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75E924C050;
        Wed, 22 Aug 2018 17:19:39 +0100 (BST)
Received: from oc7655065388.ibm.com (unknown [9.152.224.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 17:19:39 +0100 (BST)
Subject: Re: [PATCH] RDMA/smc: Replace ib_query_gid with rdma_get_gid_attr
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180818021707.GA25026@ziepe.ca>
From:   Hans Wippel <hwippel@linux.ibm.com>
Date:   Wed, 22 Aug 2018 16:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180818021707.GA25026@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082214-0008-0000-0000-000002653529
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082214-0009-0000-0000-000021CD7812
Message-Id: <6612bff3-63cb-6353-a8fa-a7c8a1995e2b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=819 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/2018 04:17 AM, Jason Gunthorpe wrote:
> All RDMA ULPs should be using rdma_get_gid_attr instead of
> ib_query_gid. Convert SMC to use the new API.
> 
> In the process correct some confusion with gid_type - if attr->ndev is
> !NULL then gid_type can never be IB_GID_TYPE_IB by
> definition. IB_GID_TYPE_ROCE shares the same enum value and is probably
> what was intended here.
> 
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

I ran a few SMC tests and the changes look good. So, no objections from 
our side and thank you for the patch.

Hans

