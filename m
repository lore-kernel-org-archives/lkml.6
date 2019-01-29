Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+lxuNgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfA2Ino (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:43:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2Ino (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:43:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T8cwJm041486;
        Tue, 29 Jan 2019 08:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nNX53GkyjRN/YhQ8Q2c1A4aYOjVIJvIoJVmUyTuOljk=;
 b=Z+lxuNgLIlv9E+7z40Zv5r/hwopAH15o20lg7r+IihgqfswOoKxDQ9gn59Zs2jnEGUwg
 WAoCnVI/RfI/mKOF+o6dBirrC3cBzWn94N4jX0lBxos6nrIml9wxKdple82nlgoYUYOf
 u8OyG+v9nsH1KY9fv25TtVpjRrm1cQB2xRAtDgWcj2c4N8RxzsN5ri4QWSN8daspV/wm
 wgdm0VscvA7VleKQQVTUGwAuJgrsdLvdJDkvwgOFKbDPpqZpOVcFZjHj81wxJhKdXZ/w
 UlXPdijxADSNfkiFDajWlMK0/kpt15okEfZfvxJr+NC9BpxdITMOMagOIuw77I+pg2rK BA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q8eyuavhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:43:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T8hTG1005775
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:43:29 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T8hSxk021422;
        Tue, 29 Jan 2019 08:43:29 GMT
Received: from kadam (/197.157.0.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 00:43:28 -0800
Date:   Tue, 29 Jan 2019 11:43:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v4 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190129084320.GN1795@kadam>
References: <20190129083520.28607-1-gaoxiang25@huawei.com>
 <20190129083520.28607-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129083520.28607-2-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:35:20PM +0800, Gao Xiang wrote:
> Let's add .get_acl() to read the file's acl from its xattrs
> to make POSIX ACL usable.
> 
> Here is the on-disk detail,
> fullname: system.posix_acl_access
> struct erofs_xattr_entry:
>         .e_name_len = 0
>         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
> 
> fullname: system.posix_acl_default
> struct erofs_xattr_entry:
> 	.e_name_len = 0
> 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> change log v4:
>  - leave kmalloc and wait the conclusion of fault injection
>    pointed out by Dan Carpenter;

I do think this is the right thing, but I also wasn't going to ask you
do redo v3.  Anyway, thanks!

regards,
dan carpenter

