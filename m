Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D04C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C66214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fom5lheZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1NlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:41:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39467 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1NlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:41:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so14237013ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8o4J5b7e5xMrJT7yIBgifQ6pcR7efKYk2SmD7+QxuM=;
        b=fom5lheZ0gJF6Jy18hXb7efeqA1M5D7xdfZQfKDuvdq4kQ71XH1i69259xej+kR9/e
         YKRaL2GS7JqWFNKbvZYvkpt/3eRK1gnFwpSptXrzoK68JF6zSUh8g1TuhKTRwO8grUvd
         Z8I3zfVzLi6ADgUp+P/XcY1q0YsczeUCBHCL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8o4J5b7e5xMrJT7yIBgifQ6pcR7efKYk2SmD7+QxuM=;
        b=hfUSCErgeqCR3FGAaBD6jplrxD5ojodi2o9fwGnjdiVCF4FpzV941rsOlzm8AGLkiR
         LPiSRVk3/OEjeWBuyju4osknZ23hTaAGsISe0S4pDQX+1H9rzwH5dWLOKY1xtqe/klAg
         dK+JP8sw8DVSpfv6fXqGzZI39jc3xNXRjqHzrdce9w9uHpuWRz6HoyKT5JjBw9W9z0gM
         /xgUgUfVPzp4BrHnS19E/BcziuHEwQgjT8XfB9jbLSbOkRKgkX826PA3prTY3Djt4owd
         VK7yxk/KfRHaa5vh7mI6Kh7+DEPozRlHm7P2RvREEnfi76gjy3BYzqzBAiVfah1pqKdD
         exdw==
X-Gm-Message-State: AJcUukf1PE96eJGqg1ZF5jfMzHWtLNmd/RiHEwBzQTAinhHAnvkYpHQo
        ev8v3jPlIM/L1zuE6wftA19EPp8MnQzEXQAcxMrjiQdi
X-Google-Smtp-Source: ALg8bN7m/A/VFH1kOJV4RS3EC+xGWkbGJYBbc3STs3vJ11zQdiRHieNAFoWcDvsmJ13GpqNhJDw7BSnkQ2TeZ4u6aGo=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr18071005ljc.97.1548682880932;
 Mon, 28 Jan 2019 05:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20190122211822.7016-1-vz@mleia.com>
In-Reply-To: <20190122211822.7016-1-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 14:41:09 +0100
Message-ID: <CACRpkdYn2dtUK5UYR7a-omkhTxavH3DUAeh4KK1y2kedstx79g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: remove unused 'pinconf-config' debugfs interface
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:18 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> The main goal of the change is to remove .pin_config_dbg_parse_modify
> callback before a driver with its support appears. So far the in-kernel
> interface did not attract any users since its introduction 5 years ago.

Good riddance. Both patches applied.
Thanks for noticing this and making the world
a better place by getting rid of this.

Yours,
Linus Walleij
