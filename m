Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0D6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PV+kRfKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfA2Gnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:43:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34238 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfA2Gnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:43:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T6cvvQ093031;
        Tue, 29 Jan 2019 06:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UZvF/sQUeV/sYSGiXZe44y+eTcoVhQ6hF2NbogNNcYQ=;
 b=PV+kRfKs58UxcOiinSgQgkHMNXpRQNrbXo6dq/ELCZQtwnSk9kW48oYbtAl/FRdTjRgb
 ONcJraTMOaQRoYmOgq0rHoeQzs1UsV5fe3xqPmF2VT5ET2ZDcMcXG85tJi3KORYHWHS0
 Q9gJyLDcXzROihEaewahXjmu+8PFUu6n4XcPHMBORhESdU/42cYaIQ3/vhND92jNtxcY
 2IgrV1p2/nRFN0vfMAC9WmWlVr4erogdwzxyJIvh882TJl+ktMb5FMCkXgYkf/3uTi9q
 vWOlLsmeXOoE5Lr1wOHSeyCELc1mHnoprqB+z/QV2FvJLu4j78Ld68ZialmonJPR5CS8 cg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2q8d2e2krv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:43:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T6hNZt007923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 06:43:23 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T6hMRt030927;
        Tue, 29 Jan 2019 06:43:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 22:43:21 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] hisi_sas: Misc fixes and other more minor patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 29 Jan 2019 01:43:19 -0500
In-Reply-To: <1548426159-225679-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 25 Jan 2019 22:22:26 +0800")
Message-ID: <yq1fttcc6bc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This series includes a misc assortment of fixes found during testing.
>
> Also includes is some debugfs tidy-up and a patch missed from original
> upstreaming.

Applied to 5.1/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
