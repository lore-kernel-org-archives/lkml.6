Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0212177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4T+bmdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBHWk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:40:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHWkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:40:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x18MdQIt156586;
        Fri, 8 Feb 2019 22:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gBPYWlKhYl2ua/1AEAUiZNc8SWSRuntEFmHPPTgDhJg=;
 b=r4T+bmdqHwgmHEtVGEKDUNfxlDSe9gHT0Oxd7de5FA9hYa6nKtFDrvRTbbU6f39r9EmP
 yqhKNBQigRZMvmxSOIvl8f/bOkBFRlHJ74M8954rup8+P9A5EXSpmy5J9FP7kzYdGju7
 z+5cXQLVrCQtjvnZ3mKvRcACR1wZ3jDwyDyTySBNxQJ40EihIDY7J7wms2MtEuG2kJTz
 AjZ6uEYYusoUh/w+HHa1g5P5WwKgMQF8tNEQ5W5wpSu+NQ5OX0bgzgTweRhHUjTdcCjK
 cq5CsjPxh0HQyAZYbYofkPNpzP2oBPYoN+4kMmti2qHiBRjFBarHFpy0Rbqqz1W/W6id 2A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qd98nq6dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Feb 2019 22:40:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x18Mef78005494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Feb 2019 22:40:41 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x18Mee7h030292;
        Fri, 8 Feb 2019 22:40:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Feb 2019 14:40:40 -0800
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181012213926.253765-1-dianders@chromium.org>
        <1ca83453-89e1-82c1-2720-987407bd9fa8@free.fr>
Date:   Fri, 08 Feb 2019 17:40:37 -0500
In-Reply-To: <1ca83453-89e1-82c1-2720-987407bd9fa8@free.fr> (Marc Gonzalez's
        message of "Wed, 6 Feb 2019 14:59:41 +0100")
Message-ID: <yq1lg2px5sq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=737 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902080154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

>> - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
>>               also list one or more of the following:
>>                  "qcom,msm8994-ufshc"
>>                  "qcom,msm8996-ufshc"
>>                  "qcom,ufshc"

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
