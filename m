Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE701C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD602081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9Kj3r0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD602081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLDOpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeLDOpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:45:06 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB74214DA;
        Tue,  4 Dec 2018 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543934705;
        bh=hVb8TID6cd1Olg3jtzdBexIhOrCiR/d52f5IOpnmACI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I9Kj3r0o3/KmrFHvG5GA+pHQ+dy7Ck2z0nBok1uWJCjEzruGA59yQo0y1FUoCsswk
         o1aUEqebWNFZ+Ip6QC3hVzUmt5fPdbbp1IG8/nQbMgOSbjkGWOSY/gCtPmTyidtwMS
         Yy/BeYZ28OHA5lgEi9DmgXTRG0r6SrbtOljEJnKM=
Received: by mail-qt1-f176.google.com with SMTP id r14so18303203qtp.1;
        Tue, 04 Dec 2018 06:45:05 -0800 (PST)
X-Gm-Message-State: AA+aEWabfDNQBcpbRss9JXgU3Ay3IIqzCytJBrREZgoS/w6xd1DUpFNH
        ig8sLjT91RoK/1Xcd+UpjTPJCYWcAMlZnApXlg==
X-Google-Smtp-Source: AFSGD/WGVWJioClsa0lvQGJtAOGi8FkeeWgHBEl1fwnzno8/vkh5RpuvYCjALLTG0ebaUzuRMqN9CWkjmLCc7SNclL4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr19931119qtf.26.1543934704526;
 Tue, 04 Dec 2018 06:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
In-Reply-To: <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 08:44:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
Message-ID: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
Subject: Re: [PATCH v2 14/34] dt-bindings: arm: Convert Amlogic board/soc
 bindings to json-schema
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Rob,
>
> You forgot linux-amlogic in CC...
>
> On 03/12/2018 22:32, Rob Herring wrote:
> > Convert Amlogic SoC bindings to DT schema format using json-schema.
> >
> > Cc: Carlo Caione <carlo@caione.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---

[...]

> > +      - items:
> > +          - enum:
> > +              - amlogic,s400
> > +          - const: amlogic,a113d
> > +          - const: amlogic,meson-axg
> > +      - items:
> > +          - enum:
> > +              - amlogic,u200
> > +          - const: amlogic,g12a
>
> but all this feels wrong for me.
>
> First of all, this yaml description is not human friendly and not intuitive at all,
> and secondly with this conversion we loose all the comments about the SoC family relationship
> with the compatible strings !
>
> I really understand the point to have automated verification, but really it's a pain to read
> (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> I feel it will be a real pain to write !

What do you suggest that would be easier? Is it the YAML itself or the
json-schema vocabulary? For the former, we could use {} and [] to make
things more json style. But I imagine it is the latter.

There is some learning curve for json-schema and is certainly a
concern I have, but there would be a learning curve for anything. Our
choices are use some existing schema language or invent one. All the
previous efforts (there's been about 5 since 2013) have been inventing
one, and they've not gone far. There will be far few resources
available to train people with if we do something custom.

> Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> and it should be easy to extract a yaml description from a text document without pain and
> keep all the human description, no ?

Yes. Please go look at the annotated example in patch 2.

> What will be the case for all the bindings with ASCII art to describe the architecture of the
> HW ? will you simply drop it to replace it with cold yaml description ?

No, you can have literal blocks and/or comments with however much
description you like. In fact, there's some notion to write the
descriptions in sphinx and extract them to generate documentation, but
that's a ways off. That's just the extent of what is possible.

Rob
