Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1503AECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC05320C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ydCV1Tyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC05320C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeGQDK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbeGQDK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:10:56 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F4520BED;
        Tue, 17 Jul 2018 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531795239;
        bh=bIrBnG4oVYfiizv0mn0+QjyB1i5OZK8XAI7zfYPI1m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ydCV1Tyh2eTeUysE3LXNjRh2EomJXDLj1t/V/YIc2Pzq/waolK27ho+mAyYG8DuBx
         G81Gnnt/mhH6uIDdyeKETMsmT7xg/cFsv9oKpC4JyPjg4ZoYElWwfJqhbltMTssprE
         lw0f8pjI6t+sjPGYEWKOB+cL+f9og+I4/5aKY1TA=
Date:   Tue, 17 Jul 2018 10:40:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] ARM: dts: make pfuze switch always-on for imx
 platforms
Message-ID: <20180717024027.GA4576@dragon>
References: <1530063055-25914-1-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315B66212D928D7EAF27557F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM3PR04MB1315B66212D928D7EAF27557F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 02:16:55AM +0000, Anson Huang wrote:
> Hi, Shawn
> 	Although the commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch") is reverted to avoid the boot failure on some i.MX platforms, but adding the "regulator-always-on" property for those pfuze's critical switches are the right way and making sense, no matter how the pfuze regulator's switch ON/OFF function will be implemented, below patches should can be applied anyway?
> 
> ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
> ARM: dts: make pfuze switch always-on for imx platforms
> ARM: dts: imx6sl-evk: keep sw4 always on
> 
> 	Let me know your thoughts, thanks!

Okay, resend them as a series with commit log updated, since the commit
log doesn't reflect the current situation any longer.

Shawn
