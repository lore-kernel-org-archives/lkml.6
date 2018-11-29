Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9972081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cHlO1igJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9972081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeK2N5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:57:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2N5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:57:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT2igin091542;
        Thu, 29 Nov 2018 02:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vz3VseW+/4s+WL5xBi4PVwTPWx9H2J+92nRwZRXNjCE=;
 b=cHlO1igJ8soGxLU7bGAw+FWPxFdIXXNwjDDN2BN6EF/sq21Q58+S5uM98gBSdTvabSnx
 6XVHkNkUpu9wqcX+wWmmZiUH9YZwAceKwtd6kDVr8fM0WDocuEixH4W6omLlike0p6VT
 KK/jCow3JK4vJlO3jiJ0FLHs8Vmn5m+AIaGu9ZgvGr53gY7SfTHv/R1SQ9tV4XjcwkBC
 YqMGfH5zPo+ArABev3Uf0PAAljGyYo5fWLlAdDFIe/eKbGnsuP9wSAIstWeZfGesF5PW
 U6/VRPa/jlUYz0m4ab32xsGfZRtPQhnKDSu9N5ITZn4ng+0o7kO2u3yFmDotjeAhsLiG Eg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nxxkqnph7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:52:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2qgAK013093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 02:52:42 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAT2qfcK008898;
        Thu, 29 Nov 2018 02:52:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 18:52:41 -0800
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/41] scsi: xen-scsifront: mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1543374820.git.gustavo@embeddedor.com>
        <00c2a9d45e39fb294f4995b07a9b7547206c3085.1543374820.git.gustavo@embeddedor.com>
Date:   Wed, 28 Nov 2018 21:52:38 -0500
In-Reply-To: <00c2a9d45e39fb294f4995b07a9b7547206c3085.1543374820.git.gustavo@embeddedor.com>
        (Gustavo A. R. Silva's message of "Tue, 27 Nov 2018 22:34:35 -0600")
Message-ID: <yq1tvk0y4qx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=613
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo A.,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that, in this particular case, I replaced
> "Missed the backend's Closing state -- fallthrough" with
> "fall through - Missed the backend's Closing state", which
> contains the "fall through" annotation at the beginnig of
> the code comment, which is what GCC is expecting to find.

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
