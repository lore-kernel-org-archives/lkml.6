Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24037C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAAF2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544470498;
	bh=yeXlX/XZ7Cf3vKr9VT+19QjwSmppxiZce6jmBVjeYpY=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=PLizcd3Jm988tnDXzYcRu0OS+uz2zifXCIfsxIzJ7btnD2FXhOaJJGm0DqNAd9nIa
	 9SKetsYcFdYQ9T+A+yR4YvSF+TKhgEfcWTPsUR+5+zcBJsZvqsp6rTzN0iob20mlFi
	 9HOxyl7Iuis41tEMhEfU9z/V2QphQWpbgLvDYoRA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAAF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeLJTe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbeLJTe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:34:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEEF20821;
        Mon, 10 Dec 2018 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544470496;
        bh=yeXlX/XZ7Cf3vKr9VT+19QjwSmppxiZce6jmBVjeYpY=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=t6E2V11Fyp3iwINPdNIeRdbSAt0oca4m3JAMCeO6R/8JuhHJEv/j9yiLTYevJ+WE0
         jemJOWTDaMYs9B11GyNvo+72Fuji2UQxEPGya2Dq9eIGqtEHQSADirVzBeD2ss2ats
         xSUB0DtMv5v/u0/uhsWjp15Zfmxu/j04YhJhQDck=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1543559158-2891-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154447049532.17204.8968924447056060225@swboyd.mtv.corp.google.com>
To:     "clement.peron@devialet.com" <clement.peron@devialet.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] clk: imx6q: add DCICx clocks gate
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543559158-2891-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 10 Dec 2018 11:34:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-11-29 22:31:40)
> On i.MX6QP/i.MX6Q/i.MX6DL, there are DCIC1/DCIC2 clocks
> gate in CCM_CCGR0 register, add them into clock tree for
> clock management.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

