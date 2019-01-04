Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17222070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YVy6XKlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfADEkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:40:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfADEkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:40:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x044dV9U108888;
        Fri, 4 Jan 2019 04:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=u1w7lMKRegC8vu0PXMrRzElKsHo2A6ST70TUsBHbqGk=;
 b=YVy6XKlSkmwILTxJm7N0cwxzxtVTnh7b7ZMGwdg6pm7YEJSKOR3YG8TqbXxhRlH5bY/q
 xpqROUnA89jRBfHBbToua9SvWoZlu4RzHgbN2QIZqbdO5nWKUyqho3526mqFMny48oqq
 2tp5xJjOuZlh5Nsj2sRPHEYOx8BrbSZroThvO774s+4HWPg+xAEli+/fi3cmKMBLmC2X
 ipfjNUO3US3iwAo8xT0/AnjJgYYzBWeOe7DYgM/nZPy+6bTmRpn1J12E0Zl2+j5Vhf20
 YJF1R9yiF01y+BslQec5JSxqh6QDIjlnnVOGJiXR94fnnm85/NZxBILZvGUvlgb0vsfX Mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pp0bu2c2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 04:40:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x044eUp8028265
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 04:40:30 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x044eT1G006402;
        Fri, 4 Jan 2019 04:40:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 20:40:28 -0800
To:     Leo Zhang <nguzcf@gmail.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Colin Ian King <colin.king@canonical.com>,
        Laura Abbott <labbott@redhat.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] target/iscsi: fix error msg typo when create lio_qr_cache failed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545581907-920233-1-git-send-email-nguzcf@gmail.com>
Date:   Thu, 03 Jan 2019 23:40:26 -0500
In-Reply-To: <1545581907-920233-1-git-send-email-nguzcf@gmail.com> (Leo
        Zhang's message of "Mon, 24 Dec 2018 00:18:27 +0800")
Message-ID: <yq1imz58285.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=720
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Leo,

> -		pr_err("nable to kmem_cache_create() for"
> +		pr_err("Unable to kmem_cache_create() for"
>  				" lio_qr_cache\n");

Applied to 4.21/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
