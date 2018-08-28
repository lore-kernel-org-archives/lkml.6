Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED070C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E12087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9OmKrTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920E12087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH2CZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbeH2CZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:25:50 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875292087B;
        Tue, 28 Aug 2018 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535495524;
        bh=KNDE63myee7q7naAlBxUf1fdJwePm2cQnRXiGEHjZaw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=p9OmKrTfqUp5qEo5YGUJ+lP4VSYtlDBUX01aju3bQjaJ7qRgYBgE9OB8XlMxybCU7
         5KPAybps7LaW+uhh1tEa045vNuQcnZaHLPHlTBz+QZxmG4wwJwr03AB/1g0HFetQMw
         O/3aSJQ368Dazzgku8pdXTHU9Eb2kfS1pw0NLHqE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Johan Hovold <johan@kernel.org>, Tero Kristo <t-kristo@ti.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180822090319.29167-1-johan@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
References: <20180822090319.29167-1-johan@kernel.org>
Message-ID: <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date:   Tue, 28 Aug 2018 15:32:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2018-08-22 02:03:19)
> Fix child-node lookup which by using the wrong OF helper was searching
> the whole tree depth-first, something which could end up matching an
> unrelated node.
> =

> Also fix the related node-reference leaks.
> =

> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")

Found by inspection? Or it's actively causing problems? I'm thinking
it's the former so this can bake in clk-next for a while.

