Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE7C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CCF206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CCF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeKUCGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:06:09 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45174 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbeKUCGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:06:09 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKFTWNX005365;
        Tue, 20 Nov 2018 09:36:11 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ntg9sv8up-1;
        Tue, 20 Nov 2018 09:36:11 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 39D46611C8AF;
        Tue, 20 Nov 2018 09:38:55 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 15:36:10 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKFaAlo019275; Tue,
 20 Nov 2018 15:36:10 GMT
Date:   Tue, 20 Nov 2018 15:36:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
Message-ID: <20181120153610.GD16508@imbe.wolfsonmicro.main>
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
 <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
 <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
 <20181120144700.GB16508@imbe.wolfsonmicro.main>
 <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
 <20181120153215.GC16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181120153215.GC16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=425 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
> > On 2018-11-20 15:47, Charles Keepax wrote:
> > > On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
> > >> On 2018-05-17 18:41, Mark Brown wrote:
> > >>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number
> > >> This patch causes following kernel warning on Samsung Exynos4412 based
> > >> Trats2 board:
> > >>
> > >> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
> > >> wm8994 4-001a: Failed to get supplies: -517
> This is really weird, because the error in your log relates to
> DBVDD1 which is an independent regulator supplied by a separate
> regulator. I am really having some difficulty seeing how the
> patch interfers. It is definitely that patch which causes the
> issue, like you revert it and things work again?

Wait does the board still boot just you have an extra probe defer
now? Or does it actually fail?

Thanks,
Charles
