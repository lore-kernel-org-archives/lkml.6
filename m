Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592A820843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNw7zqt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592A820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeIZHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:18:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44346 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:18:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q153C1005803;
        Wed, 26 Sep 2018 01:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=M4V1rd0BCQNQJkSLE8EeYek7TKmxYgo9vwkrAvlYR8M=;
 b=SNw7zqt5VOrcI6amtWIM5d2qKvI3PFI1TZHRoxpw/4tDcTNhIMgsYsQ2nhkjVISt1iDK
 p3MW4NOv6lLk08eXpXX7aWuyy3VGzYpPIOP6WkflXrRjZRXnviwq4+9TVZyMcBaK8F3K
 FO9MvDXXZaqPxKqifTYp3SKRylfWt4XkSP712tOTzpHhfufknfyYvWE/aET7JF5vYi02
 Pu16g2ZDi2PYr6l9YP5Xnp0AJax7A7Lv+zz0BKq2aHvM/k4XX7ksB+Q0IEkkdbbqIWm3
 gBXCqUT2GNYQ6ICGsb89KkNSVTI3oefbLyY1hzA2Nh6sxEiktTGrMiJBniLNS9ebWIHf Ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mnvtup7ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 01:08:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q18Eio006329
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 01:08:14 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8Q18Dsi030477;
        Wed, 26 Sep 2018 01:08:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 18:08:12 -0700
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, stanislav.nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bart.VanAssche@wdc.com, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180808224454.243790-1-evgreen@chromium.org>
        <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
        <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com>
        <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
Date:   Tue, 25 Sep 2018 21:08:09 -0400
In-Reply-To: <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
        (Doug Anderson's message of "Tue, 25 Sep 2018 11:40:54 -0700")
Message-ID: <yq1h8idgj5y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Doug,

> I came across this patch and Evan's other one and noticed that they
> haven't been applied though a batch of other SCSI patches for 4.20
> were applied about a week ago.  Martin: is there something about these
> patches that needs to change before they can land?

I have simply been awaiting some sort of consensus on the various
competing approaches. Lots of patches posted with tiny incremental fixes
but very little discussion about the merits of one over the other.

-- 
Martin K. Petersen	Oracle Linux Engineering
