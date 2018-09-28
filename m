Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11759C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CC82172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FC9TiC7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CC82172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeI1Op2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:45:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48926 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbeI1Op2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:45:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8S8DTpB038176;
        Fri, 28 Sep 2018 08:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3xn6yw8lSmCv4/je5JrcV5HwQfi7xgQ/Y23fH5ynGfM=;
 b=FC9TiC7JU09h27JIrsftECyJsHzEYgUzxbflIatQtkg7rKSNIdiSWvY5Tu/lv2OACjFH
 MLkBi53xzibcWYI/JKrGac4ChIbd29mOaM7pW1Z0z4N0MPHXBvCycKPuyvgy+ZuXKauc
 o0IzAO7SBnIFwRIWmqVW/TnW9JvRImGYq0lq/oGc1kCSIvRmICDeczDndyWIiHsDgIAm
 2wbXchckS9IfAewHkD6ZuuALOmwzF3XeO/Cs5A4OXbBhh3Nm0zXYBy8OtIBDou3SVpkm
 Zpe1kNPuybSd6kiOorNrTr7JUNxRAINuPBteANu8E+wTTDRWK/ujGKm2Jmjd5x4bP6Jb nQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mndppxge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:22:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8S8MjKe002471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:22:46 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8S8MjTJ007123;
        Fri, 28 Sep 2018 08:22:45 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 01:22:45 -0700
Date:   Fri, 28 Sep 2018 11:22:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: ks7010: Add null pointer check for skb
Message-ID: <20180928082239.disbtllum3duvdcg@mwanda>
References: <20180927151614.25470-1-qader.aymen@gmail.com>
 <20180927180443.yjqycqa7jir6rb57@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927180443.yjqycqa7jir6rb57@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=797
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:04:43PM +0100, Aymen Qader wrote:
> Retraction: in hindsight I see that with the current usage of this
> function, there is already a check for the socket buffer so this check
> is unnecessary. However, I'm not sure if it's considered good practice
> to keep this check anyway--in any case, ENOMEM isn't the right error
> to return.

When we find inconsistent NULL checks then we fix it to make sense.
Generally, we prefer a minimal style, with no extra code for future
proofing.  (The future seldom goes the way you expect and those extra
NULL checks would be easy to add back).

So, yes, do remove the NULL check but also fix the indenting while
you're at it.

Take your time to write patches.  I write them, then I sit on them over
night then I send them in the morning.  It means that sometimes other
people have already sent it but that's fine.  If you have to redo a
patch then don't send the v2 patch on the same day.  v2 patches are
stressful and you imagine that everyone is waiting for you to send it
or something.  We are not waiting for you.  We don't care if you wait
until next week to send these...

So when you write a v2 patch wait until the next day to send it.  Then
you will be calm when you review it.

regards,
dan carpenter

