Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B373FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816D421848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n6Pi1KTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBTRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:01:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47051 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:01:01 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so14357770vso.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOrMhWk3/lgG/tvp9+23WDrZ2cEwrtC9jjBpPfEKDQg=;
        b=n6Pi1KTdwlMTuYvYqvia+b6HX/EQWebI9mZE8Q30hClQSUQfFykJgHxQbFwu7oZRUj
         2d8hZ/oOHCdjxYioREfUX2YMca3anC6Kh8u4BXlLWa266LRsFxpY8aAb/WqRAuRVRl3T
         FP7i3vk2Zhu9eN4EmYD/HE2jETAT328Bo/doI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOrMhWk3/lgG/tvp9+23WDrZ2cEwrtC9jjBpPfEKDQg=;
        b=lhtkD+076EyibCURFu1puhR+t4w8QapWljjyNpDmi/0RFY6e1XA8SfM0xdi9xuaQD0
         DHUDIEONPo97BHbUgLb9wPzEH2CCutZtpA5bJ4RayDxAqe5QWIkE1+D/obXPZtQ0KypG
         vHLKHvEfD8H2j30dwchRG/1ISjo8oMyzge3FhT0QRm9gHZbd8QYcS5YVZJdq6xsG4Vtn
         yA2LN6L/fXVi4I2gqp8i1ew0nxDgQTmsOrt4YxTsJpJGF+xx2RmqqQ4mpStE/ks/BgQ5
         5ZpCiseGxUsi231eRXOHyOdstGXFSqoryINow9OGhTTQ+vi8JPSx79D4PSRkoviCNnwh
         lVgQ==
X-Gm-Message-State: AHQUAuasOuJ6OHeVcsxZUVv1vDf3E5RbYY5CSK70tdJ+OpCE/zy57sdg
        daPEtOUnRxQj03vwSKR07VGXKWeduOE=
X-Google-Smtp-Source: AHgI3IZZW3pWq28caAPaA97L1TRm/3xeaCR9YTx/P+dMBMHb3EcEYDzpfiHcIbOTT1vrz5fjvXB5UA==
X-Received: by 2002:a67:cd93:: with SMTP id r19mr14338789vsl.185.1550682059833;
        Wed, 20 Feb 2019 09:00:59 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id j4sm12872568vke.0.2019.02.20.09.00.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 09:00:58 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id j8so8463110uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 09:00:58 -0800 (PST)
X-Received: by 2002:ab0:74cb:: with SMTP id f11mr17080356uaq.14.1550682057803;
 Wed, 20 Feb 2019 09:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20190220005449.GA25243@beast> <CAG48ez3Kbt7oyH7wyw+d1vwNRD_b5Y+tiCOLofkxyqxcNWs8vw@mail.gmail.com>
In-Reply-To: <CAG48ez3Kbt7oyH7wyw+d1vwNRD_b5Y+tiCOLofkxyqxcNWs8vw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 09:00:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+5rfZ17KcBwMPg6dEnBBVZVvFjv+xZhyThr2rJZ-V0WA@mail.gmail.com>
Message-ID: <CAGXu5j+5rfZ17KcBwMPg6dEnBBVZVvFjv+xZhyThr2rJZ-V0WA@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: Pin sensitive CR4 bits
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 6:37 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
> > +       if (WARN_ONCE(cr4_pin && (val & cr4_pin) == 0,
>
> Don't you mean `cr4_pin && (val & cr4_pin) != cr4_pin)`?

Whoops! Yes, thanks. :)

-- 
Kees Cook
