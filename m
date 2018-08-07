Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A45C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EBB21884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EBB21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbeHGOmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:42:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389077AbeHGOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:42:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77COlYB016380
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 08:28:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqan4a5tf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 08:28:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <michaele@au1.ibm.com>;
        Tue, 7 Aug 2018 13:28:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 13:28:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77CShpR30802070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 12:28:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52C3142042;
        Tue,  7 Aug 2018 15:28:52 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 005944203F;
        Tue,  7 Aug 2018 15:28:52 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Aug 2018 15:28:51 +0100 (BST)
Received: from localhost (unknown [9.192.165.219])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 23384A00B6;
        Tue,  7 Aug 2018 22:28:41 +1000 (AEST)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Bryant G. Ly" <bryantly@linux.ibm.com>
Subject: Re: [PATCH] misc: ibmvsm: Fix wrong assignment of return code
In-Reply-To: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1533562260-11456-1-git-send-email-bryantly@linux.vnet.ibm.com>
Date:   Tue, 07 Aug 2018 22:28:40 +1000
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18080712-4275-0000-0000-000002A66451
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080712-4276-0000-0000-000037AF6965
Message-Id: <87y3dibbt3.fsf@concordia.ellerman.id.au>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:

> From: "Bryant G. Ly" <bryantly@linux.ibm.com>
>
> Currently the assignment is flipped and rc is always 0.

If you'd left rc uninitialised at the start of the function the compiler
would have caught it for you.

And what is the consequence of the bug? Nothing, complete system crash,
subtle data corruption?

Also this should be tagged:

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")

cheers

> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index 8f82bb9..b8aaa68 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -2131,7 +2131,7 @@ static int ibmvmc_init_crq_queue(struct crq_server_adapter *adapter)
>  	retrc = plpar_hcall_norets(H_REG_CRQ,
>  				   vdev->unit_address,
>  				   queue->msg_token, PAGE_SIZE);
> -	retrc = rc;
> +	rc = retrc;
>  
>  	if (rc == H_RESOURCE)
>  		rc = ibmvmc_reset_crq_queue(adapter);

