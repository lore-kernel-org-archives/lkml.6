Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5763FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03460208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QVyBaHt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03460208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755074AbeFNK6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:58:16 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:41592 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754963AbeFNK6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:58:13 -0400
Received: by mail-oi0-f43.google.com with SMTP id a141-v6so5229579oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NcO03yk+DfovUTH5JP+nSMS07AYHevA6cYnEdWUWASA=;
        b=QVyBaHt6+o/pEqOCDY2xPLex9NLs6Zwno1AYL8zIph0saYcAg3UrSUMRXNuGyLo7QT
         obQdc8osV4OugUgWk5tiZIsBXeLuE+MgNb42XVWyq/Z5n0NuGAJtupiucYPHXVqrG0ho
         kDbxLmZV7MU11rX8NbeMC/bemX+pikc5TK7E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NcO03yk+DfovUTH5JP+nSMS07AYHevA6cYnEdWUWASA=;
        b=j9ZS+MLwHfyDsyUpK+8WfveGFyUUzC2GRo/i9XGyFhx2fMybY++zcAnAvzi/Ld10uS
         9bUOXvp1a/IZSVd7da12WwhzjYi3gWvtSMUBAPKiLN1jXhv4AoiRE4Ai2WyPy1CKx6ZJ
         zAIwRuX9K+ya8zVKMu7nZQXQ1oAmjuGWiOgoCGI6M1QyhnVCZfdU5olIddgBDjdaK3aV
         4wHiHX6i1Tm8M6VydtfMOvnhvJnGgTYOPnj4+yYO03jRSHoL+s+UpKed0VcMP+nwSQW+
         8e0+WcgXBQFeuYwupU5xxHwjsqkhYFyztaRQFWjOEjk0PG8tqCqZN3GgNsD9TNt2UCuU
         mVPg==
X-Gm-Message-State: APt69E3i4paGJhu1LHeJLFDQ2SIx7PLiCJe3kMWio3CsTik0DQvKZ1PY
        rXVYvbBEiQOxY/5nXvgaexI8bt2pYWyJuKjJVg8jgw==
X-Google-Smtp-Source: ADUXVKKMNlaf95U1UxE5vFHDy+NwpQrzFyPhD4Zu0vXxDrZ6z9fZJ2aUXbqYotoY6W/FUfMyx8Ggtt3j1ZxIQeU3dEI=
X-Received: by 2002:aca:3f57:: with SMTP id m84-v6mr860066oia.280.1528973892630;
 Thu, 14 Jun 2018 03:58:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4044:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:58:12
 -0700 (PDT)
In-Reply-To: <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 14 Jun 2018 16:28:12 +0530
Message-ID: <CABe79T5i8zUcBJnFmM-pAvzXf2CZXesh4NqxSGFj8f0Z-c8m1g@mail.gmail.com>
Subject: Re: ACPI support in common clock framework
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Andy,

Regards,
Srinath.

On Wed, Jun 13, 2018 at 1:43 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Rafael, ACPI ML
>
> On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> Hi Michael, Stephen,
>>
>> We are adding ACPI support in our Linux based platform.
>> At present our clock hierarchy using common clock framework through DTS.
>> Now we required ACPI support in common clock framework to upgrade our platform.
>>
>> For example, clk_get API called in many drivers to get clock device is
>> tightly coupled with DT framework.
>>
>> Please let us know, if anybody in Open Source community have plans to
>> add ACPI support for common clock framework.
>> If not please suggest us alternative method to use common clock
>> framework in ACPI use case.
>>
>> Thanks in advance.
>>
>> Regards,
>> Srinath.
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
