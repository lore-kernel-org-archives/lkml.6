Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838BC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E01206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E01206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeKUDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:40:38 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52988 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbeKUDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:40:38 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKH97NE014878;
        Tue, 20 Nov 2018 11:10:18 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ntg9svcq8-1;
        Tue, 20 Nov 2018 11:10:18 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 30CC1611C8AF;
        Tue, 20 Nov 2018 11:13:02 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 17:10:17 +0000
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wAKHAH31015287;        Tue, 20 Nov 2018 17:10:17 GMT
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
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
 <20181120170103.GP3894@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <5eec838b-e454-9ce4-22b1-7d00ef28ead4@opensource.cirrus.com>
Date:   Tue, 20 Nov 2018 17:10:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181120170103.GP3894@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=500 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 17:01, Mark Brown wrote:
> On Tue, Nov 20, 2018 at 04:57:16PM +0000, Richard Fitzgerald wrote:
>> On 20/11/18 16:34, Marek Szyprowski wrote:
> 
>>> Deferred probe was there already. This patch however introduced the
>>> warning from gpiolib and I would like to have it fixed somehow. In both
> 
>> I don't follow what it is you want, are you asking that it shouldn't probe
>> defer, or that it shouldn't log the reason why it deferred?
> 
> He's complaining that gpiolib and/or the driver's usage of it shouldn't
> be generating a backtrace in normal operation.
> 
Ah, I didn't see that. I seem to have not received the start of this thread and
the subsequent discussion only includes the -517 warnings not a mention of
a backtrace.
