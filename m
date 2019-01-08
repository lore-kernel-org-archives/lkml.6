Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195132087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tDp1riQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAHJ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:59:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45256 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:59:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x089wwg0171836;
        Tue, 8 Jan 2019 09:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dQ8UlmPGnMrKWkrB3A66sb4x9LUYtblrI7itGz1to4U=;
 b=tDp1riQyDFb408igILo1MK72ybNg2SL2N0fPBDvtX8M40uIVt+REvJeDGq3tILGDwWTO
 nnm3D3Dxa5YOa0+v4tgndNWGRmqdF0zLd1somGY2qkw2h80D/kH++m4sCDMfCrLZLBbJ
 5hotLoH33s7jIwHQu0dsPn9kwi7RZkDPRLT8CdiiaFB8RHA2buDDaBm9jOOiKGer4ocR
 eZMSpwR0MW6wxAr6phBL1OD8SHrQ5itnSnrscnTQycQbmZgUUMPj/t1tJJ4Wxk4Qi50q
 bo3oZME4GRzXbdfcqrkwX5BrojlS7/8U/FHaFoHEoZWGiadCnH+84n2xYIc07gOQIAvn XQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ptn7qteuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 09:59:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x089x4Or032437
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 09:59:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x089x1oB009404;
        Tue, 8 Jan 2019 09:59:02 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 01:59:01 -0800
Date:   Tue, 8 Jan 2019 12:57:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] [v3] staging: rtl8723bs: Clean up dead code
Message-ID: <20190108095738.GH3200@kadam>
References: <20190107232054.4742-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107232054.4742-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject does work for `git am` but the more normal way to format
it is:

	[PATCH v4] staging: rtl8723bs: Clean up dead code

On Mon, Jan 07, 2019 at 05:20:52PM -0600, Aditya Pakki wrote:
> rtw_wps_start() is part of dead code due to CONFIG_INTEL_WIDI.
> The fix removes the deadcode and replaces the function with NULL
> in rtw_private_handler. Identified as part of copy_from_user bug.
> 
> Changes from v1 & 2:
> The return value of copy_from_user() is not checked appropriately.
> However, maintainers identified the patch fixing the issue is not
> required as function rts_wps_start() is dead code and can be removed.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

The "Changed from" comments need to go here under the --- cut off line.
It gets removed from the final kernel git log.

That information is just for maintainers to remember what was discussed
earlier.  It's not needed for the permanent record.

>  .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 +------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)

regards,
dan carpenter

