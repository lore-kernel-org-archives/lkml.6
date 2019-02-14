Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A512229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xDjXhl4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437250AbfBNHh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:37:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55990 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBNHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:37:56 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E7Y2PW022890;
        Thu, 14 Feb 2019 07:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=OUrDxgUXxOed/njM5tA6OMlBtcETW0o6JtRct/Cp5T8=;
 b=xDjXhl4/WXeOZW3g99YOjjq6+RXgEzOF70+PEJkILF+FiAX78Ktg/WkERKgAQmFfqsw2
 F4tIFBjZeWy2WA//7QPREyQS1yXWjJdVC80egfmgCVRS6GAFcpGjBa+k1l03umom0qYF
 6zZF9l9ODI1F70aIn4TN5ReaCWhkF8rLwY0W3N32sbkb6hhPtlKVN+piPbwJWnZqUhnx
 Wd7hO+EH7EulY1J0HPsptCe+cHmlXr0So6IxRhPN8ylDXmjSeTcJCbrHuCs46N1HUr2s
 NC9SDXnMpIBx3lOifchuyPb2jWD3+RydJ4VOZcAxAc9jRRANEiL2jSX9Uc+OoxJP3dnj AA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qhre5p9xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 07:37:43 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1E7bgkG014983
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 07:37:42 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E7begE005640;
        Thu, 14 Feb 2019 07:37:41 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 23:37:40 -0800
Date:   Thu, 14 Feb 2019 10:37:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@telemann.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/coda: get rid of CODA_ALLOC()
Message-ID: <20190214073731.GB2304@kadam>
References: <20190214065848.GB21768@kadam>
 <alpine.DEB.2.21.1902140804170.2466@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902140804170.2466@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:04:43AM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 14 Feb 2019, Dan Carpenter wrote:
> 
> > These days we have kvzalloc() so we can delete CODA_ALLOC().
> 
> Maybe it would be better to get rid fo CODA_FREE as well?

I feel like that's a separate issue.  The CODA_FREE() macro already
uses kvfree() so it doesn't bother me as much as the CODA_ALLOC() macro.

regards,
dan carpenter

