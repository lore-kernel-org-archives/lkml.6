Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D793C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8B920661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0+Qr59sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfBWHSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:18:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBWHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:18:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1N7Es0O170230;
        Sat, 23 Feb 2019 07:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=bKaiT4Jm4bntz660DNaINIYyQfhJHMYyUQadrCK9ejY=;
 b=0+Qr59sD0mVv6vvRWm3WXBpNy6QuzpeWyM9lLK3t53bZhT9uQo+qmabnLlpYuCy92j08
 2RwBTTlGwowNufQqJoBAoHfUvAdiaY/6xMcq3vLe5zjHFBUughKAo+U3Iua6GLxEaxCD
 XvwrNCXovhNa542IL5c4IQfRl2alsixzbqVY1jsGg0Pne8xmeTxDzwxW7UyeDUTjQh9K
 UB/jefmwhvJThnEIewpa5o0gSUyY+V3c0a6eC9BnvteRHkcpZzA30tz0s0Gk8j/aa5tb
 3CzQh35101LjQ1rH8xqkBdCUW1nrkBLDGa25+AEHcpCS/b2NTtwbO7iq8RPKL7WfavgU 1w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qtwktrab7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Feb 2019 07:18:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1N7ILw9023894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Feb 2019 07:18:21 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1N7ILuo026681;
        Sat, 23 Feb 2019 07:18:21 GMT
Received: from kadam (/41.202.241.61)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 23:18:20 -0800
Date:   Sat, 23 Feb 2019 10:18:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        quytelda@tamalin.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: Re: [PATCH] staging/ks7070: Removed unused varibale
Message-ID: <20190223071812.GE1737@kadam>
References: <20190223063939.18261-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223063939.18261-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9175 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=774 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902230052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 01:39:39AM -0500, Bo YU wrote:
> From: Bo Yu <tsu.yubo@gmail.com>
> 
> Compiling the kernel with W=1 results in the following warning:
> 
> drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
> set but not used [-Wunused-but-set-variable]
>   u16 mib_val_type;
> 
> drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
> set but not used [-Wunused-but-set-variable]
>     u16 mib_val_size;
> 
> drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
> set but not used [-Wunused-but-set-variable]
>       u16 result_code;
> 
> Remove these variables.
> 
> Rebase on next-20190222
  ^^^^^^^^^^^^^^^^^^^^^^^
Is this a v2 patch or something?  Don't include this in the changelog.
Put it under the --- cut off line.

> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Quytelda Kahja <quytelda@tamalin.org>
> 
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
  ^^^

>  drivers/staging/ks7010/ks_hostif.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

regards,
dan carpenter
