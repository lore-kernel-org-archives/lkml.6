Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E023C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C6217C6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fyi7GqlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C6217C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbeHIMQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:16:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54006 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:16:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w799mxKO065860;
        Thu, 9 Aug 2018 09:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=X3QL61q0dJhTvxjQWiL2gCOld1mHn6eQs8PD9fWg4EQ=;
 b=fyi7GqlIldvFUbAPKDcCX+n/VqMSxBHtvICD8h269nIhbCuNcUvo4j2H0JHrdZBKlSaw
 IsUZzMRlB4u3NdhLJbuvw5mJL6VL8z1jSP67rDGVYQbo+C4I5oJWQx2BQ3v+QS68lWTt
 uWklud7J1ksHsBEt5ANnBdcDqQxscj5D3Bdl/GvQoYgkZXDd1z0vAgXvqUk+d01LoBiI
 AnZjWr5GsbqRDWIkDM8uSyDVJYWWH9fyJ5vIyhJcleJUWQJ+sYebCtGT2CS4qn7S57FU
 Iz+KCIlDg4j8cjBeCmh6a+SR7Prg5us4D/acZGI+O5DtMIo8F4LyBPvFM9ZhQHTqbc1B gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kn3jtaj41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Aug 2018 09:52:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w799qHqg016229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Aug 2018 09:52:17 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w799qFeo031305;
        Thu, 9 Aug 2018 09:52:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Aug 2018 02:52:15 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180731134603.20089-1-jthumshirn@suse.de>
        <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
        <20180809080543.xvjoya74j66sadvg@linux-x5ow.site>
Date:   Thu, 09 Aug 2018 05:52:13 -0400
In-Reply-To: <20180809080543.xvjoya74j66sadvg@linux-x5ow.site> (Johannes
        Thumshirn's message of "Thu, 9 Aug 2018 10:05:43 +0200")
Message-ID: <yq11sb7rho2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=674
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808090102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> Martin,
>
> though it looks like these patches aren't fixing all of the errors Ard
> has, they fix all I could reproduce up to now and Ard already stated
> they're not regressing.
>
> So can we please stage them for 4.19?

I merged them last week.

-- 
Martin K. Petersen	Oracle Linux Engineering
