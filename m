Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85793C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3C224BAA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2LnDtCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3C224BAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeGBMW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:22:56 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42624 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:22:52 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so9915498uaj.9;
        Mon, 02 Jul 2018 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cyjukQZGlbnwD2WVyHDycm8IBYoHNvuMNEx7II6lnKc=;
        b=H2LnDtCBEudoJdqGnO7Gw57iyvHr49y0WMuSZvIJlLdOywoGzPWEE8Yol+PRmdOphw
         2ykH/1usahtmwpl9k7OkWufFTj9LVK5MDG7La3ClVXTkrOUyPMTyvLY0lj4ubskgwTh+
         rieTRL5gcuxa79Dl1DmXZAyY05Gp71/RFeIYfdDaO+epzl/MrHs4o6Uyo75wVrLg20E5
         lVbAtZhLMCYAUV5KCX0nX3EfeWma5A1PMoi+iJSxDrl/ntRald6tQ3nYY8PDh+GCSrlx
         MIhfN1x7vJpY5lCHLEmANXCIVeGLtqqD1jq22PP1jRHK5nJy19VKO+CsnNn3ab5L3Cd2
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cyjukQZGlbnwD2WVyHDycm8IBYoHNvuMNEx7II6lnKc=;
        b=V49+Jt6308D3XT1aFq8bxijBq5M72C6Yh4oXV87+ms62uWsYRXAfA9dYjHzWFlmX0Y
         YfAXqI6s8nMqVC/5w0Xv8bDfsetHIGPfvtRVAMUswh/CyWSDvXc74Mk9Ih2Iz0Zw83ma
         hoo3RtO5drXnBKgcn3Tdzc6pHBvEEtjKXyFRJWU76ut0ry2zfgIPRRG56y6GBr11VRSi
         xcHLYU1Jm+FjLAyDFvsUFoJlCL3R1BWqUPPPe2c6Tg1l0XXlLzmP0nk/38aD2j3iNeB5
         g1WUSwgZc7HlEkdwQpWJCooEblLAKEa1pvX1a119GWGz5SwP182Sbb31QhObuphG1kfr
         kPGg==
X-Gm-Message-State: APt69E3U49ERzP/ICa7yKI63VjfXeccX2J8U1Qxq2volAgFp4kfDotEC
        6NRsd04CW+M4kg1AWqftboFuBIqHdwr+mgZ1deI=
X-Google-Smtp-Source: AAOMgpfR5nQtqqAX3gIa3gUmTim62tM8lWsTg3YsDXOZ+TYMN5gA8HWy3/fJSR3kr+eESRICNHGubu8U/Unwan62XiM=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr15695550uae.12.1530534170893;
 Mon, 02 Jul 2018 05:22:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:22:50 -0700 (PDT)
In-Reply-To: <20180619080522.40a20951@canb.auug.org.au>
References: <20180617235812.18596-1-youling257@gmail.com> <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
 <32076294-07ac-7801-2220-7468e71c275e@redhat.com> <CAHp75VfPPnqgsHFwfLaUZSYa3i2tUmvWpwgxEAz45q61aU9OGA@mail.gmail.com>
 <20180619080522.40a20951@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 15:22:50 +0300
Message-ID: <CAHp75VeO-3AAvYXP3=bShpec4YzDRXwEKCAP_HwfQpzoLCcZ1A@mail.gmail.com>
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        youling257 <youling257@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:05 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 18 Jun 2018 16:59:30 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

>> > youling has indicated to me (off-list) that he does not
>> > want to use his real name.
>> >
>> > He has already provided me with the touchscreen details
>> > and dmi strings for this tablet a while ago and I had
>> > writing the exact same quirk on my TODO list already.
>> >
>> > As such I've no doubt that he created this patch and
>> > has the rights to Submit it under the GPL license.
>> >
>> > So I'm going to resubmit this with his S-o-b removed
>> > and replaced with mine. Where the intent of my
>> > S-o-b is to certify point c. of the certificate
>> > of origin, quoting from:
>> >
>> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>> >
>> > "c. The contribution was provided directly to me by some other person who
>> > certified (a), (b) or (c) and I have not modified it."
>> >
>> > This seems better then me re-creating the exact
>> > same patch from scratch.
>>
>> I guess this will not pass checks Stephen has.
>> So, Stephen, how should we proceed?
>
> That's fine.  I amy report it (If I forget this email), but you can
> just ignore the report.  My scripted checks obviously can't take this
> case into account.

Thanks!

I have pushed to my review and testing queue as is.

-- 
With Best Regards,
Andy Shevchenko
