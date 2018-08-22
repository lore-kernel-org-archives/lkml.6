Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C39E2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C39E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeHVLc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:32:57 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57082 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728302AbeHVLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:32:56 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7M8980j027782;
        Wed, 22 Aug 2018 03:09:08 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kxgv1cwec-1;
        Wed, 22 Aug 2018 03:09:08 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id E891E611C8A7;
        Wed, 22 Aug 2018 03:11:02 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 22 Aug 2018
 09:09:06 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w7M896Zq022135; Wed,
 22 Aug 2018 09:09:06 +0100
Date:   Wed, 22 Aug 2018 09:09:06 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <sapthagiri.baratam@gmail.com>
CC:     <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Subject: Re: [PATCH v2] mfd: arizona: Correct calling of runtime_put_sync
Message-ID: <20180822080906.GR32322@imbe.wolfsonmicro.main>
References: <5b7c2583.1c69fb81.c4b41.086e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b7c2583.1c69fb81.c4b41.086e@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=823 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808220084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 07:52:44PM +0530, sapthagiri.baratam@gmail.com wrote:
> From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> 
> Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
> as there is no corresponding runtime_get_sync call.
> 
> MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
> source we need to hold a runtime PM reference to keep the device from
> going into low power mode.
> 
> fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
> Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
