Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 78C7BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265DC20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvRlCgsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265DC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756216AbeFONCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:02:19 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46369 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbeFONCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:02:18 -0400
Received: by mail-vk0-f66.google.com with SMTP id b134-v6so5600126vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 06:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KCSjOfB6tU8nIerXSGcwSiL/VxSgPNQ2H1bTc5UZPV4=;
        b=tvRlCgsp59t63T6S/M0uj8EBOEihY9jCBivzDrk+LkkCibBxsJmgig2aLs0bEUr0Ct
         YOrSMDpUlO5KakghNa5i7LxD0V4nF9Daq1gTX+lxx8EdwM8/cCUhG/c0SiIpRh6rEyVE
         XhiiuoK2E9yJpBlxuS4FgZTMWQjwxy9Il7eO9t/ZrrQAYgx0Rjv/QePwTLiYFRLtJ4JP
         sZiJQHQF9nMJnE2mB9+PtIWDlVS+Y5sZNbpKFYkoVxWmYtz6jDutp55Xz7H16sbLcmlN
         Fm12bLjvzbQW5pqJOSDFpkiEBbaGK05hTv3JRImzKJ6506O+8r0V6+RxxcoankffT0RQ
         1Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KCSjOfB6tU8nIerXSGcwSiL/VxSgPNQ2H1bTc5UZPV4=;
        b=DddhGxzhuErkxi+FpIYnnHOZpyq6X4mMLZiAwP6V7a3fFMRbHueRh1A2haif9tHR1b
         Zh4Svdbxd58IsuSmtPiPfWGpUlpa1QBB9bnfJflSP5pXR7IAX72Vpj8hNvaZjqpqVJxC
         tPH6ZUeWk2uH1yBJkf670XSIItnxsjSNrS3ZPbXbskK6aK+WpOtk4tBKle6G+AcSKLu/
         NEbtAOA9plTLik8USOYhnocs4wMj45QeP5MWXIyPxJnCLSTBpeAj4YS5qSPiTQUw4XCo
         UxETT4hEtNTri/1MW5m3Ze2x2e6IHVysvIbABkzFGX1m/cJIYuNzAsqi73JTpBjdA8wY
         oKSQ==
X-Gm-Message-State: APt69E1dzsaXv5zxMiNQSgOV3lqqWqDiVFJoDgP9EFxY5xL3ADvw5cEV
        4xWlwacu9cY8Kezb2ELEIY5rfShw0lgfvNjbrc8=
X-Google-Smtp-Source: ADUXVKLTpU0yxF0iwM1bN49s4x0w/LAdCvUAZpBVbVihgrEqLraC7B44L/fqKKXfzCE+HM4s9fdT30coG2oAduf25/c=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr905942vkc.26.1529067737429;
 Fri, 15 Jun 2018 06:02:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 06:02:16
 -0700 (PDT)
In-Reply-To: <1529055023.10037.0.camel@sipsolutions.net>
References: <20180614212643.29563-1-johannes@sipsolutions.net>
 <CAHp75Vf372rACqseUNYEba3Gw1Hg+PmdFdn+a2ex=2JzWZ2nWQ@mail.gmail.com> <1529055023.10037.0.camel@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jun 2018 16:02:16 +0300
Message-ID: <CAHp75Vc+9uKFPLyviuRdVqMxoO2bpjjoAd4XXO+Xox0KNG+Krg@mail.gmail.com>
Subject: Re: [PATCH v2] bitfield: fix *_encode_bits()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:30 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2018-06-15 at 11:51 +0300, Andy Shevchenko wrote:
>> On Fri, Jun 15, 2018 at 12:26 AM, Johannes Berg
>> <johannes@sipsolutions.net> wrote:
>> > There's a bug in *_encode_bits() in using ~field_multiplier() for
>> > the check whether or not the constant value fits into the field,
>> > this is wrong and clearly ~field_mask() was intended. This was
>> > triggering for me for both constant and non-constant values.
>> >
>> > Additionally, make this case actually into an compile error.
>> > Declaring the extern function that will never exist with just a
>> > warning is pointless as then later we'll just get a link error.
>> >
>> > While at it, also fix the indentation in those lines I'm touching.
>>
>> I'm just wondering if we have test cases for that API.
>> If not, perhaps it's a good time to start (perhaps extend test_bitmap.c)?
>
> I guess. Do we have infrastructure to provoke & check compile errors
> though?

Not sure,. What I'm telling about is run-time testing.

-- 
With Best Regards,
Andy Shevchenko
