Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C302150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="naW8G/h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C302150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeISTgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:36:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeISTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:36:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8JDs5vu172831;
        Wed, 19 Sep 2018 13:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BIa1zgvdqBDVTzCke2BhfOUAwG/f6yXblcuctTARqXU=;
 b=naW8G/h93CLfx+XhQL6dHSxo0lGFrvoabL/KaY9Y10ZG+RlzewvAUbC9yRHB+l6h8ehp
 x/QOqR01Po/kH9DH3kBbMBC3lUt0LFrVyst2KqN66Uwr+HXhmwhe/+v90N63O3c1zHfP
 a79cEwGTl18MOrwHF9nvDGnehLMjNEyXffyDJWlVoCaCKhiBI0uwWUiZrlHHHKp0AdsD
 uNfuwauTuYQb9GNLoYqI6Zjq3EUpkba7u6rVxKlSyK6oa6K8HwqsXa/dkefzMNxuvQQE
 hAZJq1gb0jwqIfEjYFtRFA3zO7tcqvuOmzfWQjkLVt9NeLWe6N5frXC0cs5F/0AERzC3 JA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mgt1pu4by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 13:57:53 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8JDvqMd026953
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 13:57:52 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8JDvoI7007853;
        Wed, 19 Sep 2018 13:57:50 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Sep 2018 06:57:50 -0700
Date:   Wed, 19 Sep 2018 16:57:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gary R Hook <ghook@amd.com>
Cc:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/2] Fix static checker warning
Message-ID: <20180919135741.5icpyesntcfbgtcr@mwanda>
References: <cover.1536959537.git.Janakarajan.Natarajan@amd.com>
 <31c49295223e51f5c1c4e36e7a09fe100dab1711.1536959537.git.Janakarajan.Natarajan@amd.com>
 <8dfca0f4-6639-3444-148f-eb0b0817fec6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dfca0f4-6639-3444-148f-eb0b0817fec6@amd.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9020 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=629
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds reasonable.  The subject needs a subsystem prefix and it might
be better to make it more specific.  Like so:

[PATCH 1/2] crypto: ccp - potential uninitialized variable

I don't know if Herbert fixes those things up himself normally?

regards,
dan carpenter

