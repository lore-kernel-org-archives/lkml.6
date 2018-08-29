Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A0AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D59206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7WRmgkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D59206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeH2NgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:36:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeH2NgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:36:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7T9ckii168290;
        Wed, 29 Aug 2018 09:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=L2/qqa+KdwJEyd4JIPlm7j4zrsWroKIALy36MnT1XOA=;
 b=C7WRmgkZv/pzHQgxIqbRxNafRecH+Wdfx6pS88edciBEL6iG6u7LDNnStbWY27Et6ROn
 cF1LfabPQmlFDRxi4YfBA8ae7PgyZvNADeaPw/r4l8mp9Xl98V2tyve5uoGqLsE9OruT
 Ri1IN+bUMasSXXp+WUmdUu4aoY/Pp8uqvQ/Dce6WNcd1vqKLvpfzZQ91+OfNShhDrxxm
 msksCMaoUoRXDwh3II933KT/1CaN8Z5VWv1Pxzt1xTsHE/2TUQmYRY4ssex5hgBSwRu9
 gVfU+PC1/DU1aQF6sIcikDXJyX47g014BPFVdPMhODIMfjGTzz+Of1tTDqL8Pj7y6bmV ww== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m2y2pgrfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 09:40:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7T9e1IM026718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 09:40:01 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7T9e043024251;
        Wed, 29 Aug 2018 09:40:00 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 02:40:00 -0700
Date:   Wed, 29 Aug 2018 12:39:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     qiang.zhao@nxp.com, kernel-janitors@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, leoyang.li@nxp.com
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in
 ucc_get_tdm_sync_shift()
Message-ID: <20180829093948.c7nbl27ju4uszrum@mwanda>
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
 <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=550
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:06:45PM +0200, Mathieu Malaterre wrote:
> Where did the original go ?
> 
> https://patchwork.ozlabs.org/patch/868158/
> 
> 

Btw, we still haven't pushed a patch for this bug.

regards,
dan carpenter

