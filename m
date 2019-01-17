Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9941F20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QC4t6mv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfAQVUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:20:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44581 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfAQVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:20:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so12461774otl.11;
        Thu, 17 Jan 2019 13:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogy6xz8UHuvcLvCW7Q7NOZfiiBOXpv3rBQwAFzf/+KA=;
        b=QC4t6mv5clBrgJeb5yOqPcQvERHHSxayfB+G0Vc4TstrM4tU4AfZIlz1XeOQS8Gzq5
         fhLg2NJxUFfgr9hewjStmoJFfA/lCOCA/hWmSB+bckHP0QsZFRAVf9ZGWnYdLi1ZhS//
         ywyWtHG3xex3kEXDbmqr0PG6mXMOYtaqTMKkrgksvMSQrB90l8bvlRui/ujMeqQ1GSt3
         C5pKKOoo+Hd8z3kctEdT3cUIyVD/wk//txsRnnD2p8eNl7wWNE6oK5PdL/2hQaqL9SMZ
         tR8C1W6EO1JyBJYQ7u7tOLMotLy5ljXgZOSaQXn7k5jn2hS931+SsdosZUOtmkXmxnqA
         cu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogy6xz8UHuvcLvCW7Q7NOZfiiBOXpv3rBQwAFzf/+KA=;
        b=ghwrn7nnuebX6TWaf2Uo7xbyD88xCnzjg/535wlGf/Nj3i/G/kx8PdOc4olnBwboS9
         W17epi0eljVd7/y1+dWItOQQSAGgs+x014JBG8YC5qFCNicSQA2N2jGg2JXGNmT/T64W
         JqQYgmhH3fJULkoPHgFiNKJMm9yOhDIePVgxk9uIdGYcXvADVBRqOsoc11aCnH2raj05
         jOtfLNjUH4ol/2XvIEoJRkR6PqjDF2lR3tt1bgyzwU9b5CWjn7TX2GO7D3wQJxxYXVgN
         fgLRZh7GV2v8kdR9NJXDadc2GLxFyIygD4t3aoVbxu+eAV8Q44tZZS2ovieEVgobZY1D
         JONQ==
X-Gm-Message-State: AJcUukemGLsa3pSdeBpfEGrnibHedFlgCUGJT0q2fk4QjhzP9x4lxkhI
        KDIT15ahqB8blm6+IHjUsDAmzcLBePuQAcAxGt4=
X-Google-Smtp-Source: ALg8bN6zst1xaYMIOyQa7NlrqiKzfcgl9QtzmKCH5E70P+hJyxC4aj13MrXwTJggDhix1GJAP580g9IvFG5B1TNqkb8=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr10306229otf.131.1547760034647;
 Thu, 17 Jan 2019 13:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20190116165236.8330-1-jbrunet@baylibre.com> <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
 <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
 <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com> <ba1f56258e7873041a0f75996e376170563c9e6e.camel@baylibre.com>
In-Reply-To: <ba1f56258e7873041a0f75996e376170563c9e6e.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 17 Jan 2019 22:20:23 +0100
Message-ID: <CAFBinCAdJu2C-LWspiHR4vVr=PUD2HGNi4zz+CSJP96ZE4GoJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 9:39 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2019-01-17 at 21:27 +0100, Martin Blumenstingl wrote:
> > OK, but we had incorrect documentation in the past. did you check this
> > with someone from Amlogic?
> >
> > I'm curious because there seem to be two different approaches here:
> > 1) hiubus name and offsets are being fixed within this patch
> > 2) aobus is being dropped here and re-introduced with a different name later
> > on
> >
>
> because hiu exist and aobus does not, for which both the name and size was
> wrong
>
> > approach 1) can also be used for the "rti" region (at least in my
> > opinion, the patch doesn't explain why it can't be done):
>
> THe patch remove aobus (instead of fixing name and size) because, of the
> multiple region documented covered by this 'made region', I did not anticipate
> which one will be required and I did not want to add them all.
>
> Better to add them as needed, which is want I done for pinctrl as you pointed
> out
>
> > rename "aobus" to "rti" and change the size to either 0x1000 or 0xb000
> > (both values can be found in mesong12a.dtsi from
> > buildroot_openlinux_kernel_4.9_fbdev_20180706)
>
> RTI is added here:
> https://lkml.kernel.org/r/20190117103151.3349-1-jbrunet@baylibre.com
>
> I don't really understand the problem ? result is the same
the actual problem is "me" as I have conflicting information:
- Amlogic's buildroot kernel (for G12A) uses similar bus definitions
as the GX SoCs (for which there are public datasheets) - this is how
Jianxin added it to meson-g12a.dtsi originally
- this patch does it different - but cannot check if this is correct
(no public datasheet is available for G12A or AXG) nor do I have a
"big picture" of upcoming changes

Cc'ing Jianxin: can you please review Jerome's patch and give some
more details on the memory map on G12A so further contributions can be
reviewed easier?


Regards
Martin
