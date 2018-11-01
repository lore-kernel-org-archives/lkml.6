Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C252251C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVzNaucR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C252251C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeKBIkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeKBIkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:40:51 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0AC2251C;
        Thu,  1 Nov 2018 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541115346;
        bh=vdSiiXjuHzsYQhPZbkWEzdaYqLVb0qmrSizjKkWE9gs=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=GVzNaucR63Orl1enOLnLq7zaaO66VOaBKQtTU0BZvjMZJiX6tD1/DkOKqHah1UIT+
         ItSNNQg4vK9wzVkMs2eX596WZwHwuUuzEw0oe0TR/jpE7Mte6/3Q03GyTOf2jvhFKV
         EwVQEwHw5FdhSBjZbAkZaxXIKf0vw+E0T4yj90c4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alan Tull <atull@kernel.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
Message-ID: <154111534593.88331.1129843003477644482@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/5] Implement devm_of_clk_add_provider
Date:   Thu, 01 Nov 2018 16:35:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-11-01 07:40:39)
> All Tull reported that there might be a great ammount of drivers with
> imbalance on clk_add_provider. This is an issue for Device tree overlays
> (and also a bug) https://lkml.org/lkml/2018/10/18/1103
> =

> This patchset implement a devm_ function of of_clk_add_provider, and
> fixes 3 drivers.
> =

> Drivers like clk-gpio will be easily fixed with coccinelle if this set
> is accepted. (I volunteer, I want to learn how to use it, just seen the
> great presentations from Julia).

We already have devm_of_clk_add_hw_provider(), so any instances of
of_clk_add_provider() should be replaced with that, instead of
propagating the usage of of_clk_add_provider() any further. I'll gladly
apply patches to convert drivers from struct clk based APIs to struct
clk_hw based APIs so that we can clearly split clk providers from clk
consumers. So if you're interested in working on some coccinelle script
for that it would be great!

