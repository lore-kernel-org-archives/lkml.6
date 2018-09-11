Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49320C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A56206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ww+MAYjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A56206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeIKW7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:59:49 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:38419 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeIKW7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:59:48 -0400
Received: by mail-io0-f172.google.com with SMTP id y3-v6so4312439ioc.5;
        Tue, 11 Sep 2018 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXWSbhZWmG8MF6e/+/Bywee7w0TaSTNEl4Ors3bkiGo=;
        b=Ww+MAYjjANKpSPms1RB+Hstf58cpop/uIDx0itmjMUCJ1SivPOo5agQfWQb+ZhlvdU
         kBl0G10crzZ/ir21aQW6lFnT8uW74f4hvPtK2qTww61mDT7hAR+kTTgdtFuiCUt+8/2O
         GU2aL+iFw63yXlEDcS5aNR47pQbaIEzzcN/rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXWSbhZWmG8MF6e/+/Bywee7w0TaSTNEl4Ors3bkiGo=;
        b=n30Lqh+OBO2lt+OxWB0xoArme9yz4eGXVk0EbzuKAJQBJQRJXb1ya9mVFU8HHfB2gK
         qTkuUWHbzrRoqIof//Ol8wJA6SPeXL4g6zPcrd/TsTqndnM6zxttpxAt3MFxuUv+CvOa
         tbbuGrszP7EundHjaEBEzkW0bqedxXGC6CV3c8dP6/WqsL8b+7+LjlObhehr8eharjIY
         gskrxzY0adUVBKPTbXi4CiWSf0qbaVO0jWnfBEMZOGL4BRG2lWWVos8EUoh00Y76mUl7
         8+W9PT1wGNGcYarUmzwIcS5xKIF8l+WBdp5zazku2KhBbzTyDuGwz4JP/ZbVlNApnIK5
         Ld/w==
X-Gm-Message-State: APzg51A/0KjaCnMnLI3xDoJggvWGlups+k2BUie6JYpU4ZeRTY2wyuYE
        ZFIfhnT23jHA72rw2XqybvMEVxs/oLIgjze3W+M=
X-Google-Smtp-Source: ANB0Vdbxy4IDvnNRujJdPBUIA2Mx72l0r3/8qx8x/sXU7ha3wBdLGuFT9Rv5nGqRktmvENhNuNuxwD6QQlkYCH8fRCE=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr23859079ioh.259.1536688761671;
 Tue, 11 Sep 2018 10:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180910215659.GA17966@roeck-us.net> <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
 <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net> <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
 <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
In-Reply-To: <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Sep 2018 07:59:10 -1000
Message-ID: <CA+55aFzZ2rBWPrYOSozf44HNDhPPm94GCnsVDwCtnTOJbvombQ@mail.gmail.com>
Subject: Re: Random crashes with i386 and efi boots
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 7:42 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> So I am in favor of changing the order in efi_call_phys_epilog() too.

Yeah, the only reason the order was changed was that it seemed more
logical to use the new cr3 to load the GDT. But that was clearly
wrong.

So ack on just changing the order, and my bad for suggesting the
change in the first place.

            Linus
