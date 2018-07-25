Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB479C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9383020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3HZD34J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9383020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeGZAhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbeGZAhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:37:01 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F66120833;
        Wed, 25 Jul 2018 23:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532560985;
        bh=Esat033kCywSxZnojg81rFZZjLXzwAxkVuGCTfGybao=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=j3HZD34JdRkMW5JWJPt3Eol8MDlUsKWvFW/M4ZvuZopOVtKx8eu+Zs9IB08Pz3m0A
         HzRUJBg+qTHxbmSSoq1B69RW9pKKyMPuiw2f2x09Hi3zrD9fpZSZuENWJfUi7PG51s
         U+fpdV0gEPcT4u4fkzyc43fWPFIyDUU2QFxF9C68=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <153256098433.48062.7081577175619627994@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: uniphier: add NAND 200MHz clock
Date:   Wed, 25 Jul 2018 16:23:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2018-07-20 01:37:35)
> The Denali NAND controller IP needs three clocks:
> =

>  - clk: controller core clock
> =

>  - clk_x: bus interface clock
> =

>  - ecc_clk: clock at which ECC circuitry is run
> =

> Currently, only the first one (50MHz) is provided.  The rest of the
> two clock ports must be connected to the 200MHz clock line.  Add this.
> =

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

