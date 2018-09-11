Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29954C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07EC20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07EC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeIKM6m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:58:42 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:56045 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:58:42 -0400
X-IronPort-AV: E=Sophos;i="5.53,359,1531785600"; 
   d="scan'208";a="78841661"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     'zhong jiang' <zhongjiang@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Wei Liu <wei.liu2@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] xen-netback: remove unecessary condition check before
 debugfs_remove_recursive
Thread-Topic: [PATCH] xen-netback: remove unecessary condition check before
 debugfs_remove_recursive
Thread-Index: AQHUR30TfVb2xRhgeE6EPvt2EzXbNaTqu8Ow
Date:   Tue, 11 Sep 2018 08:00:02 +0000
Message-ID: <06106022e5344ccca2127e5afd6928d9@AMSPEX02CL03.citrite.net>
References: <1536414822-32911-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536414822-32911-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: zhong jiang [mailto:zhongjiang@huawei.com]
> Sent: 08 September 2018 14:54
> To: davem@davemloft.net; Paul Durrant <Paul.Durrant@citrix.com>; Wei Liu
> <wei.liu2@citrix.com>
> Cc: xen-devel@lists.xenproject.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] xen-netback: remove unecessary condition check before
> debugfs_remove_recursive
> 
> debugfs_remove_recursive has taken IS_ERR_OR_NULL into account. So just
> remove the condition check before debugfs_remove_recursive.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
>  drivers/net/xen-netback/netback.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-
> netback/netback.c
> index 3621e05..80aae3a 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -1660,8 +1660,7 @@ static int __init netback_init(void)
>  static void __exit netback_fini(void)
>  {
>  #ifdef CONFIG_DEBUG_FS
> -	if (!IS_ERR_OR_NULL(xen_netback_dbg_root))
> -		debugfs_remove_recursive(xen_netback_dbg_root);
> +	debugfs_remove_recursive(xen_netback_dbg_root);
>  #endif /* CONFIG_DEBUG_FS */
>  	xenvif_xenbus_fini();
>  }
> --
> 1.7.12.4

