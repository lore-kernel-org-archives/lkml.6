Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF35C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C2020824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1wrop78m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C2020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJXOqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:46:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJXOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:46:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O6J7Hr037571;
        Wed, 24 Oct 2018 06:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Tr006XsgLxTKXjxaNhOVMieo5KOjmMOyI1ZgsoypwMA=;
 b=1wrop78mboP2VwRAohBv02kDknnIzVtqpujbwyS7njTTEy2S910+YFeScl5AN2uLiYUQ
 qglBsEEnAit/r0f23NHta+mTejCKaL5TghYcqf+XbKZQ0aRqFU8ZLAT+uha6pS0nphCy
 poK7MzahWNj6ElcLlFsZ3H0UJdKgnw06h3OWiYvKzyJpQLjUabusVlPaLArjr/K4PpRE
 N8V1Ux7SispHN3+sOSxCLLsQPgCzkjHjWp/fzN6EkymT2tYa8WhZtnFUgZJfBXESuVP/
 ei/Vxzqp40rmAD8Glkasz9sYsU+3FnpvXmGAk4XkIL2arrH0x03yws3lCygwrlFD9wan Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qsc3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 06:20:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9O6Js6C027509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 06:19:54 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O6JrLZ017740;
        Wed, 24 Oct 2018 06:19:53 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 23:19:52 -0700
Date:   Wed, 24 Oct 2018 09:19:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "kbuild@01.org" <kbuild@01.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "mehta.salil@opnsrc.net" <mehta.salil@opnsrc.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH net-next 6/7] net: hns3: Add enable and process hw errors
 from PPP
Message-ID: <20181024061931.6tp4skg5tspxy4o2@mwanda>
References: <20181019191532.10088-7-salil.mehta@huawei.com>
 <20181023112852.4pmcezetrudduvna@mwanda>
 <F4CC6FACFEB3C54C9141D49AD221F7F93BF51DF4@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4CC6FACFEB3C54C9141D49AD221F7F93BF51DF4@FRAEML521-MBX.china.huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:37:35PM +0000, Salil Mehta wrote:
> Hi Dan,
> Thanks for letting us know about this. We have a fix for this
> but I guess now net-next is closed and David might not accept
> the fix for the below problem. It looks problematic case 
> might rarely hit so we might be safe deferring it for next cycle.
> 

New features and cleanups should be delayed during the merge window but
one line bugfixes are acceptable.  Just send it.

regards,
dan carpenter


