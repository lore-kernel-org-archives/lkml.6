Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77489C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE821903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeLUP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:29:05 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60284 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729140AbeLUP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:29:04 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBLFOqst023194;
        Fri, 21 Dec 2018 09:28:57 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pcxwrcpv5-1;
        Fri, 21 Dec 2018 09:28:56 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id EE5AE611C8A7;
        Fri, 21 Dec 2018 09:31:54 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 21 Dec 2018
 15:28:56 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wBLFSt8E017938; Fri,
 21 Dec 2018 15:28:55 GMT
Date:   Fri, 21 Dec 2018 15:28:55 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <broonie@kernel.org>, <lee.jones@linaro.org>,
        <linus.walleij@linaro.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] clk: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181221152855.GI16508@imbe.wolfsonmicro.main>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-7-ckeepax@opensource.cirrus.com>
 <154356443157.88331.15749597863624143993@swboyd.mtv.corp.google.com>
 <20181221135037.GH16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181221135037.GH16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812210119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 01:50:37PM +0000, Charles Keepax wrote:
> On Thu, Nov 29, 2018 at 11:53:51PM -0800, Stephen Boyd wrote:
> > Quoting Charles Keepax (2018-11-20 06:16:30)
> > > +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> > > +MODULE_DESCRIPTION("Clock driver for Cirrus Logic Lochnagar Board");
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_ALIAS("platform:lochnagar-clk");
> > 
> > I think MODULE_ALIAS is not needed if it's this simple?
> > 
> 
> Not actually sure on this one, to be honest its mostly cargo
> culted from other drivers. I will investigate and see what I dig
> up but if has any pointers I would greatly appreciate it.
> 

From what I can find out it looks like MODULE_ALIAS is indeed
redundant on DT only drivers, which these are at the moment so
will remove and give it a test.

Thanks,
Charles
