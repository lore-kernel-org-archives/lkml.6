Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD872C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC632085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u2MQP8qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfAGSCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:02:09 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfAGSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:02:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07HxWc6103545;
        Mon, 7 Jan 2019 18:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=GLx6mKVNS7mQ/rFAFpF8Lz4QyeUdXHV8Txo29+ehDYY=;
 b=u2MQP8qqf9FUTB8WEzq/mCDDH7XjBlhFVEutjVkG20ZvQ93qwPafOx02W3qJ9sZu1a2+
 TpnJToS9ohaxefivN5f8Mfr4Jg7EvV2DTmbHNikloDIRhdE9XWqeYRUdKYQz/SEF5NPd
 zgLbMx1CJlyYR3CYQLWPTpHiv4ZysFK/DBd19DivOd41zesG094SQT7Ndll0ZTrJOCuM
 d6yRJqQ52UMmsECocxyJkfAoHLqZ8U3mIYmnleGO5bm/eoKS/BCgxa+L2J0dxbJtoJ99
 zTJP04AfcutKl5twPuL34IeOQzdvrBuZDTn3m191hdu4M5nNb6feq1RTorSfoQ2soXcs hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ptm0ty9jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 18:02:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x07I22BV018379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 18:02:03 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x07I22GT022111;
        Mon, 7 Jan 2019 18:02:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 10:02:01 -0800
Date:   Mon, 7 Jan 2019 10:02:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        suyanjun218@gmail.com
Subject: Re: [PATCH] xfs: correct statx's result_mask value
Message-ID: <20190107180200.GK12689@magnolia>
References: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190107175229.GJ12689@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107175229.GJ12689@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:52:29AM -0800, Darrick J. Wong wrote:
> On Mon, Jan 07, 2019 at 04:53:10AM -0500, Su Yanjun wrote:
> > For statx syscall, xfs return the wrong result_mask.
> > 
> > Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > ---
> >  fs/xfs/xfs_iops.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index f48ffd7..3811457 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -521,6 +521,9 @@ xfs_vn_getattr(
> >  			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
> >  		}
> >  	}
> > +	
> > +	/* Only return mask that we care */
> > +	stat->result_mask &= request_mask;
> 
> Why not just:
> 
> 	stat->result_mask = STATX_BASIC_STATS;
> 
> at the top of the function?
> 
> I don't see the need to mask off result_mask at all, since we could some
> day elect to return more than what's in request_mask...
> 
> ...waitaminute, are you seeing garbage in the result_mask that's
> returned to userspace?  I also noticed the vfs stat functions declare
> "struct kstat stat;" without explicitly zeroing the structure fields,
> which means (I think) that we can leak stack information if the kernel
> isn't built with the stackleak plugin?

Ignore the above; vfs_getattr_nosec actually does zero the kstat buffer
before calling ->getattr.  We also set result_mask to STATX_BASIC_STATS.

Now I'm really confused: why is this necessary at all?  What incorrect
masks did you see, and under what circumstances?

--D

> --D
> 
> >  
> >  	if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
> >  		stat->attributes |= STATX_ATTR_IMMUTABLE;
> > -- 
> > 2.7.4
> > 
> > 
> > 
