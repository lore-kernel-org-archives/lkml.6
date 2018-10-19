Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65DEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701002087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701002087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJSUkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:40:49 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44424 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727333AbeJSUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:40:48 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JCY6pZ007103;
        Fri, 19 Oct 2018 07:34:44 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n3es40sey-1;
        Fri, 19 Oct 2018 07:34:44 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 23A1E611E120;
        Fri, 19 Oct 2018 07:34:44 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 13:34:42 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9JCYgL2020117; Fri,
 19 Oct 2018 13:34:42 +0100
Date:   Fri, 19 Oct 2018 13:34:42 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] regulator: lochnagar: Add support for the Cirrus
 Logic Lochnagar
Message-ID: <20181019123442.GM1653@imbe.wolfsonmicro.main>
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com>
 <20181019095003.26046-4-ckeepax@opensource.cirrus.com>
 <20181019112622.GB5895@sirena.org.uk>
 <20181019121920.GL1653@imbe.wolfsonmicro.main>
 <20181019122118.GI5895@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181019122118.GI5895@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=946 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810190113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 01:21:18PM +0100, Mark Brown wrote:
> On Fri, Oct 19, 2018 at 01:19:20PM +0100, Charles Keepax wrote:
> > On Fri, Oct 19, 2018 at 12:26:22PM +0100, Mark Brown wrote:
> 
> > > Please do not submit new versions of already applied patches, please
> > > submit incremental updates to the existing code.  Modifying existing
> > > commits creates problems for other users building on top of those
> > > commits so it's best practice to only change pubished git commits if
> > > absolutely essential.
> 
> > I don't think any of this has been applied anywhere yet.
> 
> It looks a lot like
> 
> bef9391cbec547351c6a13e52f3a26bb2d271ec7 regulator: lochnagar: Add support for the Cirrus Logic Lochnagar
> 
> in -next.

Well it sure does look a lot like my patch :-). Apologies
something must have gone wrong on one of our ends as I don't
seem to have ever received your usual confirmation email it
was merged. I will try to keep a closer eye on people's trees
in future.

No changes in this version, was just updating other patches in the
chain for some feedback so no harm done. Will send an incremental
patch for comment style.

Thanks,
Charles
