Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E532C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E30020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbeLFLxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:53:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43146 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbeLFLxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:53:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6BrN5F018397;
        Thu, 6 Dec 2018 05:53:23 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2p3rk7hd0x-1;
        Thu, 06 Dec 2018 05:53:23 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 00CC7611E121;
        Thu,  6 Dec 2018 05:53:23 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 6 Dec 2018
 11:53:22 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wB6BrLVf010939; Thu,
 6 Dec 2018 11:53:21 GMT
Date:   Thu, 6 Dec 2018 11:53:21 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 06/15 v3] regulator: max8973: Let core handle GPIO
 descriptor
Message-ID: <20181206115321.GI16508@imbe.wolfsonmicro.main>
References: <20181205124721.26624-1-linus.walleij@linaro.org>
 <20181205124721.26624-7-linus.walleij@linaro.org>
 <20181205134345.GF16508@imbe.wolfsonmicro.main>
 <CACRpkdbJsTc2tAyTriz33a75d-1tJdcvdock0fxi7HdJ+EH_Dw@mail.gmail.com>
 <20181205153331.GG16508@imbe.wolfsonmicro.main>
 <CACRpkdaSuU+v1yZm-GXBH693JbVZysXm6_1939ct50arKJn2qw@mail.gmail.com>
 <20181206103430.GH16508@imbe.wolfsonmicro.main>
 <CACRpkdaO6-ak74zudmNy1G5rXC0G6UVxOJ8Du82X6bZTPoJhpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdaO6-ak74zudmNy1G5rXC0G6UVxOJ8Du82X6bZTPoJhpA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=603 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812060107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 12:47:46PM +0100, Linus Walleij wrote:
> On Thu, Dec 6, 2018 at 11:34 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Thu, Dec 06, 2018 at 09:58:30AM +0100, Linus Walleij wrote:
> > > On Wed, Dec 5, 2018 at 4:33 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > On Wed, Dec 05, 2018 at 03:42:06PM +0100, Linus Walleij wrote:
> > > > > On Wed, Dec 5, 2018 at 2:43 PM Charles Keepax
> > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > > On Wed, Dec 05, 2018 at 01:47:12PM +0100, Linus Walleij wrote:
> > You shouldn't really need to use unhinge, you can just use devm
> > on the path that doesn't pass it to the core and not on the
> > one that does. You just need to update the error case below it to
> > use config->ena_gpiod rather than gpiod.
> 
> Indeed I just think it will be confusing when people read the code.
> 
> It's better consistency if its just devm_* and the  we unhinge the
> one we pass to the regulator core IMO.
> 

That's ok no objections from my if you prefer it that way.

Thanks,
Charles
