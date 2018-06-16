Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65DCC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B120891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEBLTMuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B120891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756884AbeFPPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:50:22 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:39245 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeFPPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:50:20 -0400
Received: by mail-oi0-f51.google.com with SMTP id t22-v6so11393126oih.6;
        Sat, 16 Jun 2018 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZXGg18g5pPjSRyZDeoTUVX9XCegl+mmO+OHaGdnq0uk=;
        b=VEBLTMuZsXyWzKCTvg3QYcZSVmm624ACetQ73ZVzuf4qRSpz9X5PLi7zvzlLOmy+/v
         qzhXpC8nSYfX8/8+RFESzZfFaVxHlRxm/w6ph8DYxje9CPuXSAPg5Q4BhrBj4lhdLeKX
         9xRl9x3kphldHog2QL++H6Wl12vQPsaFt/PzxVCzaXWuUz+4qOfQ/H6HHPudv+7X3ccy
         DBW4hGD+wwDjNHPsZNqQDhGhAJY2ss4Rrli4MrALaQrDNsbBzPbA8mAuVDfZoTPBGgIP
         haCWFnzrbo89mz8K9OrirFSvCGRkSWG0Uvs/muVZdoG/CP8jXmVEL5QdZGW2PGsVCi9P
         fIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZXGg18g5pPjSRyZDeoTUVX9XCegl+mmO+OHaGdnq0uk=;
        b=f8UGrA2Dr2dzggrPRa/cO1HqRukTO9fHXO6tH2jO2JDkpvDfyoAzvQ5h26TPv6lKlO
         MHzjZOf52Cb8heo0F0AKoV5bkxrN/f8YF7Pu6GVGvbWN4LBpN98SRmmRJ1Np66w8DEof
         zEgYQ384CEi98NGgc50h9xqnz+XnXMyfCsfuu0MhJdXgXIHIMGBk62p1irJRFoGgnDff
         it8dk/AJ67KZTk2SaNbhaVUF/Nck9VBv1ZihU+Y346zRdouixdABoPmC0Fdoa2ohnwta
         BsUJjovnxvySnxAcKsAVX6BieNod0uqNYwzKsk2f+wb1uuxpk0g6cZa62Qfkv5bMGHLL
         xZBg==
X-Gm-Message-State: APt69E1A5cZs6uziKAyKSw4N/mynSjP90Xv6PALRpMBJTdlOu+oa3/tm
        7Nwv90uAiX4mOPNzVWIp7oUP7+SLSbVhQIDZi/8=
X-Google-Smtp-Source: ADUXVKKFzqJI9IsUsLn0w/u+xtwF+GvU1WwmMkeBkOhG3tYswZlYc9LRQu+r0B3eHDj5XdTBZ8oaQZ0LVFR8YUZdR9E=
X-Received: by 2002:aca:5bc6:: with SMTP id p189-v6mr3592943oib.116.1529164219309;
 Sat, 16 Jun 2018 08:50:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 08:50:18
 -0700 (PDT)
In-Reply-To: <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com> <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 16 Jun 2018 17:50:18 +0200
X-Google-Sender-Auth: kRGg-iVx55l3k5aqgemkFTJTEro
Message-ID: <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
Subject: Re: ACPI support in common clock framework
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Rafael J. Wysocki (2018-06-13 01:27:39)
>> On Wed, Jun 13, 2018 at 10:13 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > +Cc: Rafael, ACPI ML
>> >
>> > On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
>> > <srinath.mannam@broadcom.com> wrote:
>> >> Hi Michael, Stephen,
>> >>
>> >> We are adding ACPI support in our Linux based platform.
>> >> At present our clock hierarchy using common clock framework through DTS.
>> >> Now we required ACPI support in common clock framework to upgrade our platform.
>> >>
>> >> For example, clk_get API called in many drivers to get clock device is
>> >> tightly coupled with DT framework.
>> >>
>> >> Please let us know, if anybody in Open Source community have plans to
>> >> add ACPI support for common clock framework.
>>
>> There are no plans for doing that AFAICS.
>>
>> Moreover, it generally would not be consistent with ACPI power
>> management defined by the specification.
>
> This matches my understanding.
>
>>
>> >> If not please suggest us alternative method to use common clock
>> >> framework in ACPI use case.
>>
>> The problem with using the clock framework on systems with ACPI is
>> that, in general, the clock manipulation is expected to be carried out
>> by ACPI power management and therefore it is "owned" by AML.
>> Currently, there are no defined methods for synchronizing the AML's
>> use of clocks for power management with what the OS may do with them
>> directly.
>>
>> In theory, that can be worked around to some extent by representing
>> clocks as power resources in ASL (even though the provider information
>> would be missing then) and manipulating those power resources directly
>> from the OS.  I'm not aware of anyone doing that successfully,
>> however.
>>
>> For simple power management it should be sufficient to let drivers
>> rely on the ACPI PM domain which should happen automatically in the
>> majority of cases anyway.
>>
>
> Is this for clk_enable/disable? What about clk_set_rate() or
> clk_set_phase()? Is ACPI's AML taking care of that?

That's for clk_enable/disable AFAICS.

AML doesn't manage device performance states at all.
