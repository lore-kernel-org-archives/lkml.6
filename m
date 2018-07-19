Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1EBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32DB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XiFxWPje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32DB20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeGSOuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:50:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33428 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbeGSOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:50:02 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so7180203iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=qhk7DcdRiJwPLhrUv1W8bD542RILzdVdXn5/MdJu0x0=;
        b=XiFxWPjeloioH/KeeIqsQ+oY3wjRtNDbmfXYLRSjbVNJwCnl7sXoGq/btaqZNp7AR5
         LvjlXcPoNB/A5Tx/JS9Zxt1pPX5s/aBGjVS1kvFbrfqr0RyrWOX20IZ6tkS6mDxgoD0C
         EuHFt9uLFWMm3t4XWvSwxBBqapC5zauqOc6EYEKmlu+CM/guo3YrKZSYkONPA3Ris5HT
         I8QuCWPGFDDE8k2DUAehVeRq6C3ZRUYxQNkvxkNrmVyAxOT08uiEA5jDKToCo2I1yQb1
         eaFuD0V8R6ZJWYIQVpCk6U1kW3xkUAJFspW6sFVgfoyfYOUig9TLHCWpPsWUBT6yvmav
         nhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qhk7DcdRiJwPLhrUv1W8bD542RILzdVdXn5/MdJu0x0=;
        b=oTeV/0ZdmL3FsHhedvm+xWebS/6EOK0E8S+I3sALDIBRPK3wLIxW8TvNbCtcJRzO9s
         qcpD71t2RGA4yQgNazPxC5m9KA/O48ZW/dXfRuEuor5yE+/A0rHgjnqcBX+afax+i9EX
         nKklxLR82n/UUNbalHlLTUWT+CSb4XUvwVvbOiZkPX8QZEYOeF/48dNaKk1rzzYDVxY8
         XuOb5x6TfcdUTscZq+SPmaMMc4u2rwJSs+da9mdlylji2nSKOrG42FYgx9K3cmJ1huhs
         qDquXey9BJiUs3bEEkdb4OAuexa4/GgGma1Ia+c1UhkIaeF9FH1ckfkWk5k6e7P5iLY4
         hy5w==
X-Gm-Message-State: AOUpUlGgwYuGkGsTTHhEX5lYUnOdYR1XQ09Bm+D9QaoSy30w91Do6q2v
        RurReEBo8mZtyZQcY4IOfNIb0Q==
X-Google-Smtp-Source: AAOMgpfBeOcWpbAXhinFHg73RvZSCTJXEb66vSw86NtYVf3G1WNKwpjuFe8CS/MK+S8pMdXRMZgdTA==
X-Received: by 2002:a6b:19c4:: with SMTP id 187-v6mr8668977ioz.244.1532009201519;
        Thu, 19 Jul 2018 07:06:41 -0700 (PDT)
Received: from localhost ([2604:2d80:4413:8125:59cb:8e52:e49b:158f])
        by smtp.googlemail.com with ESMTPSA id n195-v6sm1759756itg.16.2018.07.19.07.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 07:06:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <mturquette@baylibre.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <bo.yang@amlogic.com>,
        <sboyd@kernel.org>, <jian.hu@amlogic.com>,
        <xingyu.chen@amlogic.com>, <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <sunny.luo@amlogic.com>,
        <carlo@caione.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
Organization: BayLibre
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
        <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
        <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
        <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
        <1531216472.2708.71.camel@baylibre.com> <7hfu0jmhbe.fsf@baylibre.com>
        <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com>
Date:   Thu, 19 Jul 2018 09:06:39 -0500
In-Reply-To: <7e1cce0b-fc86-b900-2019-a85c5e5ba2ae@amlogic.com> (Yixun Lan's
        message of "Tue, 17 Jul 2018 09:24:02 +0800")
Message-ID: <7h601be2vk.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

[...]

>> 
>> As Jerome said, I think consistency is an important goal, so leaving off
>> the "meson-" for drivers/clk is fine with me.
>> 
> ok
>
>> Also for consistency, for the rest of the drivers, keeping "meson-" is
>> probably the right thing to do.
>> 
> ok, for the above, you are talking about the already exist compatible
> names? or the patches we will push in the future?

I'm talking about future patches.

>> However, patches would be welcome to add compatibles without the "meson"
>> for the rest of the drivers & documentation as well, but please do not
>> remove any compatibles.
>> 
> I assume you are talking about the patches in the future we will push?
> to drop the "meson".
>
> I'm confused here, as the above two paragraphs conflict with each other

Yeah, what I wrote is confusing, sorry about that.

What I mean is that new patches should stay consistent with compatibles
in their existing drivers/subsystems.  That means keeping the "meson-"
prefix for everything except drivers/clk.

In addition to that, patches would be welcome for *adding* compatibles
without "meson" to all the current drivers.

Kevin

