Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC860ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E9920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E9920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJYVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:53:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34620 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727234AbeJYVxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:53:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9PDGc9B022635;
        Thu, 25 Oct 2018 08:20:45 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2n81s36u59-1;
        Thu, 25 Oct 2018 08:20:45 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id A4DAF611C8B7;
        Thu, 25 Oct 2018 08:20:44 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 14:20:43 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9PDKhVx010911; Thu,
 25 Oct 2018 14:20:43 +0100
Date:   Thu, 25 Oct 2018 14:20:43 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181025132043.GG16508@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <20181025124905.GF16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181025124905.GF16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=967 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810250115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 01:49:05PM +0100, Charles Keepax wrote:
> On Thu, Oct 25, 2018 at 12:42:05PM +0100, Lee Jones wrote:
> > On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
> > > On 25/10/18 09:26, Charles Keepax wrote:
> > > > On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
> > > > > On Mon, 08 Oct 2018, Charles Keepax wrote:
> > > > > > From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > > I really feel this isn't the driver you are objecting to as such
> > > > but the way regmap operates and also we seem to always have the same
> > > > discussions around regmap every time we push a driver.
> > 
> > Absolutely.  I didn't like it before.  I like it even less now.
> > 
> 
> I guess the question from my side becomes do you want to block
> this driver pending on major refactoring to regmap? I will have a
> think about what I can do but its going to affect a LOT of drivers.
> 

Actually one more thought, perhaps as a halfway for now i could
look into removing the readables and defaults. We lose some things
like error checking that we are reading real registers but as
this driver doesnt currently do cache syncs we might be able to
get away with this for now.

Unless anyone strenuously objects i will have a look at the
options there. As well as looking at wider refactoring but aiming
further out.

Thanks,
Charles
