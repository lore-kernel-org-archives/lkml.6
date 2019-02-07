Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAAFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6C02175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQ+rM3ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfBGAae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:30:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGAae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:30:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3709974pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShCIURYTkil5sjHiYPuxph9+95OH9s8T1TV7yEWXo/E=;
        b=JQ+rM3tyokCfxZ6bhKrtzB9tpn44i4UxSC8Ub7zPlFe457mccirjwJQT1fhHQeGUHF
         uHAjEjIg08bgg2HMqj8OvlhTsD+PKVtUTFbbUF5+T6MFeRhrUPrpmeVR8DhSxIZ7m1Ut
         BSU3YJ1SyZK3FRlhZhcaxoVbyMjoEXDVKK9Bx/8ycWBnkuqzOSxx/kZA5j7OyslR8GGw
         Z6TZx5Ry9+UYqXVHP0s1fnynNnTrCsF2h/fJ1LtLUS9Ke/aGq3F1J+o1rzpWrkT5xO71
         A3A7EZa7+6yJNTJlk68mqt+6UzsI2UdXuizYraA0kXS6y4BTrkEryFUWkQ4HRXczUZ4t
         HM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShCIURYTkil5sjHiYPuxph9+95OH9s8T1TV7yEWXo/E=;
        b=SZxvKUtrd9zlIUcSmyXOugUDTREtID/fbX5K6l1tfZlMn7YibZB95nnnZzS9geOper
         pUJ3/uFzzoEWO+e3zRrT4sWJY1Aa3oKfcwA4KOq4jxEOc5O7vtyGgxh5f/5ni1M/BsJB
         urgNRHHPNyOqVmH7Q8O9Iq+MzmmJ/ePE3ceOfxlQYlIv7JxaPrdae/bhUK0+MIh74ATZ
         U+3/ScI6PRwfK1WTo3+AS+NO5lfI8tt0y49+ixcchRrIteE6J/WGOB8aKc5kRcBBsIkk
         UQXIrmFEi4YWy9bZH15Mi/efGL2rl415mIz3Vu5sqO2z8kqzjtNMYitfRM3HOT6W7rRE
         Fofg==
X-Gm-Message-State: AHQUAuaKiVbGyy24o6jSPzhJCw7/WqJhrfQodxcZRC+KQiP0Rpq42L97
        em2bVJj/FpqXas7cY63pWoxSsdNsVzHnbCxuIRGlMg==
X-Google-Smtp-Source: AHgI3IZBwz5L2NuzeX811DeethaCNhNkB3aI81eeOBaH00CdIK8I9zvKbcZGRyCcWzuqBxSgKll2Fg6dRb41kwHSM9c=
X-Received: by 2002:a63:e156:: with SMTP id h22mr12258858pgk.255.1549499433078;
 Wed, 06 Feb 2019 16:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org> <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen> <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
 <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
 <20190206174339.GA19743@archlinux-ryzen> <CAK7LNAQ97h3RjKNy8f2abb7fnCaQS3TOoF2LFeGgNxeoCy0GwA@mail.gmail.com>
 <CAK7LNATAdXh4d39VfNqmLX-V-46sLwVXK+YhE1AiMCDutvUr0w@mail.gmail.com>
In-Reply-To: <CAK7LNATAdXh4d39VfNqmLX-V-46sLwVXK+YhE1AiMCDutvUr0w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Feb 2019 16:30:21 -0800
Message-ID: <CAKwvOdk4cT=Ay2Xk4hYo4-x8=4ng9gF5rF=5RsV-Rp=q5UFNtg@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jon Flatley <jflat@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 4:28 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> BTW, it would be nice if kbuild test robot
> could test building with clang ...

Is "kbuild test robot" different than 0day, kernelCI, or ClangBuiltLinux's CI?
-- 
Thanks,
~Nick Desaulniers
