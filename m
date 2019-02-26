Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA71FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C8421848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGkXgtUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBZPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:10:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57772 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBZPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:10:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QF8cEW167132;
        Tue, 26 Feb 2019 15:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gd0vNU+ffw23nd4MQik+4nScigIR8amBMmQrm7eCago=;
 b=iGkXgtUQS6yBDskQCVCHGeLFMTgRcZA33y/V+wPXLKoLe2Zs5+jYSZBnIZFqH7GcrrVy
 O2DPI6T9hsg/tU+rE89CdC0iFuIC7xmJcbvksBG5Y6mbucSnfgOslD1pYdWuSFviO+aH
 kMRgLmlghvEEARIGMWeS9NW//AVOjvhBjO0AIspPzrM/gNRtmiXSWDFCeexZj7vtZQ1o
 fCt7jDyKOMvaKBBRFOkahUmtKnMlBmWFlyTt8/rBvvFMzh+8nRuT2MhR1/A7WVpK0dkf
 B9OGO1rNXMq093Sx83afyL5ZcIWc52kvS3RCFCaCQ7ShwAbnvT4MFVmi0WiNREcraZK6 mA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qtupe5bwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 15:10:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1QFAbQ2001672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 15:10:37 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1QFAann007239;
        Tue, 26 Feb 2019 15:10:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 07:10:36 -0800
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: Re: [PATCH] scsi: clean obsolete return values of eh_timed_out
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1550385027-6217-1-git-send-email-avri.altman@wdc.com>
Date:   Tue, 26 Feb 2019 10:10:33 -0500
In-Reply-To: <1550385027-6217-1-git-send-email-avri.altman@wdc.com> (Avri
        Altman's message of "Sun, 17 Feb 2019 08:30:27 +0200")
Message-ID: <yq17edmd1qu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=944 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri,

> Those are no longer in use since commit 242f9dcb8ba6
> ("block: unify request timeout handling").

Applied to 5.1/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
