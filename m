Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81237C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45106214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131673;
	bh=YUKdoUTdVOsh4ePDuGZ5IkFg5OFwW2rDLrMYKWOZJig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KnedfULRIkDjLk+3kVNG21m6f7GIO6Zqcyd+p3VKUzQcDDXYa+cecIsKF0rFd3uag
	 gYueaXkfOQOaKuJIDNSTSDH+a16RCRZ8741kWx+7Mn9ivS6YC5/B9Ghx2H6IIFRasN
	 5DM4mXr5lzdIxJQaXTfnHmi9n2KR+bb/RAXxKMUk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45106214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeLFV1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeLFV1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:46 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DE92146F;
        Thu,  6 Dec 2018 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131665;
        bh=YUKdoUTdVOsh4ePDuGZ5IkFg5OFwW2rDLrMYKWOZJig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mtw80NaMfMVffOW74aj/EI26GoQDEzan0jzuEAo+MAJ6brIQBDlkWQKmd9IWDFEXk
         Tn9/bMPwQS6xTmEYNE5bM/Mg9ql9Q8lAcUMZMtdl1Qw6kzdzwTf4DXTlz+llH2FShD
         9neyDhJX+Xl3B1H4Kz94GaksN4CqAIAXVOkIJlR4=
Received: by mail-qt1-f178.google.com with SMTP id r14so2284760qtp.1;
        Thu, 06 Dec 2018 13:27:45 -0800 (PST)
X-Gm-Message-State: AA+aEWYvexktP4dJjkXSiiae/uIi+tZ5pQGMnpG9QI5gbGL5gw1w6OU1
        ZjBMHXCBd5y+02OEdeeKQ6RFmdSbEOrFIX5gRQ==
X-Google-Smtp-Source: AFSGD/Xq7Y31Py8rddAX76hKx/Dgp6RhHrT1700dFVf7MBtjRNWpyx/brxsFhnAarR60gHdRV/sSlbWPfoSSMDfS4m0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr29894028qvl.77.1544131664335;
 Thu, 06 Dec 2018 13:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com> <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 15:27:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 8:44 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi Rob,
> >
> > You forgot linux-amlogic in CC...
> >
> > On 03/12/2018 22:32, Rob Herring wrote:
> > > Convert Amlogic SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Carlo Caione <carlo@caione.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
>
> [...]
>
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,s400
> > > +          - const: amlogic,a113d
> > > +          - const: amlogic,meson-axg
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,u200
> > > +          - const: amlogic,g12a
> >
> > but all this feels wrong for me.
> >
> > First of all, this yaml description is not human friendly and not intuitive at all,
> > and secondly with this conversion we loose all the comments about the SoC family relationship
> > with the compatible strings !
> >
> > I really understand the point to have automated verification, but really it's a pain to read
> > (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> > I feel it will be a real pain to write !
>
> What do you suggest that would be easier? Is it the YAML itself or the
> json-schema vocabulary? For the former, we could use {} and [] to make
> things more json style. But I imagine it is the latter.
>
> There is some learning curve for json-schema and is certainly a
> concern I have, but there would be a learning curve for anything. Our
> choices are use some existing schema language or invent one. All the
> previous efforts (there's been about 5 since 2013) have been inventing
> one, and they've not gone far. There will be far few resources
> available to train people with if we do something custom.
>
> > Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> > and it should be easy to extract a yaml description from a text document without pain and
> > keep all the human description, no ?
>
> Yes. Please go look at the annotated example in patch 2.

How's this?:

  compatible:
    oneOf:
      - description: Boards with the Amlogic Meson6 SoC
        items:
          - enum:
              - geniatech,atv1200
          - const: amlogic,meson6

      - description: Boards with the Amlogic Meson8 SoC
        items:
          - enum:
              - minix,neo-x8
          - const: amlogic,meson8

      - description: Boards with the Amlogic Meson8m2 SoC
        items:
          - enum:
              - tronsmart,mxiii-plus
          - const: amlogic,meson8m2
