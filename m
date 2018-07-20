Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2D20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqdwk73F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeGTCv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:51:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbeGTCv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:51:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6K25CfG162714;
        Fri, 20 Jul 2018 02:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=GGcAQfBrx++bAt1ChCKMwz6qJDWZ+FQ5/6ny5UtsR98=;
 b=qqdwk73FQskmSLIz3W8GRQnyTaEmk46snF8Rv9Xt8ZvVtH3kKZ38kPql2bposqosKN2y
 mo8v+NMLKkTjj263HwBAEh69hsNeQmmjzcIJcMwhbbg724ShiCPPkcRgKC62U0i1AE62
 ti7TguUlFN3f9JkjlCC28S6euQXODOLjNMvuG+wDNi+AfH8LbkjTAVbGCqjuj0ugkYeO
 RAOuzSlw17xsjlMJNG+Klpvltq+TryBa2ZKYDUoKH8SPugshFHlpTbealwvweNBS6vTB
 vqV8z1m/W2es25C9bA/f7p8A/fZoo4nXB2OH1IW1oS5ma/kogtXsTR0zo8tzRuTp+P5t lQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k9ykc9ecx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 02:05:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6K25QO7018795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 02:05:26 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6K25Q0Z023008;
        Fri, 20 Jul 2018 02:05:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Jul 2018 02:05:21 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] hisi_sas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 19 Jul 2018 22:05:10 -0400
In-Reply-To: <1531923273-193768-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 18 Jul 2018 22:14:24 +0800")
Message-ID: <yq1in5a8xwp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=487
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some misc patches, generally more minor in
> importance.
>
> However there is a patch to add a CPU barrier to the delivery path for
> each hw version. We only saw this issue on v3 hw in hip08 chipset,
> where the host CPU exhibits a looser memory model than in
> predecessors, and software must enforce SMP coherency.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
