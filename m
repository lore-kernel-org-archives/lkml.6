Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7431C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409524156
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="izX5UxoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409524156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeGEIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:20:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54802 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeGEIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:20:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w658J7s8169089;
        Thu, 5 Jul 2018 08:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=R57Bija1o6aBcC+WGjhhp9tzcMPdC9xk4O81h2Tgpqo=;
 b=izX5UxoXBPYmZsgy1IdQRioYPeKhKXEeM4DdzY0Nd369Mp6Fm5imcBPgCjJ9k3qhaSbq
 jVMo0W/bY+EVZolkQQ/RCCwUGNqoaI23TYAjwbK8ZxVum5L7mTwy2uY1eSRbZnJj3sHH
 34uyrU2OjowasADp97O5riQfO2T/refnVdkRpKJwezFuw3dODod9/4hZ4fC54APgp5MB
 1ra3PXR/oZghbpQ2XDl445TFm3336pU9q1P54bsEdL4a05dv4esdFl+SnJgZPKKDy3+G
 0LNH1Qm4UNQO37+NEgKOgPT+2rJwUoMK0VRoxnt7JGztwqMLuqML8p2CfiXFEf7CXJPG 0g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k0dnjcuhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 08:20:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w658K42m029429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 08:20:05 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w658K3Jl014661;
        Thu, 5 Jul 2018 08:20:03 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 01:20:02 -0700
Date:   Thu, 5 Jul 2018 11:19:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        apw@canonical.com, Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <error27@gmail.com>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Israel Schlesinger <israels@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>
Subject: Re: [PATCH] checkpatch: Add warnings for use of mdelay()
Message-ID: <20180705081953.pmvpmtzm273eb6yk@mwanda>
References: <1530728333-31590-1-git-send-email-pheragu@codeaurora.org>
 <173cc189627e0d6618b535fcd1ce6a4c90ce2ad0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173cc189627e0d6618b535fcd1ce6a4c90ce2ad0.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=715
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither Smatch nor Coccinelle do a good job tracking when you're in
atomic context.  I've wanted to add this to Smatch but even then it
would be to warn that "We're holding a spinlock so we can't sleep".
It's trickier to say for sure when you're not holding a lock...

regards,
dan carpenter

