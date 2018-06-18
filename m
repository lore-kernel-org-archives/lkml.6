Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF2DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100E92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPNRiYxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100E92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934438AbeFRN7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:59:35 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43894 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934030AbeFRN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:59:32 -0400
Received: by mail-ua0-f193.google.com with SMTP id z16-v6so10727348uaz.10;
        Mon, 18 Jun 2018 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HNwR8Iyl07xMlDC6OT6Yjh7CYWQfLG6i4rbcMKo9EaA=;
        b=GPNRiYxMc9maiLKdLVJ6lDiTStH+EaRnuxVJpoB5MmhHd5Zmf+XrdkMtB9IeDlRU6u
         04DIJ6l2zg09QU5q+Sk1JGPk0EUULw6Wbx1IM+m4IygiOfU3/saToPyavrkMdKMrpg9/
         3N5Zj6+4dhal0nvkq8ZnhLF2KeMlDMJwFKMgxPEzZFzZE12lpxkLevlbSgh4pkZbDJtG
         38xKkcHrRfW/JX6HKGlmz4En8IOP16BNVExlW7Ofjmst/bEmmdaxaj3ahnG5r4SiK7VY
         TONW8RZaVTZa07olDP4Sd9zeVoU853KMx/ZCI0TXsJerlAJMyk0y/Vrs+W5ghUcO6ubW
         j6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HNwR8Iyl07xMlDC6OT6Yjh7CYWQfLG6i4rbcMKo9EaA=;
        b=E0L4AOXrPKrbAZjJr5fAZiKz78BHhGQzzM0gviR9sKPwA0+BWhIjwA8mMlY09d8ZhS
         stRpgkFkQpJHxCF8s5xA25XnZr2S1FaUUf40L478nPB6byCB8aZvbse0XfHLuONBLaFV
         DyfwJAz1VXDAz1vhFhOj8ltD5ntm93+EEXybwMLq1xLZT/eSwfEGkNAHxmhqp3lnUD1v
         B0s9lUV8BhSQHvKAcPALfu/FoqIx0GjTnxDyQERWIX0QvGfia1Q0Lr4uNys7iLL2CHKF
         hihd9m2UQ9i595He6voELMw3Y2p3e2R33BHGh7pPE1lkt1cBuMXoT/jANZXvkcxgJ2gD
         YIKQ==
X-Gm-Message-State: APt69E2v6KeOj7K6NYfyrBoBv7DkBui5PCALk0a/U95u6st0eC83y2gq
        2+9GjxqD8SMvpEP/2A9C11LX6cMdJqvXKg42l4g=
X-Google-Smtp-Source: ADUXVKIQRY6Dm9S3E8PqUh2T4d7S3s4SUUvSJ52Y6nWEtTZtEaJ8UKxZG7BBSWMEy0m7jZCqzybNwWUyZWhEFOHk7Zo=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr8188087uad.49.1529330371558;
 Mon, 18 Jun 2018 06:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 06:59:30
 -0700 (PDT)
In-Reply-To: <32076294-07ac-7801-2220-7468e71c275e@redhat.com>
References: <20180617235812.18596-1-youling257@gmail.com> <342c314e-6e9f-aefc-3ec0-300b53071089@redhat.com>
 <32076294-07ac-7801-2220-7468e71c275e@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 16:59:30 +0300
Message-ID: <CAHp75VfPPnqgsHFwfLaUZSYa3i2tUmvWpwgxEAz45q61aU9OGA@mail.gmail.com>
Subject: Re: [PATCH v4] platform/x86: touchscreen_dmi: Add info for the ONDA
 V891W Dual OS tablet
To:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     youling257 <youling257@gmail.com>,
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

+Cc: Stephen

On Mon, Jun 18, 2018 at 3:54 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 18-06-18 10:43, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 18-06-18 01:58, youling257 wrote:
>>>
>>> Add touchscreen info for the ONDA V891W Dual OS tablet
>>
>>
>> Nitpick: still missing a period '.' at the end, this should be:
>>
>> Add touchscreen info for the ONDA V891W Dual OS tablet.
>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: youling257 <youling257@gmail.com>
>>
>>
>> As Andy indicated you need to use your real name when submitting
>> kernel patches, not an internet alias (or a nick).
>>
>> So you need to re-submit this with something like this:
>>
>> Signed-off-by: FirstName LastName <youling257@gmail.com>
>
>
> youling has indicated to me (off-list) that he does not
> want to use his real name.
>
> He has already provided me with the touchscreen details
> and dmi strings for this tablet a while ago and I had
> writing the exact same quirk on my TODO list already.
>
> As such I've no doubt that he created this patch and
> has the rights to Submit it under the GPL license.
>
> So I'm going to resubmit this with his S-o-b removed
> and replaced with mine. Where the intent of my
> S-o-b is to certify point c. of the certificate
> of origin, quoting from:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>
> "c. The contribution was provided directly to me by some other person who
> certified (a), (b) or (c) and I have not modified it."
>
> This seems better then me re-creating the exact
> same patch from scratch.

I guess this will not pass checks Stephen has.
So, Stephen, how should we proceed?

-- 
With Best Regards,
Andy Shevchenko
