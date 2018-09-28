Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18340216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIbUSsnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18340216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeI1Oiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:38:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1Oiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:38:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8S8DniY038469;
        Fri, 28 Sep 2018 08:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=R6iNgq3nTGQBT6FK2Le/cmD+556UncVXUnDzUjyx3ys=;
 b=hIbUSsnuHyQEsb3ZVvyrnVVMgUhto4x/fKGQj84eXIwMO/8GQY+eCmeeh/xD/725HCDa
 azTPM8ndCZQWkhZn4LQRLGWz21vybBRwi5EnGLIrxyqO0zV+6bwVna/rvOI2V/oRY2Uc
 iY28ZG1YDPw5knfQxcxoVscwq2KC3uBnSMOwvlSAvscxl2fndO9pWH1HO7kbb8BFgbPa
 SmEL35Dw/WSkUs8upNFeSuX+q8AxcaEr38O7Rq+c4JCz80Zs8kUe3f8BonZL/RQUBjze
 nhOAxcNzb/APxY5bhH8ZEUZzCBOQ/SA5jJPE9rAE+PkQvDLRB45wFpjfn32AB8QT5OVm dg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mndppxfk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:16:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8S8GAEC032433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:16:10 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8S8GAOg007471;
        Fri, 28 Sep 2018 08:16:10 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 01:16:10 -0700
Date:   Fri, 28 Sep 2018 11:16:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] staging: ks7010: Add null pointer check for skb
Message-ID: <20180928081601.is2gl764krxcvtlv@mwanda>
References: <20180927151614.25470-1-qader.aymen@gmail.com>
 <20180928081325.krgawue3cs6mavw2@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928081325.krgawue3cs6mavw2@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=845
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, if you have the cross function DB built then Smatch says that the
NULL check can be removed here no problem.

$ smdb hostif_data_request
[ snip ]
drivers/staging/ks7010/ks_wlan_net.c |   ks_wlan_start_xmit |  hostif_data_request |  PARAM_VALUE |  1 | skb | s64min-(-1),1-s64max

regards,
dan carpenter

