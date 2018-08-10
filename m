Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7946BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6022453
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TS8IXeVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B6022453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHJVS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:18:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeHJVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:18:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7AId7Ps105116;
        Fri, 10 Aug 2018 18:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AVC0vwY7RkcttaX++Ms3UmIPuuqPKTUz9SDLuq5UiqA=;
 b=TS8IXeVkY+6te7SVZLqYYJNWXxOsjjhTmw05HBoaub9FGZeJh+5KIgUpxLoHokpfdRdo
 JfNQrT2cPiwyHboyLyczquap5MsIdlxPjZGHOXFoOasOpCX2y6W44VRKpXylBsdTgymr
 jzFLZkMJb5O3GdEiZdqFmjViKw2cZXgRIUcWX5+h+ME1za/1oVrIC6nzu2NRZBzmrmf3
 +Jjs/eAZuRC1I5tEOXFhp1R4O/hP+LouLRK1L59ync66HN8jhG3fi5XvtKOCuKHxxBdv
 UhUcrQ5wrwQi+H6Q6i1xoCY12eKuHOIyaA1MHOn0teYxCs+nL+LdzR8OaSfilR86VpDY 8g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kn3jtgm56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 18:47:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7AIllWM005102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Aug 2018 18:47:48 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7AIllGU009396;
        Fri, 10 Aug 2018 18:47:47 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Aug 2018 11:47:46 -0700
Date:   Fri, 10 Aug 2018 21:47:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] staging: rtl8188eu: use is_multicast_ether_addr
 in rtw_security.c
Message-ID: <20180810184740.g22cklpox4lcj7jc@mwanda>
References: <20180810105133.31224-1-straube.linux@gmail.com>
 <20180810113132.p3go5yduhyz6cr65@mwanda>
 <76d01501-e2b2-8f98-724f-8d4c326013e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d01501-e2b2-8f98-724f-8d4c326013e4@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=551
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808100201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 08:21:23PM +0200, Michael Straube wrote:
> On 08/10/18 13:31, Dan Carpenter wrote:
> > No no...  I only gave it a Reviewed-by tag because I didn't want you to
> > resend again...  :P
> 
> Ah, sorry. So I shouldn't have added the tag?
> Should I remove it again? I guess not..
> How are those tags (reviewed, acked, etc.) handled normaly?
> I'm a bit confused now. ;)

Greg adds it.

regards,
dan carpenter

