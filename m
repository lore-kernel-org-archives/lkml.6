Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B9FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393456AbeKVUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:07:09 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55630 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387669AbeKVUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:07:09 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAM9OiZO026981;
        Thu, 22 Nov 2018 03:28:27 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ntg9t04eh-1;
        Thu, 22 Nov 2018 03:28:27 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 3BC80611CE60;
        Thu, 22 Nov 2018 03:31:51 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 09:28:26 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAM9SOx8010764; Thu,
 22 Nov 2018 09:28:25 GMT
Date:   Thu, 22 Nov 2018 09:28:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 10/11] mfd: wm831x-core: drop unused MODULE_ tags from
 non-modular code
Message-ID: <20181122092824.GH16508@imbe.wolfsonmicro.main>
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
 <1542861179-8941-11-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1542861179-8941-11-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=932 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811220087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 11:32:58PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_WM831X
> drivers/mfd/Kconfig:    bool
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
