Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D51ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C03820883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="weM2jn0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C03820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIQMRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:17:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeIQMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:17:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H6nRof084951;
        Mon, 17 Sep 2018 06:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UsMWWQqp61PO2FUJz0b7RdLR1UuA8pRFXFNbV7fKvss=;
 b=weM2jn0MWLcF0VowlPB9PYKvnI1wtJ/6saFX++UC0/30tMrO3U4O6nKkAdPnw6WX8Ig3
 TG5G23MWdZMkw8wgwyvNEZ1F3MiwZFJ5NITuczrlL9I2l1xbpuRTuu0DEE9J1ybQdty7
 edQcwVIyicRii9HdtH4drduAbFu226GJuLjiI0ykWK46KuKRu/yamrX67KwxREtlqRXf
 qRWsgf1C8y2w9vD+92mxIfZpI7kUqCTkqQW66SwKqZVMemqdj7E8jWe0SZN16OQ8kffi
 ORWd4nGOjHgTTo5NFOBkejhQKS98yyNPrFPSg2BIdCIoa2XlQkb1DMGLg7OxED1DCT7f LA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mgsgtc9ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:51:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6pF8t003085
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:51:15 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8H6pEJU016833;
        Mon, 17 Sep 2018 06:51:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 23:51:14 -0700
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/2] String fixups in ibmvscsi
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180911192226.3620-1-labbott@redhat.com>
Date:   Mon, 17 Sep 2018 02:51:11 -0400
In-Reply-To: <20180911192226.3620-1-labbott@redhat.com> (Laura Abbott's
        message of "Tue, 11 Sep 2018 12:22:24 -0700")
Message-ID: <yq1bm8wsjkw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=461
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Laura,

> This is (hopefully) the last version of the string fixups found in the
> ibmvscsi driver.

Applied to 4.19/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
