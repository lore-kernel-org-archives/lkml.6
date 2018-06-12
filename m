Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF17DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AEE208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HSxnFF7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AEE208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933548AbeFLLu5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:50:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53576 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754299AbeFLLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:50:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CBkAL9132801;
        Tue, 12 Jun 2018 11:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=Eiz6F8v714qmX2pfN+Bqzjkuvp8aD5p4rZwLTdVKEMI=;
 b=HSxnFF7NcjQEO4WlxqTT3A3FfSzJ83iesjSRJLp1tu/C4rVsUnIAvuxzgN7VyOTWBceA
 kJazDJPGewyK4J2DjZKN7F6CG/uzYoPFgNTnOQbeez8t+lkoE69tY92nVIWmQnxz+knk
 yeafFs+ydjEGv/Xcd9RkT3H5xzL5ToEMRS7pIc0X7E7+65P1/cmaK7j56/RHVDRLlVs/
 rYG1CSZdNYXVi+BRJ6KDg/Pg7/GWCZuvxP0AlpMZXB5Fj2UrARupWgqoSxfc9TFekkwt
 WMFJWbSaWRApQL/J8eJfggr1ipXaT3osItYoVY9NOUAcmwCfGxZCpeDQIa1BP0R5/XJq yg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jg4dm1u53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:50:49 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CBom4K011712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:50:49 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5CBomcL026814;
        Tue, 12 Jun 2018 11:50:48 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 04:50:47 -0700
Date:   Tue, 12 Jun 2018 14:50:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] staging: comedi: add error handling for vmap
Message-ID: <20180612115039.sz4zjgf7vrudpvyx@mwanda>
References: <1528773937-38106-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528773937-38106-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=671
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:25:35AM +0800, Zhouyang Jia wrote:
> When vmap fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling vmap.
> 

Again, this is not error handling, this is just an error message.  This
error condition is handled in the caller.

regards,
dan carpenter


