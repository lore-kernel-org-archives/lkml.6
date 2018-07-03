Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE77123ED7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DZDHVavS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE77123ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeGCMXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:23:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeGCMXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:23:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63CEPpn136678;
        Tue, 3 Jul 2018 12:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=5X2oFTorfwO/wTJQbfpHALl90q1qNNAWOPbH4TsmPUo=;
 b=DZDHVavSAeVKHQ4VQRon2LWimcE7j9nyTHs0ehFLfpq7iN3iY3a6VZkACu/BcBfOT7tP
 Tny4qbGONfytt3RwrXHwFO/jI7LkdWtBBraN3dSH2NckpxeQZBJc3qcrr8i2ffDb31vG
 GZw58Fuqe79dF8CY8xVM8kc/ltRLZmo39afjTADKFBYiUSGm34FHE/nkJjNwKgAFDzjd
 VcfJbaKDr40dApfr+JNg0iMRsdAbXmSn48ZBAUQ3kuyV5RMdK3PAcuCoJXqMJf/+suob
 wjC9WVAjAhqlRzXfMSRrxODrpZrk7TiDaYf3K0eLUN2vWNrGEcbZrfKfdJyZbfTVOIG1 +A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gq08et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 12:23:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w63CNGQH030830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 12:23:17 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w63CNGkr001052;
        Tue, 3 Jul 2018 12:23:16 GMT
Received: from mwanda (/197.157.0.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 05:23:16 -0700
Date:   Tue, 3 Jul 2018 15:23:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gnss: fix potential error pointer dereference
Message-ID: <20180703122309.x6m4hrawpg2tb2bu@mwanda>
References: <20180703115921.7h35wi73oym3use5@kili.mountain>
 <20180703121143.GP9802@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703121143.GP9802@localhost>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:11:43PM +0200, Johan Hovold wrote:
> On Tue, Jul 03, 2018 at 02:59:22PM +0300, Dan Carpenter wrote:
> > The gnss_allocate_device() function returns a mix of NULL and error
> > pointers on error.  It should only return one or the other.  Since the
> > callers both check for NULL, I've modified it to return NULL on error.
> > 
> > Fixes: 10f146639fee ("gnss: add receiver type support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Ouch, thanks for catching this!
> 
> I think you got the wrong commit for the fixes tag above, however. That
> should be:
> 
> Fixes: 2b6a44035143 ("gnss: add GNSS receiver subsystem")
> 

Oops.  That's what I intended, yes.  I will resend.

regards,
dan carpenter

