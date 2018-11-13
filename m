Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F11C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AE621780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3bU23SHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AE621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbeKNEur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:50:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeKNEur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:50:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wADImUkk061304;
        Tue, 13 Nov 2018 18:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=w3rTiomaZ0Q5U3zG0P0QgJpZ63Uw1Gxcph6AAa2T6rw=;
 b=3bU23SHiwYQXJUbwHz/N9+Eq2IUJZmphoh1WnZSdmN3IvY230RzsgPXjelWBtVN4kRQz
 6I7uVSABzCslAjdgLLO1hDlPcB9tZQwv3iSALZ20leWM18Lj+OIRIpIfDxwuxNoYweK7
 1jrq7CFbWw0YQPEJ7ctO0ErvJlywkAMggdy0nM3mJ1OpUYIodLYddQOrsykgcq3fRl5s
 YQxBJy5TYcLtrpNsUJGrrFdWZMfcTBFkwU9Qdfmqpk1D+EjX4FZ9Hw8qhblpgWp8rquQ
 7lMEoiO85HWOTo0zhvOS3vIEGra3CR7s7XkTDfFtvokKj6hzL1ex3OExSoOJ/B0Du/CH 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nnwc0mpav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 18:51:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wADIp0Bd023372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Nov 2018 18:51:00 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wADIoxqu018855;
        Tue, 13 Nov 2018 18:51:00 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 10:50:59 -0800
Subject: Re: [PATCH] soc: ti: wkup_m3: Add PRCM int16 as the wake up source
To:     Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org, tony@atomide.com
Cc:     linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com,
        t-kristo@ti.com, linux-kernel@vger.kernel.org
References: <1541999860-14550-1-git-send-email-j-keerthy@ti.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <99b2658c-2394-0660-6f63-0ef63a7c30f3@oracle.com>
Date:   Tue, 13 Nov 2018 10:50:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541999860-14550-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=874
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811130170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2018 9:17 PM, Keerthy wrote:
> Add PRCM int16 as the wake up source.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
Looks good.

Tony, Would you able to pick this up ?
