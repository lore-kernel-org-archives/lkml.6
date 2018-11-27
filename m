Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975D6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50875204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qsnkurPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50875204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeK0MSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:18:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36898 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeK0MSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:18:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR1DhPm134717;
        Tue, 27 Nov 2018 01:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xDYgDdLRvWhveJAWFCmRx7K9OmSBKDVIN6Y2eDxvstM=;
 b=qsnkurPysilmn3UJsOCFWO1wIU7slv0z84+qMEOe9HLxhhrSeFlE3r8213Idh0z3hcJc
 iZPKelxekiEFdMuOh3c7kNWw3NY8kNdCpPKVASIbuxc/I/rRa6FODOeNB7n3wik4WWCB
 cZbk1PyUjGI13nx6Cu5I81mWP5EqrxADu4h+QZLHRHwHrlo8d2zjcDsXThxwZ4EHk3Q+
 gwZfgJ9yhlgiXmYRfheIteK1J57Ub2+5A6F/zC3MjTKcQUZIckYadGJ1cAT854wASsRZ
 1PsN3zr+65n7CXfI5JoFivYZMPJOlzFqlJpZ42ef8NxiQdHFIliYbQXAEMSc8ITXDvIM Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkq942w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 01:22:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAR1M7ww024224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 01:22:07 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAR1M5Xv032625;
        Tue, 27 Nov 2018 01:22:06 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 17:22:05 -0800
Date:   Tue, 27 Nov 2018 04:22:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux@wolf-entwicklungen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: add missing call to cdev_del()
Message-ID: <20181127012201.GM3088@unbuntlaptop>
References: <20181126181820.24224-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126181820.24224-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:18:20PM +0100, Michael Straube wrote:
> If cdev_add() fails, cdev_del() should be called.
> Add the missing cdev_del() call as pointed out by
> Dan Carpenter.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---

Thanks!  Looks good.

regards,
dan carpenter

