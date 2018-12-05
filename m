Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D311C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DF320989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DF320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeLELgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:36:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53002 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbeLELgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:36:43 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5BTc4M029184;
        Wed, 5 Dec 2018 05:35:40 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2p3rk7ffja-1;
        Wed, 05 Dec 2018 05:35:40 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id CA16C611C8B4;
        Wed,  5 Dec 2018 05:35:39 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Dec 2018
 11:35:39 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wB5BZZ82006220; Wed,
 5 Dec 2018 11:35:36 GMT
Date:   Wed, 5 Dec 2018 11:35:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        David Dajun Chen <dchen@diasemi.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Eric Miao <eric.miao@marvell.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mike Rapoport <mike@compulab.co.il>,
        Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        <linux-omap@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Message-ID: <20181205113535.GX16508@imbe.wolfsonmicro.main>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=966 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812050106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 11:23:07PM -0500, Paul Gortmaker wrote:
> The solution to #4 is similar - we delete the ".remove" function and
> the binding into the platform_driver struct.  However, since the same
> ".remove" function could also be triggered by an "unbind" (such as for
> pass-through of a device to a guest instance)  - so we also explicitly
> disable any unbind for the driver.
> 
> The unbind mask allows us to ensure we will see if there was some odd
> corner case out there that was relying on it.  Typically it would be a
> multi-port ethernet card passing a port through to a guest, so a
> sensible use case in MFD drivers seems highly unlikely.  This same
> solution has already been used in multiple other mainline subsystems.
> 

I guess if this is a general direction thing, but it does seem
that module unload is not the only reason one might ever unbind a
driver. So are we sure we want to remove the option to unbind
these drivers? Certainly for testing it is sometimes useful.

Thanks,
Charles
