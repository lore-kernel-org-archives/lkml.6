Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED6ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D2621528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6MH1ZOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D2621528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJQV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeJQV3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:29:16 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA9EE21527;
        Wed, 17 Oct 2018 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539783212;
        bh=M2+4YV1bCso/tUSBW5n4rClfyBNQMWWZM25xTpCm7Ys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c6MH1ZOZg6tjbOYfNc1jTZLSGU9sY+dq7G2lftDVBj+4RKjzWvKjsy04bWXBM+SIP
         YwHsuHdk+ySEFNVKPCZmhTorbbkZi6/YZE0jEifymqDO1d7ILTj1wLfXIhhEQldlc8
         fYL0xazpZA+QVz3utwkaZI535rqabZdUeesXtF2Q=
Received: by mail-qk1-f169.google.com with SMTP id q12-v6so16413573qkl.13;
        Wed, 17 Oct 2018 06:33:31 -0700 (PDT)
X-Gm-Message-State: ABuFfogbkFUa9RABzfqWzDXp9bgUZDkSLMk5AdZg06/0EAckQEnbb+Ya
        /7CguVRL+Q6j1+3b/TzwpWUqh7FcjeHaZAF+Bw==
X-Google-Smtp-Source: ACcGV61Wn1rAi9K7mqFzWt1NZigOBwZRgu5KYCN40iTPH8Sngd+3TBmO0h0iNa9ZKr5UyLsuYCpKzLtLFbOzLescrAI=
X-Received: by 2002:a37:6904:: with SMTP id e4-v6mr7461192qkc.79.1539783211195;
 Wed, 17 Oct 2018 06:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181005153638.1886-1-digetx@gmail.com> <20181005153638.1886-6-digetx@gmail.com>
 <20181017132501.GA19385@bogus> <6e9e90a1-0580-cc20-f7f9-69fefae0b3dd@gmail.com>
In-Reply-To: <6e9e90a1-0580-cc20-f7f9-69fefae0b3dd@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 17 Oct 2018 08:33:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
Message-ID: <CAL_JsqKiMVNB+d3n_HJ_Mq+6wi95DS6GvZ=u0vdyAKm9E4jkdQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 8:32 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> On 10/17/18 4:25 PM, Rob Herring wrote:
> > On Fri, Oct 05, 2018 at 06:36:32PM +0300, Dmitry Osipenko wrote:
> >> Redefine binding for regulator-coupled-max-spread property in a way that
> >> max-spread values are defined per regulator couple instead of defining
> >> single max-spread for the whole group of coupled regulators.
> >>
> >> With that change the following regulators coupling configuration will be
> >> possible:
> >>
> >> regA: regulatorA {
> >>      regulator-coupled-with = <&regB &regC>;
> >>      regulator-coupled-max-spread = <100000 300000>;
> >> };
> >>
> >> regB: regulatorB {
> >>      regulator-coupled-with = <&regA &regC>;
> >>      regulator-coupled-max-spread = <100000 200000>;
> >> };
> >>
> >> regC: regulatorC {
> >>      regulator-coupled-with = <&regA &regB>;
> >>      regulator-coupled-max-spread = <300000 200000>;
> >> };
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> >> index a7cd36877bfe..9b525b657fca 100644
> >> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> >> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> >> @@ -76,8 +76,9 @@ Optional properties:
> >>  - regulator-coupled-with: Regulators with which the regulator
> >>    is coupled. The linkage is 2-way - all coupled regulators should be linked
> >>    with each other. A regulator should not be coupled with its supplier.
> >> -- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
> >> -  in microvolts.
> >> +- regulator-coupled-max-spread: Array of maximum spread between voltages of
> >> +  coupled regulators in microvolts, each value in the array relates to the
> >> +  corresponding couple specified by the regulator-coupled-with property.
> >
> > Is this in use already? How is a single entry handled?
>
> No, it is not in use yet. Only some of the prerequisite patches were applied.

Please make that clear in the commit message.
