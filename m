Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E9B54C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA312086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sEYenTIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA312086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeFMJae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:30:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeFMJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:30:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D9Q2tB114346;
        Wed, 13 Jun 2018 09:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=+KO80sweRiaYxSSDYP2FDj3IBQ4noPPmLqxtHwWRQ7A=;
 b=sEYenTIareRtSzPxwhF4TdZi+SEXnc1rt2oCRAUQw+ZtTLknQpW1VkzbMIXoqGf0wkUj
 UtcbvdSYO575TUXRY3aVdlJVcyDHqFyHyuv2Ari3u2C+qZYZblv1ajf2Jz+Wt4RGysnP
 SNG6/amnuRXgnhN6EEdtfebmJo40B+8YYLq9yQckzWetsEtlJKhBvGQ/g5VnZgZULP1u
 mN6HKRgtCjrrBlrJFsyJTuPiy6fBDNxw9DQCsnbv/QBH13RPsnPCpzet86Lbdmjlu9kY
 17107cCNDQI2koT53xpbkLp7yFRH6DOt6eKcMPlof1EBCkYB4MMQAPR+xi5DQRsqMNOE jQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jjp6bsmyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:30:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9UGG6007879
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:30:16 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9UFZx029919;
        Wed, 13 Jun 2018 09:30:15 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 02:30:15 -0700
Date:   Wed, 13 Jun 2018 12:29:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180613092955.vc5impf46prhcur7@mwanda>
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=791
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sooooooooo close...

On Tue, Jun 12, 2018 at 11:09:44PM +0200, Chris Opperman wrote:
> Changes since v3:
> a) Reverted u64 to unsigned long long and u32 to unsigned int.
> b) Added patch versioning.
> c) Changed type of scans_left to unsigned long long to avoid cast.
> d) Clarified and updated changelog.
> 
> >8-----------------------------------------------------------------------8<

This part here needs to go ...

> 
> Improve readability of comedi_nsamples_left:
> a) Reduce nesting by using more return statements.
> b) Declare variables scans_left and samples_left at start of function.
> c) Change type of scans_Left to unsigned long long to avoid cast.
                          ^
> 
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
> ---

... down here, under the --- cut off line.

>  drivers/staging/comedi/drivers.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c

regards,
dan carpenter

