Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E19C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77172089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VjMyuHBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77172089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeIZG7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:59:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeIZG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:59:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q0iOih188101;
        Wed, 26 Sep 2018 00:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=C+uGdWNY8qIhEndDpBNysLi3IyS9ZuIywD+IlIn6vvg=;
 b=VjMyuHBZI3FtgvD7lwx4HTaNeHrmv7h4RUB3kaJybTRKbIWDK2Dn1k8GjI3usdWr0FB6
 EDeUGbiyk3TBQxOTGheiCUeL3plevcDZqTR5iAHU5GSr6N0K0IsBXY8F67F0TEE5RHKE
 Tqszio3KoeyoNgwyKWFd1kQxFARy63WFZZ8Ek3NBEbrQ1iNiuSFG1LYSXrOKYKGfYezJ
 upXCt2Vwa9sBzH7J1x7Jiomh4YkkEMuEhU1wy6VvkTzPhDe6wQnKbZ/Fxf2V1PYc6KOw
 /zC+GNLkJi/F9TP56YWHJrzBk3GX15JxNCvuffxdq8QMNzAweRiJHTcHHfuJh8nDIfYi mA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mnvtup5k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:48:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0ms4H023224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:48:54 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0mrHr029178;
        Wed, 26 Sep 2018 00:48:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 17:48:53 -0700
To:     Hannes Reinecke <hare@suse.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Matthew Wilcox <matthew@wil.cx>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: advansys: Remove unnecessary parentheses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180920205858.6035-1-natechancellor@gmail.com>
        <9432dde7-c63f-9c0c-fc9b-8728a0715ff3@suse.com>
Date:   Tue, 25 Sep 2018 20:48:50 -0400
In-Reply-To: <9432dde7-c63f-9c0c-fc9b-8728a0715ff3@suse.com> (Hannes
        Reinecke's message of "Fri, 21 Sep 2018 07:57:31 +0200")
Message-ID: <yq1y3bpgk25.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=690
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hannes,

> On 9/20/18 10:58 PM, Nathan Chancellor wrote:
>> Clang warns when multiple pairs of parentheses are used for a single
>> conditional statement.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
