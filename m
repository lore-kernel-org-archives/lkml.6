Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C084AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA8621735
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA8621735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeHHMSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:18:46 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42016 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbeHHMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:18:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w789x0Lr027708;
        Wed, 8 Aug 2018 04:59:10 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2kn9j1ncbw-1;
        Wed, 08 Aug 2018 04:59:10 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 87EB3611C8B0;
        Wed,  8 Aug 2018 04:59:09 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 8 Aug 2018
 10:59:08 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w789x5cb014434; Wed,
 8 Aug 2018 10:59:05 +0100
Date:   Wed, 8 Aug 2018 10:59:05 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "leonard.crestez@intel.com" <leonard.crestez@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API [UNSCANNED]
Message-ID: <20180808095905.GG32322@imbe.wolfsonmicro.main>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
 <20180806143901.GP2414@sirena.org.uk>
 <1533569985.11050.9.camel@analog.com>
 <20180806160402.GR2414@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180806160402.GR2414@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=822 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808080102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:04:02PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2018 at 03:39:53PM +0000, Popa, Stefan Serban wrote:
> > On Lu, 2018-08-06 at 15:39 +0100, Mark Brown wrote:
> 
> > > I suggested having an explicit operation to check if a register supports
> > > this mode of operation when I reviewed an earlier version, I didn't
> > > notice a reply on that?
> 
> > Sorry, I got confused about what needs to be done. Should I add a new field
> > to the regmap_config struct which will be checked during the function call?
> > Something like can_multi_write? How do you suggest it should be called? Is
> > readable_noinc_reg ok?
> 
> Like I said last time I'd suggest making it more like the readable and
> volatile checks - I'm fairly sure I've seen devices that don't
> autoincrement only for some registers.

I can confirm I have seen hardware that autoincrements for some
registers and not for others.

Thanks,
Charles
