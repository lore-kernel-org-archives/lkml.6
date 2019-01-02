Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F39FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634FA2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsIui/yX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfABJSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:18:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38336 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfABJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:18:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x029E4p0154385;
        Wed, 2 Jan 2019 09:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=TOK/w2pnfxGWo+gG/VAdGVmuSSYQRVUyzryHqdchmrA=;
 b=LsIui/yXrBIFKCV79yCsPUVbp6BnqsUOSqz/tGz6inX8JV6MjMRcOr1401vSh8KujNbS
 ZICAZClH1FozLBRD9yJH0WINvKXJOp2T4pUAngajJPpLfZGKTYTvQ1F+DtAQ1ufHxlTf
 7vIzQ3f9HD8tJc44aLv/cKx+b4HvbhqVES4shMUXLlkXZZ27TRvDfNjMPihuYjXN5lrd
 78bn8PGtH+zcHg6e/51iI98w1PhO5RJhcHEoFfH1O0XjlATUhTBzml6OtxniLYIDfO2j
 V0h4ODVXwdgkHsc/KWA0bBWJdPLkYN6xbAuwjQcGqhwaoonm2DpmJ896wuApzyjCFxMw +Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pp0bts569-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 09:17:58 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x029HpBo024100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 09:17:52 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x029Hov6013666;
        Wed, 2 Jan 2019 09:17:50 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 01:17:49 -0800
Date:   Wed, 2 Jan 2019 12:17:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, arve@android.com, maco@android.com,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/2] binderfs: implement "max" mount option
Message-ID: <20190102091731.GB3781@kadam>
References: <20181223143550.10672-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223143550.10672-1-christian@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 03:35:49PM +0100, Christian Brauner wrote:
>  static inline struct binderfs_info *BINDERFS_I(const struct inode *inode)
> @@ -110,10 +132,16 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  
>  	/* Reserve new minor number for the new device. */
>  	mutex_lock(&binderfs_minors_mutex);
> -	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> +	if (++info->device_count <= info->mount_opts.max)
> +		minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
> +				      GFP_KERNEL);
> +	else
> +		minor = -ENOSPC;
>  	mutex_unlock(&binderfs_minors_mutex);
> -	if (minor < 0)
> +	if (minor < 0) {
> +		--info->device_count;

Isn't this decrement supposed to happen under binderfs_minors_mutex?

>  		return minor;
> +	}


regards,
dan carpenter

