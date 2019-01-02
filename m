Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19365C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65672171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ot5NU7CR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfABLbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:31:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:31:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02BTLAF062221;
        Wed, 2 Jan 2019 11:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=NUjmGz/jbP8Ezo2DEgm/JQl4rPd5zOA2aNEq5kDyD1A=;
 b=Ot5NU7CRv259SOzj5Apyw7cdpPUR+GRaC7Bq87dnXH8swsbx/pyhdfdxX/iLH+hiDt9h
 H6ls26qNrFD8FIbJJbV4mfXtZlxxlpcxPDT5gZDR6u4KvtCDZ5KAR+eF7qlNrGWbfBiS
 b/Glq/LVedy6OanWGL7W/RqJHZinVHEjkMqWaHyEsCL/kUK3UuVnf6PT2HNpSrsbMxiA
 xqRi40ZbhJHIqvgAJb2hdnjZOuy3M3arm+uPMA81zKC78L75D3YGZ9ljB1ec7okOBwrN
 tuW227QpVRMrGuKsOeWCSlGMBizyZFj06cnqt6IavXh5mcVIU4bdSIRERggtAMoT173x zQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pp0btspbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 11:31:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x02BVAV4018017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 11:31:10 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x02BV8UT015580;
        Wed, 2 Jan 2019 11:31:09 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 03:31:08 -0800
Date:   Wed, 2 Jan 2019 14:30:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Aymen Qader <qader.aymen@gmail.com>
Subject: Re: [PATCH] rts5208: fix a missing check of ms read
Message-ID: <20190102113047.GL3781@kadam>
References: <20181220200002.29685-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220200002.29685-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=905
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 02:00:01PM -0600, Kangjie Lu wrote:
> When ms_read_extra_data fails, the data read in "extra" buffer is
> just incorrect and thus should be used. However, "extra" is used
> in multiple places no matter ms_read_extra_data() fails or not.
> The fix checks the status of ms_read_extra_data() and returns with
> an error code upon its failure.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

