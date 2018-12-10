Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B582084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544469618;
	bh=2AGN2PcwGti2dDpMVvtBewhNOhrFKjahOgrPVKm3xrU=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=eTatxh8wXbcZoGbJa2GNMvqroLvNeNWWH3HWsPItPn99kI6q2zJJ+5Hdn/xkjLpac
	 eNOzOnNeWCewgPX2pZGnFvr5N4gGEUTSWKw0nenR3RBwFwZCfA6ECDY4GrCxzGVIT5
	 aJYDGYvEMWeYQ105085bf5SXC2uuhsCjWkpWOG8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B582084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeLJTUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLJTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:20:16 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0670E2081F;
        Mon, 10 Dec 2018 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544469616;
        bh=2AGN2PcwGti2dDpMVvtBewhNOhrFKjahOgrPVKm3xrU=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=HHwAOjfAZ4wC59VzokefI95Lj18MpLf++5b7XHP1VnLkLAxL4ej9RFqES4LzHOGbO
         nwwBkfKbQffn9zE2erx8XlKtTXe0Icv0wFjJ7gBj/m3+XK6qfgaFROPonJvNtNsI1g
         uUR9N91oO5DyGhgKpk6zObXglsrFpqtna61b15TY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181210081454.GQ3987@dragon>
Message-ID: <154446960530.17204.11121916509657625570@swboyd.mtv.corp.google.com>
To:     Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com> <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com> <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com> <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com> <20181210081454.GQ3987@dragon>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 10 Dec 2018 11:20:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-12-10 00:14:56)
> On Wed, Dec 05, 2018 at 11:41:01AM -0800, Stephen Boyd wrote:
> > No worries, I fixed it up and merged to clk-next.
>=20
> Hi Stephen,
>=20
> In order to send imx7ulp device tree for 4.21, I pulled branch
> clk-imx7ulp into IMX tree to resolve the dependency on clock ID
> definitions.  So please keep the branch stable, thanks.
>=20

Ok. No problem. Thanks for letting me know.

