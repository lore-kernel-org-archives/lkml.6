Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E81C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55B6208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axwB9GEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55B6208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeH1Eyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:54:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40632 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeH1Eyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:54:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7S13UgH015495;
        Tue, 28 Aug 2018 01:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=hjGIUla1NhVNlQSwpc6lnNUz5IirW6XlBR046GOdXBE=;
 b=axwB9GEFXxTKp5iD4qoZkoGDSFoL51+thfFpa8uF5JdDDDpyx14I3P3z0ygFbFII8plI
 XmjxDKXDGsfcifsRGm/dXb8iduTYBALji2QhBIYuonDbmJ5iMp0xO09G1Nn+7qk2R9U8
 pANoGNjz4Y2WKeK3AVMq34aK2NkYoN4a43JKyioqT+bxORx+Hb1LRM7xwtHwHtsGHyFk
 YIqnRpRKnGnMBP9vcVUOMSl19wJrxBAXhmm5yEuQxN6jOXdthdo3E9JiU+KNfTiulh39
 0gVynVMLCrqqbgh83nKIStYrm61qQo1W2o/m6/a3O3S/lKXFHStn1/WD5FUvrBLS5JXI 7w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m2y2p8xuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 01:05:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7S15HDN028257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 01:05:18 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7S15HRp011381;
        Tue, 28 Aug 2018 01:05:17 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 18:05:17 -0700
Subject: Re: [PATCH V3 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180828005924.13092-1-nm@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <7a73e77f-b119-89bc-cd0e-bbd6628b1395@oracle.com>
Date:   Mon, 27 Aug 2018 18:05:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828005924.13092-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2018 5:59 PM, Nishanth Menon wrote:
> Hi Santosh,
> 
> This is the rebase to v4.19-rc1 and repost of the patch series [1]
> Please find attached series to enable host-id as an optional dt property.
> 
> [1] https://patchwork.ozlabs.org/cover/931822/
> 
> No Functional changes. Will be great if we can get this in rc cycle,
> but, will defer to you.
> 
> Nishanth Menon (2):
>    Documentation: dt: keystone: ti-sci: Add optional host-id parameter
>    firmware: ti_sci: Provide host-id as an optional dt parameter
> 
Yes I had this series bookmarked and was going to merge it now since
rc1 is out. Will get to it in next few days & it should showup
in next. But don't plan to send it for rc since its not a regression"
as such. Thanks for following up Nishant !!

Regards,
Santosh
