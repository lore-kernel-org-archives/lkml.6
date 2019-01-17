Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464F520856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547747858;
	bh=aFoDpqYyvIa3XPsbditSEh0OFxF2BqwNiWwJrygHAXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IWCdoZ2/i1MWW49LcHT/ncpCWzx09tvAL9jjkDxwjRZ/PBudYHt5cB+qwhE4p0U2h
	 miETaCCrEY89UudLSozfgQg70ssvBx3p3J4zqptGVskzpXSCVJ8lJ95S1+GFzmUgXt
	 dCEaoiZVTW2NzXTYTtbGkoRhynamo5cvEWlc7RnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAQR5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfAQR5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:57:36 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 177EF20868
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547747855;
        bh=aFoDpqYyvIa3XPsbditSEh0OFxF2BqwNiWwJrygHAXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QlqgMrmq49+sejNQtjRK5F10YCozvuY6j/VzfXxvgpc/YjM+fWV1kvzVEQbrCk1Xf
         TijPnmQk3GELXX8X+k99/a1U/fjwqB+++G4/L8ch2isT9rNJHGtGZ+w+5gw3BStQ+c
         gK9ppYBONzS98hJeVGjpaoeX7VyKYkYNgmIzM/gk=
Received: by mail-qt1-f181.google.com with SMTP id k12so12273896qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:57:35 -0800 (PST)
X-Gm-Message-State: AJcUuke/7h1Yq0NfqjoZxfJxrbiHUjxXczwyjvTytz81is5Ynt2mCaoT
        MYrlGxCSaZStJNBxkAwLR/iA6p5W+qiEkp5atQ==
X-Google-Smtp-Source: ALg8bN5tTpOwVkO7HghKv9Tc67I088OBEEsYyHiz+yga2EbGVQngUS7+t4tTs69bxdaM/qNQGnR6B5SksVNUumPISfE=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr12635189qvl.77.1547747854238;
 Thu, 17 Jan 2019 09:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
In-Reply-To: <20190114144202.27315-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Jan 2019 11:57:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKwj46CSB8vRbYyU6kRMTXqa2Q6O=vQkJwTwC_gHjOf-g@mail.gmail.com>
Message-ID: <CAL_JsqKwj46CSB8vRbYyU6kRMTXqa2Q6O=vQkJwTwC_gHjOf-g@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce bus domains controller framework
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        loic pallardy <loic.pallardy@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 8:42 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> The goal of this framework is to offer an interface for the
> hardware blocks controlling bus accesses rights.
>
> Bus domains controllers are typically used to control if a
> hardware block can perform read or write operations on bus.

Lots of things are domains. Power domains, clock domains, etc. But
naming is hard.

We now have the inter-connect binding which ATM only deals with
bandwidth. Any reason we can't add access controls to that?

> Smarter domains controllers could be able to define accesses
> rights per hardware blocks to control where they can read
> or write.
>
> Domains controller configurations are provided in device node,
> parsed by the framework and send to the driver to apply them.
> Each controller may need different number and type of inputs
> to configure a domain so device-tree properties size have to
> be define by using "#domainctrl-cells".
> Domains configurations properties have to be named "domainsctrl-X"
> on device node.
> "domainsctrl-names" keyword can also be used to give a name to
> a specific configuration.
>
> An example of bus domains controller is STM32 ETZPC hardware block
> which got 3 domains:
> - secure: hardware blocks are only accessible by software running on trust
>   zone.
> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>   linux kernel).
> - coprocessor: hardware blocks are only accessible by the corpocessor.

We already have a way to assign secure vs. non-secure with 'status'.
Ignoring co-processors for a minute, why does that not work for you?

Co-processors are so varied in terms of capabilities and view of the
system, I'm not sure we can define something generic.

> Up to 94 hardware blocks of the soc could be managed by ETZPC and
> assigned to one of the three domains.
>
> It is an RFC, comments are welcome to help to create this framework, thanks.

Finally, for a new, common binding, I'd like to see more than one
platform using it (or at least an intent to use it).

Rob
