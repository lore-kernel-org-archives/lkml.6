Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268382098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s4g/0eiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268382098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbeJQGMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:12:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQGMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:12:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GMEESV050628;
        Tue, 16 Oct 2018 22:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xwC8SYYwst8d9F8Nx16+Ro3jKi5sLpedku66sxZYPzw=;
 b=s4g/0eiBMj22ilX3X6WHPh6WjsB1aZsO5DyMl6tTV1AIR5fs0IHtT4KtMkTAegP7ji+o
 GFois/cztvfF+ewf+jBXrsB8yKQ0iF51akG30Q7DG8L+GYyFJUfdyDju9mwGm/h6qG0f
 M4IiT67sIG4dL9DwvoCn9Q/xwcTSueTU750G6sIHJWxLnwdz8ke+gmNE/efExatdmKyo
 NzxwLt0jkXHDO6wjsg/7eu8dGGUWumVGXPdOqusyRNPvcBXBQ2oiEhazfvS6zFWZ4iNj
 KI3afvV9SVFlUa85zxilvkRxKoLeaGDDZZt94tcmtihtaoE61iTGYHBh2Pi8KjSSugD1 aw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nq3kh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:20:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9GMKFnC025212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 22:20:15 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GMKFdU032679;
        Tue, 16 Oct 2018 22:20:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 15:20:15 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Remove unnecessary self assignment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180920221706.4948-1-natechancellor@gmail.com>
Date:   Tue, 16 Oct 2018 18:20:12 -0400
In-Reply-To: <20180920221706.4948-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 20 Sep 2018 15:17:06 -0700")
Message-ID: <yq18t2xr0tf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns when a variable is assigned to itself.
>
> drivers/scsi/qla2xxx/qla_mbx.c:1514:4: warning: explicitly assigning
> value of variable of type 'uint64_t' (aka 'unsigned long long') to
> itself [-Wself-assign]
>         l = l;
>         ~ ^ ~
> 1 warning generated.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
