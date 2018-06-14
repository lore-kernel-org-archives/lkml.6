Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15796C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53E320864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gxrF9fky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53E320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeFNOTP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:19:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57904 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966060AbeFNOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:19:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5EEIuu5118817;
        Thu, 14 Jun 2018 14:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=gj0nWtW5R/ajAT3h9zSxr66rN/nncsJSAbMhL2J8DEA=;
 b=gxrF9fkyDZLb+GkvAUnR0bwbkSAIt9cYov7T8JhjM44CQ640exHKO+CfcduwCbTUxlyo
 tiOInWBKOfNhhLLvFE+8r4829lV0L2+LvDsIBSAeg68feCFX+zSYGA5SxHAvYulpGbNX
 sLHQcDYg+OMtzCedj+R3UJpVdPsFB+ANxHSRTi9vKH598lUEj7ETzZk5T3tV0ACwfTzZ
 2OWkCZpyTTHterhagmQ1BiGzv4/nGcwaxjkJid3Xg1RTrM/ZWg6wlU1w1f2nK//SKv9S
 G9oPDZz+AB0PfTk1BZ8ptdsHfjSh1JbAwJirluGU84VpKfmnw1Ol01McOJytDQSEGwYo CA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jk0xrdact-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 14:19:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5EEJ9eu009808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 14:19:09 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5EEJ8ME013121;
        Thu, 14 Jun 2018 14:19:09 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 07:19:08 -0700
Date:   Thu, 14 Jun 2018 17:18:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: add error handling for nlmsg_put
Message-ID: <20180614141856.3nifsvsxwxdy5hdo@mwanda>
References: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
 <20180612115525.yg2mnhlcz6ok3dyo@mwanda>
 <CABb2Tx+7E9dxV0=D0t80CPnxfLJpEo0+eNG-c_2XH2tZD-C8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb2Tx+7E9dxV0=D0t80CPnxfLJpEo0+eNG-c_2XH2tZD-C8BA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=639
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also I think the email list is rejecting your replies because they're
in html?

regards,
dan carpenter

