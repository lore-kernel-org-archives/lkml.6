Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A498C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B086321B34
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UCNlNuOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B086321B34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeHIEUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:20:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54552 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeHIEUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:20:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w791sGlB065066;
        Thu, 9 Aug 2018 01:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8h1RychiPBPNWdg+SX17irx0v15BTnmpqfF05gJZDCY=;
 b=UCNlNuOR16lsGaOJtB5JsHOB/4gLpz7EWlNgqLR7lbO+MaIG4japCV/xAiddk8/EQSbf
 6jLNJTzMoYU/dDayG573Dg2Gp3djd9nDpzkX75FFFl7gnGEh2mZVQy15rSwPM4g0T9A0
 ODTLkSnGrTpOBt4M1DvByceACWwk2Gk+KEzZvs1CYcLdLgMZgRRxEEfkIYBB74Xqkog5
 Myx/qyqVO3lENsG2tcNbgOvkVTgB0qpqIZFedVmfoAmStvuWGnT6goygUjX97pbaA07/
 apsLXvFvoPaTxWX0OrwTcYVlQsgwlpy3KmxgX4ByPkztYIWjW01yUvVP8rQdOqUZXnBw 8w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kn43p047m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Aug 2018 01:57:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w791vu2Y018297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Aug 2018 01:57:56 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w791vtkL031120;
        Thu, 9 Aug 2018 01:57:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 18:57:55 -0700
To:     Ohad Sharabi <ohad.sharabi@wdc.com>
Cc:     stanislav.nijnikov@wdc.com, avri.altman@wdc.com,
        alex.lemberg@wdc.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, gregkh@linuxfoundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: remove unnecessary query(DM) UPIU trace
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533475583-16939-1-git-send-email-ohad.sharabi@wdc.com>
Date:   Wed, 08 Aug 2018 21:57:52 -0400
In-Reply-To: <1533475583-16939-1-git-send-email-ohad.sharabi@wdc.com> (Ohad
        Sharabi's message of "Sun, 5 Aug 2018 16:26:23 +0300")
Message-ID: <yq1bmacqp27.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808090020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ohad,

> This patch removes redundant trace that occurs when sending Device
> Management(DM) request (fix behavior in patch
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git/commit/?id=6667e6d91c88a788d5ab1b1e999d245473e84a9)
> Since the function send_command is called also for DM request, UPIU trace
> for DM request is called twice- one identified as query_* the other as
> send/complete.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
