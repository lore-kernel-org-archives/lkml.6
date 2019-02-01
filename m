Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166ADC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A16214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEKsEME2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfBAXZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:25:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBAXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:25:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so3643630pgp.6;
        Fri, 01 Feb 2019 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROocmubUaz8xcAZ9JngUJ4UCXMa3KlXgM10tViBqdcM=;
        b=TEKsEME2R9KgVtp6RVSKUAkwC66dTLIbtlwJrjiljfC4DX0PVFFLS5cFro8IT45/wq
         hCuzY4qwB4w0kQz4vStllduHLGxKNgVH12K0Hu8sxyH4G80ssBvuDmvc3Mx9TywLfNJb
         1FJS4GRoKXTL97GPytvzqiLloc/Qm7ibvRRu8LswsRK5rwDQdao1VxhzzotIg4kchrs+
         mrWPiZ0/snEoJxFe91mLbX4TwOwdwDvAG6wirF+NirKenSeWSMwQ8skdXTBuriO4nPue
         CyaEZkPRQ4Lq+XpV+Lkc/6/9mo5RP8PVAnVuxZ0rz3w22/3RDHQZfVs0MZxj64GcNABF
         Znhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROocmubUaz8xcAZ9JngUJ4UCXMa3KlXgM10tViBqdcM=;
        b=bl2KG9qVJzYT1HwuauxKgGA2hGDZ8kAYAqQH92rO35TSW6mq/sTUu/n1z3wDLtX3UE
         k+4JMJBXo26otcHd2eoTBZO0GgFKbsObhWX9ANKkWbFXZsgVyrmzliPhinhXWMeIB6wZ
         iFuuIV92ipJFuk+4gE9N6KnhHVn+45M6z6IVCQO9HCrGKgtHxOrL0kDxvluP9U5GjN16
         7MUfyjINnqo5Xr6c4LWdPt05NHBJE+J0P57szrrHrZ75sCr45qLFxTZimqghJ2VwhE2b
         cxuN7v5odnRga4703luzYUBtgX2NC6lkyfcEOxKHO2yXRn+f2/We2bO5wNPOMB9RUaAx
         6xww==
X-Gm-Message-State: AHQUAuZLsQCkAqEoniZ1TipHNX6OJYDJ/gO1dnmwO+9kkOXenxSHGqA8
        sxe/FcpI2Uif+va8CN8yPJ74FrtdBVahJTTvO6b4gNyP
X-Google-Smtp-Source: AHgI3IYKJtf/YqfLn+ux0iwz96rGue40PcsNKFyRvscpCOBpVbnhLeZPVKGmtONQeJCJL3r32HHK8C/GxtvtJd0Bxg8=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr4202311pgh.265.1549063545887;
 Fri, 01 Feb 2019 15:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20180924143719.22191-1-hdegoede@redhat.com> <CAKErNvoeMs9cDDAvMfxaGLsKY3-q_JmrjCUB8VK4ZUXUVytwsQ@mail.gmail.com>
 <35cfd1f2-43eb-fc49-4777-a21413bb2d41@redhat.com>
In-Reply-To: <35cfd1f2-43eb-fc49-4777-a21413bb2d41@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Feb 2019 01:25:44 +0200
Message-ID: <CAHp75VfxuQ5SA7X_zwOiAZ41HvE-Oi32aBhCCZ_T7S9rDT48vg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Implement irq_set_wake
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 12:52 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 1/31/19 8:47 PM, Maxim Mikityanskiy wrote:
> > On Mon, Sep 24, 2018 at 5:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> We were relying on the interrupt being shared with the ACPI SCI and the
> >> ACPI core calling irq_set_wake. But that does not always happen on
> >> Bay Trail devices, so we should do it ourselves.
> >>
> >> This fixes wake from USB not working on various Bay Trail devices.
> >
> > This patch breaks suspend on ASUS E202SA (bisecting pointed me to this
> > patch, and if I revert it and build 4.20.5 without this patch,
> > everything works flawlessly).
>
> Thank you for the bug report, can you please test 4.20.5 with the attached
> patch on top? That should fix it. Once I've confirmation that this fixes
> things I will submit the patch upstream.

Thanks for fast reply, Hans!

I looked at the patch and would propose one modification, i.e. use
INTEL_CPU_FAM6() macro instead of ICPU().

-- 
With Best Regards,
Andy Shevchenko
