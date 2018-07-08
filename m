Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D7C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43EE2086E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC8EnQTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43EE2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeGHJ4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:56:36 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53726 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932082AbeGHJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:56:35 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so21728314itd.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68mfPqeSnsOpP9Mdxueykaq2yiZM1g5E4iOTuuAfluk=;
        b=FC8EnQThv66mliZdYzAaTiwL1OOk6wSMCUmTSDTvwtP4LUbyfvbaWfW+KiVb+ncKr7
         /DFfaza6bNM7gCW1KLUZysuoP1ehHw9by60+zR3wHO5cSFUan0t3TpLqYZJGjN5TqvTF
         iP3Hw4/2vfc4g6ZSqWKOV/93jBAEi4llVZAFdFu21rU8K5RScoY/Feny9UHRS64dJrjj
         +G8sUSstxmrJ6y0Q8UKxTun0WftdDZcNbaxVQg8Z8gJZn4GS1mrxX6q5SOwmw6oQzJFp
         uvHjoLQqKZRKSvLFynaiqqNRECWpt9i7ot57bOLI4pvmrBxkPf9YtZY/NU9WG2Ci5qIm
         7pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68mfPqeSnsOpP9Mdxueykaq2yiZM1g5E4iOTuuAfluk=;
        b=tWpwVgVfpyazelPMbJYXnvsLbp03wEjY2ogQlQQn+Qulgep4VfSsstF6UPoyeIfQhE
         3ie15RdYq5iBVo5E+X1gWDzvrJheZKYsh6/6vu9s6Ox98GUjLMV5BsYcZEuxA8x5+DPG
         N1kWekSFStjsKG3bzpMXigArgpBuLMvCRrO7cTG4LYuwQH20ImBf/TZEGQtVj8AYxMYb
         GlMltbqwMpHLMCJ6OOSBIYQRCFdwFxA0sSY9x9/BnlYtv0HTJnXvFhNU++sNBWIoEvyd
         shK6AVIlDLGoixVOjXnA8fv5eyx+qS7vSJQqUTldakzvnr+ix7tF+wKT2ovLZec2NP/T
         9VHQ==
X-Gm-Message-State: AOUpUlHjfBlumfKqge3tuogIFW8XKCcH+Sb16gdSiyzVPvfd1v83A4f3
        O63mYd9sQPNHLuK9XivhGL0G7bHE4Ij9nhqx6os=
X-Google-Smtp-Source: AAOMgpdzDugm3+DLQ4XQvpZZZFwVXNGwobQZ1nVBKWptKSD73X1/07rLevg7iFhXn2OuibETCFCeTUC/y3XCVmzNeuk=
X-Received: by 2002:a24:6e92:: with SMTP id w140-v6mr596362itc.37.1531043794823;
 Sun, 08 Jul 2018 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com> <20180707211401.GA13111@wunner.de>
 <20180708073130.GR2534@lahna.fi.intel.com>
In-Reply-To: <20180708073130.GR2534@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Sun, 8 Jul 2018 12:56:18 +0300
Message-ID: <CA+CmpXvaE63kBreCMMw_+QwMb811Rjx7B1z5==cY9nQ39J_Ukw@mail.gmail.com>
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     lukas@wunner.de, LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, rjw@rjwysocki.net, christian@kellner.me,
        Mario Limonciello <mario.limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 10:31 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sat, Jul 07, 2018 at 11:14:01PM +0200, Lukas Wunner wrote:
> >
> > Because I'm fairly certain that
> > I do not get a PME for the Light Ridge in my MacBook Pro, but I'll test
> > this once more and modify negotiate_os_control() to grant PME control
> > to the OS.
>
> I think in case of Apple hardware, they handle the in some different
> means than PME (possibly part of chipset driver or ACPI method/event).

In addition to what already mentioned, many things have changed around power
management during Alpine Ridge development, some of them came later as FW
updates (and BIOS changes). Comparing Alpine ridge to Light Ridge here is
comparing oranges to, well, Apples.
