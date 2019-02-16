Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBEBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82A20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HelBmjL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbfBPDc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:32:58 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51814 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfBPDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:32:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1G3O9tA140257;
        Sat, 16 Feb 2019 03:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=A3H1JRYqMbRrb96aHiAJyCX99oP+VoC3SNGb0A/nERA=;
 b=HelBmjL5c6TgsggteJZijCAkKEmmwqv5fwnHEeuuj8FW2jx6ZkDIUQP7U/ara/YrlSOg
 W1oRq/eEawMi/AhPo8TVeDWmw4ReHx0SAkPJyhQ2qKxctmS4XRt06P+FA+dferEqse6z
 nkwwM62sUJFcIokxjlD8268WEqv0ABAitAzssU7IHW+qtEPwsLyojxhYy9YR3P1wC6H0
 iTSVsGJNcJbDGgrjwD4fufXnIcTgeY3v03TfpoAxDjvdTiH+iOq0kb9vh7dMuL0KYygN
 AZzkge+tBb7hkq4VtO0x/fZcjeXE5fv2i5K2X5oybz1COln0xnk5KpXofjmc8Uhis7VS BA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81dr7p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:32:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1G3WjMF014995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:32:45 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1G3WhYE008594;
        Sat, 16 Feb 2019 03:32:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 19:32:43 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] scsi: qla2xxx: remove redundant null check on pointer sess
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190215095232.28852-1-colin.king@canonical.com>
Date:   Fri, 15 Feb 2019 22:32:41 -0500
In-Reply-To: <20190215095232.28852-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 15 Feb 2019 09:52:32 +0000")
Message-ID: <yq1imxkmmqu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=712 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902160021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The null check on pointer sess and the subsequent call is redundant as
> sess is null on all the the paths that lead to the out_term2 label.
> Hence the null check and the call can be removed.  Also remove the
> redundant setting of sess to NULL as this is not required now.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
