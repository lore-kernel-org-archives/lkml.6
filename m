Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D72C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BDF2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MiwCAmuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfAGM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35448 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfAGM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07CnNeM029973;
        Mon, 7 Jan 2019 12:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xvDa7MmLnrhCT31DqladHvQPeWgEtCj2/fl5GX9R4Us=;
 b=MiwCAmuNpYwHLa1mA8Oz+wRm5T5ljOiW4ZVMh2Ybt+oVZB+ReMZfMBpcIwtnT+alYuQY
 xmkUficjCgtcUAD6b/v2lfoxLAwT37G+RaRVLZsFqDCRbEpS/hqja9wU3q1ERO1fzzn6
 pd8cKyzPWiICvTcf7xwk5B52xvkh9ZEwyy2ZGzDl8FFQtgzByDfDPGUJcb9rVhEv1ugJ
 Gx7yVkgWl/xYMK5J+JmoLjvEiWuUryIYUC9l6eIWdy9rDdRjSsN2MS4FjEYEblLzVyLm
 ifkZIjpyX6iR/z3CmQjM8HZVyPNUfdGeG5krtur+QYwsZC49JBO3fGr3meOvfgX4HLaw CQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2ptm0twkmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 12:58:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x07CwUfq010309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 12:58:30 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x07CwTWq027241;
        Mon, 7 Jan 2019 12:58:29 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 04:58:29 -0800
Date:   Mon, 7 Jan 2019 15:57:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] v2 staging: rtl8723bs: Clean up dead code
Message-ID: <20190107125730.GB3200@kadam>
References: <20190106162101.9176-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106162101.9176-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9128 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 10:20:59AM -0600, Aditya Pakki wrote:
> rtw_wps_start() is part of dead code due to CONFIG_INTEL_WIDI.
> The fix removes the deadcode and replaces the function with NULL
> in rtw_private_handler. Identified as part of copy_from_user bug.
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

