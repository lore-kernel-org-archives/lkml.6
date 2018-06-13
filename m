Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2A0DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zi3Lx8kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935426AbeFMTGI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:06:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56180 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMTGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:06:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DJ4YJn188166;
        Wed, 13 Jun 2018 19:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=BHEv6bNyxIijQm9w5Ivp0quzKePXMwDo5Xb9HJZ8ps4=;
 b=Zi3Lx8kjHL0PuR67bQPRXTA20LUkeEbx9/c6u6rrvE4pUDMfdjxQw3r5BhUp6+OfIrQi
 SffXk5G2Pbv7QU7Kkzd6hiOuE+pRFGcxz0Uu1pMWVUP/mXmYYQJADFOCwKCmCDu+fhi2
 XJIHUpk6kyYhhMd7UwoLXyG2BmBboUunJvo2AmAx3VXJQwJ7KBtjulDzhhrDBeElGpoo
 5xCS9goFZVYfKdu1kAe+Mnu7VGyKFlhM9sDLKxyXK9+HpPTPWFowHcYBINmiWOloMTa5
 UBnI/CuoPUbtJDV172BtyPKIsKqGmvBehYMFxZngwXkMvlyy4mIqiZHqumTdnCGxEHCj Qw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jk0xrj244-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 19:06:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DJ60Ds026444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 19:06:00 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5DJ5xos013107;
        Wed, 13 Jun 2018 19:05:59 GMT
Received: from mwanda (/41.210.141.4)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 12:05:58 -0700
Date:   Wed, 13 Jun 2018 22:05:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     devel@driverdev.osuosl.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
Message-ID: <20180613190549.ugl43yee4f3thk4t@mwanda>
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
 <20180613092955.vc5impf46prhcur7@mwanda>
 <20180613182643.GA14100@kerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613182643.GA14100@kerdev>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=293
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 08:26:43PM +0200, Chris Opperman wrote:
> Hi Dan/Ian,
> 
> Noted your comments regarding additional text, thanks! Just curious whether 
> the "scissors" format given at the link below is valid? 
> 
> https://kernelnewbies.org/PatchTipsAndTricks
> 
> It is given as an alternative to placing additional text below the
> cut-off line.
> 

Try it yourself.  Save your email as email.txt and then
`cat email.txt | git am` and then review the patch with git log -p.

I've seen people do the scissors thing, but I assume the maintainer has
to hand edit the log which we refuse to do.

regards,
dan carpenter

