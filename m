Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E7C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3016820989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3016820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeK0Ubw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:31:52 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38068 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728266AbeK0Ubv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:31:51 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAR9YRKp014197;
        Tue, 27 Nov 2018 03:34:27 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ny4x63ug0-1;
        Tue, 27 Nov 2018 03:34:26 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id F390B611C8B6;
        Tue, 27 Nov 2018 03:34:25 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 09:34:25 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAR9YOqS006890; Tue,
 27 Nov 2018 09:34:24 GMT
Date:   Tue, 27 Nov 2018 09:34:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v5 3/8] clk: lochnagar: Add initial binding documentation
Message-ID: <20181127093424.GR16508@imbe.wolfsonmicro.main>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-3-ckeepax@opensource.cirrus.com>
 <20181126201645.GA2094@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181126201645.GA2094@bogus>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811270085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:16:45PM -0600, Rob Herring wrote:
> On Tue, Nov 20, 2018 at 02:16:26PM +0000, Charles Keepax wrote:
> > Lochnagar is an evaluation and development board for Cirrus
> > Logic Smart CODEC and Amp devices. It allows the connection of
> > most Cirrus Logic devices on mini-cards, as well as allowing
> > connection of various application processor systems to provide a
> > full evaluation platform. This driver supports the board
> > controller chip on the Lochnagar board.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > +  - compatible : One of the following strings:
> > +                 "cirrus,lochnagar1-clk"
> > +                 "cirrus,lochnagar2-clk"
> 
> What's the 1 vs. 2?
> 

There are two versions of the device, we need to be able to
differenciate between them in the driver.

> > +     - ln-pmic-32k : On board fixed regulator.
> 
> regulator?

Well that is a spectacular copy and paste oversight sorry about
that will get it fixed up.

> 
> > +     - ln-clk-12m : On board fixed regulator.
> > +     - ln-clk-11m : On board fixed regulator.
> > +     - ln-clk-24m : On board fixed regulator.
> > +     - ln-clk-22m : On board fixed regulator.
> > +     - ln-usb-clk-24m : On board fixed regulator.
> > +     - ln-usb-clk-12m : On board fixed regulator.

> > +lochnagar-clk {
> > +	compatible = "cirrus,lochnagar2-clk";
> > +
> > +	#clock-cells = <1>;
> > +
> > +	clocks = <&clk-audio>, <&clk_pmic>;
> > +	clock-names = "ln-gf-mclk2", "ln-pmic-32k";
> > +
> > +	assigned-clocks = <&lochnagar-clk LOCHNAGAR_CDC_MCLK1>,
> > +			  <&lochnagar-clk LOCHNAGAR_CDC_MCLK2>;
> > +	assigned-clock-parents = <&clk-audio>,
> > +				 <&clk-pmic>;
> > +
> > +	clk-pmic: clk-pmic {
> 
> This isn't really any relationship to the parent and I think shouldn't 
> be a sub-node.
> 

Yeah sorry that is a good point will move it out.

Thanks,
Charles
