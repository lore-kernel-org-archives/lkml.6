Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D773ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FC2154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d4TF1dbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5FC2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391386AbeIVBoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:44:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48452 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:44:25 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LJreZj032993;
        Fri, 21 Sep 2018 14:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537559620;
        bh=icKvfb9tMJ62Kdwldr/wZ1ECV2cnEFA14036T/n4CxQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d4TF1dbJHrVktV5CX4gmmPq02cZgnwMKZo//aH4PWY9g8e+cxD30f7UReMr9tHfyp
         vaeRY5RYEC6xVN3CbV6EduRSpcbgSmw3/eUEWXgou1AokhWx7oWg9Xvah+JVouHiAn
         c8nXOSIYTJJalH7/GeOFaWAAAglV+J5w8dndlaeM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJreQl022694;
        Fri, 21 Sep 2018 14:53:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 14:53:40 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 14:53:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LJreat022060;
        Fri, 21 Sep 2018 14:53:40 -0500
Date:   Fri, 21 Sep 2018 14:53:40 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <tony@atomide.com>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Message-ID: <20180921195340.jo3m5bisgntk6wsh@kahuna>
References: <20180828005056.27326-1-nm@ti.com>
 <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:55-20180828, Santosh Shilimkar wrote:
> On 8/27/2018 5:50 PM, Nishanth Menon wrote:
> > K3_ARCH uses TISCI for clocks as well. Enable the same
> > for the driver support.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > Ref: https://patchwork.kernel.org/patch/10447677/
> > 
> > Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..
> > 
> >   drivers/clk/Makefile         | 1 +
> >   drivers/clk/keystone/Kconfig | 2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Since it is almost a month.. Gentle poke? I am not sure when clk
gets picked up.. but checked clk-next (7be9338d38a6 Merge branch
'clk-mvebu-periph-pm' into clk-next) and linux-next ( next-20180921 )
and did'nt see the patch..

-- 
Regards,
Nishanth Menon
