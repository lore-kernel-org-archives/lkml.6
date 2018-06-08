Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id czuKKK3cGVs8DQAAmS7hNA
	; Fri, 08 Jun 2018 01:34:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B345E6074D; Fri,  8 Jun 2018 01:34:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IM9H7TfW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3DAFF605A5;
	Fri,  8 Jun 2018 01:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DAFF605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHBeS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:34:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFHBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:34:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w581VtPi153015;
        Fri, 8 Jun 2018 01:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=fE9qXYphG7/m8u2ZID0OhoHy7BQWRAGkf0bFG4Kpb8Q=;
 b=IM9H7TfWGwjWbMgZltPjJkBJkOeHq6GPV9UsQ1eXib2uSImdHBk18JPeykqO/AyLXiYo
 zMxqHkXQSbK8lhWmysD0Q3D30k1MNTqeEIasYVYMH/iSPaA5UjCSjXIm9wb1mW44MAqx
 mNmiNk48rpardszCQGSKjmPoS2Boag2YGJK3/VGg+rFYqte4rqYzOJJRPAuxCASejmVi
 uMJKazkLX2B9+B6aXZYCIQ/OdjftAOzoUvU8Jq1jZn8Pvy0bs9s8tY6nsu2JeGXjNmBY
 HMNvwELDDLm7oFSoj57dNroAgYQwnQ9zTNk45QlW7MXzuwhKyQHuJLYJkSiP4xfydx0I rA==
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jbvypk5k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jun 2018 01:33:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w581XvMC003998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jun 2018 01:33:57 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w581Xtut005679;
        Fri, 8 Jun 2018 01:33:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 18:33:55 -0700
To: Varsha Rao <rvarsha016@gmail.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 0/2] message: fusion: Fix clang and checkpatch warnings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1528342739.git.rvarsha016@gmail.com>
Date: Thu, 07 Jun 2018 21:33:52 -0400
In-Reply-To: <cover.1528342739.git.rvarsha016@gmail.com> (Varsha Rao's message
        of "Thu, 7 Jun 2018 09:17:07 +0530")
Message-ID: <yq1fu1y83jz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=700
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806080015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Varsha,

> This patchset fixes extraneous parentheses clang warning and few
> checkpatch issues.
>
> Varsha Rao (2):
>   message: fusion: Remove extra parentheses
>   message: fusion: Replace NULL comparison

This is an old driver that's pining for retirement. We generally do not
accept code cleanups for unmaintained code for fear of introducing
regressions.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
