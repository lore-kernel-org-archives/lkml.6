Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049BCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6820989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfhM1mzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfA2GaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:30:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42090 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfA2GaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:30:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T6Obj3082958;
        Tue, 29 Jan 2019 06:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=4m7Vfm/ayjEUjHKEQXPM0gARYx4rproQBgxQTfUFQME=;
 b=NfhM1mzW0WHsceuVsllKeTidUtkDC8ZPSDuJLLXpilT2esze9Niq+beiNyDxoldq6dna
 UJ684SZ1vNmq+bPJNPy7lE7HLmsMrzq4lSI+t+AokjM/yuW+j+ncAVDd9NdzkFVg7ffq
 uO4DSRfRbb8/K5Y1ZbKZrbVvtM38J68I3Vx56pnCROpUqR4nld03e+oMEZeZNVO1uP+6
 G/kXz9jg2l/hbeVP50HI/dObrQsMqGz1QtcoC1ZZCNR/dYrq4hP+j6TKAgWQT0f6yWKN
 hwdm78Si+CHFQ5IYzkdDbIWtzlO3uIQ8gH3GrDE5bxOQ6HCppEf2+b7g8mLrQfiLDGuo kQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2q8d2e2j48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:27:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6RrJO023093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:27:54 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6RpxY006998;
        Tue, 29 Jan 2019 06:27:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 22:27:51 -0800
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     GOTO Masanori <gotom@debian.or.jp>,
        YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: nsp32: Remove unnecessary self assignment in nsp32_set_sync_entry
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181210235156.6237-1-natechancellor@gmail.com>
        <20190126191143.GB25003@archlinux-ryzen>
Date:   Tue, 29 Jan 2019 01:27:48 -0500
In-Reply-To: <20190126191143.GB25003@archlinux-ryzen> (Nathan Chancellor's
        message of "Sat, 26 Jan 2019 12:11:43 -0700")
Message-ID: <yq1womoc717.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

>> drivers/scsi/nsp32.c:2444:14: warning: explicitly assigning value of
>> variable of type 'unsigned char' to itself [-Wself-assign]
>>         offset      = offset;
>>         ~~~~~~      ^

Applied to 5.1/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
