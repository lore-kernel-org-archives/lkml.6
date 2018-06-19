Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934BCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6720020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx4DXdQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA6720020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030283AbeFSREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:04:53 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39931 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966468AbeFSREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:04:51 -0400
Received: by mail-vk0-f67.google.com with SMTP id r83-v6so252711vkf.6;
        Tue, 19 Jun 2018 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hzNP1mW585OOmkjQkl9sPQcA+IcHWK6JlAFG25jXmhA=;
        b=Vx4DXdQDi7ljeRpuHsYP8BaH7Kai8p5f/gsQLnHt62jguGGHejE4okTU6PzuvKrbRu
         zAK3NJVMsAEJx7eBq8918tN0lnSR5tPW+aM9i2p9IHg7jY51MpE0JxApGwob1JIOw6+E
         gLHxZrm0jJ73Nj0ViAXf8JXUiy1+H2EupVuevSF/fSYR7V+CMm6IgwzTDP9n2XjMye9o
         Z+EroMAxwA/x3BWpsIayWzPfiMto7H5p7GJeQIp1vZPJYoRYEgYOZq9EN3d2EuJbbVFR
         I9B6eJB0e/1RaBgqKS61Vq10kLOO/zeQdxpg3j6Wf3JBMDNpKZkwkDUaZg50GpySJwO1
         o2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hzNP1mW585OOmkjQkl9sPQcA+IcHWK6JlAFG25jXmhA=;
        b=sOEQrI/S8cRyDgp4dyien1jTxgSfYgLsj1t+cFLMiSzV5EGqsVQvxwQGE0hggPSsNk
         XMFW9p2lztFTB86hB177XHw6hyZse/GHC74UDiz7izA/jcz20MZFlWEn/0p0vbTBLhUy
         f3ridq0agilRXBVK5Soyuks1SEyEhc020VfvUcuK2ZFarZx/rv3BLnThfeO0GfbnJNmb
         P0uaBZ7J/tEuqRPWC0lzexnTBEhcIhFX7ip052JFb/eeYdHMDiPbAxoPe16fGm2Tesfx
         OpzFV8qYw0eDXLK51CG7QXSUeRNWaR4yCm4/08Wte1H5A7fcTK+R70Vz/etoE7rwxgSH
         Bdiw==
X-Gm-Message-State: APt69E1Zjkv+Vlv4taBVxH24cd2M9ft6DDWns81A7WmxPum53+mgugNS
        tGTWBHaf33NUZBDxV2Prqu+Hb7Mgyly+hR/nbz1cZQ==
X-Google-Smtp-Source: ADUXVKJmzVuLOSLuLy7AoHqsrJe36Jf0q30Uffng8k2fmRs28Tk9mehqhZyRGJJjeVcKW3AFwZKrH71Zi+fI6rLWlV8=
X-Received: by 2002:a1f:7283:: with SMTP id n125-v6mr10063534vkc.26.1529427890357;
 Tue, 19 Jun 2018 10:04:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 10:04:49
 -0700 (PDT)
In-Reply-To: <CAD8Lp4596OLxc9sw=DwAZ_nHLEOt686xxatqCmSpV0eEWwigjQ@mail.gmail.com>
References: <20180611071838.47945-1-chiu@endlessm.com> <CAHp75VdfUO9rS-=nn+Ffe8bMEbCO-0xe8QBVqsJAZVFTMYkNxg@mail.gmail.com>
 <CAB4CAwdKJiuEiV1CtoyYTZTatRt73BQbRX5kyEtpqNj8STj5-w@mail.gmail.com> <CAD8Lp4596OLxc9sw=DwAZ_nHLEOt686xxatqCmSpV0eEWwigjQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 20:04:49 +0300
Message-ID: <CAHp75VfLMwTEOSKd3cy8j1RuQMwTDFnp_aMzQvod-DJG5e0KVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Call led hw_changed API on
 kbd brightness change
To:     Daniel Drake <drake@endlessm.com>
Cc:     Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 7:46 PM, Daniel Drake <drake@endlessm.com> wrote:

>> > Can we avoid those ugly castings?


> Now kbd_led_set can continue being a correctly typed function pointer
> for led_classdev.brightness_set. And from the code you are adding here
> you can call __kbd_led_set directly with signed integer values, and
> rely on correct bounds correction without ugly casts.
>
> Andy, what do you think?

Thanks, Daniel for investigation.

I'm fine with solution(s) that has no ugly casting and no regression
on the hardware we support.

-- 
With Best Regards,
Andy Shevchenko
