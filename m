Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E809C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AB320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Z0FUJXpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfA2TWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:22:45 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:45050 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfA2TWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1548789756; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/aEekcWIhaR6pCkL1wjpjvgEdW7dbXfax+7aRkTe148=;
        b=Z0FUJXpSAxbT7foYtXbAiy9pY+BSqaZ7Nto0V4P42ecrBkfDLEtrQIQto7eWMsdTM0Mswy
        nIz8WgKJUiWvb393WXaE+nJ6tdyxK48dLjOWSeQV2nhu4lQOD63YoMBCF0KFx4rJSe4GHG
        hJTaP22ZcW0duwX7FSRAy9aS+/49Vus=
Date:   Tue, 29 Jan 2019 16:22:25 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: jz4740: Fix gating of UDC clock
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1548789745.2531.0@crapouillou.net>
In-Reply-To: <154878559039.136743.10189442694979275708@swboyd.mtv.corp.google.com>
References: <20190125153436.13517-1-paul@crapouillou.net>
        <154844250661.136743.15303302299846585853@swboyd.mtv.corp.google.com>
        <1548444298.1804.2@crapouillou.net>
        <154878559039.136743.10189442694979275708@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mar. 29 janv. 2019 =E0 15:13, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Paul Cercueil (2019-01-25 11:24:58)
>>  Hi,
>>=20
>>=20
>>  On Fri, Jan 25, 2019 at 3:55 PM, Stephen Boyd <sboyd@kernel.org>=20
>> wrote:
>>  > Quoting Paul Cercueil (2019-01-25 07:34:36)
>>  >>  The UDC clock is gated when the bit is cleared, not when it is=20
>> set.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net
>>  >> <mailto:paul@crapouillou.net>>
>>  >>  Tested-by: Artur Rojek <contact@artur-rojek.eu
>>  >> <mailto:contact@artur-rojek.eu>>
>>  >>  ---
>>  >
>>  > Any Fixes tag for this?
>>  >
>>=20
>>  Fixes: 2b555a4b9cae
>>=20
>>  Should I resend?
>>=20
>=20
> No need to resend. Is this fixing something that's broken in the=20
> v5.0-rc
> series? I'm trying to understand if this is a critical fix or a
> non-critical fix that can bake until the next release cycle.

It's been broken for one year and nobody noticed, it can wait for 5.1.

-Paul
=

