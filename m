Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BD82087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6+iNTq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BD82087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeIXQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:03:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeIXQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:03:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8O9wm3Q040577;
        Mon, 24 Sep 2018 10:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WxsrZ78j4exAQyijedF75kxkjRPEPcTuiypF1R8Wl2A=;
 b=l6+iNTq52UfPcNwV74U3sgOMEGiPsM8VsMyhW3Zxn5DIMQuvg2tPG9D512CQA1w0PlN5
 Og4xCGjNcDt95StvcactpCdBVBe27R/pqK9O1KCjUqiM/nuOfn+oYVIJe1PTTO/tfJK1
 SGOD+I1LOy5rmAxFoV2xoidlVl3TIYZ2qY4+6B3ao4bLfi3AhE303Ug+/PXlgfhFePlK
 CV/D4f6G0NdbaCYypqiGBB5ZwjVXW8Pxsn9f+M/XJusy/ltMnO1Z0DaG/LaBmx4kYet7
 tb9obG5rah0VTvTXNxAc9q8yX3dlkECwX9hiMZ5Btc4JLXi3CR9MVnjwbR/L40oH7MUS uQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mnvtubdjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 10:02:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8OA2EaE013471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Sep 2018 10:02:15 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8OA2D39011698;
        Mon, 24 Sep 2018 10:02:14 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Sep 2018 03:02:13 -0700
Date:   Mon, 24 Sep 2018 13:02:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] staging: vc04_services: Remove spaces after '*'
Message-ID: <20180924100206.dhbdz4fbrmba3dwh@mwanda>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180923140620.14583-6-qader.aymen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923140620.14583-6-qader.aymen@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9025 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=564
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809240107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 03:06:20PM +0100, Aymen Qader wrote:
> This patch fixes the checkpatch.pl error:
> 
> ERROR: "foo * bar" should be "foo* bar"
                                ^^^^^^^^
It should be "foo *bar".

> 
> in the interface/vchi directory
> 
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
> index f818cf2e27e1..77bf92018165 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
> @@ -154,7 +154,7 @@ typedef struct service_info_tag {
>  extern "C" {
>  #endif
>  
> -extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
                                                                                                ^^^^^^^^^^^^^^^^^
> +extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
>  								 const VCHI_MESSAGE_DRIVER_T * low_level);
                                                                                             ^^^^^^^^^^^

Change these as well.

regards,
dan carpenter

