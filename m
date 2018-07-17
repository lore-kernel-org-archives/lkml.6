Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3C1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE48208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+D4G/Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE48208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeGQGpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbeGQGpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:45:49 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2734E208AD;
        Tue, 17 Jul 2018 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531808093;
        bh=lta4qCa9f7aqclIKu9G1ICn8m8pHlZdXFOnMNLtUX1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+D4G/Kwh9heONu24kshD5UUDTy4pZ92IPj4U1j93TtR7V9Y7b7VP6pqlqHtiB29A
         jc3h5wTbSq9w6zDzjuiUePhgJY1fjrmH/v0DgmA1tLpwME3zLyihWB1tUAemdTpCZo
         YxYFdV6hmPQq9EJevBb8yhFt63+wAtYNXZT5e1XQ=
Date:   Tue, 17 Jul 2018 14:14:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
Message-ID: <20180717061439.GH4576@dragon>
References: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 01:01:15PM +0300, Leonard Crestez wrote:
> This is functionally identical but simpler and slightly faster.
> 
> The PU domain is turned on at boot time and never turned off. In the
> current implementation the pm core will repeatedly call power_off when
> the domain is unused and get -EBUSY back. If the domain is marked as
> "always on" instead the pm core won't even attempt to turn it off.
> 
> In theory on 6qp it is safe to turn PU off in suspend, however that is
> best accomplished with a new core flag.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied all, thanks.
