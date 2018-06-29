Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1428C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D83927D68
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUbyiLEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D83927D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeF2W7d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:59:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42600 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeF2W7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:59:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TMxNr7106273;
        Fri, 29 Jun 2018 22:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=qd091HCxAbzAyjq5CbxZ7GpFzmzc5ThZc0FIgFKuO6U=;
 b=RUbyiLEirGotLRXo9PZ7eE7zZtR2m1lvnmQE99plH2DORVB4NF3Xffcww9dtWjm19Uny
 Q74rMuEpslLUDteihIvJNeq3IcYIKj2rPZagmm6jGraMtyLofoHmMK04sfyu6DWcA/Da
 GnBrRbFBVCeJOK9dvlwfcNEwWYKAipy6n9InTRamGNrBQbpYmcb5TOBrSBJWUSoXbiTL
 ES6WWfrAghg10+o+SHFeXMEavMp2bIp+0gM4WDaY17mTxKbldr8OAdWmBc+E76Z2oN7R
 aPHLZI7i0t95E845KisQDFyB3ZIA2Rs4hw3+OyK2ilI5rzvonnJCEE+NRd013Ukxjf5t Uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jukmu87gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 22:59:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TMxLZf017602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 22:59:22 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TMxKoK013293;
        Fri, 29 Jun 2018 22:59:20 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 15:59:20 -0700
Subject: Re: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
References: <20180622101617.11157-1-kishon@ti.com>
 <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <10adb1c9-9b10-e1e7-7076-25b0c68c99f1@oracle.com>
Date:   Fri, 29 Jun 2018 15:59:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2018 9:15 PM, Kishon Vijay Abraham I wrote:
> Santosh,
> 
> On Friday 22 June 2018 03:46 PM, Kishon Vijay Abraham I wrote:
>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>> binding.
>>
>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>> Everyone who use a custom .config should also enable
>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
> 
> Can this series be merged?
> 
Applied. Sorry for missing it in earlier batch.

Regards,
Santosh
