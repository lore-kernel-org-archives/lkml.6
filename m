Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC36ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A2208EA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llPkUoXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954A2208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeGOSjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 14:39:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41115 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeGOSjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 14:39:11 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so14624170ybe.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrjXDHkdNFN7mHtHTyoEboa7wkuaItGxhJsSyzVpF74=;
        b=llPkUoXWG7QjA0+MWJ2gsg/shteGITPXFt/92GrHipRA4JXpBuT1oA8039CsYiUPJX
         DsNkaf9wtkskg0a2F4wujPXQYHHmuVXQJB6Ehi7azFK+izy3/ulOUihcDM2ui1nZF6PZ
         QPbW7Kxzu8IN2gcQpB6CU2NVMd6dqXwwJdQe45sTvrQusHTA773eBMYWm9TOWXAfNaZA
         chJBG8KSpwKnFmY/D8v9J5ffElpmwaj+uQK1AJHOlPkfR+Zh8qKEJdWtgcvGvyryZGeh
         G/OGEDHcXlvWU/FBWGyP1+RO6fNuxRs4YtGD0ziLTGfqWyEumao0CdYix3ZekiutvWVJ
         srZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrjXDHkdNFN7mHtHTyoEboa7wkuaItGxhJsSyzVpF74=;
        b=c0XwqQSjB3VwXvkQ/APvK3d9XHkpDUjUitNLf2BD3qfnu0FiguiYloAFW7ttHu3He8
         AtWTpyVKRkC6Y/AlcKSNGJKZ8/LNHb0+3nnMOL+5W4/lELMF7VbKxsKUXFSKsPrsgPdi
         IHpWM6F/Weq3s7UkQ5yN+z3ahFrL5HwIzU/+Y92izvrGWt+7oLBGdSVSZqM5jnoPqPJ2
         0/pOSdVLrxriNKchCu3m/fqp9deWyDdel9t9my+eyOjX+8m/sB18Xz6mT9r8rRWT9xV9
         Cq88ML/gXqsO1yHUCt3w0KDiV49ZhmyRP5m9QLMB0a33IGkrCUgWygJfUZ8r+sQbWiEY
         DVRw==
X-Gm-Message-State: AOUpUlFqM9kRZs/M/ynRBQVwumCF5FN4aee8+cnr09yEIqTLXYfmtshe
        csFB60I6+e/xIvnhtPXBq48vaCAOCu1JxiiIbrZoAA==
X-Google-Smtp-Source: AAOMgpdy0A9buSqmUoidNxD/pMzbQn6Xk1rrIy9rI4SQ9NTIS1QJ0OPMSxXlef87IVctdTP5xD+20z+UIcp5B0xP+HU=
X-Received: by 2002:a25:9c44:: with SMTP id x4-v6mr7193108ybo.230.1531678527093;
 Sun, 15 Jul 2018 11:15:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 11:15:26
 -0700 (PDT)
In-Reply-To: <20180715100345.GA17618@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
 <20180715090544.GC23333@kroah.com> <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
 <20180715093216.GA16003@kroah.com> <CAE_wzQ9rsw14EbFpt4kdt8bRJYyjDVvMrf45u3-y4Dzs4NKwRg@mail.gmail.com>
 <20180715100345.GA17618@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Sun, 15 Jul 2018 11:15:26 -0700
Message-ID: <CAO3upoZeTGDZsGaYGhmQE_7GaihLYPym6miD9vMWM5Fzi46GMA@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        John Joseph <jnjoseph@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 3:03 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jul 15, 2018 at 12:53:09PM +0300, Dmitry Torokhov wrote:
>> > I can't wait for people to just realize this whole "new" subsystem can
>> > be replaced with UIO, but that's a topic for a different thread...
>>
>> Yes, that is true and that is why I am not sure why we are going
>> through all this staging exercise.
>>
>> As far as I understand we'd still need to have quite a bit of kernel
>> code so that we can safely program DMA controller (it does not look
>> like uio_dmem_genirq.c is sufficient as is for gasket needs), but that
>> should be solvable.
>
> I agree, it should be solvable, and much smaller and simpler than this
> whole large chunk of "subsystem+driver" code.  But I'm not the one
> having to do this work, and it provides a bunch of easy cleanups for
> people looking to get into kernel development, so I don't mind :)
>
> But the "maintainers" should keep this in mind, as it is, this code is
> _not_ acceptable for the main kernel tree because of the UIO framework
> already present.

My own preference is to rewrite the apex driver entirely in-kernel and
pull in its userspace parts here.  If I don't receive significant
pushback on that I'll start doing that real soon.

>
> thanks,
>
> greg k-h



-- 
Todd
