Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A6BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61599218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="plcqZIAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBHXIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:08:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52744 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:08:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x18MrwdX169238;
        Fri, 8 Feb 2019 23:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=u916G/qoX5auVXNcSCPOw4hHroaPHbVfJaZlM1TeWU4=;
 b=plcqZIAMkP6oZPY6O/UMKMxTvuF0mx8XYybGgqm705XLp0VfGjBiUfKzj/OoIxelJWpG
 Avix1qbtrElmDjXvSbAzcPQRryB6AbPHQBO8THaIzi90OOFcgMwLQy4tssSV9Zee6P/Z
 2SoTHH4EQpTO00UJc6aTsXhk98ODk2ZuvCs6BJ2J1Bkj/870fkRnyt94Hb195Kxr3Bqr
 QR7gl47gvAqOJb9/Rbswy0nvKbpahY67cFmpEpIl2cUvzBHoUNJdl2lUrWI6n8Z1RPLb
 HuBB40P7bkFnKpP17gj3FNecLVkz5s7vU5+fFc7kxVcqqu+mogP1m+abp2eBAIb6iZF5 YA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97ff7mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 23:08:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x18N8luJ022333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 23:08:47 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x18N8kDm013646;
        Fri, 8 Feb 2019 23:08:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Feb 2019 15:08:45 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/6] hisi_sas: DIX support, performance optimisation, and misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 08 Feb 2019 18:08:43 -0500
In-Reply-To: <1549450376-114929-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 6 Feb 2019 18:52:50 +0800")
Message-ID: <yq18sypx4hw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=829 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces the following:
> - DIX support for v3 hw

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
