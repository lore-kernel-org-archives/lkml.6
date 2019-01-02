Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF59C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7592171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8EoxKHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfABK4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:56:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36530 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfABK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:56:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02AsvAA037344;
        Wed, 2 Jan 2019 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CU9h6cODLTfVhuz97Um/hesryVZhwPyCreyjzCmuROM=;
 b=M8EoxKHgRO5of3rjfm3OUaEcLYcxSwPuE/Wz2FtgbBi9ZQBUGGc4z5brOc7FkmdO9U3w
 UA99iSU1PnEI4grFzC/TkeNYGVJqnjKTm52M7gvdz9qjsupRCzg+V5lsZ+nrRTC/qYaz
 8+bALTtwfh97FO9ygRTVr8zggQnItMW4BQVzubHhdhQQgfR+pdiFWAxhxJQNa40lXhQl
 O2Y/FAXHCcvOim1jkAM1d+oxx3gj181nbLidj8IJT1aZlF0WReRQpWnX8hJu3qchISdc
 uLnFk/epTV7JG8tGfqKzgXaOC5RDXEldtHkMI2zAEWBL/rwgw1I8bT0dvZNq57NOBCU9 1g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pp0btsjjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 10:55:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x02Atsqm026676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 10:55:54 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x02AtqKw015850;
        Wed, 2 Jan 2019 10:55:52 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 02:55:51 -0800
Date:   Wed, 2 Jan 2019 13:55:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        David Windsor <dave@nullcore.net>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mm: Mark 'stack_vm_area' with __maybe_unused
Message-ID: <20190102105531.GI3781@kadam>
References: <1545965190-2381-1-git-send-email-yuehaibing@huawei.com>
 <20181228085804.GR16738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228085804.GR16738@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:58:04AM +0100, Michal Hocko wrote:
> On Fri 28-12-18 02:46:30, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning when
> > CONFIG_VMAP_STACK is not set:
> 
> Isn't this warning disabled? I can see the following
> # These warnings generated too much noise in a regular build.
> # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> KBUILD_CFLAGS += -Wno-unused-but-set-variable
> 
> in the main makefile. IMHO this warning doesn't really give us much.
> 

It would be nice to enable that warning.  YueHaibing and Colin King have
been whittling away at the problematic code...

YueHaibing, how many of these warnings do we have remaining on an
allmodoconfig?

regards,
dan carpenter

