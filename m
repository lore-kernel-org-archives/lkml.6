Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC44421534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pq5AJPmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC44421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHTQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:32:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHTQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:32:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7KDDdYx193379;
        Mon, 20 Aug 2018 13:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=10utMaDlP3wRVWgdgnmhN6IsAwm3NVoWIvDwnatIHZc=;
 b=pq5AJPmIsh62LLOHfEdpk9zOl0cFYMD/h6yhr7ehO4g+O4LlNEILLuPTQL887hg6F4lu
 6V9T34+ALgk/BVf3xvW8U3679C615FwoW28D2Ue71GJjY7uWDXwbFhKf7BVsf8ps99rk
 b39zYqHspkXeZfYigLjQ3dqgklEzrq/i/pb+2xxYJctE6V+gMQEmwYpOodzna8fVBEKM
 fsscvrSKKCO8FRh2F35ZOXsbpUTXWKFOsw3N5aCr1injkZjlVGQ777LEOYXTVphuSHPL
 TC8MgL0Ba+IfNwUa3c4Pv3PBnGcKRTE/h37ZUiAex+AYjXlf+N04Tahu/6GYPwDTIyi0 hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3qe5xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 13:17:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7KDHB63029024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 13:17:12 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7KDHBno021588;
        Mon, 20 Aug 2018 13:17:11 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 06:17:10 -0700
Date:   Mon, 20 Aug 2018 16:17:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Removed code valid for 5GHz
Message-ID: <20180820131703.jjib3ehmzs57dfni@mwanda>
References: <20180817074729.GA16204@Gentoo-PC>
 <20180820095042.pgucu7e3i3aiu3lb@mwanda>
 <20180820125539.GA1597@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820125539.GA1597@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:25:39PM +0530, Bhaskar Singh wrote:
> On Mon, Aug 20, 2018 at 12:50:43PM +0300, Dan Carpenter wrote:
> > On Fri, Aug 17, 2018 at 01:17:29PM +0530, Bhaskar Singh wrote:
> > > This patch removed code which are valid for IEEE 802.11a i.e. 5GHz.
> > 
> > I would be uncomfortable accepting this kind of change without an Ack
> > from the maintainers.
> > 
> > The messes up the indenting so we can accept it anyway.
> > 
> > regards,
> > dan carpenter
> > 
> 
> "find and remove remaining code valid only for 5 HGz. Most of the
> obvious ones have been removed, but things like channel > 14 still
> exist."
> With due respect, I want to say that, the above thing is mention on the
> TODO list, please correct if I intrepreted that statement wrongly.
> 

Yeah.  I think you interpreted it correctly.  That seems fine then.
When I realized that we weren't going to merge the patch then I stopped
reviewing without looking at the TODO.

When you resend the patch, please quote all the relevant information
from the TODO so that we don't have to look for it:

    This patch removes support for channels > 14.  That is from the
    TODO which says:

	- find and remove remaining code valid only for 5 HGz. Most of
	  the obvious ones have been removed, but things like channel >
	  14 still exist.

regards,
dan carpenter
