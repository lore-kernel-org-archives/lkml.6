Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1157C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D69F2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ffgn39Uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeLTJKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:10:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeLTJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:09:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK8xU3T163795;
        Thu, 20 Dec 2018 09:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OL/z9sWEf00tjg1m6zFVJa13CzXDPFnCfS59Hi+pA/M=;
 b=ffgn39UqtIkRjzrQVTa1RVmH45yGlmw9zUBIJCpeQKVfsg+kZeq4GLXTpZbDUI0QThOO
 3+uiOOguOjoewCDlLAWPIwxuhQzXe5ny6p/TlTCaCPc8UPyglg9LBuclY5CtLw3fqYo2
 pTIfsmkqnQqQ1e98LzYU7LqCYmmgxBU0b+wQRc+IeXNHbGRfe5EUzMYdD3dcParaRWOA
 5afog1A2b8N2sQAvTRh/NMBz8JNjwRaoRO/XtjvGHDXQ6HjDMG83dOkjR39e6Ahzo4y9
 oV53+2Ux9CPtwgUc2UPX41kTK7AVzIqdRuFXQxUqVUqDbxrtItd8lfKQoz9wXGK8/m49 Vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pfh3a634a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 09:09:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBK99nJg002746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 09:09:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBK99moX026370;
        Thu, 20 Dec 2018 09:09:49 GMT
Received: from kadam (/197.157.0.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 01:09:48 -0800
Date:   Thu, 20 Dec 2018 12:09:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rts5208: add a missing check for the status of command
 sending
Message-ID: <20181220090921.GP19692@kadam>
References: <20181220075704.40732-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220075704.40732-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:57:01AM -0600, Kangjie Lu wrote:
> ms_send_cmd() may fail. The fix checks the return value of it, and if it
> fails, returns the error "STATUS_FAIL" upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/staging/rts5208/ms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index f53adf15c685..5a9e562465e9 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -2731,7 +2731,9 @@ static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
>  		}
>  
>  		if (val & MS_INT_BREQ)

You would need to add a curly brace here.


> -			ms_send_cmd(chip, PRO_STOP, WAIT_INT);
> +			retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
> +			if (retval != STATUS_SUCCESS)
> +				return STATUS_FAIL;

You can't overwrite "retval".  We already had an error code save there
but now you're changing to STATUS_SUCCESS.

Anyway, I think the original error handling is probably correct and we
should leave it as-is.  We're already trying to handle an error
situation by resetting stuff.  Then if we get another error while we
take these extreme measures to recover, we shouldn't give up.  We should
just keep on trying to reset instead of returning early.

regards,
dan carpenter

