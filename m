Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9779EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6673120869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gitwdxfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfBLXvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:51:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54222 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBLXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:51:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CNn51k114262;
        Tue, 12 Feb 2019 23:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=jsSXjS6BZQY5Sga8chtBzP5JreLH+wfybF0eHc+UlFs=;
 b=gitwdxfTDxm/cRpJHgs7ToQG5UmAY6R23YaNPiuvgvAm4dCOp++gdNgRQMDLbQMFgUJz
 eDZtE5GfwOyhx19bqf7IRln0IRx6+uFYrjQiYY1FAcQ5lA7sZZpgZRbKYFHc5XrDODUC
 CpAS0mPzYeW1tWE7WzQjvZ+i4kj3tCBN+BcqkAZZGQTTcoRXxEvByzCSyNgY5vot8+y9
 /QEVsHB6aH8c7B785OnKWJiOUTVqusE8GzOeUolaJP00PJeLwHP/wbYqMleCgRJnc+Ak
 uFt+MDKUv2u+wvvid6UfnTgafj/aINKuw4j3B5tlNEGxFnfHskWi44s+V3pQVMS8+bH6 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhredy35r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 23:50:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1CNomqI025067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 23:50:48 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1CNoln3014869;
        Tue, 12 Feb 2019 23:50:47 GMT
Received: from localhost.localdomain (/108.49.136.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 15:50:47 -0800
Date:   Tue, 12 Feb 2019 18:50:41 -0500
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] xen: mark expected switch fall-through
Message-ID: <20190212235041.GA4463@localhost.localdomain>
References: <20190212203720.GA24175@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212203720.GA24175@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:37:20PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/xen/xen-pciback/xenbus.c: In function ‘xen_pcibk_frontend_changed’:
> drivers/xen/xen-pciback/xenbus.c:545:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (xenbus_dev_is_online(xdev))
>       ^
> drivers/xen/xen-pciback/xenbus.c:548:2: note: here
>   case XenbusStateUnknown:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to for-linus-5.0

(xen-scsiback patch too)

-boris

