Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75D320657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J196DzG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392188AbfAPKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:46:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388841AbfAPKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:46:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0GAiJh8021533;
        Wed, 16 Jan 2019 10:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=foSOY5nVwWAHI4ww9/uXffs99ewJH1mpNX6lzFkCPFI=;
 b=J196DzG49fuTdhyinbEDzyvx6Rq8SEyJ6riWgKp/xUXQYY4M4/KL32TErA7vZsSNlvYn
 wb/uuIrc0Du3f5w+i+BRdGAX6U7s79Awk7qI7iMb1pGro0MMUj7OEPO2YA6cn6yCz0Xd
 HiEOagEdHgdTne240sApRNq05j8q/FBu7u3hVIyP3VVZ9WSSjmrlC4YXNpmBzCbr/0gx
 pBW+HAvI7KCuqHJrXKp3xEMzDrg0mIuyeSzN/AKlmbR9/HCsmEshQjqjvIyEnlEJ+GVy
 oVszWXWGCYIw52+Jt8lyuYHqGsDuu6IcT0zU+DomsBNwxPaegwtrM7Ko74lPlADR4fQ7 VQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pybjns6u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 10:46:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0GAk9vJ016666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 10:46:09 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0GAk7c6008095;
        Wed, 16 Jan 2019 10:46:08 GMT
Received: from kadam (/41.202.241.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 02:46:07 -0800
Date:   Wed, 16 Jan 2019 13:45:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 3/5] staging: erofs: decrease the shrink count in
 erofs_workgroup_get
Message-ID: <20190116104553.GE4482@kadam>
References: <20190116085956.21004-1-gaoxiang25@huawei.com>
 <20190116085956.21004-3-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116085956.21004-3-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:59:54PM +0800, Gao Xiang wrote:
> It is more suitable to update in erofs_workgroup_get since
> it's actually the one matched with erofs_workgroup_put.
> 

This patch is fine.  No need to resend.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

But for future reference, I found the commit message a bit confusing.
Ideally, I would understand basically what the commit does and why
without needing to read the diff.

I mostly just read the subject or the commit message, either or, instead
of reading both.  (This is not really true.)  My email client looks like
this.  (Also not true).

https://marc.info/?l=linux-driver-devel&m=154762932712086&w=2

While none of that was strictly true, it is a little bit true-ish...
So please, assume that some people will start reading the commit message
without reading the subject.

I sort of thought from reading the commit message that it was a bugfix
or a behavior change.  A better commit message would be:

staging: erofs: move shrink accounting inside the function

This patch moves the &erofs_global_shrink_cnt accounting from the caller
to erofs_workgroup_get().  It's cleaner and it matches erofs_workgroup_put()
better.  No behavior change.

regards,
dan carpenter

