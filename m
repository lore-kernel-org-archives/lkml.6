Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2424C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F72208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3wsaE6Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F72208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeHANWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:22:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41736 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbeHANWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:22:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71BXmJH012360;
        Wed, 1 Aug 2018 11:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3PlWYqTZmHuthhk3Q5MJ0HadCpc4GAQHx+FhSdy+RAs=;
 b=3wsaE6FvzYhDLWRHy9gGC/5L7Y5SMsRO4LrUlU9NrX/2CXqENIHQNFPZaDiMh/PoEiUk
 QnJq6bN5cUn2VGw94qtbvDZ3fbqphUL2/gJ3t9qZlYspJo38ub4SJcQWL2dlWvEcgfmf
 8DXIq4SVH8R3509k+4OluxTbskoXDgt+ieRTLchHshKrHQRsugdTTG5vjPXDNgvtrB5x
 7OMwd1fBdnFDg6YhcWML6IfMAWEspTozq86aGkxE48vbmm7c0oKUvOZy+9XNUTOWMKPO
 M4IT4JUXirWYhGD4sUC1rAdZNV3EpEj1KZ4qhUlCBJSs/Ca8gwHwvuGiOIUTizG/fzwx vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2kge0d5b9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 11:36:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w71BaTFb028118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 11:36:29 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71BaTLU008043;
        Wed, 1 Aug 2018 11:36:29 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 04:36:28 -0700
Date:   Wed, 1 Aug 2018 14:36:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, yuchao0@huawei.com,
        linux-erofs@lists.ozlabs.org, hsiangkao@aol.com,
        linux-kernel@vger.kernel.org, weidu.du@huawei.com,
        miaoxie@huawei.com, chao@kernel.org
Subject: Re: [PATCH RESEND 1/2] staging: erofs: add the missing break in
 z_erofs_map_blocks_iter
Message-ID: <20180801113620.3ufakhg3z62q46mw@mwanda>
References: <ea978a27-efd4-9d58-e4c0-f9d00420304f@huawei.com>
 <1533116214-70017-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533116214-70017-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=770
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:36:54PM +0800, Gao Xiang wrote:
> This patch adds a missing break after adding the default case.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> As pointed out by Dan Carpenter:
>  - fix the wrong place of fallthrough comments

Thanks.  Looks good.  Next time use [PATCH v2] instead of RESEND.  The
word RESEND basically means you are resending a patch exactly the same
as it was before.  You would only need to do that if we accidentally
deleted your first patch or whatever...

regards,
dan carpenter


