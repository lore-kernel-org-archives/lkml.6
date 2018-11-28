Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E36C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F67205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2wWuMwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F67205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeK2E6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:58:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36892 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeK2E6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:58:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so17760699plr.4;
        Wed, 28 Nov 2018 09:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I9xpTrwkRogxo+mf8bRgWuEsMj1yYsMmfxvIjxXPP3k=;
        b=I2wWuMwTUbS+kJKYrO/Fu0WBtMDKX4GqtEIU3nBW+hxEoBqQsDoSG9hZeEFJUSSGQK
         KZQMgrRAPB+2LkxqH2KuxzHyYQvG8BjffALjBKQ4brwmcqbuB6sSdvRtWIXG+qPIsnri
         vj9dluhAbbdm2PkySTucCxlpf+8nDgugQWwcu3fPuB5TYB5k492ggCBOXhXUiQbz1yOp
         e7Pj16BAXFvplH1w+Bit2WflvekXnQ+w74vF18EkMCeTAr9+eTIqXV57T44X7yQAlzF/
         Z/MJ1v3EXO9ABFMJkqQ41Ozl8zh6fvifZcPXyWaETq1QkgtLXu4tl9C+SByoZOFRJZHm
         P5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I9xpTrwkRogxo+mf8bRgWuEsMj1yYsMmfxvIjxXPP3k=;
        b=ANkM61WunHtJmQ6fWmkTcVg5dhWakgTKVGq0zqlNpEwNgLiXRHoJwnAoCj9is+60jc
         pgvdl/tOnw23zDUyUnWbWyJe6juNww96o4sF42Ax3+QDSiyT7Kj1mfYAC0G5xWdvG/wG
         8eQn+/XwBAHyjDHrJdDvSVjCS1q5Ok2HYID74y8ET9SbgmOtjsHS1XcW5iXBemdGgrAR
         zgiGH5ezoum/tEQkGUxKrP6I0W+dW/6OD4HCgxQQVHsmyvm1Cpi2lXrDPRTq+cfuH6IY
         dT4EaxgKl5AU0BqbyPuLnFYdUaI5wucAnNUTlAXkCukjLB12LYUmOr+z5eftYM0kdZWA
         byQg==
X-Gm-Message-State: AA+aEWZrrgPr+xoP2SKJQKFN/cY29l2NjrJLr5nycWLubWO6EG5RbUUp
        gO0moRPKVn8iI6uAYX0ujr+aVDhfVqg=
X-Google-Smtp-Source: AFSGD/WtFtuuFPf7aev8Gsj6SbmJWuFho3KuGe0OTHV+5cL/fBUTHDzDZS8As9+0uwPmwW6A0LbB3g==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr28625646plo.50.1543427740719;
        Wed, 28 Nov 2018 09:55:40 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id l5-v6sm9772781pfl.73.2018.11.28.09.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:55:39 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de>
Date:   Wed, 28 Nov 2018 09:55:37 -0800
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B310522C-8D67-4143-8281-2C870A881F6B@gmail.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
 <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com>
 <20181127184835.GA5147@rkaganip.lan>
 <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com>
 <87a7ltjxnz.fsf@vitty.brq.redhat.com>
 <alpine.DEB.2.21.1811281404230.1532@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 28, 2018, at 5:07 AM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>=20
> On Wed, 28 Nov 2018, Vitaly Kuznetsov wrote:
>=20
>> Nadav Amit <nadav.amit@gmail.com> writes:
>>=20
>>> On a different note: how come all of the hyper-v structs are not =
marked
>>> with the =E2=80=9Cpacked" attribute?
>>=20
>> "packed" should not be needed with proper padding; I vaguely remember
>> someone (from x86@?) arguing _against_ "packed".
>=20
> Packed needs to be used, when describing fixed format data structures =
in
> hardware or other ABIs, so the compiler cannot put alignment holes =
into
> them.
>=20
> Using packed for generic data structures might result in suboptimal =
layouts
> and prevents layout randomization.

Right, I forgot about the structs randomization. So at least for it, the
attribute should be needed.

To prevent conflicts, I think that this series should also add the
attribute in a first patch, which would be tagged for stable.

