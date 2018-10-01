Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC8EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C9C2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uLaNxIhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C9C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeJANqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:46:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeJANqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:46:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9174Oxj176554;
        Mon, 1 Oct 2018 07:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mVptqbPN0aMqW3DC010KGC5Oy0NCDhopuLfxaBmpMcM=;
 b=uLaNxIhEpG9PFreD7Qsf4d6YLzNl/pBZ1jTYr/VCNj6DHpTtsYOoaDBRJLpyUmPXvntu
 QOLBLQ69lJSttJaa3cJ4vWdnIZ/Tlx7Imd9vThyEtgA3RyhsmgiFLws7b0cJI3YaMLA9
 RS6Fp4CEhAyUo13y9dlGXUXtCYZUdkj7SWBhfxdNUsbsnvwTbd/fs+3YOaCOcybhQ89V
 4YQhJaulzaZP3SRUPmBb0oHFm/GD9gD9HOnoyp8ObSJEe5dkuyXvPd7/UfKKJbqZm66E
 J0e8VtZ/qF0qpKqIX3M5jSqzqwF5BK+LhlHgoPn49Mnb7QasdkXA5EDb4ofxz+mDsLrH Qw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mt21qn14j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Oct 2018 07:10:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w917A2k6018697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Oct 2018 07:10:02 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w917A2Yg025530;
        Mon, 1 Oct 2018 07:10:02 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Oct 2018 00:10:01 -0700
Date:   Mon, 1 Oct 2018 10:09:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maxime Desroches <desroches.maxime@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Staging: rts5208: rtsx_card: Fixed multiple coding
 style issues
Message-ID: <20181001070956.uimxrdbvg4dyhbel@mwanda>
References: <20180929044431.24540-1-desroches.maxime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929044431.24540-1-desroches.maxime@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9032 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=751
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810010074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 12:44:31AM -0400, Maxime Desroches wrote:
> Fixed multiple coding style issues
> 

Too vague.  Also inaccurate.

regards,
dan carpenter

