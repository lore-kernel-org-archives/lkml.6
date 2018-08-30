Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D13C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879DA2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jpfKE2rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879DA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeH3PZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:25:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeH3PZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:25:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UBO3KG156260;
        Thu, 30 Aug 2018 11:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=X/jUe6WJU18vGxwy1JztgkSnIS12SQS1c0rmAxipAtk=;
 b=jpfKE2rQaIeFQPyjK6FhXUrrcm8e/mKgPV8CD9hdAkPADf7MABzE80p4Hc5GXkXMSSRM
 ShqQllUfqyKFzNIt5dU1Gg5rvw/fpsMmRB+wcnfrCH4bdRtnniAuEqxNNeyuT+nT37oa
 N5KO4wxzCxWU0tFUUH4dRmUgy4lBQcHFSJL3CVFVsuXCbuEAuZzDJAtL+DLrRpis6yuv
 Aa2mEZq36FuzB+OgX/GQu2V7qhjO8SdC/bLEAvzpdbYTbiZ3D8bCLJQpXZk+mTwg4YSP
 msrM9+Wwy6mfPYyL6cyDDBPdzblFWbZeOFsHLD0mKtkPIq4fjyGBrMYneMgdvjKk0BPB Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m2xhu0ywc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:24:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBNvTk004509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:23:57 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UBNto7004523;
        Thu, 30 Aug 2018 11:23:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 04:23:55 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: raid_attrs: fix unused variable warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180813222716.757523-1-arnd@arndb.de>
Date:   Thu, 30 Aug 2018 07:23:53 -0400
In-Reply-To: <20180813222716.757523-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Tue, 14 Aug 2018 00:27:10 +0200")
Message-ID: <yq14lfc5c8m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=893
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> I ran into a new warning on randconfig kernels:
>
> drivers/scsi/raid_class.c: In function 'raid_match':
> drivers/scsi/raid_class.c:64:24: error: unused variable 'i' [-Werror=unused-variable]
>
> This looks like a very old problem that for some reason was very
> hard to run into, but it is very easy to fix, by replacing the
> incorrect #ifdef with a simpler IS_ENABLED() check.

Applied to 4.20/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
