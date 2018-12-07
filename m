Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927A4C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EE3208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544215320;
	bh=OtDqfq3w8gp1NsX6Qb0YVgy1KI6ESC5c2NQQmld852c=;
	h=References:Subject:Cc:From:To:In-Reply-To:Date:List-ID:From;
	b=MEekata02xxiBCdDLFM80WwUdLCj5caepeV9Rdc32DXmO1TBzbHjEMslJok+okXGD
	 bNR/EhHE2VSudCmHc5BTr5bkIOSebSsuAa8Hf/LUtv44lp7Nbp5wmPVH8B/dUc+9BX
	 QSzeX3PHEycEjucsUlOVTzJdmv/Cjh0VuPmhWhrw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EE3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbeLGUl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLGUl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:41:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFB420868;
        Fri,  7 Dec 2018 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544215318;
        bh=OtDqfq3w8gp1NsX6Qb0YVgy1KI6ESC5c2NQQmld852c=;
        h=References:Subject:Cc:From:To:In-Reply-To:Date:From;
        b=cAShwgoJ5MLskx/T8qZ0dWlrQfgoJpGnq7+Wg/+PgmKvXtVTsc+lObvgJ2xd5c9fn
         gXgeQdWcEn/pJQ93aZLPSQFzcRnpEsDjbcAnH27fknYxbHznHIGv1sT7Vibx7ZI3Y7
         h72szmveFAehpU+Lx4r8zMjWJ18RryjWzJRhrklE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-2-sboyd@kernel.org> <CAMuHMdVWbcoVr9E9nmKvhrUAAf4817wEQnQ6QrF1sWeHpgL_2g@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk: renesas: Remove usage of CLK_IS_BASIC
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <154421531739.168715.18141681984476948631@swboyd.mtv.corp.google.com>
In-Reply-To: <CAMuHMdVWbcoVr9E9nmKvhrUAAf4817wEQnQ6QrF1sWeHpgL_2g@mail.gmail.com>
Date:   Fri, 07 Dec 2018 12:41:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2018-12-07 00:27:11)
> Hi Stephen,
>=20
> On Thu, Dec 6, 2018 at 10:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > This flag doesn't look to be used by any code, just set in various clk
> > init structures and then never tested again. Remove it from these
> > drivers as it doesn't provide any benefit.
> >
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: <linux-renesas-soc@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> Thanks!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> I assume you want to apply this yourself, with the rest of the series?
>=20

Yes I'll apply it to clk-next. Thanks.

