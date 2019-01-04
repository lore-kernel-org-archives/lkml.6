Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34545C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046032070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7ZL1tOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfADGE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:04:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfADGE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:04:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x045s4G3157399;
        Fri, 4 Jan 2019 06:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=4swN2adAoZRu4c8yK0aPO2aPEYDrsgZkrCu5SeWO5tU=;
 b=Q7ZL1tOzFTSjL0kSfb/I51JrjUJr9lSZ1Y7XNDwja9xXP7/iVuHZP6HwUQzyapGYtjkv
 xktxK/SSXNkjnxIjkBBzzUrCEQjDgOD7lpIgAv64y+N2Js76XdJYO95qWiWvtYwBYcJw
 OKens41mVQBu80DVWHVQGLRez3MymWOhITAz/osESohWldNiS0vE7rnuZgPodFYViZfL
 HY/76BzuXcZxCM957OAAhweGapAjY7n0sHjkU2XgmIeox3Kdz7W+d806e2sdlJ53Or4j
 /HKlemyIJp8fki30BtrlFCCKlOlvI0/Jc5Wqz5ToWT/ytsRZOmL5QBPOK8MOu+ULSIs7 zQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pp0bu2jhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 06:04:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0464eJ5001945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 06:04:40 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0464eBm029727;
        Fri, 4 Jan 2019 06:04:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 22:04:39 -0800
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181220031607.10588-1-yuehaibing@huawei.com>
Date:   Fri, 04 Jan 2019 01:04:37 -0500
In-Reply-To: <20181220031607.10588-1-yuehaibing@huawei.com> (YueHaibing's
        message of "Thu, 20 Dec 2018 11:16:07 +0800")
Message-ID: <yq1ef9t6jre.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> The return code should be check while qla4xxx_copy_from_fwddb_param
> fails.

Applied to 4.21/scsi-fixes, thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
