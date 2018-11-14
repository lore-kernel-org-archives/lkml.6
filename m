Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1907A214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb9yWuyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1907A214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeKOFoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:44:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35671 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:44:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so7828449pgu.2;
        Wed, 14 Nov 2018 11:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azqJU8sLKCqUdcpTLYFdzT1D3gVaueehGjCTsxo/J7I=;
        b=nb9yWuyL9zbRRaU8bJih2M3cf16d3bxuLapmZxZ7w5AX+gybIgWyyYnqmMMr9MT7aL
         cMgyvLlDwMN23YefP7lgifmCtoz8x0Djo0GsoYw+0Diy7dToerFKnFim6XS5NPbr649b
         G8pHuV969UKzkFPr3HCMoBQcbxKHEailsFY6KawEgFkD8z7MGdApjZG+vla23w1REf+K
         h9axfVthSOWnq2QnCFX7+JhISf6Wbu8rz1CgCSIui2MhXUDKOszXWYvl4pOM2/dUfSVk
         BugkQbI9aLOdgFg7hcuaItCOoRbNZQt6vI9P73WFJoeIO9uP4zBbw1mYIpkW2GMc61rO
         9UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azqJU8sLKCqUdcpTLYFdzT1D3gVaueehGjCTsxo/J7I=;
        b=nOe6XV53aGfInHTEUqRbwbC+j+uz84b7OtyTyYxHR3paCW7n6/ZADijBh23ayj/d1u
         T2pLtYS7GhWIXSH41XQIF9Hyh2eyE/98JgUuSFeTIEzooXlI3Tqa0jF9L/HUBsGiG2oB
         Y/oMZhggFjk9tD8RrlFVEE29iaAH+yv3fT2CoXLsYU77V+tZKwJdoZLABqfE6PGdR3yu
         P/pio2wQ+v+INnBaSCCkfouzvJGt00sINpunMPV9VY+9D4pIqA6xh1SURFlOVlj6J9Hr
         bH3shwRt/m7lNVIHpvO4se2dtbT1+WkeGAESS4dA0g2dnpf3HpK1Ip8o83SSODiwjODV
         xL4w==
X-Gm-Message-State: AGRZ1gL9SauEpyC1zLRiQEjm9QDwVNSC96AGb4upiX87VgrDSLLQMEaR
        0Dpeq1o279ckFRp/9UNKHNk99hkgBohoruKx0T7LFl2w
X-Google-Smtp-Source: AJdET5cGPwaCb/LBaMzggnnisCY++V/5k69G+JowCQIUuGvX4SHTQammvToHmxphaoJ9uJS9KSOWvnbR3DH2JllVaSA=
X-Received: by 2002:a62:3387:: with SMTP id z129-v6mr3233928pfz.143.1542224380817;
 Wed, 14 Nov 2018 11:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20180418222905.10414-1-robh@kernel.org> <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
In-Reply-To: <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Wed, 14 Nov 2018 14:39:29 -0500
Message-ID: <CAKON4OxwAmmPv2+CEtT+eO3Uu8duCKD8OqyWj8+w2Y5SZ4bfOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To:     robh@kernel.org
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        devicetree-spec@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, grant.likely@arm.com,
        Mark Rutland <mark.rutland@arm.com>, geert+renesas@glider.be,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        sboyd@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 9:36 PM Rob Herring <robh@kernel.org> wrote:
> I share the concern as I doubt most kernel developers don't know
> jsonschema. But then the alternative is us defining and writing our
> own thing which is C like 'cause that's what kernel developers
> understand. My hope is to simplify and restrict things enough that it
> writing a binding doc is straightforward without being jsonschema
> experts. That was the intent of this patch without going into all the
> details behind it.

When schemas were first discussed long, long ago the idea was to have
a n arbitrator who controls the schema (like Grant/Rob) so there is no
need for general schema design knowledge in random kernel developers.

First a developer should try and build their device tree using the
existing schema. Then only if they find that impossible to do so
should they propose schema changes. The schema arbitrator would then
look at those changes and work them into the existing schemas as
needed. Doing this via an arbitrator will ensure consistency in the
overall schema design while eliminating redundancy with slight
variations (like we have now).

Another side effect of schemas is that as they evolve and enforce
commonality among driver implementation it will become possible to
turn those in-common pieces into driver libraries.

-- 
Jon Smirl
jonsmirl@gmail.com
