Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3662ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611E720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCCGYtXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611E720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeGXD1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388194AbeGXD1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:27:08 -0400
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDAE20874;
        Tue, 24 Jul 2018 02:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532398982;
        bh=uX4NZwYQJvakRuc/oYWEC9/4xzU7v0oA7JsAZAtjwGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oCCGYtXIq7OVecqly9nEJPBc1TI5pA8hXew/ws4j+j5Lq62+OIN6O3CLL3bmHpssO
         XrPri+tKErvrC/ezAYL8tIJoyiDRQb9JdyqKvIzImzT7S/hQQnlWowX/b1Mga2wNvn
         bpU2vfRYp/YxPODFRreQj3l7+reGfKIPNir+enBk=
Received: by mail-qt0-f170.google.com with SMTP id m13-v6so2739646qth.1;
        Mon, 23 Jul 2018 19:23:02 -0700 (PDT)
X-Gm-Message-State: AOUpUlHNoee36Xa0bcUx7nk5MNIjhEZqijv6vQTlBRyvPtdfRRr9/BHT
        vgobAjaKkJ/MwK+3pF+ygP92Fe/hesiT+pEfhA==
X-Google-Smtp-Source: AAOMgpeerid7OMwqDy+lTFAN7lkc+Vqa/JsL22hCiaJbCn4ci5TSo83XuPXnMAHNvu17wfctNJqnYc0i+aAVAK2Yf2I=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr15012244qts.354.1532398981854;
 Mon, 23 Jul 2018 19:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180723221317.16394-1-robh@kernel.org> <811b4c0c-7d9c-2bbc-5029-58a458a13f7e@mleia.com>
In-Reply-To: <811b4c0c-7d9c-2bbc-5029-58a458a13f7e@mleia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jul 2018 20:22:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL67uQradiJ-OQTNs++zkUC3DWp8ore3XiB9f8fF0MhSw@mail.gmail.com>
Message-ID: <CAL_JsqL67uQradiJ-OQTNs++zkUC3DWp8ore3XiB9f8fF0MhSw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remove 'interrupt-parent' from bindings
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 5:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> Hi Rob,
>
> On 07/24/2018 01:13 AM, Rob Herring wrote:
> > 'interrupt-parent' is often documented as part of define bindings, but
> > it is really outside the scope of a device binding. It's never required
> > in a given node as it is often inherited from a parent node. Or it can
> > be implicit if a parent node is an 'interrupt-controller' node. So
> > remove it from all the binding files.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> > index 38211f344dc8..0bfb3ba55f4c 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
> > @@ -14,8 +14,6 @@ Required properties:
> >    Reset value is IRQ_TYPE_LEVEL_LOW.
> >
> >  Optional properties:
> > -- interrupt-parent: empty for MIC interrupt controller, link to parent
> > -  MIC interrupt controller for SIC1 and SIC2
> >  - interrupts: empty for MIC interrupt controller, cascaded MIC
> >    hardware interrupts for SIC1 and SIC2
> >
>
> I would rather ask you to keep the property here, it is optional in sense that
> its presence distinguishes MIC and SIC types of interrupt controllers.

Sure, no problem.

Hopefully I remember on the next round of wack-a-mole.

Rob
