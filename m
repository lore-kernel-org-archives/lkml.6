Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1913C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8457B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5g4x5GW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8457B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIEOEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:04:31 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42169 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:04:31 -0400
Received: by mail-io0-f193.google.com with SMTP id n18-v6so5411332ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTg80bpYFHB3VvnrnYB4afDoN3ocrsA/HxEdh+c+mqE=;
        b=G5g4x5GWefP2k4dZQmt/C2h0bFHwduQoo0io+PxvumsZWFODvMAYHuz0nqJemrU435
         xIuBlSIHE/RKtkWpw982SwPlFM0NcHkgWXCfG5+c3pPReCoi8B/T136lErxg6lv9IP7b
         9u/UmwFeHALt7vL089DRslsY+3O6l0M1m28tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTg80bpYFHB3VvnrnYB4afDoN3ocrsA/HxEdh+c+mqE=;
        b=cpyxzUZOkJQW78OSrJxb47DOjexjJJpWR1aKtx9F/xwalUuMK0AxnxEzgLUzmonnOp
         XajK7rDK82Bwqj2l8lF9YGeM3OLhClWxZbvFdDfK2mCMHAVoQuRBB/mY+F6WVAWfnE81
         ypMRWKS29s+r+c/QaJYuq74t8MQcnhRXYCcUuzsnipdByPHKgl0mZXGjqkB8bwTK6FQs
         qDhQqn+Pqvhfei5dPIrPZ8MNG5Vgm/Oc5BLmqemtyQuUHhuuSV6V7PCgXdW0pf12+o6I
         yc+3pqtHlmj4j3PtO7USGZnXLN257rXQwurf5kxYtxUKFRkjXE2QvHp4g6qiD9aqpBg9
         sllA==
X-Gm-Message-State: APzg51ACjKnUaVuSKINarYQHt6j/bu1SFfFLpS3euQUrE/C6dtZp5KOR
        3vNS5ddUkuSbcarJA5BKvEO8YLJnR+tGPkg7BkNHjQ==
X-Google-Smtp-Source: ANB0VdYOTcStGeiNVhk4SAgjTEDbtsR8Od2Y4Ub4/2ljna2OHKrdDztUieN5DtV7IuiWfFdNqQ0F/jEq/TpjcZh3J9c=
X-Received: by 2002:a6b:b983:: with SMTP id j125-v6mr10575075iof.43.1536140108517;
 Wed, 05 Sep 2018 02:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
 <20180828112721.28178-3-Eugeniy.Paltsev@synopsys.com> <CACRpkdbQryY-R+14GvYAEkLH+7Tr4Pvb6YohWouTwug7qEGbDA@mail.gmail.com>
 <1535652965.4465.84.camel@synopsys.com>
In-Reply-To: <1535652965.4465.84.camel@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 11:34:57 +0200
Message-ID: <CACRpkdZCXdpYXF-xj8myJOuYGk7PAZ3+UP34MP02QCgbuTT=+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 8:16 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
> On Thu, 2018-08-30 at 10:43 +0200, Linus Walleij wrote:

> > > +- snps,bit-per-line: Number of bits per each gpio line (see picture).
> > > +  Array the size of "snps,ngpios"
> > > +- snps,shift: Shift (in bits) of the each GPIO field from the previous one in
> > > +  register (see picture). Array the size of "snps,ngpios"
> > > +- snps,on-val: Value should be set in corresponding field to set
> > > +  output to "1" (see picture). Array the size of "snps,ngpios"
> > > +- snps,off-val: Value should be set in corresponding field to set
> > > +  output to "0" (see picture). Array the size of "snps,ngpios"
> >
> > Move this into a lookup table in the driver instead, and match
> > the lookup table to the compatible string. The format of the
> > register is known for a certain compatible, right?
>
> Actually I really don't want to hardcode this values into lookup table as I going to use
> this driver on 3 already upstreamed platforms and at least one upcoming.
>
> They all have such CREG pseudo-'GPIOs' differently mapped with different IO lines number,
> different enable/disable value, etc...

So each of them will have their own compatible, and table entry,
so what's the problem? If they don't have their own compatible,
they should be added, because they are per definition not compatible
if they need different values into different parts of the register.

> Is it really a problem to have this values configured via device tree?

Yes because the DT maintainers do not like that we use the device
tree as a data dumping ground.

pinctrl-single.c and some other real big pin controllers are dumping
data into the device tree, but it is a dubious practice. Two wrongs
doesn't make one right.

> If we read them from DT we are able to use this generic and configurable driver to handle
> both existing and upcoming platforms without the need of patching the driver on every new
> platform upstreaming.

But you will have to patch the driver to add a new compatible for each
platform you're upstreaming anyway, so this isn't going to make things
easier.

Yours,
Linus Walleij
