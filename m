Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1CF208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWlLIaSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1CF208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbeGKC5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:57:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45044 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbeGKC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:57:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6B2iACp007554;
        Wed, 11 Jul 2018 02:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=DkifRSbsimJQkMl7fTugkaXI6mABQBa32vUQ8NelJM4=;
 b=ZWlLIaSmdatb9J7jM4D7gQdKgGe0bOIX+Xpzj9f6Spm3bCcWX0ZKDh3t6Zr9N3U2/XcT
 aC6vuMP1IGJhi0cQPWgGeGK6enfBvVVLMH60Ul1eUzyeUIShVWlKzDGNx7Js05OUzPZT
 gWaJrXqEFClPwo37PfVE8A1dbgn/ZNgYOvTaGnL4s3C5SFumy7UD+NEA98jLE7TPy+La
 igjOAK76U5EKY7aYubWrJqo0advmrutP1ARGNQ5tTLYXXbwqWyzJqsjpBh3voE9QQzGK
 GmpD62ghBH1J9w7QUmbjuqPwwons9fT+S5BcnmIYrp1Xf6Snb2+lVDpvztEMOhK4lnLG sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p764c6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:55:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6B2t8PY012342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:55:08 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6B2t7IK009970;
        Wed, 11 Jul 2018 02:55:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 19:55:06 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] sbitmap, scsi/target: add seq_file forward declaration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180706201920.2185565-1-arnd@arndb.de>
Date:   Tue, 10 Jul 2018 22:54:55 -0400
In-Reply-To: <20180706201920.2185565-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 6 Jul 2018 22:19:07 +0200")
Message-ID: <yq1in5mo51c.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> In general, headers should not depend on others being included first,
> so this fixes it with a forward declaration for that struct name, but
> we probably want to merge the patch through the scsi tree to help
> bisection.
>
> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")

Applied to 4.19/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
