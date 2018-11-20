Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35664C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6220684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C6220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeKUDdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:33:50 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:12119 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbeKUDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:33:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKGxTeI014706;
        Tue, 20 Nov 2018 11:03:35 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984pjs-1;
        Tue, 20 Nov 2018 11:03:34 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 92EBE611C8B2;
        Tue, 20 Nov 2018 11:06:56 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 17:03:33 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKH3Wra012122; Tue,
 20 Nov 2018 17:03:32 GMT
Date:   Tue, 20 Nov 2018 17:03:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
Message-ID: <20181120170332.GE16508@imbe.wolfsonmicro.main>
References: <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
 <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
 <20181120144700.GB16508@imbe.wolfsonmicro.main>
 <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
 <20181120153215.GC16508@imbe.wolfsonmicro.main>
 <20181120153610.GD16508@imbe.wolfsonmicro.main>
 <9314db6c-9498-579d-430c-5a2992fe513e@samsung.com>
 <59879030-93a4-f562-b03b-c5e579d44e89@opensource.cirrus.com>
 <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
 <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=782 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 04:57:16PM +0000, Richard Fitzgerald wrote:
> On 20/11/18 16:34, Marek Szyprowski wrote:
> >On 2018-11-20 17:16, Richard Fitzgerald wrote:
> >>On 20/11/18 15:56, Marek Szyprowski wrote:
> >>>On 2018-11-20 16:36, Charles Keepax wrote:
> >>>>On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
> >>>>>On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
> >>>>>>On 2018-11-20 15:47, Charles Keepax wrote:
> >>>>>>>On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
> >>>>>>>>On 2018-05-17 18:41, Mark Brown wrote:
> >>>>>>>>>Subject: [PATCH] regulator: wm8994: Pass descriptor instead of
> >>>>>>>>>GPIO number
> >>>>>>>>This patch causes following kernel warning on Samsung Exynos4412
> >>>>>>>>based
> Sounds like all is ok and working as expected.
> If this is causing you a problem you'll need to provide more explanation of
> what problem you have so we can understand.
> 

The problem looks to be that we shouldn't be using devm for the
GPIO allocation because the device we want to allocate the memory
against differs from the one that holds the OF node. Apologies
for missing that in review of the patch.

I have sent a fix that hopefully should resolve the issue, if you
could test it on you system that would be awesome.

Thanks,
Charles
