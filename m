Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA97206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ns/QWa1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA97206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeIENi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:38:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeIENi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:38:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8598ooN186591;
        Wed, 5 Sep 2018 09:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dOZIlZYOlUxpSQ0fB5cLwlffwsuwqAggFvA8ftpXZMs=;
 b=ns/QWa1WocEzRY6sL36nUpEbhi7O24lUUpSS3eKYZMOWB3jYdhJBVm4AQRyAi0Ivr44W
 0DxdilND66u52ZNLVv0uDuaWi95HM0U81UvZWkeFS8wuKXsezf4qWSsxMoDfhcYqczJx
 +DNptL67u/Rm5tWtM/n4ppVJTwrghM2LkSMPCqsvZ2Opk9+KQaMb3IuH8ZpwNGCC3gQ5
 6IurjPpAvnZXWmu4idU5Wpz4r5iCrNgfFmKeDtCyAfztSmKZMaM/AEA5tvn8xd3QRdjm
 a2liXK84O2mrkkbYaA6kaUxws6A8NzS9eNDISMA9DW2CLNBGVgcl+nijm6nVCESLPzqr AQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpjjv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 09:09:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8599ZqO028001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 09:09:36 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8599Y5F032593;
        Wed, 5 Sep 2018 09:09:35 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 02:09:34 -0700
Date:   Wed, 5 Sep 2018 12:09:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martijn Coenen <maco@android.com>
Cc:     gregkh@linuxfoundation.org, tkjos@google.com, arve@android.com,
        amit.pundir@linaro.org, devel@driverdev.osuosl.org,
        smoreland@google.com, linux-kernel@vger.kernel.org,
        robenea@google.com, maco@google.com, john.stultz@linaro.org,
        peskal@google.com
Subject: Re: [PATCH] ANDROID: binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.
Message-ID: <20180905090925.474dugeix3ssykcz@mwanda>
References: <20180905073346.157318-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905073346.157318-1-maco@android.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:33:46AM +0200, Martijn Coenen wrote:
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index bfaec6903b8bc..a54a680ff2936 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -200,6 +200,13 @@ struct binder_node_debug_info {
>  	__u32            has_weak_ref;
>  };
>  
> +struct binder_node_info_for_ref {
> +	__u32            handle;
> +	__u32            strong_count;
> +	__u32            weak_count;
> +	__u64            reserved;
> +};

What's the reserved for?  On 64 bit systems there is a 4 byte struct
hole between weak_count and reserved.  Why not just make reserved a
__u32 and get rid of the hole?  (Not rhetorical, I have no idea).

Btw, people sometimes complain about that we don't check that user input
is zeroed in ioctls.  Like for example maybe they're passing random data
in the the strong_count field and then later we decide that actually
that field should mean something but we can't make it mean anything
because we've been letting the user put whatever they want there.  These
are just random thoughts in my head, not necessarily important.

regards,
dan carpenter

