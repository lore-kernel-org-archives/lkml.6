Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CEA2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sNSRtNT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CEA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJKKtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:49:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeJKKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:49:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B3NnhF131136;
        Thu, 11 Oct 2018 03:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eMLSoiskzkVN/7FLcQHw7MZFgaHUtR9m3WW0XrEQvyE=;
 b=sNSRtNT61NoZkud6KVtMwUwgZsRpMJ1m7Rmevk1L9QmBEC74KWP2Fs307ZsHH/fIO6RP
 ypH78K0J3/Fw8uIpl2xqjQ/6r8hFDIZmHT+UB1UdIuZ5yIkXxGmsSceTVZF41KHR3cEy
 Rvz6wBbzjTSuWiYPk81AVTyqAEy2AmgEIamgQlhQAYc1Gkl7QLqs83l6O2+RUIFK8yuC
 lSHoxUGYy/5JdOYJGcmhO+dweVAGsTQuO8sJgo6d3fbWp8jDErnDTq2GK0eMqURA1GHx
 jqVjbnuGm+EFbh7tpalDuPnQjQ4oL6srsXB6FZmAJrzDCNQx/MnfyWPiEz0YtuSSYhLH 8g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mxmfu0m0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 03:23:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B3Nq6Q027633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 03:23:52 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B3NoXr020234;
        Thu, 11 Oct 2018 03:23:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 03:23:40 +0000
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ching Huang <ching2048@areca.com.tw>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: arcmsr: clean up clang warning on extraneous parentheses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180930230307.18664-1-colin.king@canonical.com>
Date:   Wed, 10 Oct 2018 23:22:28 -0400
In-Reply-To: <20180930230307.18664-1-colin.king@canonical.com> (Colin King's
        message of "Mon, 1 Oct 2018 00:03:07 +0100")
Message-ID: <yq1woqp1823.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=539
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are extraneous parantheses that are causing clang to produce a
> warning so remove these.
>
> Clean up 3 clang warnings:
> equality comparison with extraneous parentheses [-Wparentheses-equality]

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
