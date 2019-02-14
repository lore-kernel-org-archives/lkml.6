Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB398C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15CB222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ICpS4Jyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437442AbfBNHs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:48:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437428AbfBNHsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:48:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E7i48V029171;
        Thu, 14 Feb 2019 07:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bheLtZPV7pm0gY8PJ5wrEfJzea3Duu04eNSgouxwohA=;
 b=ICpS4Jyynk4Mw0HFyYC9iCHp7VY0oDsKLIr2LWp8TxIfJPx402bJr8maqICi4faCKRil
 8MzDnuLcMLG+NRodudXpi2Ac9BZyVmeDypZW0HgtxV+j0cDcaPen/FaKiesJrPHpgqYa
 eza/Hn3YsbQ2vB6sH9ufJeoLiUlMA4ZCADQoDLkSjt65CZE34vrFufQfQrScF5H13RMM
 y2SC0mF9LJjSR6niJE471AUqHz31tRDVYxUKZosJP3VpfsxAo25uujP1OgXW41fLPvv3
 2dvFY9WwMBNZWiCi+NMxlWvmQQYvNDupaqUknSW5ywQ6GJBAFXnygemx1qrFQyKqiJ5b Tg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree6csb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 07:48:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E7mAjx020057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 07:48:11 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E7mA6v024127;
        Thu, 14 Feb 2019 07:48:10 GMT
Received: from kadam (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 07:48:09 +0000
Date:   Thu, 14 Feb 2019 10:48:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@telemann.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/coda: get rid of CODA_ALLOC()
Message-ID: <20190214074801.GC2304@kadam>
References: <20190214065848.GB21768@kadam>
 <alpine.DEB.2.21.1902140804170.2466@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902140804170.2466@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=601 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 08:04:43AM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 14 Feb 2019, Dan Carpenter wrote:
> 
> > These days we have kvzalloc() so we can delete CODA_ALLOC().
> 
> Maybe it would be better to get rid fo CODA_FREE as well?
> 

Actually, you're right.  CODA_FREE() is especially weird  without a
CODA_ALLOC().  But let me send that as a second patch.

regards,
dan carpenter

