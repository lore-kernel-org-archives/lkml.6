Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816A4214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZiE6y3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816A4214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIZGio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:38:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIZGio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:38:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q0NnCi174855;
        Wed, 26 Sep 2018 00:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=E1ZYBWWEMM1ha29hTZPf/oLISxPRAjzERTM44CcaiHs=;
 b=fZiE6y3zd1P+4hZO8n3OvFhnqmkZUs7xmWxAcOTprserl4EzFLWIueuN+S4GVNs1WdjX
 bDMFw7rwCf0/SmtdCAYCQTuuMcYUHs6wg4rQE8m5iAmA4bmIPV+aTg/DHgnq048xbnnl
 z6gB5c7SFLSYrDF1P6CyP1BVTTJbaQiHqzBeWdAVUg4CnuK0Lktkk5uqO5WgZKjjlHT0
 7kOiZcVSynemH6WQpuvsOZsxjG3sBzBxc+EYiUTfjbEOjYPB0OItOef46eXEa1SlE+YN
 N2GZI2YR44Fug+W+0+YbnVd639lbEm+a7sdpEWxv2V/11Cpq3Dx32k4dO4F6//iYqazo rA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mnvtup48k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:28:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0SQgD021487
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:28:26 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0SPia020662;
        Wed, 26 Sep 2018 00:28:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 17:28:24 -0700
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        kishon <kishon@ti.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        evgreen@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/3] scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
        <20180904101719.18049-3-vivek.gautam@codeaurora.org>
        <20180924172432.GL1367@tuxbook-pro>
        <CAFp+6iFPOGRAToBrV44VDNYG4DP2c6_+8QZbKsDmM4SF57NGfQ@mail.gmail.com>
Date:   Tue, 25 Sep 2018 20:28:20 -0400
In-Reply-To: <CAFp+6iFPOGRAToBrV44VDNYG4DP2c6_+8QZbKsDmM4SF57NGfQ@mail.gmail.com>
        (Vivek Gautam's message of "Tue, 25 Sep 2018 15:22:38 +0530")
Message-ID: <yq1efdhhzkr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=745
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Vivek,

> Kishon is looking to pick this series through linux-phy tree.
> Will you please consider giving your ack for this patch? Thanks.

Looks fine.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
