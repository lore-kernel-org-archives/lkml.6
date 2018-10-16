Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587BAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B8020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NWKu0z5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B8020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJPKeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:34:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeJPKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:34:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G2jcOh178752;
        Tue, 16 Oct 2018 02:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CXFDEI7l5pIaQ+OZtIuB+nrOQ5hdM0cZPkRwVJpxFLw=;
 b=NWKu0z5UR+Ycd8T8dzYdHq8Mev5d0g56LNRIRyTbmrwmik3LdiP4QzyptUh0w2yiWFPq
 8XRteu7EDAiLgOypL/Yqb68AHdsjnk6s3jVIavCL0TLTvFKjwyAtSp80vJOi91fTnMcj
 Loo+wTmOqT0LVZdWdi1m3R+UEr49QhGM4xqNXk6jpBqGAaPj66kjwDnYPzqxbdli5Lsb
 X7DmOA+wMoTm4WefO8ETWhwsKx4Dst7N9FnyEykmPlL46bffVpWSGTux3wv5E00jdesR
 7zjFd2p4l0r+10/KUaeQHv4TgIvppZqBVTTf1QAAzNWiKgOl4RRsHS7a7UGwCwzGMCyl dw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n39br5pe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:46:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2kMeo026926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:46:22 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2kLWn031027;
        Tue, 16 Oct 2018 02:46:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 19:46:21 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: fix integer type usage in uapi header
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181012104143.1931393-1-arnd@arndb.de>
Date:   Mon, 15 Oct 2018 22:46:18 -0400
In-Reply-To: <20181012104143.1931393-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 12 Oct 2018 12:41:28 +0200")
Message-ID: <yq1r2gqwqv9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=469
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> We get a warning from 'make headers_check' about a newly introduced
> usage of integer types in the scsi/scsi_bsg_ufs.h uapi header:
>
> usr/include/scsi/scsi_bsg_ufs.h:18: found __[us]{8,16,32,64} type without #include <linux/types.h>
>
> Aside from the missing linux/types.h inclusion, I also noticed that it
> uses the wrong types: 'u32' is not available at all in user space,
> and 'uint32_t' depends on the inclusion of a standard header that
> we should not include from kernel headers.
>
> Change the all to __u32 and similar types here.
>
> I also note the usage of '__be32' and '__be16' that seems unfortunate
> for a user space API. I wonder if it would be better to define the
> interface in terms of a CPU-endian structure and convert it in kernel
> space.

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
