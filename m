Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D39C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC342083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC342083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeIAAma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:42:30 -0400
Received: from baldur.buserror.net ([165.227.176.147]:50182 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeIAAm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:42:29 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fvq2A-0004G2-NO; Fri, 31 Aug 2018 15:28:48 -0500
Message-ID: <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Andy Tang <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Date:   Fri, 31 Aug 2018 15:28:44 -0500
In-Reply-To: <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
         <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
         <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
         <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
         <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
         <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
         <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: andy.tang@nxp.com, vabhav.sharma@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com, yogeshnarayan.gaur@nxp.com, linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 06:12 +0000, Andy Tang wrote:
> Hi Scott,
> 
> Please see my replay inline.
> 
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
> > On Behalf Of Scott Wood
> > Sent: 2018年8月31日 1:43
> > To: Vabhav Sharma <vabhav.sharma@nxp.com>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> > viresh.kumar@linaro.org; linux-clk@vger.kernel.org;
> > linux-pm@vger.kernel.org; linux-kernel-owner@vger.kernel.org;
> > catalin.marinas@arm.com; will.deacon@arm.com;
> > gregkh@linuxfoundation.org; arnd@arndb.de;
> > kstewart@linuxfoundation.org; yamada.masahiro@socionext.com
> > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Andy Tang
> > <andy.tang@nxp.com>; linux@armlinux.org.uk; Varun Sethi
> > <V.Sethi@nxp.com>; Udit Kumar <udit.kumar@nxp.com>
> > Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
> > lx2160a
> > 
> > On Thu, 2018-08-30 at 12:39 -0500, Scott Wood wrote:
> > > On Thu, 2018-08-30 at 07:36 +0000, Vabhav Sharma wrote:
> > > > > 
> > > > > Why are you increasing NUM_CMUX beyond 8 for a chip that only
> > 
> > has
> > > > > 8 entries in cmux_to_group?
> > > > 
> > > > Configuration is 16 cores,8 cluster with 2 cores in each cluster
> > > 
> > > So?  This is about cmuxes, not cores.  You're increasing the array
> > > without ever using the new size.
> > 
> > Oh, and you also broke p4080 which has 8 cmuxes but no -1 terminator,
> > because the array was of length 8.  Probably the array should be changed
> > to NUM_CMUX+1 so every array can be -1 terminated.
> > 
> 
> [Andy] How about we add -1 terminator to p4080 and increase NUM_CMUX to 16?

Why 16?  What does such a change have to do with this chip, which according to
the rest of the patch has 8 cmuxes?

> We don't want to increase NUM_CMUX each time new soc with more cmuxes added.

You don't want to have to make a trivial change each time you exceed a limit
that has yet to be exceeded once since NUM_CMUX was added?  This isn't ABI or
in any other way hard to change.  It's right in the same file as the chip
description you'd be adding.

And even if a chip did come along with 16 cmuxes, you'd then need to increase
the array to 17 to hold the -1 if you don't want to leave a situation like the
p4080 is in now, where a chip's cmux array could be broken by increasing
NUM_CMUX further.

-Scott

