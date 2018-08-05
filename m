Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35804C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D944421782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZW3I+3FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D944421782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHEN2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:28:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43022 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:28:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w75BNirF019452;
        Sun, 5 Aug 2018 11:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fjdL3WjXWmoO4fl8bQcAimlXG5w2OUUL6GQuRcpXYmY=;
 b=ZW3I+3FBFEHvRiNQIbskGqmMAt+OUpeIwsXU23FIzksB7bcjBPX9aghL+yf6OEbxto+z
 uKM+98xSJ94+FoWwar6nZw/t6F95w/FKlAjeX+lWglYxD/bwucFdDvUh0o8D1eWCxg4o
 PYlMnzfYS5h9QFAVvCTcfCB/K9WZW1SQwldb8NW+GEUOYhebsUm5ZriUlbRiDcuZdQ2N
 q2YzLtGK+xXV3d/RgbsxJwMBhmDH2FHlPKe8h2q+yZe7SLpyIeTu2L/n/u11JQioTNK4
 PjA4NJvaqX8YLZ36HaceaevRy40g4dRgjkPg0jg8yPT7yiizahjCJt8U3xfzjlLWV0Fo Ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kn43nj40f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Aug 2018 11:24:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w75BOSiI028362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Aug 2018 11:24:28 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w75BOREX020776;
        Sun, 5 Aug 2018 11:24:27 GMT
Received: from oracle.com (/10.154.190.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Aug 2018 04:24:26 -0700
Date:   Sun, 5 Aug 2018 07:24:24 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     arnd@arndb.de, gthelen@google.com, jgg@mellanox.com,
        santosh.shilimkar@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: [PATCH] RDS is not Radio Data System
Message-ID: <20180805112424.GC4056@oracle.com>
References: <20180805065920.GA8968@amd>
 <20180805101945.GA4056@oracle.com>
 <20180805103756.GA24849@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805103756.GA24849@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8975 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=795
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808050129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/05/18 12:37), Pavel Machek wrote:
> 
> Was it?

RDS was added in 2.6.30: see  https://kernelnewbies.org/Linux_2_6_30

Recent RDS commits may have triggered the observation you note below
(you may have had it disabled by default until now)

> Because this was first time kernel asked that question... when I was
> testing -next. Is this related?

> Can you apply the patch, or do you want me to send it to davem?
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

please feel free to send the patch and add me as

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

--Sowmini
