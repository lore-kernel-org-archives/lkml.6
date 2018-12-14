Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEFC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B1208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824886;
	bh=hJ9oA+Xb3Y24SLrB8Q7AD0wh1ZV9YyqxsiTAT/djpmA=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=tsydK3BO16ThxLqLwyyDelfFJiHVKEB6uVDNORAzUXc0w/9cqcqJFZTVB44QZMXH7
	 d8bv90R6bhEu32N+lnZPomfv7Aqq/sK1XM06ROXMS/OE88TE8vzcSi6Timp9flkAMM
	 Os8DxSpt0p+Vco+Qhvb/Oe8yI9D7GZiLkV9ZO8dQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbeLNWBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbeLNWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:01:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DF22080F;
        Fri, 14 Dec 2018 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824884;
        bh=hJ9oA+Xb3Y24SLrB8Q7AD0wh1ZV9YyqxsiTAT/djpmA=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=KhyL0c5RyM7kl4V1QTev8ESQ+TB0qGQdzEVyFCLPAfRmvWtkrICQRjIfF9pw9QPsn
         Z0D7Llvl3cZfhwWz20LV35PWomK/eh38M7L3cUX/ZCgSWckp9CxyKu0fFLJqR96l52
         IH8+NYg33UJ4IUmhWFgzmd4JBPh6IVagiH02nq0s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181210073240.32278-14-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 12/12] clk: mediatek: Allow changing PLL rate when it is off
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com> <20181210073240.32278-14-weiyi.lu@mediatek.com>
Message-ID: <154482488309.19322.1300826887966936368@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Fri, 14 Dec 2018 14:01:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-12-09 23:32:40)
> From: James Liao <jamesjj.liao@mediatek.com>
>=20
> Some modules may need to change its clock rate before turn on it.
> So changing PLL's rate when it is off should be allowed.
> This patch removes PLL enabled check before set rate, so that
> PLLs can set new frequency even if they are off.
>=20
> On MT8173 for example, ARMPLL's enable bit can be controlled by
> other HW. That means ARMPLL may be turned on even if we (CPU / SW)
> set ARMPLL's enable bit as 0. In this case, SW may want and can
> still change ARMPLL's rate by changing its pcw and postdiv settings.
> But without this patch, new pcw setting will not be applied because
> its enable bit is 0.
>=20
> (am from https://patchwork.kernel.org/patch/9411983/)

Remove this.

>=20
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> Acked-by: Michael Turquette <mturuqette@baylibre.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
