Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0420672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3f3BX06/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeLKCLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:11:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52630 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:11:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBB292tE039163;
        Tue, 11 Dec 2018 02:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ib3uE5qzqMNqY99xzmw6v7bFTadPb+1+69LCBw+CeWA=;
 b=3f3BX06/mKY4OJGsthndTojyPuDOy6SJyRYDDiSRcGOb1GuWluf0u6/4bRXVuJUvv/JY
 dOPLBbegagLUlMnTUhW9+6D2PXTwCgPS/aPXSuNQFjW56UoLld4+5kxFY9g5R2z6t1Ak
 W6YDxtitLa5ApLAcbiBMRrJIKV8aA7Lze4WL2+rvQv3MxFlyh27TWtc/Fkh4XVj7Mdg6
 o+aln1XEK+I6wOGzYNLlYC68xpB9O1sdXwEzZVicvRV+0GDBfPgUib/YaIjZrIhATjG9
 pT1AQ/SgMdkvLSq/OSRRKpFz3qO9r8xzVAEZlr/MTUgy9GrST92ZDafDcMPkbmLFmDrx PQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p86kqs8sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 02:11:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBB2BMcP026412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 02:11:22 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBB2BKGC002081;
        Tue, 11 Dec 2018 02:11:21 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 18:11:20 -0800
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
To:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181210215856.2238253-1-arnd@arndb.de>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <b660e44c-c446-a408-c766-1d67a62d6fd7@oracle.com>
Date:   Mon, 10 Dec 2018 18:11:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=589
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 1:58 PM, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> The function am43xx_suspend_init() references
> the function __init am43xx_map_scu().
> This is often because am43xx_suspend_init lacks a __init
> annotation or the annotation of am43xx_map_scu is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
