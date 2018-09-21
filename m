Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C526AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8A21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="smV539L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B8A21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbeIUNvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:51:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:51:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8L846Qu118148;
        Fri, 21 Sep 2018 08:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Pk9BmheqWGOwcEvbZUoUkHcmmDR3rja9rGd1XO2j54M=;
 b=smV539L7ZjGB7CXwlxXgFyPCm+fr3Bvhh9dthKLJyN9ViVK+yNGDUXGYZCYPK7enzioH
 ihcSKR9zRkeKfpueqyplsx/IiNpVFvUpbZqaa65GLeP7FSSDS2IVGugs0V2TEVppR8sI
 U5lkuvMo35tLtpb3pNeOoGcxPhlFb0TXPiEA6mQdV94h4SsamAO3UZRdUjQydE6xj948
 YePqJyDImJ11hUVpiNRTRXoii5IEKG5lDbuhjmL4Tz6x/LuzaF1drsNX31S+vacZoT8I
 z3er+d3cPuyZ0OAB6vPb9oloaNGGOChA7X6gK52Bk7s4JLdsXKQWeqA8nXRIAkvikp6H Sg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mmkm21mbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 08:04:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8L841Rd016290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 08:04:01 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8L840gA023900;
        Fri, 21 Sep 2018 08:04:01 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 01:04:00 -0700
Date:   Fri, 21 Sep 2018 11:03:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     valdis.kletnieks@vt.edu
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Aditya Shankar <aditya.shankar@microchip.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Remove unnecessary pointer check
Message-ID: <20180921080351.ckw727xyznzwemuu@mwanda>
References: <20180920212648.25181-1-natechancellor@gmail.com>
 <32473.1537507532@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32473.1537507532@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:25:32AM -0400, valdis.kletnieks@vt.edu wrote:
> On Thu, 20 Sep 2018 14:26:49 -0700, Nathan Chancellor said:
> > Clang warns that the address of a pointer will always evaluated as true
> > in a boolean context:
> >
> > drivers/staging/wilc1000/linux_wlan.c:267:20: warning: address of
> > 'vif->ndev->dev' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (!(&vif->ndev->dev))
> >             ~  ~~~~~~~~~~~^~~
> > 1 warning generated.
> >
> > Since this statement always evaluates to false due to the logical not,
> > remove it.
> 
> Often, "just nuke it because it's now dead code" isn't the best answer...
> 
> At one time, that was likely intended to be checking whether ->dev was a null
> pointer, to make sure we don't pass request_firmware() a null pointer and oops
> the kernel, or other things that go pear-shaped....
> 
> So the question becomes:   Is it safe to just remove it, or was it intended to
> test for something that could  legitimately be null if we've hit an error along
> the way (which means we should fix the condition to be proper and acceptable
> to both gcc and clang)?
> 

Obviously, we hope that Nathan considered that.  This driver has new
competent maintainers so they would think about that too.  I also review
staging patches and I reviewed it a few minutes after it was sent.  So
it's not like anyone was going to just merge the patch without thinking
about whether a different test was intended.

I am on the kernel-janitors and we've had one or two of these recently
where the warning indicate a bug so perhaps we do need to think about it
from a "process perspective".  The Fixes tag isn't appropiate because
it's not a bug fix, but we could just say in the comments:

    "This unused variable was added in commit 123456789012 ("blah blah")
     so far as I can see it has never been useful."

That would help reviewing because now I know that you thought about it
and I also can just look at the original commit.  For this patch I did
git log -p and the scrolled to the original commit, and the function
name had changed so I had to scroll back and forth a bit to see what
the function was called originally.  It wasn't a huge deal but having
the original commit would be nice.

regards,
dan carpenter

