Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69832C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B12083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285B12083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeJOSd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:33:56 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:44912 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbeJOSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:33:56 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9FAn7Hn028178;
        Mon, 15 Oct 2018 05:49:07 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n3es3t35e-1;
        Mon, 15 Oct 2018 05:49:07 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id A8096611C8B0;
        Mon, 15 Oct 2018 05:51:22 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 15 Oct 2018
 11:49:06 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9FAn5qk011136; Mon,
 15 Oct 2018 11:49:05 +0100
Date:   Mon, 15 Oct 2018 11:49:05 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <broonie@kernel.org>, <lee.jones@linaro.org>,
        <linus.walleij@linaro.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181015104905.GF1653@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-3-ckeepax@opensource.cirrus.com>
 <153924124658.207691.10370075148426001371@swboyd.mtv.corp.google.com>
 <20181011132602.GD1653@imbe.wolfsonmicro.main>
 <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <153935999691.5275.1587207165396958375@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810150100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 08:59:56AM -0700, Stephen Boyd wrote:
> Quoting Charles Keepax (2018-10-11 06:26:02)
> > On Thu, Oct 11, 2018 at 12:00:46AM -0700, Stephen Boyd wrote:
> > > Quoting Charles Keepax (2018-10-08 06:25:40)
> > > > +struct lochnagar_clk_priv {
> > > > +       struct device *dev;
> > > > +       struct lochnagar *lochnagar;
> > > 
> > > Is this used for anything besides getting the regmap? Can you get the
> > > pointer to the parent in probe and use that to get the regmap pointer
> > > from dev_get_remap() and also use the of_node of the parent to register
> > > a clk provider? It would be nice to avoid including the mfd header file
> > > unless it's providing something useful.
> > > 
> > 
> > It is also used to find out which type of Lochnagar we have
> > connected, which determines which clocks we should register. I
> 
> Can that be done through some device ID? So the driver can be untangled
> from the MFD part.
> 
> > could perhaps pass that using another mechanism but we would
> > still want to include the MFD stuff to get the register
> > definitions. So this approach seems simplest.
> 
> Can the register definitions be moved to this clk driver?
> 
> Maybe you now get the hint, but I'd really like to be able to merge and
> compile the clk driver all by itself without relying on the parent MFD
> device to provide anything at compile time.
> 

If you feel strongly but since the MFD needs to hold the regmap
(which needs to define the read/volatile regs and defaults)
these will need to be duplicate defines and personally i would
rather only have one copy as it makes updating things much less
error prone.

> > > > +       if (lclk->regmap.dir_mask) {
> > > > +               ret = regmap_update_bits(regmap, lclk->regmap.cfg_reg,
> > > > +                                        lclk->regmap.dir_mask,
> > > > +                                        lclk->regmap.dir_mask);
> > > > +               if (ret < 0) {
> > > > +                       dev_err(priv->dev, "Failed to set %s direction: %d\n",
> > > 
> > > What does direction mean?
> > > 
> > 
> > Some of the clocks can both generate and receive a clock. For
> > example the PSIA (external audio interface) MCLKs, the attached
> > device could be expecting or providing a master audio clock. If
> > the user assigns a parent to the clock we assume the attached
> > device is providing a clock to us, otherwise we assume we are
> > providing the clock.
> 
> And this directionality is determined by dir_mask? It would be great if
> this sort of information was in the commit text or in a comment in the
> driver so we know what's going on here.
> 

No problem will make this more clear.

Thanks,
Charles
