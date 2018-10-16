Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09837C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFF2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2r4fD2Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFF2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJPKoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:44:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37606 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJPKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:44:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G2rnTP043586;
        Tue, 16 Oct 2018 02:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=FCMvidZtFWeCVEi3zKEgtr+HYrp35lOByi/ivWs0Ju8=;
 b=2r4fD2PxVoVHVM6nKa2wqPz/2EFaMSucM7vK1IhruQ98C8jlzVKe4ZHO4TXn+cV9o7rM
 HI1L6E61gS6E5x5mumU9631+zCVcACponzSJoTazWNuaKYJv0C2ey1/1YVRdAu/GClMp
 8JUXrbB9I/5I/GWXwIGzZUws8oUXsKz0fqqrGZUxlj+e7Sl92d2D/jJsjIWWuLN/RmKr
 00MAp1oS5LQJq+Wdx0DYYVUYI97QS6DxHUOE2CcIFO19maTwaaufbVp8sUZfBnSufe0D
 xST6AOykAUrP/p6gBKJ3ptEi37AnLWsDIjWJ9o/h2/nKB7kqIBukZZMRzS9kEoOJgLC8 /Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38npwtny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:56:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2uQcG020971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:56:26 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2uPk2002703;
        Tue, 16 Oct 2018 02:56:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 19:56:25 -0700
To:     Can Guo <cang@codeaurora.org>
Cc:     dianders@chromium.org, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v5 1/1] scsi: ufs: make UFS Tx lane1 clock optional for QCOM platforms
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1539397502-30120-1-git-send-email-cang@codeaurora.org>
Date:   Mon, 15 Oct 2018 22:56:22 -0400
In-Reply-To: <1539397502-30120-1-git-send-email-cang@codeaurora.org> (Can
        Guo's message of "Fri, 12 Oct 2018 19:25:02 -0700")
Message-ID: <yq1ftx6wqeh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=373
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can,

> Per Qcom's UFS host controller HW design, the UFS Tx lane1 clock could
> be muxed with Tx lane0 clock, hence keep Tx lane1 clock optional by
> ignoring it if it is not provided in device tree. This change also
> performs some cleanup to lanes per direction checks when
> enable/disable lane clocks just for symmetry.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
