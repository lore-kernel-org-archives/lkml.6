Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA883C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08A2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn6oL7k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A08A2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeJBWiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeJBWiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:38:52 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32705206B2;
        Tue,  2 Oct 2018 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538495688;
        bh=yDBCGDFT6rFV4y6LqngYF8DH2bsdWOcqX8zN8DJw1CI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rn6oL7k6zNsFtXL1lpX8mqhoLPDZ/0e4Pr/InBsIAYiPD4ATdh3ecOqoQw4warC/k
         SQBry3czeJX9Xg5rZLdbnz6cLWO25Avfdb7+Drus+OABYJwBeI1aHDaW9U42kQsy/J
         L1CGNV0tWisAOfOXGLdnAJi2xYXj43Ox+g7hDwoU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <159d6244-8077-e21f-36d9-ccb1eeb3ed78@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180621073706.22812-1-brgl@bgdev.pl> <20180621073706.22812-3-brgl@bgdev.pl>
 <160f4225-236c-af54-9693-120e834af578@lechnology.com>
 <CAMRc=McmwWt5OdCxGntDJ-5cxte+Ad2FJcnmWT8NxnBtzP40DA@mail.gmail.com>
 <159d6244-8077-e21f-36d9-ccb1eeb3ed78@lechnology.com>
Message-ID: <153849568750.119890.126631906736660249@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/4] clk: davinci: kill davinci_clk_reset_assert/deassert()
Date:   Tue, 02 Oct 2018 08:54:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-10-02 08:28:44)
> On 10/02/2018 10:08 AM, Bartosz Golaszewski wrote:
> > pt., 6 lip 2018 o 19:54 David Lechner <david@lechnology.com> napisa=C5=
=82(a):
> >>
> >> On 06/21/2018 02:37 AM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> This code is no longer used. Remove it.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>> Reviewed-by: David Lechner <david@lechnology.com>
> >>> Acked-by: Stephen Boyd <sboyd@kernel.org>
> >>> ---
> >>
> >> I've picked this up in clk-davinci-4.20, so it will just hang out
> >> there for a while until the rest of this series gets merged.
> >>
> > =

> > Hi David,
> > =

> > I don't see this patch in next yet. Is it queued for 4.20?
> > =

> > Thanks in advance,
> > Bartosz
> > =

> =

> This is currently the only clk-davinici patch I have queued, so it
> might be easier to just resend it and let Stephen/Mike pick it up
> directly instead of me sending a pull request for one patch.
> =


Ok I applied it directly to clk-next.
