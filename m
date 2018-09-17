Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396EBECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6423214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6423214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeIQTRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:17:52 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55498 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726865AbeIQTRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:17:52 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8HDkE0P012092;
        Mon, 17 Sep 2018 08:50:18 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com ([141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mgyg0u1a4-1;
        Mon, 17 Sep 2018 08:50:18 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id F02CB611E120;
        Mon, 17 Sep 2018 08:50:17 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Sep 2018
 14:50:17 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w8HDoG8P022560; Mon,
 17 Sep 2018 14:50:16 +0100
Date:   Mon, 17 Sep 2018 14:50:16 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20180917135016.GK1653@imbe.wolfsonmicro.main>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
 <CACRpkdakAAAFKfRFeB_8kUCyGts_7sojVwyexe4aL4QQo2CcGg@mail.gmail.com>
 <20180906144834.GD1653@imbe.wolfsonmicro.main>
 <5b9f3f61.1c69fb81.f4e64.f592@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b9f3f61.1c69fb81.f4e64.f592@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809170140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 06:11:08PM -0500, Rob Herring wrote:
> On Thu, Sep 06, 2018 at 03:48:34PM +0100, Charles Keepax wrote:
> > On Thu, Sep 06, 2018 at 03:46:12PM +0200, Linus Walleij wrote:
> > > On Wed, Sep 5, 2018 at 12:41 PM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > It's a bit confusing, maybe you can clear it up:
> > > it appears to be an I2C device, so when you say this is a
> > > "development board" is there something like a board
> > > controller that is accessed over I2C and this is what the
> > > driver really probes to, not the board per se?
> > > 
> > > I guess jamming this card into the I2C slot of any other
> > > system (would work fine with a 96Boards LS connector
> > > as it seems, actually)  also involves connecting some
> > > I2S or similar on the side for high-datarate traffic?
> > > 
> > > This driver seems to only concern itself with the I2C
> > > board controller per se, not the board is that right?
> > > 
> > 
> > Yeah I have poorly phrased that, these patches are very much
> > just dealing with the board controller chip.
> 
> How would the codec I2C connect to the host? Is there one I2C bus or 
> 2? The binding looks mostly fine to me, but I think we need to 
> understand that part.
> 

If the CODEC is I2C based then both the CODEC and the controller
IC will be on the same I2C bus. If the CODEC is connected over
SPI that is obviously a separate bus as the board controller
chip is I2C only.

There are some additional I2C interfaces but they are not
currently used on any mini-cards, and they are intended for
secondary purposes not control of the CODEC itself.

Thanks,
Charles
