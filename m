Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A680C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D962F208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hipqzxzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D962F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933760AbeGJPJd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:09:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52160 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933771AbeGJPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:09:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6AF4JBV137215;
        Tue, 10 Jul 2018 15:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fR0CxYXB79tHEdG7X6NkNAvq9Ny8S81uLoeCrZVZD+4=;
 b=hipqzxzYbZq0AdmwGZxpbvNns2Y0kIK4JUlNjNqJI3eGCzo3LBeU34/xzGk7KpwgBQAc
 bA3qqwCO987Jcstg5qzcuU3wNso9nPtoAjfH90xXj0cm0NzibLUoIfIfDm+q993O6KNh
 cqEprXGl5RGh8ftPzzJx33MDO6/mxx78OOfEiWy6cFo7oLAaNJbs3eSSmTMcLPBHLTCk
 YtZNt8ijOiG6ZXCSdAupPT/hETwkvfKS/DNJ4k3orluvIV5Io2inkWVKyIpJp8NrGZuJ
 6PB7pnkThescVoCZdT356egYvObqawzy4FS0DwTUPP+X2zj19LGHf2BEDRLYUbgMv3Z0 4Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k2p75tcvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 15:08:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6AF8kSV022773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 15:08:46 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6AF8jXW017424;
        Tue, 10 Jul 2018 15:08:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 08:08:44 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: build warning after merge of the scsi tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180620132911.5f6ab464@canb.auug.org.au>
        <20180710173114.17ee69ad@canb.auug.org.au>
        <280ebbdf-fafb-1744-f517-815a30e682bb@kernel.dk>
        <1531232063.4963.8.camel@HansenPartnership.com>
        <3f0359a5-6733-f9d3-a616-d27ce430c904@kernel.dk>
        <1531232805.4963.11.camel@HansenPartnership.com>
        <84241128-2d2e-4479-abe0-658fddc1af2d@kernel.dk>
Date:   Tue, 10 Jul 2018 11:08:42 -0400
In-Reply-To: <84241128-2d2e-4479-abe0-658fddc1af2d@kernel.dk> (Jens Axboe's
        message of "Tue, 10 Jul 2018 08:35:23 -0600")
Message-ID: <yq1a7qzruv9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=443
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807100162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

>> Message-Id:	<20180706201920.2185565-1-arnd@arndb.de>
>> Subject:	[PATCH] [v2] sbitmap, scsi/target: add seq_file forward declaration

>> Martin didn't reply and it's not yet in his tree, although I'm sure it
>> will be soon.

Been out on vacation. I thought I committed it but I guess not. I'll get
to it today.

-- 
Martin K. Petersen	Oracle Linux Engineering
