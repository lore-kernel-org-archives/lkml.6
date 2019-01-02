Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F47206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546421696;
	bh=unRpJRh17Zte8JfujogbSSmV5hkL6ROQx6/jNSx8uVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RoQj2+31ajyq5YM2KJNVMgxeJAcBUvs9TOKDJzWbdLCMQfoMdv63aYs4Ws1ngCRGT
	 nm/0MGo39MsEBmKu5LmDAO+5oS7KSmkoLkV8291K99TYJb2ckRL7QxMWJnlX8ZPFO3
	 PizvBFdg1x4ZyCxfxHAA3hdV2CISu0uakKruaL44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfABJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:34:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44261 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfABJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:34:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so26227481otl.11;
        Wed, 02 Jan 2019 01:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hx7SC5jOpqXXay9xr3xWrOj93/12QBP0HZlw9mVlB4A=;
        b=ZrmkivdTovzm4JPqZdawHa1DQfcZJ9AZfgIrejl8oPR8VvnRqfS1g1E+3iCsWgD+sg
         YNSYCh7cwRn0BAvmD15Jd/7vlAmZLN2tBq5omWdoimbsd9Y339dEQUVeRUv9IWbq8XFh
         HdJwBAadKkXFj4FP5gBL8icJGd5mUzjKiXAxaOdxVr2BCjbkLy1OtlR8V+tdgUHyCQvv
         GEvVvDFDdOQAeFekIFUjfnx3uta0i8t0v1Tmh/8bcTQqTzXObIcPYnv6N0Ew1maLrbIR
         ms/1s5KXMkUhK3cg4UN4mxX37IBtMKnomhpidtDRzB0nizBbc8oJ/98+TAt3i1jUurG1
         64cA==
X-Gm-Message-State: AJcUukc2xI+0nfZQClyrh09huAdeMJA5ylN64cVB2RHbVfFJQVpMVXLy
        2s9LUdvCQsBNxTcm9FXgj03HbjBp/GOW0GV83h9gYD/I
X-Google-Smtp-Source: ALg8bN6wdfIJDNrc9l30Es9++MWLJRnCh4AL5sUhC3Kef7nlY2EYhJzUgT6mAoH1GkE5HZYpHayUc/bjwA4JIddB+Yo=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr28248425ota.244.1546421692120;
 Wed, 02 Jan 2019 01:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
In-Reply-To: <20181230195612.6657-9-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 10:34:40 +0100
Message-ID: <CAJZ5v0hSpAPzi2EcFKD_Wh23SeYnoJCAaQMGW=fSqgmhmhr37A@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 8:56 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> CONFIG_PCI set but this is not specified anywhere.

IMO it would be better to say

"After commit 5d32a66541c46 (PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set) dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly.  For this reason, add a direct dependency on
CONFIG_PCI to the IOSF_MBI driver."

If you did that, the reviewers would know upfront what this was about
and that might save at least one back-and-forth e-mail exchange in
each case.
