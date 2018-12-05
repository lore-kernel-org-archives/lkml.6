Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2C42081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yZWvghjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2C42081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeLESmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:42:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:42:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB5Icp62094394;
        Wed, 5 Dec 2018 18:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Tz+2pvb7xdW8Hwyblb2sWz4u7iqRF8eO0XF/+KukXtw=;
 b=yZWvghjTPbtIB5ODkreEZq8yj09sh0d5GxPFOB7ZcNLAA8RMWx0nQXuzVOqr5zCCbXs2
 GsGYXeifaXyffp7f1LlF6oqXVHK0Otsgvl1qsIARUv8bZWFwHQJ92B2mPWTguG2i0Fz4
 TLvwbxowDQbdSP1kg5sRcjBOMPs/PvMt7+WsCjSxmrc7+HP/uP4LqtoW6mtPXU43wiyT
 77mbWJ1XGQvbpophu2Ozd762vtlu1i0cScs+WKcavvwEaXVDnj1G01zIxAjKIat53lj/
 ICzEOi0Pe+oXJFdO/gF6fPkfk5djY9JfVRDLJB7wGf1y5ENTSB9Rr6v9syhyKynT3gYl Og== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p3jxrm3n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 18:42:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB5IgHEg030979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 18:42:17 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB5IgGWl028600;
        Wed, 5 Dec 2018 18:42:16 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 10:42:16 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 383B06A00FC; Wed,  5 Dec 2018 13:42:15 -0500 (EST)
Date:   Wed, 5 Dec 2018 13:42:15 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] x86: remove Intel MPX
Message-ID: <20181205184215.GB13232@char.us.oracle.com>
References: <7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de5232f-4bc1-5c85-00d5-cb646462577f@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=879
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:44:43AM -0800, Dave Hansen wrote:
> Hi x86 maintainers,
> 
> Please pull from:
> 
>  	git://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx.git mpx-remove
> 
> There is only one commit, removing the Intel MPX implementation from the
> tree.  The benefits of keeping the feature in the tree are not worth the
> ongoing maintenance cost.

Is there an replacement or another way to use this feature?

Thanks.
