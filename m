Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19634C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC18C2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNQZq77B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfADEhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:37:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfADEhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:37:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x044YCuE064428;
        Fri, 4 Jan 2019 04:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HYh64zGQ5F5+VkcKoAo7GrySfiu/yS+JsaKABRBTyOk=;
 b=cNQZq77BhL7JIKT94rGYBXbOP07UPXtBtO38ATFpylLnoywnCJeANwmWDplBdFCHSHCH
 3FVZ6pzKEXKns6JiWsCZzLJbY2Sejo5TDvkoUi60Qwsvs7Da7Nu5PV+d7xmsVOIfqCF+
 lovk4vvYJ5+4lQwU8l2+6dwNdazs2bqdCIZK/S2HImMP0O7yuguG7qBYbhcEXmrhnKEK
 KKxE/p7s0KrhbgnNXxQwRoPHTUjPqZQwAkwtDdeI24s/szKC+rKxSdSV2oxt+0QPflh6
 hUinBb449H9lIkRJ6Knzf6Txi4n0T/YIODJYKTv+A9ienB58VVdixx7OVizH9avh8PSf Dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pp1jra8ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 04:37:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x044bK4Y032216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 04:37:20 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x044bJrj031506;
        Fri, 4 Jan 2019 04:37:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 20:37:19 -0800
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: sd: Fix cache_type_store()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181223074158.22796-1-mironov.ivan@gmail.com>
Date:   Thu, 03 Jan 2019 23:37:17 -0500
In-Reply-To: <20181223074158.22796-1-mironov.ivan@gmail.com> (Ivan Mironov's
        message of "Sun, 23 Dec 2018 12:41:58 +0500")
Message-ID: <yq1muoh82de.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=522
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ivan,

> +	 *     The write protect (WP) bit for mode data sent with a MODE SELECT
> +	 *     command shall be ignored by the device server.
> +	 *     ...
> +	 *     The DPOFUA bit is reserved for mode data sent with a MODE SELECT
> +	 *     command.

Wonderfully consistent :(

Applied to 4.21/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
