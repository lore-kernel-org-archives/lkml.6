Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C0C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE952085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yw+OJk/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE952085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJLGzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:55:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39608 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLGzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:55:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9BNNVjL045130;
        Thu, 11 Oct 2018 23:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nWLF2vuza36lXEeo7MIRuKyCJ8ezRn11mXvc4SP2kpU=;
 b=yw+OJk/1mpXTrSC8Co/o9DZitgmBb2ks7u0kXq1JpFjMzggLMDW8M3CZ9ZdbCoGhCWN7
 UiCNElo1N1k2SUcHSCcLrNOeMDKtei/pLDZjVDoTio6+/Atf3EgkxtNOiL99DIP9FOje
 01L6otAfZsp4fjTH3lLtDMs1J5LhpW2tn3U1EfRekiQpoA61aJbSjdE2xIq19raEqVMB
 3jO/vvE4aNhATogX8xpZ9zoxV7r2pspSN/bg+8SUzwjEiq728qUmY0qd5bZDp540GhYI
 x+PtBr6GIrMdqL1d//L65H50aU6kDCgHXEHtlL/LJt0ZEw4qEVHkdApZQv4t0vyAs2/X aw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mxnprfa3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 23:25:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9BNPZ9a018444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 23:25:36 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9BNPYYn014870;
        Thu, 11 Oct 2018 23:25:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 23:25:33 +0000
To:     Joe Perches <joe@perches.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Neaten logging uses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <cover.1537183087.git.joe@perches.com>
        <yq1d0sh459q.fsf@oracle.com>
        <64a18d4b6390e0c7011f440a5f1970371ce43dec.camel@perches.com>
Date:   Thu, 11 Oct 2018 19:25:25 -0400
In-Reply-To: <64a18d4b6390e0c7011f440a5f1970371ce43dec.camel@perches.com> (Joe
        Perches's message of "Thu, 11 Oct 2018 08:37:07 -0700")
Message-ID: <yq1efcw12xm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=620
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joe,

>> Applied to 4.20/scsi-queue, thanks!
>
> Is this branch also applied to Stephen Rothwell's -next?

Yes.

-- 
Martin K. Petersen	Oracle Linux Engineering
