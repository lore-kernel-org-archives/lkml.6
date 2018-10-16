Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB7C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5038220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5038220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeJPPZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:25:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46768 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:25:51 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so17209367oia.13;
        Tue, 16 Oct 2018 00:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKzv3qCNl3oCmbWt2jjtRpMMIlnMKcpPpVgfnniWets=;
        b=DMEOt0jxx+Ey95k8ru+j63o7x8mem523G9mJzJ9721c9sA583a1vDSGqAiic2F46ze
         muUIBb+oAqilDmfige24H+qFZM+AWZx9iCXgF1F+V3cKBmvCeOvlDzdPsg1dmWXnxe+R
         Z88qDdBw/t8x5UKxosEfnagc7tjh0jujMeOU0fD4rViVN9bEd4bpZ5lAC3byi06TN4AB
         kFD5uNma73VnaIUps55xVFV1jPVrlw5HV+p4L4upq0/+bzA1GX4hYIBVcTWT7NNX0s3w
         6Gb0bnTJcgrwxQDyvCY0Nq/ReV3jpFm/BSZYor7OBMxQdZe9tFi96cViWzU/71xT37fT
         yKiA==
X-Gm-Message-State: ABuFfoiKZrGvME8bIt1B/HHFTzsrWxgX471eCFyGtjilYe+GTWiRyzoV
        6M6H9t0yPax/kuNvecn9Z743m8HOAeIRiEmsw4qYSw==
X-Google-Smtp-Source: ACcGV62dpdF7DVMv30Pn25POlhinb2JdJlnRRAeWJFwF5Prt43R8mNlUxVMoLpn2CijCi/ZrnIxmfmBLlf8vbmjvbs0=
X-Received: by 2002:aca:af91:: with SMTP id y139-v6mr10217992oie.322.1539675403891;
 Tue, 16 Oct 2018 00:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com> <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
In-Reply-To: <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Oct 2018 09:36:33 +0200
Message-ID: <CAJZ5v0h3uENUqbcb=0HH1wT_0MYQzcHct2d19tiarvXEdRay+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Oct 12, 2018 at 1:39 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
>
> > To continue the discussion started by Dmitry [1], this is my proposal
> > that I mentioned in my last mail. In short, the idea is that instead
> > of trying to extend the support for the currently used struct
> > property_set, I'm proposing that we introduce a completely new,
> > independent type of fwnode, and replace the struct property_set with
> > it. I'm calling the type "software node" here.
>
> I'm a big fan of this approach.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> for all patches.
>
> I don't know who can finally review and merge this though,
> I guess Rafael?

Yes, that would be me. :-)

I no one speaks up against them, I'll pick them up.

Cheers,
Rafael
