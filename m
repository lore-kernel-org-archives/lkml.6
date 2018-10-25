Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49064ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAD320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAD320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJYT2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:28:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:33190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbeJYT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:28:52 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9PAsBDB012370;
        Thu, 25 Oct 2018 05:56:28 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n80speg0x-1;
        Thu, 25 Oct 2018 05:56:28 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id D2226611E124;
        Thu, 25 Oct 2018 05:56:27 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 11:56:27 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9PAuQmK007651; Thu,
 25 Oct 2018 11:56:26 +0100
Date:   Thu, 25 Oct 2018 11:56:26 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181025105626.GE16508@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025101248.GT2103@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181025101248.GT2103@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810250098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:12:48AM +0100, Mark Brown wrote:
> On Thu, Oct 25, 2018 at 10:28:16AM +0100, Richard Fitzgerald wrote:
> > On 25/10/18 09:26, Charles Keepax wrote:
> > > On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
> > > I really feel this isn't the driver you are objecting to as such
> > > but the way regmap operates and also we seem to always have the same
> > > discussions around regmap every time we push a driver. Is there
> > > any way me, you and Mark could hash this out and find out a way to
> > > handle regmaps that is acceptable to you? I don't suppose you are
> > > in Edinburgh at the moment for ELCE?
> 
> > I suppose if Mark was willing to promote the regmap drivers to be a
> > top-level subsystem that could contain the regmap definitions of devices
> > then we could dump our regmap definitions in there, where Mark can review
> > it as he's familiar with regmap and the chips and the reasons why things
> > are done the way they are, rather than Lee having to stress about it every
> > time we need to create an MFD device that uses regmap. Though that would
> > make the initialization of an MFD rather awkward with the code required
> > to init the MFD it not actually being in the MFD tree.
> 
> I'm not totally against dumping the data tables in some other directory
> (we could do ../regmap/tables or whatever) but I fear it's going to
> cause otherwise needless cross tree issues.

I guess there is a question here, if i split the regmap stuff
into a separate file within mfd would that be enough? Is it just
the mixing of these tables and the code you object to Lee or is
it the fact the tables exist at all?

Thanks,
Charles
