Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE94C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCB422507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCB422507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeKMVOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:14:45 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37354 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732444AbeKMVOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:14:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wADB93cj018301;
        Tue, 13 Nov 2018 05:16:55 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2nnvmtvabq-1;
        Tue, 13 Nov 2018 05:16:55 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B818C611C8B6;
        Tue, 13 Nov 2018 05:16:54 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 11:16:54 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wADBGqUr023114; Tue,
 13 Nov 2018 11:16:53 GMT
Date:   Tue, 13 Nov 2018 11:16:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] mfd: lochnagar: Add initial binding documentation
Message-ID: <20181113111652.GV16508@imbe.wolfsonmicro.main>
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
 <20181108101405.14062-4-ckeepax@opensource.cirrus.com>
 <20181113082825.GB3513@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181113082825.GB3513@dell>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811130105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:28:25AM +0000, Lee Jones wrote:
> On Thu, 08 Nov 2018, Charles Keepax wrote:
> 
> > Lochnagar is an evaluation and development board for Cirrus
> > Logic Smart CODEC and Amp devices. It allows the connection of
> > most Cirrus Logic devices on mini-cards, as well as allowing
> > connection of various application processor systems to provide a
> > full evaluation platform. This driver supports the board
> > controller chip on the Lochnagar board.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > 
> > I have dropped Rob and Stephen's Acks from this patch on
> > account of the scale of the changes since v3.
> > 
> > Changes since v3:
> >  - Split the binding up into separate parts for the individual subsystems
> >  - Added documentation for the fixed clocks that are done through DT
> > 
> > Thanks,
> > Charles
> > 
> >  .../devicetree/bindings/clock/cirrus,lochnagar.txt |  89 +++++++++++++
> >  .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  70 ++++++++++
> 
> I think these should all be seperate patches.
> 

I will need to do a respin for the regulator changes anyway so
can split them up then.

Thanks,
Charles
