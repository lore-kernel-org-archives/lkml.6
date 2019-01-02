Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422B6218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOli538Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfABKes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:34:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47894 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfABKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:34:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02AXuAt022462;
        Wed, 2 Jan 2019 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8m5CQcVw9/JZek/qfpCoMoQmVsyqlHBB2Ju/0Vjhgbc=;
 b=DOli538ZH5eaWBPfvq0zhZIArP1H/7R/V2LTPElfMzkQueN1nqOMz2E1WVYwKK7ZnIum
 jdXDOoHwxfvpOlgZ33ELdNCq5LcIND71Eqsj2lSnT6d8S6HqfIkS2nCNS3ZEmZh6ZzZ4
 EdPUyoRgYgbPYvarubQMdyVO8YvVSm2Cr0V0dm5IagVGCTK2Uqoe/gsDH14umrcVA7f5
 jNzERYnwNgbLsq3g32sDnhvQayoNXYWcwnzryDxAv4TmfhS8SvPbpPjgqevtbCRyZkx7
 IGsMrcwAuqgf+PpAE61QQDrIrtxvJ0g997TDFCGhLhvfjmHT7GkpR4jeYOTUuIeCgFZb ZQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pp0btsgaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 10:34:41 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02AYepF027237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 10:34:40 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02AYdRU013978;
        Wed, 2 Jan 2019 10:34:39 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 02:34:38 -0800
Date:   Wed, 2 Jan 2019 13:34:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Andr=E9?= Lehmann <lenneman@web.de>,
        pakki001@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] rtl8712: add a check for the status of register_netdev
Message-ID: <20190102103421.GG3781@kadam>
References: <20181226023955.72139-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226023955.72139-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 08:39:53PM -0600, Kangjie Lu wrote:
> register_netdev() may fail, so let's check its return value, and if it
> fails, issue an error message.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/staging/rtl8712/hal_init.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
> index 7cdd609cab6c..ca0858660a45 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -32,10 +32,10 @@
>  static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
>  {
>  	struct _adapter *padapter = context;
> +	struct usb_device *udev = padapter->dvobjpriv.pusbdev;
>  
>  	complete(&padapter->rtl8712_fw_ready);
>  	if (!firmware) {
> -		struct usb_device *udev = padapter->dvobjpriv.pusbdev;
>  		struct usb_interface *pusb_intf = padapter->pusb_intf;
>  
>  		dev_err(&udev->dev, "r8712u: Firmware request failed\n");
> @@ -45,7 +45,8 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
>  	}
>  	padapter->fw = firmware;
>  	/* firmware available - start netdev */
> -	register_netdev(padapter->pnetdev);
> +	if (register_netdev(padapter->pnetdev))
> +		dev_err(&udev->dev, "r8712u: Registering netdev failed\n");

This error handling doesn't seem complete.  You're just adding the
minimum to make the static analysis tool happy.

If you leave the code as-is, maybe someone else will see the static
analysis warning and fix it properly.  But you're silencing the warning
so now no one will fix it.

Warnings are valuable.  Don't silence them without fixing the bug.

regards,
dan carpenter

