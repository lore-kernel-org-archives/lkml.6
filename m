Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646C214F0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6vwmyL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646C214F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbeGFR0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:26:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGFR0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:26:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66HOO9i162594;
        Fri, 6 Jul 2018 17:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KVSGAMk8PzYf2xqSo1Ib/l/kZA0cXfIVD0uMzjSioaY=;
 b=h6vwmyL7L+C+kNs702BNQFa0O7t19DC13ZVtX+mp2RhqDxQhvKPYzzSp8R3hhrtfdBJT
 khuN0Ues1w6wmT79jObkKSEkVo+poRGN1ZTo7oV/UExRAtzqoHqI1Z8KMB8emBXnlNhS
 U36+ar4gC7nvzwCeBA3QjWvThWKlysafpwBBbqtWX88bgH+leXu2/wYi0P7m0uCd6S1N
 noqafdkz65RmzzGQ0doC8ZpiXkzfao6f08cStyFiENkrV2N4ZcabFZ3wbvN2g/6pf4gG
 aO+Eblxk4Zl3KdKFS1Wrjsg+XzdogP/mufZpZG9M08nsxhA9szTgI9+5igT6uoWT1wGw kA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k0dnjtj82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 17:26:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w66HQOYV017633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 17:26:24 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w66HQNRI026183;
        Fri, 6 Jul 2018 17:26:24 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 10:26:23 -0700
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180706123651.2792927-1-arnd@arndb.de>
Organization: Oracle Corporation
Message-ID: <b87566e9-c398-d390-e029-0a28b2c7fbf9@oracle.com>
Date:   Fri, 6 Jul 2018 10:26:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706123651.2792927-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8945 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=633
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 5:36 AM, Arnd Bergmann wrote:
> Everyone gets these #ifdefs wrong, leading to another warning here:
> 
> drivers/soc/ti/wkup_m3_ipc.c:547:12: error: 'wkup_m3_ipc_resume' defined but not used [-Werror=unused-function]
>   static int wkup_m3_ipc_resume(struct device *dev)
> drivers/soc/ti/wkup_m3_ipc.c:539:12: error: 'wkup_m3_ipc_suspend' defined but not used [-Werror=unused-function]
>   static int wkup_m3_ipc_suspend(struct device *dev)
> 
> The easiest way to get it right is to remove all the #ifdefs and
> let the compiler drop the unused functions silently after we
> mark them as __maybe_unused.
> 
> Fixes: 7a872b6fb7fd ("soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Applied. Thanks Arnd !!

Regards,
Santosh
