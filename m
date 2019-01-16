Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B5CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2A20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0/tMf5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbfAPIzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:55:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388751AbfAPIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:55:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0G8swKD162258;
        Wed, 16 Jan 2019 08:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UJOd8+0u30FDJZN7DsUVx+V37B7/m9Pe+SRD3ysReHM=;
 b=O0/tMf5YBZImuthYy1b5IwFfynbzshXNqgAKBimRF2Qt/Xzde163za2fSzJHUTiTdPQz
 dqAirTVGXiLiTAlVJsrdFYx/LsU/G06GyleBu1eEzuNIcT2whDCwQ8hukAl78jxdZAF4
 I8uLvn8mlDMFDpV9D3miser0dVgZwD8qftL94IyrYQt+Yfwf7z/ps36kbbncd+t11lKH
 YBe4G0qK3lF2+QGf8QNQV4nnNIQvO7PbWVpnYHYvDnV37y32t69nq+/PL2k7bG1O3jv8
 bVIuy0wxPHXcf3ey8ovIVNsrhqjxLRiEeVz5k2Z0C9/rxwA9PKzel9kz/zS8X0hZtmRd ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pybkcgg8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 08:55:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0G8tHTK022499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 08:55:17 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0G8tGjn004526;
        Wed, 16 Jan 2019 08:55:17 GMT
Received: from kadam (/10.175.54.137)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 00:55:16 -0800
Date:   Wed, 16 Jan 2019 11:54:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, devel@driverdev.osuosl.org,
        tkjos@android.com, gregkh@linuxfoundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        arve@android.com, joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH -next] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116085455.GD4482@kadam>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
 <20190116062546.ufoeresnwz3wyxiu@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116062546.ufoeresnwz3wyxiu@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:25:47AM +0100, Christian Brauner wrote:
> On Wed, Jan 16, 2019 at 03:01:04AM +0000, Wei Yongjun wrote:
> > Fix to return a negative error code -ENOMEM from the new_inode() and
> > d_make_root() error handling cases instead of 0, as done elsewhere in
> > this function.
> > 
> > Fixes: 3ad20fe393b3 ("binder: implement binderfs")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/android/binderfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 9518e2e..2bf4b2b 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -519,8 +519,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	sb->s_fs_info = info;
> >  
> >  	inode = new_inode(sb);
> > -	if (!inode)
> > +	if (!inode) {
> > +		ret = -ENOMEM;
> 
> Hey, thanks for the patch. Just a nit:
> can you please just do?
> 
> 	ret = -ENOMEM;
>         inode = new_inode(sb);
> 
> This is more consistent with how we do it everywhere else and let's us
> avoid shoving ret = -ENOMEM into two places.
> 

Btw, your style is why you have this bug.  I don't have strong feelings
about this either way, I'm just pointing it out.

regards,
dan carpenter

