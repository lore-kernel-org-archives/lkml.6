Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E183C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B188C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMbUM0M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B188C2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJWbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:31:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJWbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:31:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9AEx5Tw025207;
        Wed, 10 Oct 2018 15:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YegHVM7DqawRuc0xkrr8YgLxRPBZmWJfnOD9RUSve4s=;
 b=UMbUM0M/dlV3SWxWuTwIhyq8IeZ2Y4jL5m6PXF/9cLNTw+xonP1j0UydNQn4LRFv0vUy
 1zzU79Ow/geKZZwjVMgBK3aRIOGrE9OSSTFM45d7bCrj7mqsK4EI/I7Io8oGqPwkAbXJ
 AQUx6KRP3J3W8CVdaTtMBbrCYzlaN/NxJJ1mO7tGnhMh3l/jP4eaZeLAu/dkaz1KStba
 ZhlzptKPibPyyiepCjPEaXrg20lBCJu7F3/1mcL1qjMQZTvaGULcHjpL2+THE313yEms
 +v7LKh1Q6XsZxPRU458QdII5c4y68r4yEPr2G73bHgV8bemxXvUhBhh83UDQoxeosyrz Zw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mxnpr4kny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 15:09:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9AF97Cc013241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 15:09:07 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9AF96QB005048;
        Wed, 10 Oct 2018 15:09:07 GMT
Received: from [10.175.193.46] (/10.175.193.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Oct 2018 15:09:06 +0000
Subject: Re: [Xen-devel] [PATCH] xen: drop writing error messages to xenstore
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
References: <20181009160959.31076-1-jgross@suse.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <5126873e-ade5-86b0-4ebf-58cb47c9cbe7@oracle.com>
Date:   Wed, 10 Oct 2018 16:09:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181009160959.31076-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9041 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810100149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 05:09 PM, Juergen Gross wrote:
> xenbus_va_dev_error() will try to write error messages to Xenstore
> under the error/<dev-name>/error node (with <dev-name> something like
> "device/vbd/51872"). This will fail normally and another message
> about this failure is added to dmesg.
> 
> I believe this is a remnant from very ancient times, as it was added
> in the first pvops rush of commits in 2007.
> 
> So remove the additional message when writing to Xenstore failed as
> a minimum step.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> I am considering removing the Xenstore write altogether, but I'm
> not sure it isn't needed e.g. by xend based installations. So please
> speak up in case you know why this write is there.

So this:

"This will fail normally and another message about this failure is added to dmesg."

Brings me to the question: What about {stub,driver}domains? Ideally you
shouldn't be looking at domU's dmesg as a control domain no? I can't remember
any other error node, but if something fails e.g. netfront fails to allocate an
unbound event channel - how do you know the cause from the control domain
perspective?

Irrespective of xend or not: isn't this 'error' node the only one that
propagates error causes per device from domU?

	Joao

> ---
>  drivers/xen/xenbus/xenbus_client.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
> index a1c17000129b..e17ca8156171 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -278,10 +278,8 @@ static void xenbus_va_dev_error(struct xenbus_device *dev, int err,
>  	dev_err(&dev->dev, "%s\n", printf_buffer);
>  
>  	path_buffer = kasprintf(GFP_KERNEL, "error/%s", dev->nodename);
> -	if (!path_buffer ||
> -	    xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer))
> -		dev_err(&dev->dev, "failed to write error node for %s (%s)\n",
> -			dev->nodename, printf_buffer);
> +	if (path_buffer)
> +		xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer);
>  
>  	kfree(printf_buffer);
>  	kfree(path_buffer);
> 
