Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BCCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98A0208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfACR1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:27:49 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:33260 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727034AbfACR1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:27:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03HIuVZ030656;
        Thu, 3 Jan 2019 11:27:40 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pp7776cmp-1;
        Thu, 03 Jan 2019 11:27:40 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id C9487611C8AF;
        Thu,  3 Jan 2019 11:31:43 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 3 Jan 2019
 17:27:39 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x03HRcKh007041; Thu,
 3 Jan 2019 17:27:38 GMT
Date:   Thu, 3 Jan 2019 17:27:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     <mazziesaccount@gmail.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <geert@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type
 settings
Message-ID: <20190103172738.GQ16508@imbe.wolfsonmicro.main>
References: <20181227084443.GA23991@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181227084443.GA23991@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=916 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901030153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 10:44:43AM +0200, Matti Vaittinen wrote:
> Do not return error if irq-type setting is requested for
> controlloer which does not support this. This is how
> regmap-irq has previously handled the undupported type
> settings and existing drivers seem to be upset if failure
> is now reported.
> 
> Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Geert reported that 1c2928e3e321 breaks da9063-rtc on the Renesas
> Koelsch board:
> 
> https://lore.kernel.org/lkml/20181227075648.GB2461@localhost.localdomain/T/#m194616cc88d7b4c2a78f7ce07907608fdb64a092
> 
> Geert, do you know if anyone vould to test this?
> 

Bit late since its already been applied but this patch fixes the
issues I had.

Thanks,
Charles
