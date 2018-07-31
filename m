Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73747C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208EF208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6E/3+2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208EF208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbeGaOgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:36:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33467 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732075AbeGaOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:36:35 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so15743848qtp.0;
        Tue, 31 Jul 2018 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S9etwiwTggZxtK+yILHbljc1WG84CLIlBW0CNXXnmeg=;
        b=P6E/3+2dowHDj5e4NqOxE2k4OHDlFgfjIypw0kWsU1+1JW1yvZWwSVK/d67lEyyua0
         38RKvgrU7rIiGaweNIPj+Q3MS8siodmuNJr0Zzt2em1dFjEp/DBRl78p7BNrus0v6SfP
         Hjt0lIfVA/5zyoeFoYcmRqHnTkvza9xOE6XL6EZ4xVJdZaeiyLViKy1Ru0KtRDAKcF5J
         +m6vfM1919IMwKcv4qTba8Z0eCXJTYnAxAfcGeRChjlMX/8ibLm0xr5PEnQO1sLUJRk+
         ZnvPQ2d2BTlLegkF8LZME86biLOeOgRVsim6AlBw+13oEp0vEvF4jr+Wdb8XlHmJmxVB
         x+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=S9etwiwTggZxtK+yILHbljc1WG84CLIlBW0CNXXnmeg=;
        b=L8py4dWSuI8sBWhd3l3pBrGFvzF3OnxFgntMJ6gqVHYL1ABYlnT+mW0KeKDTJlKyfA
         bg2JaZPB0wuveB2dNZnK5h20EUnBY4U2iOEvIzvA6iPkKYZoNzIibfxVJ22zy4dimxU/
         fdBzbYBts6aZyW+yfiTvzkxgXAN6o0CcFZ6y6q1aXW2GoTPxw/8FgCyU6i/CR5xOZZYJ
         jmNz6M7lDMTkzc20ZqcaaKCt1p9caknvdu2Qh57lQttpA3ci8qW2vlwaLvs6uTzsb+if
         Ej7wUVvjO3jY54PjWoUQKPUHiXH1WKVf06xh5duIWZ3RMVUXoBvGzdQvpCWVX7NVVDOz
         i+BA==
X-Gm-Message-State: AOUpUlGonoQNlIg+ufNGhRqwjjnm8J4N1GrQ4r+qYqf0oGmLTnNid/eS
        Qh2W9UaxmEvD+HN16JULTkbEMOBkGx5gZ2tAhRY=
X-Google-Smtp-Source: AAOMgpfYFv1UfCJx1iLtpi82uUSYg7nZXp5tJQkao+E83ZcTN2pM1VFY1nsWah+2tMPwRK8e61kcQqUKU9lJ12J9Z5w=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr21362311qta.178.1533041782130;
 Tue, 31 Jul 2018 05:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 05:56:21
 -0700 (PDT)
In-Reply-To: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de> <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Jul 2018 14:56:21 +0200
X-Google-Sender-Auth: ovbEnDHwsys0alfSz1KybRfss-o
Message-ID: <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
Subject: Re: use the generic dma-noncoherent code for sh V2
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> can you review these patches to switch sh to use the generic
>>> dma-noncoherent code?  All the requirements are in mainline already
>>> and we've switched various architectures over to it already.
>>
>> Ok, there is one more issue with this version.   Wait for a new one
>> tomorrow.
>
> Speaking of DMA:
>
> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
> reading through all that stuff, but the docs seem kinda... thin?
>
> Is there something I should have read other than
> Documentation/driver-model/platform.txt,
> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
> source code and the sh7760 hardware pdf? (And watching the youtube video of
> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
> DMAEngine, the Xilinx video on DMAEngine...)
>
> At first I thought the SH_DMAE could initialize itself, but the probe function
> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
> _kind_ of like a model I can crib from:

> B) That platform data is supplying sh_dmae_slave_config preallocating slave
> channels to devices? (Does it have to? The docs gave me the impression the
> driver would dynamically request them and devices could even share. Wasn't that
> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
> minimum amount of micromanaging I have to do?)

The thing here is that arch/sh is way behind on the API use, and it
has prevented us from cleaning up drivers as well. A slave driver
should have to just call dma_request_chan() with a constant
string to identify its channel rather than going two different ways
depending on whether it's used with DT or platform data.

If you hack on it, please convert the dmaengine platform data to use
a dma_slave_map array to pass the data into the dmaengine driver,
mapping the settings from a (pdev-name, channel-id) tuple to a pointer
that describes the channel configuration rather than having the
mapping from an numerical slave_id to a struct sh_dmae_slave_config
in the setup files. It should be a fairly mechanical conversion.

The other part I noticed is arch/sh/drivers/dma/*, which appears to
be entirely unused, and should probably removed.

         Arnd
