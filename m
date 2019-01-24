Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AEAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCAC218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548370235;
	bh=EGdrodCRleN5oWm83Eo0AiEOaihG4Y4a8ZggE3BU41Q=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=vu1KrsD6jlKxG0Uhnp8NFeffhMt/nfhh5vIrgTSIKyVzqWZtPg7dw915fwsezQ0LN
	 mdYelehehYvaDpiRlgzmg0FLoNiUvyWNbBV1UvndfU9oQCecU2ADVorPXsrwCLvhF2
	 3LIulJZpPVloTcGYKR9rdyn5j0Jwcl9nZeTbYlxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfAXWue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:50:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfAXWud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:50:33 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96F82082C;
        Thu, 24 Jan 2019 22:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548370232;
        bh=EGdrodCRleN5oWm83Eo0AiEOaihG4Y4a8ZggE3BU41Q=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=eRA7cmYdyYqVPCipVHlrtOg9HnPk6s4VLC0Ap38DxM8ryoCPT9l9W8NmI3HbfMrZ6
         3m5w+KsisnIXDj1TEGNjR2SZ/9O/O52SQXOHDNAPbBZ6jN/v1Wue61itd7/MjfUda7
         /qRojQtEKgsehOrPvFarDipITSRKbcb3V6cBJNC0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com> <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com> <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com> <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com> <154724656826.169631.7419387360923471292@swboyd.mtv.corp.google.com> <CABGGiswYYpm-7T9e6F_Mp6FdU-JFDC8xV_JR1E6cgiz32A0u_Q@mail.gmail.com>
User-Agent: alot/0.8
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CABGGiswYYpm-7T9e6F_Mp6FdU-JFDC8xV_JR1E6cgiz32A0u_Q@mail.gmail.com>
Message-ID: <154837023198.136743.2813500611695220769@swboyd.mtv.corp.google.com>
To:     Rob Herring <robh@kernel.org>
Date:   Thu, 24 Jan 2019 14:50:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-01-11 15:09:58)
>=20
> make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/file/=
to/test
>=20
> It will check only the schema specified and check all the DT files
> against only that schema (plus any referenced schema if you use a
> top-level 'allOf'. See the GIC schema patch[2] for an example of
> that).
>=20
> I'm running the schema check for patches in the DT patchwork instance.
> For example, here's this patch[1]. So as long as it has my R-by, then
> it should be good. I'm not yet running the schema check on DT files
> because generally there are warnings and I don't intend to fix them
> for everyone. But maybe I should anyways so we at least have the data.
>=20

Ok. I'll apply this patch to clk-next with my small fixes rolled in.

