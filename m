Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E02C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7311520869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JL9nF9M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7311520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJPUft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:35:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPUft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:35:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GChoMq112206;
        Tue, 16 Oct 2018 12:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=53G3jIaewNyix2sT8B4NyZbCJiytr2VwuelpVGz1FTg=;
 b=JL9nF9M/B3jB371z29Jb+P+yWjW+AyeIPtQU7y1YegtnNjyWrcHp2zEGzQ9r8R1plLDT
 S+McWHKENkRaz1ffin+XsCjTcEogGRtDPK2PpHH9R+nmG3Q64Nw5BdnAzW4ftTrQxnQc
 qi2H6rPjBHEGHhcvFN3h+iesWxretL/zf7ZLoej+SYVKw7+YlAjo9PC/kJsbAwzYwqda
 m0O8U5xpGy+Du5aFfvwjWhxA7TZ3ea21GMUr96CaaWCSI8cViJax0N0d4HfP7K6YIe4N
 rXrcbylzbMAkxXspze1IVQW4hJvVvWIzlgqOu3hlkQQ6c7es6UGlo28KCnRw6fk9fi1i NA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n384u0hbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 12:44:19 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GCiJUB021843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 12:44:19 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9GCiGj0014203;
        Tue, 16 Oct 2018 12:44:16 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 05:44:15 -0700
Date:   Tue, 16 Oct 2018 15:44:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gabriel Capella <gabriel@capella.pro>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: adc: Add comments to prevent checks
 corrections
Message-ID: <20181016124404.fyzau4pd7wq6r7js@mwanda>
References: <20181015212521.GA24512@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015212521.GA24512@mantaray>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:25:21PM -0300, Gabriel Capella wrote:
> This patch adds 3 comments in 2 different files.
> These comments warn to don't correct the checks of type:
> "CHECK: spaces preferred around that '-'"
> 
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  drivers/staging/iio/adc/ad7192.c  | 1 +
>  drivers/staging/iio/adc/ad7280a.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..786ace19c240 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -354,6 +354,7 @@ ad7192_show_scale_available(struct device *dev,
>  	return len;
>  }
>  
> +/* Do not put spaces around the hyphen. #checkpatch.pl */
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>  			     in_voltage-voltage_scale_available,
>  			     0444, ad7192_show_scale_available, NULL, 0);

No one will read that...  :(  It has to be on the same line.

regards,
dan carpenter

