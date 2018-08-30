Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24566C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E8D2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="445WuOAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E8D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeH3Obt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:31:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeH3Obt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:31:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UATRRr112587;
        Thu, 30 Aug 2018 10:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bIdZOYBTc0ynKNRpxh45wofJGI0GaYadq68xvus6/lQ=;
 b=445WuOAjnVH1ZgRBA81+qNg+oHcU3mDwLgLpTIHFjrrz0V15JZuo4/Vn85jk+GVG1wtG
 OCV/xS8Xy7kTwLjT+BZix3EY79fvtEVweEqhj9zoM81lxUF+2iyMp2P9lu+jSCXocIQL
 KBDj/pG0P9XWo7YKuvRudBh3fXh/SkEUsYWkT26zGMULH5V23W5e8e+2l6fG2ZYQpB29
 Xg/RVsjuDzEOfm5Roiz+kQ7tyQfz/kp6cDh77bR7MSqLAwZ/QNZ1AnU8OaOppjZ7E9c9
 ukMhUi8a2c4q1aTdELE/03uKkzphGfVC9qF7bGWjiSiXyA8OUaFmypeHNeuF0kWM9hLs hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhu0s72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 10:30:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UAUEdh030288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 10:30:14 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UAUDSq013637;
        Thu, 30 Aug 2018 10:30:13 GMT
Received: from oracle.com (/10.154.142.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 03:30:13 -0700
Date:   Thu, 30 Aug 2018 06:30:11 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Trivial patch monkey <trivial@kernel.org>,
        Netdev list <netdev@vger.kernel.org>,
        santosh.shilimkar@oracle.com, ka-cheong.poon@oracle.com,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net/rds: RDS is not Radio Data System
Message-ID: <20180830103011.GB20822@oracle.com>
References: <20180830102336.GA21063@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830102336.GA21063@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=556
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/30/18 12:23), Pavel Machek wrote:
>  config RDS
> -	tristate "The RDS Protocol"
> +	tristate "The (Reliable Datagram Sockets) Protocol"

Can we drop the extra parentheses (i.e., the ())?


