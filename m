Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46533C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7E20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O99qaLbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B7E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK3IGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:06:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39742 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3IG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:06:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so2877696oia.6;
        Thu, 29 Nov 2018 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjLIHyl46Y1925E5LQa1fhTz2lS4zWuFowCBuzUz7sE=;
        b=O99qaLbDZlnVwwWCtPZ+ztMPAiiDh1eTXCQw/0OGu7Hv17fVxAEZNxiuHUF5Rn0AAn
         WJfmigNxAhARe6FThnlS+83B6HWC0SiOyxFgFNi3gPQT5HALDKmlPVaZh2S+050/+YGf
         2IjEDI+P0hxjWFBpIL45+n/mEsByEMwchFXbhCX7yKWJegK/evL5JjRwMTfZ7gii6bcz
         MD/lc5VCCa5P13x01+Mx80qD7jW6R8Qws2vXN0DwrEBukjBsuEnV7YRW3me33cwDDgWc
         cWvZV/V1zXnJQrn9/VUyd8Qp6pGbZY9re2ZN0xihP18MEQw2Fzka+dagptWOGFuegOfQ
         n3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjLIHyl46Y1925E5LQa1fhTz2lS4zWuFowCBuzUz7sE=;
        b=KADF1qwV1XsaIODafru8PlgKsr8ZFRiomONfJ4ffYQDqKSxxVf4hmDhPTBY049u+3Q
         zzUJRA3eFJMzSvkEfFg/lS+SWys1hUeFhDQxv8XoZ3DT7D50B+U97/xxm2vuu++vW+cQ
         r/yTJu78ZhLhywq7I4av94de66v8muL52exBA7yFomXVA/MScths0lUOR4W4oCwXHlDj
         xBHqM92vSjtIb/nu5gAFg2DZhLg0z7GuYwwWUyRlUIYLRiyq36LNiM4g1CbUneHoQA3c
         n82g2Wz2TJca4PXQ19DyuC2QShnx6pHepE9qLPiRP7GxxtNaFtLkhSkdKsEhoHa5Wbf2
         fcsQ==
X-Gm-Message-State: AA+aEWZFJsAGD7zUv4zhhW1Va0zL+iT6oW9nm7uPMpJEe7swkEaNDjuE
        0zc7TrXD4BIHMW8Otf7LeH0uHiiotOscU8MWT7f7d4T7
X-Google-Smtp-Source: AFSGD/XrGvCniSMZsQ6nwTJzq9ls2wvhZoMejUUtnTF+y+jDz2YmYt+VaI14kpd2A6qaMRqd+IMNhLoa4kCIwjQXx1o=
X-Received: by 2002:aca:db04:: with SMTP id s4mr1686748oig.248.1543525185885;
 Thu, 29 Nov 2018 12:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-7-TheSven73@googlemail.com> <20181126220804.GA23069@bogus>
 <CAGngYiWBBe7P80ASQJnS8woe6SKLgNUmqKxOHMeyV1fGSCpY_w@mail.gmail.com> <CAL_JsqK--6UE9N2je3mkoxf_0+i5fTYqYpmTF2bpzFf-KRjhaQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK--6UE9N2je3mkoxf_0+i5fTYqYpmTF2bpzFf-KRjhaQ@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 29 Nov 2018 15:59:34 -0500
Message-ID: <CAGngYiXFag-C9-0XvGxVVWs5AxL2qn0UhU2W1Ds9LE+BJYgvDQ@mail.gmail.com>
Subject: Re: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document
 devicetree binding
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

Eliminating the 'compatible' property for the anybus gives me an interesting
devicetree problem.

The imx-weim code naively loops through all subnodes, applying timing settings
to the CS in the first reg entry.
In the example below, WEIM CS0 is programmed with the settings in
fsl,weim-cs-timing, because the CS part of reg is 0:


weim: weim@21b8000 {
        compatible = "fsl,imx6q-weim";
        reg = <0x021b8000 0x4000>;
        clocks = <&clks 196>;
        #address-cells = <2>;
        #size-cells = <1>;
        ranges = <0 0 0x08000000 0x08000000>;
        fsl,weim-cs-gpr = <&gpr>;

        nor@0,0 {
                compatible = "cfi-flash";
                reg = <0 0 0x02000000>;
                #address-cells = <1>;
                #size-cells = <1>;
                bank-width = <2>;
                fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
                                0x0000c000 0x1404a38e 0x00000000>;
        };
};

The problem is that my 'anybus controller' hardware spans chip selects.
It requires access to various memory areas. In the example below, CS1
will not be programmed with timing settings:

weim {
        controller@0 {
                compatible = "arcx,anybus-controller";
                reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
                fsl,weim-cs-timing = ...;
        };
};

I've coped with this in the past by creating a 'dummy' subnode, without a
compatible property. But it's ugly:

weim {
        controller@0 {
                compatible = "arcx,anybus-controller";
                reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
                fsl,weim-cs-timing = ...;
        };
        dummy@1 { /* this works ! */
                reg = <1 0 0>;
                fsl,weim-cs-timing = ...;
        };
};

Is there a better way? I've looked and looked, but can't find anything that's
similar.

Or should I extend the imx-weim driver to cope?
