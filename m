Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26469C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFECF20833
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TF4ASxX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFECF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeH3PeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:34:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeH3PeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:34:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UBTGDW160826;
        Thu, 30 Aug 2018 11:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=aQK+MKLjTTnDMjFxlRAUVxbKCjK3w5VhI6mUVsokj78=;
 b=TF4ASxX2KCPBjUxh4JI7PiQjZgD1KcSKMc4rOPiI7075d58UzMv1lh1RfbWFzotlcks5
 cwgkGrQoVqVLiAhuy/JX2WnGv5PIVaFjILnp4iVMHsbzTGDo82VJMY9qI9E9T7/AtuvU
 WjN3+wD0zPOOzv2eNMoKuTIp7E1tXWRfgI6ZVqVkn+IkYjN5sxX/rotBy35tcJgqM99A
 UDuSID3PYqlOZV+gNEAxOSLm7tAVASnl49z3J4qdjo8J048z7C4UK8oSA7/96A3AcitL
 vb8tre8OBr1H12CFsG/ciRzXk+U89480lxumbh+2o2fhE9nzRquoIZGGO7Dyx9PMTFZv YA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m2xhu10yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:32:27 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBWLcl008597
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:32:21 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBWLvR006913;
        Thu, 30 Aug 2018 11:32:21 GMT
Received: from oracle.com (/10.154.142.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 04:32:21 -0700
Date:   Thu, 30 Aug 2018 07:32:19 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Trivial patch monkey <trivial@kernel.org>,
        Netdev list <netdev@vger.kernel.org>,
        santosh.shilimkar@oracle.com, ka-cheong.poon@oracle.com,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv2] net/rds: RDS is not Radio Data System
Message-ID: <20180830113219.GC20822@oracle.com>
References: <20180830102336.GA21063@amd>
 <20180830113003.GA29794@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830113003.GA29794@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=460
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/30/18 13:30), Pavel Machek wrote:
> -	tristate "The RDS Protocol"
> +	tristate "The Reliable Datagram Sockets Protocol"


Looks good to me.

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

