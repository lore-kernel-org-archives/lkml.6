Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1350C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807D92086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z9GMQezP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfA1Ltp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:49:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43278 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Ltp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:49:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SBijZm011448;
        Mon, 28 Jan 2019 11:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iyfHeBfSVM9YU27pma+qa6+476dwJ1FJGjcVsdOdesY=;
 b=z9GMQezPrZ3jyOqX2Y7Nf50woKqkN8yM0cVViSh2Bptmmy2rrnCPNochJplUOIgQ1YSL
 ikd23TLMYJHlz2GEIsmFFU7Z9cLeKFbhgdOU9K4rNU+pSeGrLqvXKdxXFgXpF3F3GW5j
 uXDkSgfR6sltwN+ySlBprzAvxRLTZZq+jIj/ZCc4nhLMinUnKoPMQbzk05D7FNX+HWrC
 7GPhVl7MUVQF098sCZefOB3cPzu8QO6LekkOr8Xmhf0nZB1MsxmjFd1Er5B8tAFupZZV
 s0q/VEEa5gv673bCEb2nAWeW4qedQ+jviSQFB7yHGPb315Rfkg6SjHlCnnxKqGDWHLn0 Pg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q8g6qwj8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 11:49:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0SBncid006661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 11:49:39 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0SBnbjQ019343;
        Mon, 28 Jan 2019 11:49:37 GMT
Received: from kadam (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 03:49:37 -0800
Date:   Mon, 28 Jan 2019 14:49:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, arve@android.com,
        Martijn Coenen <maco@google.com>,
        linux-fsdevel@vger.kernel.org, maco@android.com, tkjos@google.com
Subject: Re: [PATCH] binder: fix CONFIG_ANDROID_BINDER_DEVICES
Message-ID: <20190128114926.GE1795@kadam>
References: <20190126102320.14120-1-christian@brauner.io>
 <20190128114729.GD1795@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128114729.GD1795@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:47:29PM +0300, Dan Carpenter wrote:
> On Sat, Jan 26, 2019 at 11:23:20AM +0100, Christian Brauner wrote:
> > Several users have tried to only rely on binderfs to provide binder devices
> > and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
> > binderfs and one that was always intended to work. However, this is
> > currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
> > will simply panic the kernel:
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> It should just do a WARN() and not panic the kernel.
> 

Oh...  They have panic on warn set up probably.  Never mind.

regards,
dan carpenter

