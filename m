Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5DEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273BD20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+O8qaZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273BD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeGYShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbeGYSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:37:49 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FA120882;
        Wed, 25 Jul 2018 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532539511;
        bh=yPcgiuO34klavLXlURoLMItDduQc+7e1KLdxuVUFkuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U+O8qaZ9MHUFyYD8GetAtQQjBAe9WXkhdeSCuhTara7aLEuHYweKgKL6NAYNUUcxS
         jhsbimzKQ5bldQMoeVEYu/aHnTSG1yWdrnb9t0KkBNZ648lW6OZA4dtohw2/rwC+mO
         r8k/y+a2z3SzwATB7yrNIb8CRcTUIAzQ4s2dEUaU=
Received: by mail-qt0-f179.google.com with SMTP id d4-v6so8394622qtn.13;
        Wed, 25 Jul 2018 10:25:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlFf1vwvVhkVoHL1/IL8qgIwKRXBmAKMARDdXXM7Tp/Qv0obsOJD
        zWflTRU5AWTMfY3c/7uSuhm9eF9v5qrOM4OPtA==
X-Google-Smtp-Source: AAOMgpeoPksRaHbuRpZQrMIOk/sOfH1RLlVb9Fr+o0UNfYqI9Rqf0Ci4WvImKA8frWGlfBgr9Poq5JSLsEfl77GcfJ0=
X-Received: by 2002:ac8:96b:: with SMTP id z40-v6mr21501665qth.362.1532539510879;
 Wed, 25 Jul 2018 10:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
 <20180725160939.GA24323@rob-hp-laptop> <e96b9bda-8a58-a817-5580-7771af7c9e28@arm.com>
In-Reply-To: <e96b9bda-8a58-a817-5580-7771af7c9e28@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 25 Jul 2018 11:24:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhiA=Yr3gWhxaQxT56NUai77Lg5iVfQUaTtBW=a5-kFQ@mail.gmail.com>
Message-ID: <CAL_JsqKhiA=Yr3gWhxaQxT56NUai77Lg5iVfQUaTtBW=a5-kFQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] coresight: Cleanup coresight DT bindings
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, John Horley <john.horley@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:13 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> On 07/25/2018 05:09 PM, Rob Herring wrote:
> > On Thu, Jul 19, 2018 at 11:55:13AM +0100, Suzuki K Poulose wrote:
> >> The coresight drivers relied on default bindings for graph
> >> in DT, while reusing the "reg" field of the "ports" to indicate
> >> the actual hardware port number for the connections. This can
> >> cause duplicate ports with same addresses, but different
> >> direction. However, with the rules getting stricter w.r.t to the
> >> address mismatch with the label, it is no longer possible to use
> >> the port address field for the hardware port number.
> >>
> >> This patch introduces new DT binding rules for coresight
> >> components, based on the same generic DT graph bindings, but
> >> avoiding the address duplication.
> >>
> >> - All output ports must be specified under a child node with
> >>    name "out-ports".
> >> - All input ports must be specified under a childe node with
> >>    name "in-ports".
> >> - Port address should match the hardware port number.
> >>
> >> The support for legacy bindings is retained, with a warning.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   .../devicetree/bindings/arm/coresight.txt          | 91 ++++++++++----------
> >>   drivers/hwtracing/coresight/of_coresight.c         | 97 +++++++++++++++++++---
> >>   2 files changed, 129 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> >> index 8e21512..f39d2c6 100644
> >> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> >> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> >> @@ -104,19 +104,9 @@ The connections must be described via generic DT graph bindings as described
> >>   by the "bindings/graph.txt", where each "port" along with an "endpoint"
> >>   component represents a hardware port and the connection.
> >>
> >> -Since it is possible to have multiple connections for any coresight component
> >> -with a specific direction of data flow, each connection must define the
> >> -following properties to uniquely identify the connection details.
> >> -
> >> - * Direction of the data flow w.r.t the component :
> >> -   Each input port must have the following property defined at the "endpoint"
> >> -   for the port.
> >> -    "slave-mode"
> >> -
> >> - * Hardware Port number at the component:
> >> -     -  The hardware port number is assumed to be the address of the "port"
> >> -         component.
> >> -
> >
> > Why do you add this in the previous patch and then remove it here?
>
> The only use case I can think of it is for someone to look back on the
> legacy bindings, which were never documented. I could skip the parts
> that are being removed.

Yeah, I'd just remove it. Finding the text that exists for 1 commit is
a little hard. Now that we've discussed it here, googling for it will
be easier.

Rob
