Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED952C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9413E217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pblJbIzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413E217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeHEMX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 08:23:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40266 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEMX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 08:23:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w75AEUmn175502;
        Sun, 5 Aug 2018 10:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1IKAyi/5iKq8ZvfEzBm6fh2VMpfOTOujCZYs814SpLA=;
 b=pblJbIzC6gwuug0E2kIhqwJwqLxam289aU4l+P39KpshQa9TBu7Se6CzEoQcb4g2DPyz
 liyKUbuJdv5l4Obr25IchURfaCIdR75nMmbGIlViuVJL8WkGJ/F/D1Vsi8OqgmzmSV44
 pa2z6/2gcQ9YxlXGNRSyf7ibuDLTDv3OHJ1UDWxajgIkkBfT4JhZn1sU7qevKzKTGQIF
 qMSAgHZ+X3dRbyy/uJBTWx/PP/mnkArH6k0l7bSSZ+nGchecR3E+XZCkn2TGkOJNrDS8
 wnSe7AhPZwRhsGK8BRU9qZn8jVPMW8+A7df91ZGpyZ421T14V5lwFTN8p3noNuMTL8Ht 8Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2kn43nj22t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Aug 2018 10:19:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w75AJoRI004232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Aug 2018 10:19:50 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w75AJo4g006791;
        Sun, 5 Aug 2018 10:19:50 GMT
Received: from oracle.com (/10.154.190.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Aug 2018 03:19:49 -0700
Date:   Sun, 5 Aug 2018 06:19:45 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     santosh.shilimkar@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>
Subject: Re: [PATCH] RDS is not Radio Data System
Message-ID: <20180805101945.GA4056@oracle.com>
References: <20180805065920.GA8968@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805065920.GA8968@amd>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8975 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=952
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808050116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/05/18 08:59), Pavel Machek wrote:
> Getting prompt "The RDS Protocol" (RDS) is not too helpful, and it is
> easily confused with Radio Data System (which we may want to support
> in kernel, too).
> 
> I wonder if option should be named NET_RDS, instead?

RDS has been around for a while now (since 2.6). How will you
rename proposal manage backward compatibility? Why can't you call
your new option CONFIG_RADIO  or similar instead?

Are we going to rename NFS* to NET_NFS* because someone decided
to reuse the NFS acronym? 

> And this sounds like a good idea:
> -	tristate "The RDS Protocol"
> +	tristate "The Reliable Datagram Sockets (RDS) Protocol"

surn that sounds fine.

--Sowmini

