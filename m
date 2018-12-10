Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F264C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FC020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544429749;
	bh=5y3zc/+2hkhN1mF9U7YAwTWZDQrnbdgBDNip+gKr0+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qylk7XtART0SucPvTbHN6bGzfG9L5q/o6vnjyOMyGNaeCiCfa+nKSWNbzVwHbd1N3
	 NOwg2XY2yoKuZM6Sy1zcTqlRNlHOXRHhqAvAGw68eUjopCtWVj5sLOLCZdj1Ck/AXw
	 zcGoo+YEVQe/K6pnXHJBJusxDrzywK0Y+YcnrU0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FC020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLJIPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLJIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:15:47 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF1B2082F;
        Mon, 10 Dec 2018 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544429747;
        bh=5y3zc/+2hkhN1mF9U7YAwTWZDQrnbdgBDNip+gKr0+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNBpfdX4mjxl+6UK2W1FrAKhGAx3vYd/VmOWLDiTtyR+yVlSJphsGs9WUb9jgwYE+
         efFNr1sfVQLfQ2nkaxhS6l0lnrezF5Ahg17HKjljYBsCcrXJbIyjMkF3Sp6Mrq1KJb
         iZKFr3QF3Qo5WbskeA6hx+gbx82kwXe+OncexzRw=
Date:   Mon, 10 Dec 2018 16:14:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
Message-ID: <20181210081454.GQ3987@dragon>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:41:01AM -0800, Stephen Boyd wrote:
> No worries, I fixed it up and merged to clk-next.

Hi Stephen,

In order to send imx7ulp device tree for 4.21, I pulled branch
clk-imx7ulp into IMX tree to resolve the dependency on clock ID
definitions.  So please keep the branch stable, thanks.

Shawn
