Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCDAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454212184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLNGvkT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfACNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:10:06 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36723 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfACNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:10:06 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so42581668itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzePJ198qub6c/5QilsHLVJ8xr4BllMABKBo7bY8pjY=;
        b=PLNGvkT6n9PovLVfoFNb1XKyfLKVGWQKOYVVXS5W/meligCpHjlCY/pq3TTS5DOEaX
         VATjhNFcll/S8ruiWV+vA+Yo56dHDcZjrEkoqLFCTHNC0m6XeEZH54w0XdGKBJY507l0
         plMk3rGyUEtJgFCLvztL57r823HeaNTeo83ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzePJ198qub6c/5QilsHLVJ8xr4BllMABKBo7bY8pjY=;
        b=KP72KH2tow2LCqvrHdfQ//p7oa3dU2nhajXp2BpBiKVFkEL5wghiQezqZ+WhKw/114
         hoRr7+a5GlcSOxo5qNNmJ5jZHDsTCE37+JbcI3SzhRSTvRFRvUHZiGCH/sNfF/S84oWU
         iWJ2E7qT0rJ2yCztGI9Ix9wX5bfT6k/ipNU7X91Kql6pYdt8LuwQONiTIwgLdpnozXen
         g9rwReJZD3X5rnwYUoGm8wDFMGxTiUfTIawQ+6WAGUD/GypiwxXwp0RlwkzLTminqIuJ
         WDprsJ3t5IEOn3iDvOsUWFusvxOH6tG1crTCGm96ZIavKayICkhuehodhxSsm9Q4zb72
         6XCw==
X-Gm-Message-State: AJcUukf4sMduh98yHT1QZbsBYgrN6vpPSNPOxqE4vibeM7S2xofX2IYy
        hB9KKYmsbA50g9AJpqhEMvj18un3cWd/nsOJ964a8w==
X-Google-Smtp-Source: ALg8bN42Vhidt7HNnzPe62Jfr0KcC2JoECVwtLKd0z5/YEUMZCc17pFJ+4qO40jDMQI0/i6NJQSA6lXl0Ek0Le4c2hg=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr28493588iti.166.1546521004670;
 Thu, 03 Jan 2019 05:10:04 -0800 (PST)
MIME-Version: 1.0
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org> <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
In-Reply-To: <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Thu, 3 Jan 2019 18:39:53 +0530
Message-ID: <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
To:     Michal Simek <monstr@monstr.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, 3 Jan 2019 at 18:00, Michal Simek <monstr@monstr.eu> wrote:
> >  arch/microblaze/kernel/syscall_table.S        |  2 +-
> >  arch/microblaze/kernel/syscalls/Makefile      | 11 ++++++--
> >  arch/microblaze/kernel/syscalls/syscallhdr.sh | 36 ---------------------------
> >  arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 ------------------------
> >  4 files changed, 10 insertions(+), 71 deletions(-)
> >  delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
> >  delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> >
>
> Looks good. Will keep this in my queue till depending patch is applied.

Thanks for the feedback. As Geert shared few feedback while m68k review,
Hopefully, I may have to include those changes here also.


Firoz
