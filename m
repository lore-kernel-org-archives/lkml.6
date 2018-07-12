Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E44C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5143420BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsRvDncG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5143420BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeGLNzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:55:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58780 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeGLNzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:55:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CDiAFL072585;
        Thu, 12 Jul 2018 13:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tb+KxN/jtIEJbpUFVDx4pzKGivoIrQ1DA8spfIY0fGw=;
 b=fsRvDncGILqFTh5VlmrMtV26P3XsQNsUx2rx/LFutfZawzGdnlwFUiVgfOx8sh+/73Hd
 FwCoIxdz60CJDCYSoJP/OPJH7by71l7BEOnP7oryQv417l5l6eZAQ5MdCpYP0D+R06Nm
 f9weEAJu0l7aur6+bhu7Jg/cE88NwTuJwLrdZiviZePBvnVaioC0csqEX8PdcvMWHyU7
 rZnOarDO6WHn2kp94L2okP9RknXiyQQYJUt0YyyQbqnDXjke0ZQXV+u0Fo8wzR3QWrB4
 NNXfIX0CkIoa/9VRqRPrmk1XmgIDc4PzPmUdbGAnmgsbj8Nq/ZNrOozLCr/IqnNMwTcv bw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k2p7e3q1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 13:44:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CDij5R012091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 13:44:45 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CDihBf002736;
        Thu, 12 Jul 2018 13:44:44 GMT
Received: from mwanda (/41.202.241.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 06:44:43 -0700
Date:   Thu, 12 Jul 2018 16:44:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "stefan@agner.ch" <stefan@agner.ch>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "benjamin.lindqvist@endian.se" <benjamin.lindqvist@endian.se>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "mirza.krak@gmail.com" <mirza.krak@gmail.com>,
        "gaireg@gaireg.de" <gaireg@gaireg.de>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: tegra: check bounds of die_nr properly
Message-ID: <20180712134421.unczwgmvfdhezq3v@mwanda>
References: <20180704091310.22003-1-stefan@agner.ch>
 <1531402315.1390.6.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531402315.1390.6.camel@toradex.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:31:57PM +0000, Marcel Ziswiler wrote:
> On Wed, 2018-07-04 at 11:13 +0200, Stefan Agner wrote:
> > The Tegra driver currently only support a single chip select, hence
> > check boundaries accordingly. This fixes a off by one issue catched
> > with Smatch:
> >     drivers/mtd/nand/raw/tegra_nand.c:476 tegra_nand_select_chip()
> >     warn: array off by one? 'nand->cs[die_nr]'
> > 
> > Also warn in case the stack asks for a chip select we currently do
> > not support.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  drivers/mtd/nand/raw/tegra_nand.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/tegra_nand.c
> > b/drivers/mtd/nand/raw/tegra_nand.c
> > index 4daa88d814134..e65ef584df0b9 100644
> > --- a/drivers/mtd/nand/raw/tegra_nand.c
> > +++ b/drivers/mtd/nand/raw/tegra_nand.c
> > @@ -468,7 +468,9 @@ static void tegra_nand_select_chip(struct
> > mtd_info *mtd, int die_nr)
> >  	struct tegra_nand_chip *nand = to_tegra_chip(chip);
> >  	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip-
> > >controller);
> >  
> > -	if (die_nr < 0 || die_nr > 1) {
> > +	WARN_ON(die_nr >= ARRAY_SIZE(nand->cs));
> 
> Unfortunately, that has a tiny little issue as die_nr is a signed
> integer and ARRAY_SIZE of course is unsigned. While I could have sworn
> my shirt off that the compiler would have to promote this to signed
> this is not quite what happens and upon deselecting with -1 this
> warning gets triggered!

Sorry, I didn't realize we were passing -1 as die_nr.  I should have
reviewed the code more carefully.

The type is promoted to the which ever side has more positive bits or
a minimum of int.  So if you compare an int to a long long it gets
promoted to long long.  If you compare an int to unsigned int, it is
promoted to unsigned int.  If both sides are smaller than int then it
is type promoted to int.

For compares, I can't think how type promoting to int can be a problem
but where it might matter is that that people sometimes want 0xfe and
they do "~(char)0x1" but it becomes 0xfffffffe.

The other trickiness is that x << shift is type x.  Sometime people
think if they make shift a u64 and x an int, the result will be u64 but
it's still int.

I think that's basically everything with type promotion.

regards,
dan carpenter


