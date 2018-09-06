Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BABC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2E8204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2E8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeIFTYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:24:36 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45746 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbeIFTYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:24:36 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86EiiQj027605;
        Thu, 6 Sep 2018 09:48:36 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com ([141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2m7q6p7axm-1;
        Thu, 06 Sep 2018 09:48:36 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 1730E611E121;
        Thu,  6 Sep 2018 09:48:36 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 6 Sep 2018
 15:48:35 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w86EmYFq001713; Thu,
 6 Sep 2018 15:48:34 +0100
Date:   Thu, 6 Sep 2018 15:48:34 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20180906144834.GD1653@imbe.wolfsonmicro.main>
References: <20180905104120.17252-1-ckeepax@opensource.cirrus.com>
 <CACRpkdakAAAFKfRFeB_8kUCyGts_7sojVwyexe4aL4QQo2CcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdakAAAFKfRFeB_8kUCyGts_7sojVwyexe4aL4QQo2CcGg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809060146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:46:12PM +0200, Linus Walleij wrote:
> On Wed, Sep 5, 2018 at 12:41 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> 
> > From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> >
> > Lochnagar is an evaluation and development board for Cirrus
> > Logic Smart CODEC and Amp devices. It allows the connection of
> > most Cirrus Logic devices on mini-cards, as well as allowing
> > connection of various application processor systems to provide a
> > full evaluation platform.  Audio system topology, clocking and
> > power can all be controlled through the Lochnagar, allowing the
> > device under test to be used in a variety of possible use cases.
> >
> > As the Lochnagar is a fairly complex device this MFD driver
> > allows the drivers for the various features to be bound
> > in. Initially clocking, regulator and pinctrl will be added as
> > these are necessary to configure the system. But in time at least
> > audio and voltage/current monitoring will also be added.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> 
> It's a bit confusing, maybe you can clear it up:
> it appears to be an I2C device, so when you say this is a
> "development board" is there something like a board
> controller that is accessed over I2C and this is what the
> driver really probes to, not the board per se?
> 
> I guess jamming this card into the I2C slot of any other
> system (would work fine with a 96Boards LS connector
> as it seems, actually)  also involves connecting some
> I2S or similar on the side for high-datarate traffic?
> 
> This driver seems to only concern itself with the I2C
> board controller per se, not the board is that right?
> 

Yeah I have poorly phrased that, these patches are very much
just dealing with the board controller chip.

You could connect just the I2C to something like the 96Boards LS
connector, and control all the functionality accessed by this
driver. Although if you want to send audio between your 96Boards
device and the Lochnagar you would need to connect up some I2S as
well.

Thanks,
Charles
