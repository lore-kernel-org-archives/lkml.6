Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646A621900
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzxCJJr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfBLKVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:21:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45613 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:21:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so1068226pls.12;
        Tue, 12 Feb 2019 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPLvJ1U2J5XGkPuS7FrpA67Dv/Qj/MbV6qZU2I6C6bI=;
        b=SzxCJJr9cKLoRxfWqTkFmr9+SHpyQYrdGl962aPQtGx9/Gjkt0WcKT8Zd+/05ddSDi
         lhp4ncn4nNyePAubvUZigSQJFbWplxFUesa0jX/qXuqTHPwh0wuAg/uOkvj9oHhiRY+s
         UOo3BBrGFsOy6U7uwRUFEyn1xSBG9wLKBLvWoyPbme/7F6aumIqfJ2j3JKPrlhwf5QnP
         DlwKH+PGcbvESYWZCujWrfR4D8joaa8zlg3F0wyuWzjYxJHiXbumLSblx3r1GmO4u8gD
         PaE5X/qVH1O7w/BHgOjTX90PptcvAEULu6dpoAzx622rTB6PFncIGNhecOVXXrE/vHHw
         ya0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPLvJ1U2J5XGkPuS7FrpA67Dv/Qj/MbV6qZU2I6C6bI=;
        b=rGooVT0IAnuIgHLe333bDAR3Iu12M+9LVu0+wOl/1gqqVOVORFBcow2d5iUu7BWfsM
         zpAbntVgIXv9CMGmB4UeTx2O1uTwe6O2T1DSN0uL6WG9havcVxcys7RIOGepPHTce4yi
         2BL1xkLK6oVm0j0B3qkd7A6iQjximdohT9OWz1s8Y4ERnHWfx31FRym4mvgCIx7H6Jrl
         MNn93dz6hBQuXTmWqN5ypCZ4YCVc1If7niyZd6DK3HEUHPLn6+C7IKHLVk9/043c708M
         dHJozPH23Jzv4C20LmcqlKo26VkCyd4aBY8rxAHCG0shPDM9qpUQf5cfWtwXKssuv6KO
         PKQg==
X-Gm-Message-State: AHQUAuaR6BJRXUBeQSPuDWqS5Q4LpIwOOZfpaZxRAvX4OCv7YAqPF911
        Up+UCHY+L/2GyUuI1XJ//Fs08eXi7WGxOuaFrkAcgYEJ
X-Google-Smtp-Source: AHgI3IYTjtEsS21g1g6BjutEpqAJH9KZww8oF5FWEf4AkX1f+Yqr3NPzHlPenD52VchrpZdvHSo0diKYNKb7fi35mKA=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr3181069pla.144.1549966908724;
 Tue, 12 Feb 2019 02:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20190212100825.9113-1-anders.roxell@linaro.org>
In-Reply-To: <20190212100825.9113-1-anders.roxell@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:21:37 +0200
Message-ID: <CAHp75Vd8yi0u7S6oA=Vr7E9ptYdvBvXBJn=fG2kM-=vS-7oOQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ima: fix build error redeclaration of enumerator
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:15 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Commit a893ea15d764 ("tpm: move tpm_chip definition to
> include/linux/tpm.h") introduced a build error when both ima and efi is
> enabled. What happens is that both headers (ima.h and efi.h) defines the
> same 'NONE' constant, and it broke when they started getting included
> from the same file.

> We only need one of the two patches applied.

I would argue that we need two patches applied. Namespace is a hidden
issue in the code.

This patch looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
