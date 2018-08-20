Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1564C215EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZbyTXb11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1564C215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTMwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:52:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:52:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7K9Xjvj028981;
        Mon, 20 Aug 2018 09:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=eeu32JaqIlqknw7ZI4YsAZHTcR5AuHoAPFlNIySW/Fk=;
 b=ZbyTXb11v4aJZ6ZcVs48uWZaqjhb1ipqtgCGuvcgU+mds4FykVyLdo4Q366TsNBFy/Ij
 h6SN8pGTlsBmcacofLI3/EIXRJjky9liGTPQyboug3MOxN1kpz2JGbrV7hPP7CWk7j9c
 v4o0rL1IjiKaf06elPBKASfPyJmi7Xa74xuR66pX+ea0a5R30j42HrS5L61la1//IMY6
 lRdjePUdNsZQk1xTtMkpFkGF5QO9tX4rqvaZkQV1OYCJmiVcT+i2qLBpx8Z/fI/OxIMb
 ISDdyQelYEDdKX6t6evW/0SNsUNTuAL2BsEB/GvC/EhoAYYUmLSB+JwlAoTWTg9a/TfP cg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kxavtdam3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:37:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9bJec011685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 09:37:19 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7K9bJeD016347;
        Mon, 20 Aug 2018 09:37:19 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 02:37:18 -0700
Date:   Mon, 20 Aug 2018 12:37:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Type cast function argument
Message-ID: <20180820093712.e5qgzyfof732n2z6@mwanda>
References: <20180818142409.GA17122@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818142409.GA17122@Gentoo-PC>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8990 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=409
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 07:54:09PM +0530, Bhaskar Singh wrote:
> This patch might suppress some warrning.
> 

Which warning?  You should find out which program is generating the
warning and delete it from your computer because that is a nonsense
warning.

regards,
dan carpenter

